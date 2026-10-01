// Three chapters; sections continue through the whole article.
#let family-counter(family) = counter("numbered:" + family)
#let section-offset(chapter) = (
  query(heading.where(level: 2))
    .filter(it => (
      it.numbering != none
        and counter(heading).at(it.location()).first() < chapter
    ))
    .len()
)
#let section-number(location) = {
  let n = counter(heading).at(location)
  section-offset(n.first()) + n.at(1, default: 0)
}
#let place-key(location) = {
  let n = counter(heading).at(location)
  (n.first(), section-number(location), n.at(2, default: 0))
}
#let restart-counters(level) = {
  if level <= 2 { family-counter("eq").update(0) }
}
#let object-number(family, location) = {
  let n = family-counter(family).at(location).first()
  if family == "eq" { (section-number(location), n) } else { (n,) }
}
#let record(family) = context [#metadata((
  kind: "numbered",
  family: family,
  number: object-number(family, here()),
))<numbered>]
#let numbered-record(target) = {
  if query(target).len() != 1 { return none }
  query(selector(<numbered>).within(target)).at(0, default: none)
}
#let record-number(item) = {
  if item.value.kind == "unnumbered" { return none }
  if item.value.family != "heading" { return item.value.number }
  let level = item.value.level
  if level == 1 { (counter(heading).at(item.location()).first(),) } else if (
    level == 2
  ) { (section-number(item.location()),) } else {
    (
      section-number(item.location()),
      counter(heading).at(item.location()).at(2),
    )
  }
}

#let heading-prefix(..numbers) = {
  let n = numbers.pos()
  if n.len() == 1 { "Chapter " + str(n.first()) + "." } else if n.len() == 2 {
    "§ " + str(section-offset(n.first()) + n.at(1)) + "."
  } else {
    str(section-offset(n.first()) + n.at(1)) + "." + str(n.last())
  }
}
