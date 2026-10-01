import importlib.util
from pathlib import Path
import sys
import tempfile
import unittest

import pymupdf
from pypdf import PdfReader, PdfWriter
from pypdf.generic import (
    ArrayObject, DictionaryObject, FloatObject, NameObject, NullObject,
)

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'scripts'))
from build import normalize_outline_destinations
from check_links import check_links

spec = importlib.util.spec_from_file_location(
    'axiom_audit', ROOT / 'checks/lean/check_axioms.py')
axioms = importlib.util.module_from_spec(spec)
spec.loader.exec_module(axioms)


class LeanAuditTests(unittest.TestCase):
    def test_allowed_axioms_and_axiom_free_proof(self):
        record = {'declarations': ['P.one', 'P.two']}
        output = ("'P.one' depends on axioms: [propext, Classical.choice, Quot.sound]\n"
                  "'P.two' does not depend on any axioms\n")
        self.assertEqual(axioms.audit(record, output, 0), [])

    def test_rejects_incomplete_or_untrusted_compilation(self):
        good = "'P.one' does not depend on any axioms\n"
        cases = [
            (good, 1, 'lean exited'),
            (good + 'Proof.lean:3:2: error: failed\n', 0, 'compiler error'),
            (good + 'Proof.lean:3:2: warning: unused\n', 0, 'compiler warning'),
            ("'P.one' depends on axioms: [sorryAx]\n", 0, 'sorryAx'),
            ("'P.one' depends on axioms: [P.assumption]\n", 0, 'P.assumption'),
            ('', 0, 'missing'),
            (good + "'P.extra' does not depend on any axioms\n", 0, 'unlisted'),
            (good + good, 0, 'printed twice'),
        ]
        for output, code, expected in cases:
            with self.subTest(expected=expected):
                self.assertTrue(any(expected in p for p in axioms.audit(
                    {'declarations': ['P.one']}, output, code)))


class PdfNavigationTests(unittest.TestCase):
    def test_nested_bookmarks_keep_heights_and_page_contents(self):
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / 'source.pdf'
            output = Path(directory) / 'normalized.pdf'
            document = pymupdf.open()
            for width, height in [(300, 400), (350, 500)]:
                page = document.new_page(width=width, height=height)
                page.insert_text((20, 40), 'Preserved text')
            document.save(source)
            document.close()
            original = PdfReader(source)
            writer = PdfWriter(clone_from=original)
            from pypdf.generic import Fit
            parent = writer.add_outline_item('Chapter', 0, fit=Fit.xyz(42, 360, 2))
            writer.add_outline_item('Section', 1, parent=parent,
                                    fit=Fit.xyz(55, 430, 3))
            node = parent.get_object()
            node[NameObject('/Dest')] = node['/A']['/D']
            del node['/A']
            self.assertEqual(normalize_outline_destinations(
                writer, original, left=0, headings=[
                    {"level": 1, "prefix": "Chapter 1.", "bookmarked": True},
                    {"level": 2, "prefix": "§ 6.", "bookmarked": True}]), 2)
            writer.write(output)
            reader = PdfReader(output)
            self.assertEqual(len(reader.pages), 2)
            for before, after in zip(original.pages, reader.pages):
                self.assertEqual(list(before.mediabox), list(after.mediabox))
                self.assertEqual(list(before.cropbox), list(after.cropbox))
                self.assertEqual(before.get_contents().get_data(),
                                 after.get_contents().get_data())
                self.assertEqual(before.extract_text(), after.extract_text())
            top = reader.trailer['/Root']['/Outlines']['/First'].get_object()
            self.assertEqual(top['/Title'], 'Chapter 1. Chapter')
            self.assertEqual(top['/First'].get_object()['/Title'], '§ 6. Section')
            for index, (node, expected_top) in enumerate([
                    (top, 360), (top['/First'].get_object(), 430)]):
                dest = node.get('/Dest', node.get('/A', {}).get('/D'))
                self.assertEqual(dest[0].idnum,
                                 reader.pages[index].indirect_reference.idnum)
                self.assertEqual(str(dest[1]), '/XYZ')
                self.assertEqual(float(dest[2]), 0)
                self.assertEqual(float(dest[3]), expected_top)
                self.assertIsInstance(dest[4], NullObject)

    def test_wrong_backlink_page_or_height_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'links.pdf'
            writer = PdfWriter()
            writer.add_blank_page(300, 400)
            writer.add_blank_page(300, 400)
            dest = ArrayObject([writer.pages[1].indirect_reference,
                                NameObject('/XYZ'), FloatObject(0),
                                FloatObject(310), NullObject()])
            annotation = DictionaryObject({
                NameObject('/Type'): NameObject('/Annot'),
                NameObject('/Subtype'): NameObject('/Link'),
                NameObject('/Rect'): ArrayObject([FloatObject(n)
                    for n in [20, 350, 100, 370]]),
                NameObject('/Dest'): dest,
            })
            writer.pages[0][NameObject('/Annots')] = ArrayObject([annotation])
            writer.write(path)
            reference = {'resolved': True, 'target': 'bib:Article',
                         'position': {'page': 1, 'x': '20pt', 'y': '35pt'},
                         'target-position': {'page': 2, 'y': '100pt'}}
            self.assertEqual(check_links(path, [reference])[
                'semantic_references_checked'], 1)
            for target, message in [({'page': 1, 'y': '100pt'}, 'wrong target page'),
                                    ({'page': 2, 'y': '120pt'}, 'wrong target height')]:
                with self.subTest(target=target):
                    with self.assertRaisesRegex(AssertionError, message):
                        check_links(path, [{**reference, 'target-position': target}])


if __name__ == '__main__':
    unittest.main()
