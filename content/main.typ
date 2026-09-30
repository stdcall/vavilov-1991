#set document(
  title: "Structure of Chevalley Groups over Commutative Rings",
  author: "Nikolai A. Vavilov",
  date: none,
)
#import "book-style.typ": book-style
#import "main-defs.typ": editorial-bibliography
#show: book-style
#set page(numbering: none)
#include "cover.typ"
#set page(numbering: "i")
#counter(page).update(1)
#heading(level: 1, numbering: none, outlined: false, bookmarked: true)[Contents]
#outline(title: none, depth: 3)
#pagebreak()
#set page(numbering: "1")
#counter(page).update(1)
#include "00-introduction.typ"
#include "10-generalities.typ"
#include "11-chevalley-groups.typ"
#include "12-elementary-calculations.typ"
#include "13-minimal-modules.typ"
#include "14-stable-general-calculations.typ"
#include "15-relative-groups.typ"
#include "20-examples.typ"
#include "21-classical-groups.typ"
#include "22-cubic-form.typ"
#include "23-exceptional-groups.typ"
#include "30-structure-theorems.typ"
#include "39-structure-theorems.typ"
#include "40-proofs-linear.typ"
#include "41-proofs-orthogonal.typ"
#include "42-proofs-symplectic.typ"
#include "43-proofs-e6.typ"
#include "44-concluding-remarks.typ"
#context {
  set par(leading: 0.55em, spacing: 0.65em)
  include "79-acknowledgements.typ"
}
#include "80-bibliography.typ"
#include "81-editorial-bibliography.typ"
#editorial-bibliography
