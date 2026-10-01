#import "@preview/cetz:0.5.2": canvas, draw
#import "../main-defs.typ": quotient

#let square(nodes, labels, x-gap: 3, y-gap: 1.3) = canvas({
  import draw: *
  set-style(stroke: 0.6pt, content: (
    wrap: text.with(top-edge: "bounds", bottom-edge: "bounds"),
  ))
  let points = ((0, y-gap), (x-gap, y-gap), (0, 0), (x-gap, 0))
  for (i, body) in nodes.enumerate() {
    content(points.at(i), body, name: "node" + str(i))
  }
  let edges = ((0, 1), (0, 2), (1, 3), (2, 3))
  for (i, edge) in edges.enumerate() {
    line("node" + str(edge.at(0)), "node" + str(edge.at(1)), mark: (
      end: "stealth",
    ))
    let a = points.at(edge.at(0))
    let b = points.at(edge.at(1))
    content(
      (
        (a.at(0) + b.at(0)) / 2 - if i in (1, 2) { 0.3 } else { 0 },
        (a.at(1) + b.at(1)) / 2 + if i in (0, 3) { 0.3 } else { 0 },
      ),
      labels.at(i),
    )
  }
})

#let double-square() = square(
  ($R times_I R$, $R$, $R$, $quotient(R, I)$),
  ($pi_1$, $pi_2$, $pi$, $pi$),
  x-gap: 2.5,
)

#let relative-square() = square(
  (
    $E(Phi,D)$,
    $E(Phi,R)$,
    $E(Phi,R)$,
    $E(Phi,quotient(R, I))$,
  ),
  ($pi_1$, $pi_2$, $pi$, $pi$),
  x-gap: 3.8,
)
