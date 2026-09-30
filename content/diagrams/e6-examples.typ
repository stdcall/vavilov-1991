#import "@preview/cetz:0.5.2": canvas, draw

#let e6-graph(mark-action: false, mode: none) = canvas(length: 1mm, {
  import draw: *
  let graph = json("e6-weights.json")
  let levels = graph.root_coordinates.map(c => c.sum())
  let direction = (-3, -1, -3, 1, 1, 3)
  let scores = graph.root_coordinates.map(c => (
    c.zip(direction).map(((a, b)) => a * b).sum()
  ))
  let points = graph
    .root_coordinates
    .enumerate()
    .map(((i, c)) => {
      let layer = levels
        .enumerate()
        .filter(((j, n)) => n == levels.at(i))
        .map(((j, n)) => j)
        .sorted(key: j => scores.at(j))
      let rank = layer.position(j => j == i)
      (levels.at(i) * 7.2, (rank - (layer.len() - 1) / 2) * 11)
    })
  let alpha = (1, 0, 1, 1, 0, 0)
  let sources = ()
  let targets = ()
  let triple = ()
  let nonadjacent = ()
  if mode in ("triple", "neighbours", "weight-torus") {
    let inverse-cartan = (
      (4, 3, 5, 6, 4, 2),
      (3, 6, 6, 9, 6, 3),
      (5, 6, 10, 12, 8, 4),
      (6, 9, 12, 18, 12, 6),
      (4, 6, 8, 12, 10, 5),
      (2, 3, 4, 6, 5, 4),
    )
    for (i, weight) in graph.weights.enumerate() {
      let pairing = weight
        .zip(inverse-cartan.at(0))
        .map(((a, b)) => a * b)
        .sum()
      if pairing == -2 { nonadjacent.push(i) }
      let sum = graph
        .weights
        .first()
        .zip(weight)
        .zip(graph.weights.last())
        .map((((a, b), c)) => a + b + c)
      if sum.all(n => n == 0) { triple = (0, i, 26) }
    }
  }
  if mark-action {
    for (i, c) in graph.root_coordinates.enumerate() {
      let next = c.zip(alpha).map(((a, b)) => a - b)
      let target = graph.root_coordinates.position(d => d == next)
      if target != none {
        sources.push(i)
        targets.push(target)
      }
    }
  }
  set-style(stroke: 0.6pt, content: (
    wrap: text.with(size: 8pt, top-edge: "bounds", bottom-edge: "bounds"),
  ))
  if mode == "jordan" {
    let remaining = range(graph.weights.len())
    let components = ()
    while remaining.len() > 0 {
      let component = (remaining.first(),)
      let previous = ()
      while component != previous {
        previous = component
        for (a, b, label) in graph.edges {
          if label not in (1, 6) {
            if component.contains(a) and not component.contains(b) {
              component.push(b)
            }
            if component.contains(b) and not component.contains(a) {
              component.push(a)
            }
          }
        }
      }
      components.push(component)
      remaining = remaining.filter(i => not component.contains(i))
    }
    let scalars = components
      .filter(c => c.len() == 1)
      .sorted(key: c => points.at(c.first()).at(0))
    for (i, component) in scalars.enumerate() {
      let p = points.at(component.first())
      let offset = if i == 0 { (-4, 0) } else if i == 1 {
        (0, 5)
      } else { (4, 0) }
      content(
        (p.at(0) + offset.at(0), p.at(1) + offset.at(1)),
        $α_#(i + 1)$,
      )
    }
    let octonions = components
      .filter(c => c.len() == 8)
      .sorted(key: c => c.map(i => points.at(i).at(0)).sum())
    for (i, component) in octonions.enumerate() {
      let centre = (
        component.map(j => points.at(j).at(0)).sum() / component.len(),
        component.map(j => points.at(j).at(1)).sum() / component.len(),
      )
      content(centre, $x_#(3 - i)$)
    }
  }
  for (a, b, label) in graph.edges {
    if mode == "jordan" and label in (1, 6) { continue }
    if mode == "a5-a1" and label == 2 { continue }
    line(points.at(a), points.at(b))
    let midpoint = (
      points.at(a).at(0) + points.at(b).at(0),
      points.at(a).at(1) + points.at(b).at(1),
    )
    content((midpoint.at(0) / 2, midpoint.at(1) / 2 + 2), str(label))
  }
  for (i, p) in points.enumerate() {
    if (
      (mode == "triple" and triple.contains(i))
        or (mode == "neighbours" and i == 0)
    ) {
      rect(
        (p.at(0) - 0.8, p.at(1) - 0.8),
        (p.at(0) + 0.8, p.at(1) + 0.8),
        fill: black,
      )
    } else if mode == "neighbours" and nonadjacent.contains(i) {
      rect(
        (p.at(0) - 0.8, p.at(1) - 0.8),
        (p.at(0) + 0.8, p.at(1) + 0.8),
        fill: white,
      )
    } else if mode in ("root-torus", "weight-torus") {
      let sign = if mode == "root-torus" {
        graph.weights.at(i).first()
      } else if i == 0 { 1 } else if nonadjacent.contains(i) { -1 } else { 0 }
      circle(p, radius: 1.2, fill: white)
      if sign != 0 { content(p, if sign > 0 { [+] } else { [−] }) }
    } else if sources.contains(i) {
      line((p.at(0) - 0.8, p.at(1) - 0.8), (p.at(0) + 0.8, p.at(1) + 0.8))
      line((p.at(0) - 0.8, p.at(1) + 0.8), (p.at(0) + 0.8, p.at(1) - 0.8))
    } else if targets.contains(i) {
      rect(
        (p.at(0) - 0.8, p.at(1) - 0.8),
        (p.at(0) + 0.8, p.at(1) + 0.8),
        fill: black,
      )
    } else { circle(p, radius: 0.75, fill: white) }
  }
})

#let e6-dynkin() = canvas({
  import draw: *
  let labels = (1, 3, 4, 5, 6)
  for (i, label) in labels.enumerate() {
    if i > 0 { line((i - 1, 0), (i, 0)) }
    circle((i, 0), radius: 0.06, fill: white)
    content((i, 0.3), str(label))
  }
  line((2, 0), (2, -0.8))
  circle((2, -0.8), radius: 0.06, fill: white)
  content((2, -1.1), [2])
})
