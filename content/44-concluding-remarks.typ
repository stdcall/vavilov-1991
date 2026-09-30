#import "main-defs.typ": *
#import "statements.typ": *

== Concluding remarks <sec:concluding-remarks>

We briefly indicate the situation for the other exceptional groups and some
further directions.

=== Other exceptional groups <ss:exceptional-landmarks>

The $E_6$ proof is unusually simple. It extends to the minimal representation of
$E_7$ when $2$ is invertible, but the other cases require more substantial
modifications. A singular family of root subgroups may be too small to fix an
arbitrary relevant column. One then needs a calculation resembling type $D_l$
rather than type $A_l$: the construction in §@sec:proofs-orthogonal uses an
$A_3$ subsystem, whereas that in §@sec:proofs-e6 uses an $A_5$ subsystem.

For $E_7$ in the 56-dimensional representation, a root element is decomposed
into 56 factors, each itself a product of seven unipotents; this is an $A_7$
calculation. For the adjoint representations of $F_4,E_6,E_7,E_8$, the
corresponding factors are products of 8, 12, or 14 elementary unipotents,
involving $D_5,D_7,D_8$ calculations. The case $F_4$ is more difficult still:
factors built from eleven elementary unipotents have parameters quadratic in the
column coordinates,
#source(315)
$ ±x_(λ_1)x_(μ_1)+dots+±x_(λ_m)x_(μ_m), quad m∈{1,3}. $
Showing that the resulting column-stabilisers generate the whole elementary
group requires an additional calculation.

The underlying decomposition method was developed jointly with E. B. Plotkin.
The original survey announced further papers in the series _Structure of
Chevalley groups over commutative rings_, entitled “Stabilisers of columns” and
“The main structure theorems”. A later account for $F_4,E_6,E_7$ uses the
geometry of root subgroups to simplify the decomposition method
#citation[@bib:VavilovGavrilovichNikolenko2006].

=== Smaller elementary normalisers <ss:smaller-elementary-normalisers>


The standard description extends in several directions when a subgroup is
normalised by a sufficiently large group of elementary matrices. Subgroups
normalised by a relative elementary group were discussed above. Further variants
are closely connected with the subgroup structure over fields.

Z. I. Borewicz and the author studied subgroups of a general linear group
containing a block-diagonal subgroup #citation[@bib:Borevich1985,
  @bib:Vavilov1988b, @bib:Vavilov1990b]\; I. Z. Golubchik observed, by analogy
with results for split maximal tori, that the description can also cover
subgroups normalised by such a block-diagonal subgroup
#citation[@bib:Golubchik1984]. Analogues for other classical groups are
discussed in #citation[@bib:Vavilov1988b, @bib:Vavilov1990b].

In root-theoretic terms the question is to describe subgroups of $G(Φ,R)$
normalised by $E(Δ,R)$ for a sufficiently large root subsystem $Δ⊆Φ$. More
generally one can consider a homomorphism $π:G(Δ,R)→G(Φ,R)$ not induced by a
root-system embedding. This touches the classification of maximal subgroups of
algebraic groups and finite groups of Lie type #citation[@bib:Seitz1987,
  @bib:Seitz1991]. Even over fields the general problem has many distinct cases;
particular embeddings have their own structure theories.#ed-note[
  One later result treats $D_(n-1)⊆D_n$, $n≥4$, over every commutative ring:
  each subgroup containing $E(D_(n-1),R)$ has a unique level, given by a
  submodule of $R^2$, and lies between the elementary group and the Lie-algebra
  stabiliser attached to that level #citation[@bib:Gvozdevsky2022, Theorem 1 and
    §11.1]. Thus subsystem levels need not be ideals.
]

#source(316) N. S. Romanovskii, Z. I. Borewicz, R. A. Schmidt, A. V. Stepanov,
A. E. Zalesskii, the author, and others also studied subgroups of $G(Φ,R)$
normalised by $E(Φ,S)$ for a subring $S⊆R$. Often $R$ is a ring of fractions of
$S$, but other situations are possible. This suggests further questions with
$E(Δ,S,I)$, for an ideal $I$ of $S$, as normalising group.

=== Steinberg groups and K-functors <ss:steinberg-k-functors>

The methods of this survey suggest analogues of the van der Kallen–Tulenbaev
centrality theorem for $K_2(n,R)$, $n≥4$. For classical groups one uses
presentations by small transformations over fields—transvections,
ESD-transvections, and their relatives—as developed by S. Böge, E. Ellers, U.
Spengler, and others. For exceptional groups the analogous presentations require
additional work. Centrality is a separate theorem: it does not follow just from
elementary normality.

Stability of the lower K-functors modelled on Chevalley groups is another
natural application. Many of the ideas originated in the fundamental work of H.
Matsumoto and M. R. Stein #citation[@bib:Matsumoto1969, @bib:Stein1978]. At the
same conference, E. B. Plotkin discussed stability of $K_1(Φ,R)$; the original
survey anticipated corresponding developments for $K_2(Φ,R)$.

=== Non-split groups <ss:non-split-groups>

Many arguments use suitable configurations of root subgroups rather than a
globally split group. They therefore suggest extensions to sufficiently
isotropic non-split groups. The orthogonal instance was mentioned in
§@sec:proofs-orthogonal. Steinberg's construction of twisted groups gives some
real forms, #citation[@bib:Steinberg1959, @bib:Carter1965, @bib:Carter1972b,
  @bib:Steinberg1967] and has been adapted in several directions. E. Stensholt
used it to construct embeddings of Chevalley groups
#citation[@bib:Stensholt1974, @bib:Stensholt1978]. E. Abe introduced twisted
groups over commutative rings, #citation[@bib:Abe1977] which were then used in
normal-subgroup investigations #citation[@bib:Suzuki1977, @bib:Strecker1979].
Cheng Chon Hu extended the construction to broader classes of semisimple groups,
including noncompact real forms #citation[@bib:Cheng1986,
  @bib:Cheng1989].

#source(317) At the time of the original survey the structure of non-quasi-split
groups over general rings remained largely unexplored; the geometric work of F.
Veldkamp and J. Ferrar treated special classes of rings. Subsequent work gives
the isotropic elementary subgroup a general reductive-group formulation, as
noted in §@ss:orthogonal-further.#ed-note[
  Standard normal structure is now proved for reductive groups of isotropic rank
  at least two whose absolute root systems in all geometric closed fibres are
  irreducible and whose structure constants are invertible in $R$: every
  subgroup normalised by $E(R)$ lies in a unique sandwich $E(R,I)⊆H⊆C(R,I)$
  #citation[@bib:Stavrova2024, Theorem 1.1]. Here the rank condition requires
  every semisimple normal $R$-subgroup to contain a split two-dimensional torus;
  invertibility requires $2∈R^*$ in types $B,C,F_4$ and $2,3∈R^*$ in type $G_2$.
]

=== Infinite-dimensional groups <ss:infinite-dimensional-groups>

The methods may also be useful for infinite-dimensional analogues of Chevalley
groups. Such generalisations have been introduced and studied by E. Abe, A. Bak,
H. Garland, J.-Y. Hée, V. Kac, R. Moody, J. Morita, D. H. Peterson, M. Takeuchi,
K. L. Teo, J. Tits, and others. Which finite-rank arguments extend depends on
the available root-subgroup configurations and on the presentations of the
groups in question; the analogy is a direction of research rather than a blanket
structure theorem.
