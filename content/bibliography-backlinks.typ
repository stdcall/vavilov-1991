#let bibliography-backlinks(key) = context {
  let references = query(<citation-point>)
    .filter(it => it.value.key == key)
    .sorted(key: it => {
      let pos = it.location().position()
      (pos.page, pos.y, pos.x)
    })
  let pages = ()
  let links = ()
  for reference in references {
    let loc = reference.location()
    let page = counter(page).at(loc).first()
    if page not in pages {
      pages.push(page)
      let position = loc.position()
      let destination = (
        page: position.page,
        x: 0pt,
        y: calc.max(0pt, position.y - 12pt),
      )
      // Explicit PDF positions receive Typst's 10pt navigation offset.
      let exported = (..destination, y: destination.y + 10pt)
      let record = (
        kind: "bibliography-backlink",
        key: key,
        page-label: str(page),
        target-position: position,
        destination: destination,
        link-input: exported,
      )
      links.push(link(exported, box[#metadata(record)#str(page)]))
    }
  }
  if links.len() > 0 {
    text(size: 0.82em)[ Cited on #links.join(", ").]
  }
}
