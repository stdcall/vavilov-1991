#import "@preview/cetz:0.5.2"

#let e6-weight-diagram(ink: rgb("cba368"), paper: rgb("101d2e")) = {
  let graph = json("e6-weights.json")
  let direction = (-3, -1, -3, 1, 1, 3)
  let points = graph.root_coordinates.map(c => (
    c.sum() * 7.4,
    c.zip(direction).map(((a, b)) => a * b).sum() * 4.9,
  ))
  assert(points.dedup().len() == 27)
  cetz.canvas(length: 1mm, {
    import cetz.draw: *
    set-style(stroke: (paint: ink, thickness: 0.8pt))
    for (a, b, _) in graph.edges { line(points.at(a), points.at(b)) }
    for point in points {
      circle(point, radius: 0.8, fill: paper, stroke: (
        paint: ink,
        thickness: 0.8pt,
      ))
    }
  })
}
