#import "diagrams/cover-weights.typ": e6-weight-diagram

#page(
  width: 176mm,
  height: 250mm,
  margin: 20mm,
  numbering: none,
  header: none,
  footer: none,
  fill: rgb("101d2e"),
)[
  #set text(font: "TeX Gyre Heros", fill: rgb("f7f2e7"))
  #show math.equation: set text(font: "STIX Two Math")
  #set par(first-line-indent: 0pt, justify: false)
  #text(size: 11pt, tracking: 0.13em)[NIKOLAI A. VAVILOV]
  #v(17mm)
  #text(size: 26pt, weight: "bold")[
    Structure of\ Chevalley Groups\ over Commutative Rings
  ]
  #v(19mm)
  #align(center, e6-weight-diagram())
  #v(1fr)
  #line(length: 100%, stroke: 0.45pt + rgb("677481"))
  #v(4mm)
  #text(size: 9pt, fill: rgb("bdc5cd"))[1991 / AI revised edition]
]
