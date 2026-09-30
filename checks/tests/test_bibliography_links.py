"""Regression checks for the narrowly scoped full-citation PDF cleanup."""
import io
from pathlib import Path
import sys
import unittest

from pypdf import PdfReader, PdfWriter
from pypdf.generic import (ArrayObject, DictionaryObject, NameObject,
                           NullObject, NumberObject, FloatObject, TextStringObject)

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / 'scripts'))
from bibliography_links import (strip_hidden_bibliography_links,
                                bibliography_backlink_references)


def dictionary(**entries):
    return DictionaryObject({NameObject('/' + key): value for key, value in entries.items()})


def fixture():
    writer = PdfWriter()
    for _ in range(3):
        writer.add_blank_page(width=200, height=300)
    cover, body, bibliography = writer.pages

    def annotation(page, destination=None, uri=None, parent=None):
        item = dictionary(Subtype=NameObject('/Link'), Rect=ArrayObject(map(NumberObject, [0, 0, 10, 10])))
        if destination is not None:
            item[NameObject('/Dest')] = destination
        if uri is not None:
            item[NameObject('/A')] = dictionary(S=NameObject('/URI'), URI=TextStringObject(uri))
        if parent is not None:
            item[NameObject('/StructParent')] = NumberObject(parent)
        ref = writer._add_object(item)
        page.setdefault(NameObject('/Annots'), ArrayObject()).append(ref)
        return ref

    def destination(page, x=0, y=300):
        return ArrayObject([page.indirect_reference, NameObject('/XYZ'),
                            NumberObject(x) if x is not None else NullObject(),
                            NumberObject(y) if y is not None else NullObject(), NullObject()])

    removed = annotation(bibliography, destination(cover), parent=0)
    annotation(body, destination(cover))  # Outside the bibliography range.
    kept = annotation(bibliography, destination(body, y=150), parent=2)
    annotation(bibliography, uri='https://example.org')
    annotation(bibliography, destination(cover, x=None, y=None))
    stale_link = writer._add_object(dictionary(
        Type=NameObject('/StructElem'), S=NameObject('/Link'),
        K=ArrayObject([NumberObject(0), dictionary(Type=NameObject('/OBJR'), Obj=removed)])))
    live_link = writer._add_object(dictionary(
        Type=NameObject('/StructElem'), S=NameObject('/Link'),
        K=ArrayObject([NumberObject(1), dictionary(Type=NameObject('/OBJR'), Obj=kept)])))
    empty_leaf = writer._add_object(dictionary(
        Nums=ArrayObject([NumberObject(0), stale_link]),
        Limits=ArrayObject([NumberObject(0), NumberObject(0)])))
    live_leaf = writer._add_object(dictionary(
        Nums=ArrayObject([NumberObject(2), live_link]),
        Limits=ArrayObject([NumberObject(2), NumberObject(2)])))
    branch = writer._add_object(dictionary(
        Kids=ArrayObject([empty_leaf, live_leaf]),
        Limits=ArrayObject([NumberObject(0), NumberObject(2)])))
    tree = dictionary(Kids=ArrayObject([branch]))
    structure = dictionary(Type=NameObject('/StructTreeRoot'),
                           K=ArrayObject([stale_link, live_link]), ParentTree=tree)
    writer.root_object[NameObject('/StructTreeRoot')] = writer._add_object(structure)
    output = io.BytesIO()
    writer.write(output)
    output.seek(0)
    return output


class BibliographyLinksTests(unittest.TestCase):
    def test_backlink_completeness_and_first_visual_citation(self):
        source = {'page': 2, 'x': '20pt', 'y': '40pt'}
        later = {'page': 2, 'x': '20pt', 'y': '80pt'}
        citation = lambda position: {'position': position, 'value': {
            'kind': 'cross-reference', 'target': 'bib:Example2020', 'resolved': True}}
        backlink = {'position': {'page': 3, 'x': '30pt', 'y': '50pt'}, 'value': {
            'kind': 'bibliography-backlink', 'key': 'Example2020', 'page-label': '1',
            'target-position': source,
            'destination': {'page': 2, 'x': '0pt', 'y': '28pt'},
            'link-input': {'page': 2, 'x': '0pt', 'y': '38pt'}}}
        metadata = {'metadata': [citation(later), citation(source), backlink]}
        records = bibliography_backlink_references(metadata)
        self.assertEqual(len(records), 1)
        self.assertEqual(records[0]['position'], backlink['position'])
        with self.assertRaises(ValueError):
            bibliography_backlink_references({'metadata': metadata['metadata'] + [backlink]})
        with self.assertRaises(ValueError):
            bibliography_backlink_references({'metadata': metadata['metadata'][:-1]})
        backlink['value']['target-position'] = later
        with self.assertRaises(ValueError):
            bibliography_backlink_references(metadata)

    def test_reader_and_writer_preserve_links_and_structure(self):
        for kind in ('reader', 'writer'):
            with self.subTest(kind=kind):
                reader = PdfReader(fixture())
                document = reader if kind == 'reader' else PdfWriter(clone_from=reader)
                report = strip_hidden_bibliography_links(document, {'metadata': [
                    {'value': None}, {'value': 'unrelated'},
                    {'value': {'kind': 'numbered', 'family': 'bib'},
                     'position': {'page': 3}}]})
                self.assertEqual(report['removed_links'], 1)
                self.assertEqual(report['removed_OBJR'], 1)
                self.assertEqual(len(document.pages[1]['/Annots']), 1)
                self.assertEqual(len(document.pages[2]['/Annots']), 3)
                catalog = document.root_object if kind == 'writer' else document.trailer['/Root']
                structure = catalog['/StructTreeRoot']
                stale, live = [ref.get_object() for ref in structure['/K']]
                self.assertEqual(stale['/S'], '/Span')
                self.assertEqual(stale['/K'], [0])
                self.assertEqual(live['/S'], '/Link')
                self.assertEqual(live['/K'][0], 1)
                self.assertEqual(live['/K'][1]['/Type'], '/OBJR')
                branch = structure['/ParentTree']['/Kids'][0].get_object()
                self.assertEqual(branch['/Limits'], [2, 2])
                self.assertEqual(len(branch['/Kids']), 1)
                self.assertEqual(branch['/Kids'][0].get_object()['/Nums'][0], 2)
                annotations = [ref.get_object() for ref in document.pages[2]['/Annots']]
                self.assertEqual(annotations[0]['/Dest'][3], 150)
                self.assertEqual(annotations[1]['/A']['/URI'], 'https://example.org')
                self.assertIsInstance(annotations[2]['/Dest'][2], NullObject)


if __name__ == '__main__':
    unittest.main()
