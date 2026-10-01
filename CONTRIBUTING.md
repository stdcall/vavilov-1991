# Building and editing

The article is set in Typst 0.15.1. Run `just build` for the reading edition,
`just build-no-notes` to omit editorial notes, and `just corrections` for
the corrections list. The fonts and their licences are in `assets/fonts`.
Every build uses these fonts exclusively.

The edition has independent pagination: its cover is unnumbered and outside
the page count, the contents use lower-case Roman numerals starting at i,
and the introduction begins Arabic pagination at 1. Page labels follow this
scheme. The article's three chapters and fourteen sections retain their
authorial sequence. Section numbering continues across chapter boundaries.
Subsections use section.subsection numbers. The erroneous section headings
in the examples chapter are reconciled with the author's contents.

Files in `content` are plain markup included by `main.typ`. Import symbols
from `main-defs.typ` and statements from `statements.typ`. Write literal,
semantic labels immediately after their targets and use native `@label`
references. Citations use `#citation[@bib:AuthorYear]`; the original
bibliography is numbered and every supplementary reference has a mnemonic
display code defined in `bibliography-codes.typ`. The BibLaTeX keys remain
AuthorYear keys in
both cases. Add a verified theorem, section or page locator when it helps
the reader find the cited argument. Place the citation within the sentence
or clause it supports, before its final punctuation. A citation must not
begin a sentence or stand between two sentences. If it supports a longer
argument, name that argument explicitly. Apply these rules in editorial
notes as well. Bibliography names are printed with initials.
Bibliographic data belong in `references.bib`, supplementary literature in
`editorial.bib`. Editorial notes use `#ed-note[...]` and may be disabled.
Store verified DOI identifiers in the bibliography records. Access URLs are
printed in full; grouped references identify each linked part explicitly.

Write quotient rings, groups, modules and coset spaces as `quotient(A,B)`.
This uses a horizontal slash; ordinary arithmetic fractions keep `/`.

Use ordinary headings: chapter `=`, section `==`, subsection `===`.
Unnumbered front matter uses level 1 headings with `<front:meaning>` labels;
its compact appearance is set centrally without changing its logical level.
Theorems use `#theorem[...] <th:meaning>`, and unnumbered lemmas use
`#lemma[...] <lem:meaning>`. Numbered displays have literal `<eq:meaning>`
labels; unlabelled displays remain unnumbered. Automatic numbering is
configured centrally as (section.formula). A reference may include a name,
such as `@eq:freudenthal-transvection[the Freudenthal transvection formula]`;
its number is appended automatically. Captioned figures use
`#numbered-figure(body, caption: [...]) <fig:meaning>`.

Both bibliographies list the pages on which each work is cited. Each page
number links to the first visible citation on that page, with a small margin
above its line. The build validates these targets against the PDF links.

Do not add local layout rules, manual spacing, forced formula breaks or
preview wrappers to article files. Diagrams are vector functions built from
mathematical data. Shared style changes belong in `book-style.typ`.
Keep lines within 80 characters and run `just fmt`.

Keep `#source` metadata within a paragraph when the original page ends in
the middle of that paragraph. It must not introduce a new paragraph.
Centre standalone diagrams with `#align(center, ...)`; use dark strokes
and construct their mathematical data from the defining objects.

Confirmed errors and substantive revisions belong in `corrections.json`,
with the printed reading, adopted text, explanation and verification.
An adapted replacement based on a later paper carries a short editorial
note naming that source. Mathematical checks state their hypotheses and
coverage explicitly; Lean declarations bind to passage labels.

PDF bookmark titles include the evaluated heading prefix from `numbering.typ`;
printed headings and contents use the same numbering. Outline normalization
preserves hierarchy, target heights and the current viewer zoom.
