#import "@preview/cetz:0.5.2": canvas, draw

#let exceptional-graph(
  file,
  zero-space: false,
  coroots: false,
  horizontal: false,
) = canvas(length: 1mm, {
  import draw: *
  let graph = json(file)
  let breadth = calc.max(..graph.levels.map(h => graph
    .levels
    .filter(k => k == h)
    .len()))
  let layer-gap = if breadth >= 5 { 7 } else { 5.5 }
  let node-gap = if breadth >= 5 { 14 } else { 11 }
  let scores = graph.coordinates.map(c => c
    .enumerate()
    .map(((i, x)) => (i * i + 3 * i + 1) * x)
    .sum())
  let points = graph
    .levels
    .enumerate()
    .map(((i, h)) => {
      let layer = graph
        .levels
        .enumerate()
        .filter(((j, k)) => k == h)
        .map(((j, k)) => j)
        .sorted(key: j => scores.at(j))
      let rank = layer.position(j => j == i)
      if horizontal {
        (h * layer-gap, (rank - (layer.len() - 1) / 2) * node-gap)
      } else {
        ((rank - (layer.len() - 1) / 2) * node-gap, -h * layer-gap)
      }
    })
  let labels = ()
  for (a, b, k) in graph.edges {
    line(points.at(a), points.at(b), stroke: 0.45pt)
    let p = points.at(a).zip(points.at(b)).map(((x, y)) => 0.62 * x + 0.38 * y)
    let d = points.at(b).zip(points.at(a)).map(((x, y)) => x - y)
    let length = calc.sqrt(d.at(0) * d.at(0) + d.at(1) * d.at(1))
    let normal = (-d.at(1), d.at(0))
    labels.push((
      (
        p.at(0) + 1.4 * normal.at(0) / length,
        p.at(1) + 1.4 * normal.at(1) / length,
      ),
      k,
    ))
  }
  if graph.keys().contains("exits") {
    for i in graph.exits {
      let p = points.at(i)
      line(
        p,
        (p.at(0), p.at(1) - 4),
        stroke: (dash: "dashed", thickness: 0.4pt),
        mark: (end: "stealth", scale: 0.45),
      )
    }
  }
  for p in points { circle(p, radius: 0.8, fill: white, stroke: 0.5pt) }
  if zero-space {
    let h = graph.zero_height
    for j in range(3) {
      let p = if horizontal { (h * layer-gap, (j - 1) * node-gap) } else {
        ((j - 1) * node-gap, -h * layer-gap)
      }
      circle(p, radius: 0.8, fill: white, stroke: 0.5pt)
      content((p.at(0) + 2.4, p.at(1)), text(size: 7pt)[$0$])
    }
  }
  if coroots {
    let bottom = calc.max(..graph.levels) + 1
    for (i, c) in graph.coordinates.enumerate() {
      if c.sum() == 1 {
        let k = c.position(x => x == 1) + 1
        let p = points.at(i)
        let z = (p.at(0), -bottom * layer-gap)
        line(p, z, stroke: 0.5pt)
        circle(z, radius: 0.8, fill: white, stroke: 0.5pt)
        content((z.at(0), z.at(1) - 2.4), text(size: 7pt)[$h_#k$])
      }
    }
  }
  // Labels are painted after every edge, so later crossing bonds cannot
  // strike through a digit. The small frame protects the glyph bounds only.
  for (p, k) in labels {
    content(
      p,
      text(size: 7pt, top-edge: "bounds", bottom-edge: "bounds")[#k],
      frame: "rect",
      fill: white,
      stroke: none,
      padding: 0.15,
    )
  }
})
