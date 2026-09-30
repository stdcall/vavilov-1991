#import "@preview/cetz:0.5.2": canvas, draw

#let weight-chain(weights, marks) = canvas({
  import draw: *
  set-style(stroke: 0.6pt, content: (
    wrap: text.with(top-edge: "bounds", bottom-edge: "bounds"),
  ))
  for (i, weight) in weights.enumerate() {
    let p = (i, 0)
    if weight == none {
      content(p, $dots$)
    } else {
      circle(p, radius: 0.06, fill: white)
      content((i, -0.35), weight)
    }
    if i > 0 and marks.at(i - 1) != none {
      line((i - 1, 0), p)
      content((i - 0.5, 0.3), marks.at(i - 1))
    }
  }
})

#let type-a() = weight-chain(
  ($e_1$, $e_2$, $e_3$, none, $e_(ell - 1)$, $e_ell$, $e_(ell + 1)$),
  ($1$, $2$, none, none, $ell - 1$, $ell$),
)

#let type-b() = weight-chain(
  (
    $e_1$,
    $e_2$,
    $e_3$,
    none,
    $e_ell$,
    $0$,
    $e_(-ell)$,
    none,
    $e_(-3)$,
    $e_(-2)$,
    $e_(-1)$,
  ),
  ($1$, $2$, none, none, $ell$, $ell$, none, none, $2$, $1$),
)

#let type-c() = weight-chain(
  (
    $e_1$,
    $e_2$,
    $e_3$,
    none,
    $e_(ell - 1)$,
    $e_ell$,
    $e_(-ell)$,
    $e_(-ell + 1)$,
    none,
    $e_(-3)$,
    $e_(-2)$,
    $e_(-1)$,
  ),
  ($1$, $2$, none, none, $ell - 1$, $ell$, $ell - 1$, none, none, $2$, $1$),
)

#let type-g() = weight-chain(
  ($e_1$, $e_(-2)$, $e_(-3)$, $0$, $e_3$, $e_2$, $e_(-1)$),
  ($1$, $2$, $1$, $1$, $2$, $1$),
)

#let type-d() = canvas({
  import draw: *
  set-style(stroke: 0.6pt, content: (
    wrap: text.with(top-edge: "bounds", bottom-edge: "bounds"),
  ))
  let left = ($e_1$, $e_2$, $e_3$, none, $e_(ell - 2)$, $e_(ell - 1)$)
  let labels = ($1$, $2$, none, none, $ell - 2$)
  for (i, weight) in left.enumerate() {
    for side in (0, 1) {
      let x = if side == 0 { i } else { 12 - i }
      if weight == none { content((x, 0), $dots$) } else {
        circle((x, 0), radius: 0.06, fill: white)
        let shown = if side == 0 { weight } else {
          (
            $e_(-1)$,
            $e_(-2)$,
            $e_(-3)$,
            none,
            $e_(-ell + 2)$,
            $e_(-ell + 1)$,
          ).at(i)
        }
        content((x, if i == 5 { -0.65 } else { -0.35 }), shown)
      }
      if i > 0 and labels.at(i - 1) != none {
        let previous = if side == 0 { x - 1 } else { x + 1 }
        line((previous, 0), (x, 0))
        content(((previous + x) / 2, 0.3), labels.at(i - 1))
      }
    }
  }
  let bond-labels = ()
  for (y, weight) in ((0.8, $e_ell$), (-0.8, $e_(-ell)$)) {
    circle((6, y), radius: 0.06, fill: white)
    line((5, 0), (6, y))
    line((6, y), (7, 0))
    content((6, if y > 0 { y + 0.35 } else { y - 0.35 }), weight)
    for (a, b, label) in (
      ((5, 0), (6, y), if y > 0 { $ell - 1$ } else { $ell$ }),
      ((6, y), (7, 0), if y > 0 { $ell$ } else { $ell - 1$ }),
    ) {
      let d = (b.at(0) - a.at(0), b.at(1) - a.at(1))
      let length = calc.sqrt(d.at(0) * d.at(0) + d.at(1) * d.at(1))
      bond-labels.push((
        (
          (a.at(0) + b.at(0)) / 2 - 0.26 * d.at(1) / length,
          (a.at(1) + b.at(1)) / 2 + 0.26 * d.at(0) / length,
        ),
        label,
      ))
    }
  }
  for (p, label) in bond-labels {
    content(p, label, frame: "rect", fill: white, stroke: none, padding: 0.025)
  }
})
