# Mathematical checks

The manifests link each check to labelled passages in the book and state its
coverage and limitations. Passing checks certify those stated identities and
data, rather than every argument in the surrounding section.

## Selected mathematical claims

`mathematical-claims.json` is a readable selection of assertions, including
mathematical claims in prose. Each record gives its source file and labelled
passage, the claim and hypotheses, the verification, and its limitations.
It is not a complete audit or certification of the book.

Coverage is `verified` when the precise assertion has a checked argument,
formal proof, exact computation within its stated scope, or independently
checked primary-source theorem; `partial` when only some ingredients or cases
are checked; and `unresolved` when a necessary justification is missing.
A later work by the original author alone is not independent verification.
Finite examples and rational invariants do not certify arbitrary-ring scheme
identifications. The limitations distinguish these cases explicitly.

## Lean

`lean-proofs.json` records the formal declarations and their hypotheses.
Seven modules contain 25 recorded declarations. They formalise inverse and
block-factorisation identities, Suslin's explicit syzygy decomposition,
transvection calculations, and the ring double's Cartesian square,
split projections and kernels, and preservation of the quadratic norm by a
short-root transformation of the seven-dimensional $G_2$ module.
Use the pinned Lean toolchain and dependencies recorded in that project.
The formalised algebraic identities do not by themselves establish the book's
normality or group-scheme identification theorems.

## SageMath

`sage-checks.json` covers all twelve scripts in `sage/`, exactly once. Run:

```sh
python3 scripts/check_sage.py --report sage-report.json
```

The runner records the Sage version, script and diagram-data hashes, results,
and output. It fails if a script fails or its inputs change during the run.

The scripts check exact polynomial matrix identities, exceptional invariant
forms and representation relations, and the vertices, labelled edges and
specified coloured variants of the mathematical diagrams. Generic rational
function-field calculations and finite classical-rank examples have narrower
scope than universal ring statements; those limits are explicit in the
manifest. Commutative diagrams of schemes and ring maps are justified in the
text by their definitions, rather than by numerical examples.
