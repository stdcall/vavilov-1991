"""Remove Typst full-citation links to its hidden bibliography destination."""
from pypdf.generic import ArrayObject, DictionaryObject, NameObject, NumberObject, NullObject


def _object(value):
    return value.get_object() if hasattr(value, 'get_object') else value


def strip_hidden_bibliography_links(document, document_metadata):
    """Mutate a PdfReader or PdfWriter; preserve real backlinks, URLs and text tags.

    The caller supplies evaluated Typst metadata from the same document.
    Only bibliography pages containing explicit keyed entries are eligible.
    """
    metadata = document_metadata['metadata']
    entries = [item for item in metadata
               if isinstance(item, dict) and isinstance(item.get('value'), dict)
               and item['value'].get('kind') == 'numbered'
               and item['value'].get('family') == 'bib']
    if not entries:
        raise ValueError('No bibliography entry metadata')
    first = min(item['position']['page'] for item in entries) - 1
    last = max(item['position']['page'] for item in entries) - 1
    if not 0 < first <= last < len(document.pages):
        raise ValueError('Invalid bibliography page range')
    cover = document.pages[0]
    removed_ids, parent_keys = set(), set()
    removed_by_page = {}
    for index in range(first, last + 1):
        page = document.pages[index]
        kept = []
        for ref in page.get('/Annots', []):
            annotation = _object(ref)
            destination = annotation.get('/Dest')
            if destination is None:
                action = _object(annotation.get('/A', DictionaryObject()))
                if action.get('/S') == '/GoTo':
                    destination = action.get('/D')
            destination = _object(destination)
            bad = (annotation.get('/Subtype') == '/Link'
                   and isinstance(destination, ArrayObject)
                   and len(destination) == 5 and destination[1] == '/XYZ'
                   and getattr(destination[0], 'idnum', None) == cover.indirect_reference.idnum
                   and getattr(destination[0], 'generation', None) == cover.indirect_reference.generation
                   and not isinstance(destination[2], NullObject)
                   and not isinstance(destination[3], NullObject)
                   and float(destination[2]) == 0
                   and abs(float(destination[3]) - float(cover.mediabox.top)) < 0.001)
            if bad:
                removed_ids.add(ref.idnum)
                if '/StructParent' in annotation:
                    parent_keys.add(int(annotation['/StructParent']))
                removed_by_page[index + 1] = removed_by_page.get(index + 1, 0) + 1
            else:
                kept.append(ref)
        if '/Annots' in page:
            page[NameObject('/Annots')] = ArrayObject(kept)

    objr_count = 0
    catalog = document.root_object if hasattr(document, 'root_object') else document.trailer['/Root']
    structure = _object(catalog.get('/StructTreeRoot'))
    visited = set()

    def clean_structure(ref):
        nonlocal objr_count
        node = _object(ref)
        if not isinstance(node, DictionaryObject) or id(node) in visited:
            return
        visited.add(id(node))
        kids = node.get('/K')
        if kids is None:
            return
        was_array = isinstance(kids, ArrayObject)
        children = list(kids) if was_array else [kids]
        kept = []
        direct_removed = False
        remaining_objr = False
        for child in children:
            item = _object(child)
            if isinstance(item, DictionaryObject) and item.get('/Type') == '/OBJR':
                obj = item.get('/Obj')
                if getattr(obj, 'idnum', None) in removed_ids:
                    objr_count += 1
                    direct_removed = True
                    continue
                remaining_objr = True
            else:
                clean_structure(child)
            kept.append(child)
        node[NameObject('/K')] = ArrayObject(kept) if was_array else (kept[0] if kept else ArrayObject())
        if direct_removed and not remaining_objr and node.get('/S') == '/Link':
            node[NameObject('/S')] = NameObject('/Span')

    def clean_parent_tree(ref, *, root=False):
        node = _object(ref)
        keys = []
        if '/Nums' in node:
            pairs = node['/Nums']
            kept = ArrayObject()
            for i in range(0, len(pairs), 2):
                key = int(pairs[i])
                if key not in parent_keys:
                    kept.extend(pairs[i:i + 2])
                    keys.append(key)
            node[NameObject('/Nums')] = kept
        if '/Kids' in node:
            kept = ArrayObject()
            for child in node['/Kids']:
                bounds = clean_parent_tree(child)
                if bounds is not None:
                    kept.append(child)
                    keys.extend(bounds)
            node[NameObject('/Kids')] = kept
        if not keys:
            node.pop('/Limits', None)
            return None
        bounds = (min(keys), max(keys))
        if not root:
            node[NameObject('/Limits')] = ArrayObject(NumberObject(k) for k in bounds)
        elif '/Limits' in node:
            node[NameObject('/Limits')] = ArrayObject(NumberObject(k) for k in bounds)
        return bounds

    if structure is not None:
        clean_structure(structure)
        if '/ParentTree' in structure:
            clean_parent_tree(structure['/ParentTree'], root=True)
    if parent_keys and objr_count != len(parent_keys):
        raise ValueError('Unexpected bibliography annotation structure references')
    return {'removed_links': len(removed_ids), 'removed_OBJR': objr_count,
            'removed_parent_tree_keys': len(parent_keys),
            'removed_by_physical_page': removed_by_page}


def bibliography_backlink_references(document_metadata):
    """Validate complete first-citation backlinks and adapt them for check_links."""
    items = [item for item in document_metadata['metadata']
             if isinstance(item, dict) and isinstance(item.get('value'), dict)]
    citations = [item for item in items
                 if item['value'].get('kind') == 'cross-reference'
                 and item['value'].get('target', '').startswith('bib:')]
    backlinks = [item for item in items
                 if item['value'].get('kind') == 'bibliography-backlink']

    def points(value):
        if not isinstance(value, str) or not value.endswith('pt'):
            raise ValueError('Expected a position measured in points')
        return float(value[:-2])

    def order(item):
        position = item['position']
        return position['page'], points(position['y']), points(position['x'])

    first = {}
    for item in sorted(citations, key=order):
        if not item['value'].get('resolved'):
            raise ValueError('Unresolved bibliography citation')
        key = item['value']['target'][4:]
        first.setdefault((key, item['position']['page']), item['position'])
    seen = set()
    records = []
    for item in backlinks:
        value = item['value']
        target = value['target-position']
        pair = (value['key'], target['page'])
        if pair in seen or pair not in first or target != first[pair]:
            raise ValueError('Duplicate, unexpected, or incorrectly positioned bibliography backlink')
        seen.add(pair)
        destination = value['destination']
        exported = value['link-input']
        if (destination['page'] != target['page'] or points(destination['x']) != 0
                or abs(points(destination['y']) - max(0, points(target['y']) - 12)) > 0.001
                or exported['page'] != destination['page']
                or points(exported['x']) != points(destination['x'])
                or abs(points(exported['y']) - points(destination['y']) - 10) > 0.001):
            raise ValueError('Incorrect bibliography backlink navigation offset')
        records.append({'resolved': True, 'target': 'backlink:' + value['key'],
                        'position': item['position'], 'target-position': exported,
                        'description': 'Cited on page ' + value['page-label']})
    if seen != set(first):
        raise ValueError('Missing bibliography backlinks')
    return records
