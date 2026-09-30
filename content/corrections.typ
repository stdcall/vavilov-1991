#import "main-defs.typ" as book-defs

#show: book-defs.reference-rules
#let book-scope = dictionary(book-defs)
#let section-order(section) = {
  if section == "Introduction" {
    0
  } else if section == "References" {
    15
  } else {
    int(section.split(".").first())
  }
}
#let entries = (
  json("../corrections.json")
    .entries
    .sorted(
      key: entry => (
        section-order(entry.section),
        entry.printed_page,
        entry.id,
      ),
    )
)
#let markup(field) = eval(field, mode: "markup", scope: book-scope)

#set document(
  title: "Vavilov: Structure of Chevalley Groups over Commutative Rings"
    + ". Revisions",
  author: "Nikolai A. Vavilov",
  date: none,
)
#set page(
  width: 176mm,
  height: 250mm,
  margin: (x: 20mm, top: 21mm, bottom: 21mm),
  footer: context align(center, text(size: 10pt, counter(page).display())),
)
#set text(font: "Libertinus Serif", size: 11pt, lang: "en", region: "gb")
#set par(justify: true, leading: 0.65em, spacing: 0.8em)
#show math.equation: set text(font: "STIX Two Math")
#show math.equation: it => {
  show ":": math.class("punctuation", ":")
  show "≥": sym.gt.eq.slant
  show "≤": sym.lt.eq.slant
  show regex("[\u{0391}-\u{03A9}]"): math.italic
  it
}

#align(center, text(size: 16pt)[Corrections and editorial revisions])

N. A.~Vavilov, _Structure of Chevalley Groups over Commutative Rings_, World
Scientific, 1991. The entries distinguish errors from added definitions,
clarifications, and revised arguments. Page numbers refer to the 1991
publication; descriptions of previous readings may summarize a passage.

#show heading: set text(size: 12pt)
#show heading: set block(above: 1.6em, below: 0.8em)

#if entries.len() == 0 [
  No corrections have been recorded yet.
] else {
  let section = none
  for entry in entries {
    if entry.section != section {
      section = entry.section
      heading(level: 1, section)
    }
    block(breakable: false, above: 1em)[
      #metadata((correction: entry.id))
      *#entry.id* · p. #entry.printed_page#if (
        entry.place != entry.section
      ) [, #entry.place]

      Previous reading: #markup(entry.original)

      This edition: #markup(entry.corrected)

      #text(size: 10pt, markup(entry.reason))
    ]
  }
}
