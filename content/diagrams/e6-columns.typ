#import "@preview/cetz:0.5.2"

#let roots = ($α$, $β$, $γ$, $δ$, $ε$)
#let coordinates = (
  $ω$,
  $τ$,
  $α β$,
  $α γ$,
  $β γ$,
  $α δ$,
  $β δ$,
  $α ε$,
  $β ε$,
  $γ δ$,
  $γ ε$,
  $ε$,
  $ε$,
  $δ ε$,
  $δ$,
  $δ$,
  $γ$,
  $γ$,
  $β$,
  $β$,
  $α$,
  $α$,
  $α$,
  $β$,
  $γ$,
  $δ$,
  $ε$,
)
#let coordinate(i, base: $u$) = math.attach(base, b: coordinates.at(i), t: if i
  in (11, 14, 16, 18, 20) { sym.prime.double } else if i
  in (12, 15, 17, 19, 21) { sym.prime })

#let weight-layout(graph) = {
  let direction = (-3, -1, -3, 1, 1, 3)
  let ranks = graph.root_coordinates.map(c => c.sum())
  let scores = graph.root_coordinates.map(c => (
    c.zip(direction).map(((a, b)) => a * b).sum()
  ))
  ranks
    .enumerate()
    .map(((i, rank)) => {
      let layer = range(27)
        .filter(j => ranks.at(j) == rank)
        .sorted(key: j => scores.at(j))
      (rank * 6.6, (layer.position(j => j == i) - (layer.len() - 1) / 2) * 7)
    })
}

#let e6-column-diagram(mode: "coordinates") = {
  assert(mode in ("weights", "actions", "coordinates"))
  let graph = json("e6-weights.json")
  let actions = json("e6-stabiliser.json").actions
  let points = weight-layout(graph)
  cetz.canvas(length: 1mm, {
    import cetz.draw: *
    set-style(stroke: (paint: luma(10%), thickness: 0.65pt))
    for (a, b, root) in graph.edges {
      let pa = points.at(a)
      let pb = points.at(b)
      line(pa, pb)
      if mode == "weights" {
        content(((pa.at(0) + pb.at(0)) / 2, (pa.at(1) + pb.at(1)) / 2), box(
          fill: white,
          inset: 0.3pt,
          text(size: 6.5pt, str(root)),
        ))
      }
    }
    for (i, point) in points.enumerate() {
      circle(point, radius: 0.55, fill: white)
      if mode == "coordinates" {
        content(
          (point.at(0), point.at(1) + 1.6),
          text(size: 8pt, coordinate(i)),
          anchor: "south",
        )
      } else if mode == "weights" and (i < 2 or i >= 11) {
        content(
          (point.at(0), point.at(1) + 1.6),
          text(size: 8pt, coordinate(i, base: $x$)),
          anchor: "south",
        )
      } else if mode == "actions" {
        for (row, sign) in ((0, 1), (1, -1)) {
          let selected = range(5).filter(r => (
            actions.at(r).any(edge => edge.at(row) == i)
          ))
          if selected.len() > 0 {
            line(point, (point.at(0), point.at(1) + sign * 2), stroke: (
              dash: "dotted",
              thickness: 0.4pt,
            ))
            content(
              (point.at(0), point.at(1) + sign * 2.2),
              text(size: 7pt, selected.map(r => roots.at(r)).join()),
              anchor: if sign > 0 { "south" } else { "north" },
            )
          }
        }
      }
    }
  })
}
