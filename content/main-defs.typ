#import "numbering.typ": numbered-record, record-number

#let source(n, printed: none) = metadata((
  kind: "source",
  file-page: n,
  printed-page: if printed == none { str(n) } else { printed },
))
#let number-text(body) = text(weight: "semibold", style: "normal", body)
#let reference-rules(body) = {
  show ref: it => context {
    let record = if it.element != none { numbered-record(it.target) }
    let number = if record != none { record-number(record) }
    let resolved = number != none
    let caption = it.supplement not in (auto, none, [])
    let destination = if resolved {
      if it.element.func() == math.equation { it.element.location() } else {
        record.location()
      }
    } else if caption and it.element != none { it.element.location() }
    let printed = if resolved { number.map(str).join(".") } else { "?" }
    let info = (
      kind: "cross-reference",
      target: str(it.target),
      resolved: destination != none,
      printed: printed,
      target-position: if destination != none { destination.position() },
    )
    let shown = if caption {
      if resolved and str(it.target).starts-with("eq:") {
        [#it.supplement (#number-text(printed))]
      } else { it.supplement }
    } else {
      let n = number-text(printed)
      if str(it.target).starts-with("eq:") { [(#n)] } else { n }
    }
    box[
      #metadata(info)#if (
        str(it.target).starts-with("bib:")
      ) [#metadata((key: str(it.target).slice(4)))<citation-point>]
      #if (
        destination != none
      ) {
        link(destination, shown)
      } else { shown }
    ]
  }
  body
}
#let citation(body) = [\[#body\]]
#let diagram(body) = box(body)
#let editorial-notes = sys.inputs.at("editorial-notes", default: "on") != "off"
#let editorial-note-counter = counter("editorial-note")
#let ed-note(body) = if editorial-notes {
  editorial-note-counter.step()
  context {
    footnote(numbering: _ => (
      "*" + str(editorial-note-counter.get().first()) + ")"
    ))[
      #body~— _Ed._
    ]
    counter(footnote).update(n => n - 1)
  }
}
#let editorial-bibliography = [
  #show bibliography: none
  #bibliography(
    ("../references.bib", "../editorial.bib"),
    style: "../assets/bibliography.csl",
  )
]
#let group-name(name) = math.class("normal", math.upright(name))
#let GL = group-name("GL")
#let SL = group-name("SL")
#let PGL = group-name("PGL")
#let PSL = group-name("PSL")
#let SO = group-name("SO")
#let O = group-name("O")
#let Sp = group-name("Sp")
#let Spin = group-name("Spin")
#let EO = group-name("EO")
#let ESp = group-name("ESp")
#let Ep = group-name("Ep")
#let KSp = group-name("KSp")
#let St = group-name("St")
#let SK = group-name("SK")
#let exp = math.op("exp")
#let diag = math.op("diag")
#let Hom = math.op("Hom")
#let End = math.op("End")
#let Aut = math.op("Aut")
#let Spec = math.op("Spec")
#let Lie = math.op("Lie")
#let rk = math.op("rk")
#let tr = math.op("tr")
#let ad = math.op("ad")
#let Ad = math.op("Ad")
#let Ker = math.op("Ker")
#let Im = math.op("Im")
#let conj(by, object) = math.attach(object, tl: by)
