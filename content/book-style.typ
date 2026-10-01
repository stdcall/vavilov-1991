#import "numbering.typ": heading-prefix, restart-counters
#import "main-defs.typ": reference-rules
#import "statements.typ": numbered-display

#let book-style(body) = {
  set page(
    width: 176mm,
    height: 250mm,
    margin: (x: 20mm, top: 20mm, bottom: 20mm),
    numbering: "1",
    footer: context align(center, text(size: 9pt, counter(page).display())),
  )
  set text(
    font: "Libertinus Serif",
    size: 11.5pt,
    lang: "en",
    region: "gb",
    fill: rgb("20252b"),
  )
  set par(
    justify: true,
    leading: 0.6em,
    first-line-indent: 1.2em,
    spacing: 0.8em,
  )
  show link: set text(fill: rgb("20252b"))
  show math.equation: set text(font: "STIX Two Math")
  show math.equation: it => {
    show ":": math.class("punctuation", ":")
    show "≥": sym.gt.eq.slant
    show "≤": sym.lt.eq.slant
    it
  }
  show math.equation.where(block: true): set block(
    above: 0.8em,
    below: 0.8em,
  )
  show math.equation.where(block: true): it => {
    if it.has("label") and str(it.label).starts-with("eq:") {
      numbered-display(it)
    } else { it }
  }
  set heading(numbering: (..numbers) => context heading-prefix(..numbers))
  show heading: it => {
    if it.level == 1 and it.numbering == none { pagebreak(weak: true) }
    if it.numbering != none {
      restart-counters(it.level)
      [#metadata((
        kind: "numbered",
        family: "heading",
        level: it.level,
      ))<numbered>]
    }
    let number = if it.numbering != none {
      numbering(it.numbering, ..counter(heading).at(it.location()))
    } else { [] }
    block(
      width: 100%,
      sticky: true,
      above: if it.level == 1 { 12mm } else if it.level == 2 {
        7mm
      } else { 5mm },
      below: if it.level == 1 { 5mm } else if it.level == 2 {
        3.5mm
      } else { 2.5mm },
      text(
        size: if it.level == 1 { 19pt } else if it.level == 2 {
          14pt
        } else { 11.5pt },
        weight: "semibold",
      )[#number #it.body],
    )
  }
  set footnote.entry(
    separator: line(length: 28%, stroke: 0.4pt),
    clearance: 0.8em,
    gap: 0.5em,
  )
  show footnote.entry: set text(size: 9pt)
  show footnote.entry: set par(first-line-indent: 0pt)
  show figure.caption: set text(size: 10pt)
  set outline(indent: 1.6em)
  set outline.entry(fill: repeat(gap: 0.3em)[.])
  show outline: set text(size: 11pt)
  show outline.entry: it => {
    set par(first-line-indent: 0pt, justify: false, leading: 0.65em)
    set text(weight: if it.level <= 2 { "semibold" } else { "regular" })
    block(
      breakable: false,
      sticky: it.level <= 2,
      above: if it.level == 1 { 1.5em } else if it.level == 2 {
        0.95em
      } else { 0.65em },
      below: 0.65em,
      link(it.element.location(), if it.element.numbering == none {
        it.inner()
      } else { it.indented(it.prefix(), it.inner()) }),
    )
  }
  show: reference-rules
  body
}
