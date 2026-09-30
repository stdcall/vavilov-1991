#import "numbering.typ": family-counter, object-number, record
#import "bibliography-codes.typ": bibliography-code, bibliography-codes
#import "bibliography-backlinks.typ": bibliography-backlinks

#let statement(kind, family, body, numbered: false, italic: false) = {
  if numbered { family-counter(family).step() }
  block(above: 0.8em, below: 0.8em, breakable: true)[
    #if numbered { record(family) } else [#metadata((
      kind: "unnumbered",
      family: family,
      number: none,
    ))<numbered>]
    #text(style: "normal", weight: "semibold")[
      #kind#if numbered [ #context object-number(family, here()).first()].
    ] #text(style: if italic { "italic" } else { "normal" }, body)
  ]
}
#let theorem(body, numbered: true) = statement(
  "Theorem",
  "th",
  body,
  numbered: numbered,
)
#let proposition(body, numbered: false) = statement(
  "Proposition",
  "prop",
  body,
  numbered: numbered,
)
#let lemma(body, numbered: false) = statement(
  "Lemma",
  "lem",
  body,
  numbered: numbered,
)
#let corollary(body, numbered: false) = statement(
  "Corollary",
  "cor",
  body,
  numbered: numbered,
)
#let definition(body) = statement("Definition", "def", body)
#let example(body, numbered: false) = statement(
  "Example",
  "exm",
  body,
  numbered: numbered,
)
#let remark(body) = statement("Remark", "rem", body)
#let proof(body) = block(above: 0.6em, below: 0.8em, breakable: true)[
  _Proof._ #body
]
#let numbered-figure(body, caption: none) = {
  family-counter("fig").step()
  figure(
    [#record("fig")#body],
    caption: caption,
    numbering: _ => context object-number("fig", here()).first(),
  )
}
#let bib-item(body, key: none) = {
  let named = key != none and key in bibliography-codes
  if not named { family-counter("bib").step() }
  context {
    let code = if named { bibliography-code(key) } else {
      object-number("bib", here()).first()
    }
    block(above: 0.65em, below: 0.65em)[
      #set text(size: 10.5pt)
      #metadata((kind: "numbered", family: "bib", number: (code,)))<numbered>
      #text(weight: "semibold")[\[#code\]] #body#if (
        key != none
      ) {
        bibliography-backlinks(key)
      }
    ]
  }
}
#let numbered-display(it) = {
  family-counter("eq").step()
  context {
    record("eq")
    math.equation(
      block: true,
      number-align: end + horizon,
      numbering: _ => [(#object-number("eq", here()).map(str).join("."))],
      it.body,
    )
  }
}
