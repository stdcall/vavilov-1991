#import "@preview/cetz:0.5.2": canvas, draw

#let zero-weight-chain() = canvas({
  import draw: *
  set-style(stroke: 0.6pt, content: (
    wrap: text.with(top-edge: "bounds", bottom-edge: "bounds"),
  ))
  let weights = ($alpha$, $hat(alpha)$, $-alpha$)
  for (i, weight) in weights.enumerate() {
    let p = (i * 1.4, 0)
    if i > 0 {
      line(((i - 1) * 1.4, 0), p)
      content(((i - 0.5) * 1.4, -0.35), $alpha$)
    }
    circle(p, radius: 0.06, fill: white)
    content((i * 1.4, 0.4), weight)
  }
})
