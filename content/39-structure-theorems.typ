#import "main-defs.typ": *
#import "statements.typ": *
#let sr = math.op("sr")

== The structure theorems <sec:structure-theorems>

In this section we formulate the main structure theorems for Chevalley groups
over commutative rings. In the following sections we outline the existing
approaches to their proofs and two new approaches.

=== Commutator formulae <ss:commutator-formulae>

The first main structure theorem asserts that the elementary subgroups are
normal in a Chevalley group $G = G(Phi, R)$.

#theorem[
  Let $Phi$ be an irreducible root system of rank at least $2$, and let $I$ be
  an ideal of the ground ring $R$. Then
  $ [E(Phi, R, I), G(Phi, R)] ≤ E(Phi, R, I), $
  $ [E(Phi, R), C(Phi, R, I)] ≤ E(Phi, R, I). $
  Apart from the cases $Phi = B_2, G_2$ with a residue field of two elements,
  these inclusions are equalities.] <th:standard-commutator-formula>

Recall that $C(Phi, R, I)$ is the full congruence subgroup of level $I$.
Probably #source(280) even for the general linear group over $ZZ$ this
phenomenon was first recognised in the works of H.~Bass #citation[@bib:Bass1964,
  @bib:Bass1968] and extended to other classical groups by A.~Bak
#citation[@bib:Bak1969, @bib:Bak1982]. Both Bass and Bak operated at the stable
level: the rank is large relative to a dimension of the ring. Conditions were
usually expressed through stable rank in the linear and symplectic cases, or
through Krull dimension and the dimension of the maximal spectrum
$upright("Max")(R)$. For the general linear group Bass obtained the formulae
when $n ≥ sr(R) + 1$.

A real breakthrough was A.~A.~Suslin's theorem #citation[@bib:Suslin1977, §1,
  Corollary 1.4]: $E(n, R, I)$ is normal in $GL(n, R)$ for a commutative ring
$R$ and $n ≥ 3$. Suslin and V.~I.~Kopeiko extended this to split even orthogonal
and symplectic groups #citation[@bib:Suslin1982, @bib:Kopeiko1978]. G.~Taddei
independently obtained the symplectic case, #citation[@bib:Taddei1982] and the
author considered odd orthogonal groups in 1983 (see #citation[@bib:Vavilov1987,
  @bib:Vavilov1990b]). These proofs used direct matrix calculations.

M.~R.~Stein treated Chevalley groups at the stable level, using absolute stable
rank or $dim upright("Max")(R)$ #citation[@bib:Stein1983, @bib:Stein1978]. The
formulae follow from surjective stability for $K_1$; further results were
obtained by E.~B.~Plotkin and the author #citation[@bib:Plotkin1984b,
  @bib:Plotkin1985b, @bib:Plotkin1989, @bib:Plotkin1991, @bib:Vavilov1988e].

For classical groups the second formula was discovered independently by
L.~N.~Vaserstein and Z.~I.~Borewicz with the author
#citation[@bib:Vaserstein1981, formula (6); Theorem 13 and Corollary 14;
  @bib:Borevich1985, @bib:Vaserstein1988, @bib:Vaserstein1989,
  @bib:Vavilov1988b, @bib:Vavilov1990b]. Their proofs differed, but both used
normality of the relative elementary subgroup in the full group.

Suslin's original proof #citation[@bib:Suslin1977, §1, Corollary 1.4] was
difficult to extend to exceptional groups; see §~@ss:suslin-proof. Vaserstein
observed that localisation and patching, originating in the Quillen–Suslin
solution of Serre's problem, gives a different proof
#citation[@bib:Vaserstein1981, Lemma 11 and Proposition 12]. Taddei obtained the
first general normality proof for $E(Phi, R)$ by this method,
#citation[@bib:Taddei1985, @bib:Taddei1986] and Vaserstein deduced the
commutator formulae #citation[@bib:Vaserstein1986b]. As explained in
§~@sec:relative-groups, the relative case follows from the absolute case.

In 1987 my Ph.D. student A.~V.~Stepanov discovered a remarkably #source(281)
elementary proof of Suslin's normality theorem. I noticed that, unlike the
original proof, it extends to the other Chevalley groups with a reasonable
amount of effort, and quickly obtained proofs for the other classical groups and
type $E_6$. The remaining cases were treated jointly with E.~B.~Plotkin. This
proof was sketched in #citation[@bib:Vavilov1990d]\; somewhat more detail is
given here.

The formulae in Theorem~@th:standard-commutator-formula are called the _standard
commutator formulae_. Two possible generalisations deserve mention.
Bass–Vaserstein stability for $K_1$ gives
$ [GL(n, R, I), GL(n, R)] = E(n, R, I) $
when $n ≥ max(3, sr(R) + 1)$. For general Chevalley groups the analogous
statement is
$ [G(Phi, R, I), G(Phi, R)] ≤ E(Phi, R, I). $
It holds at the stable level, but cannot be expected independently of the
dimension of the ground ring: it asserts that $quotient(G(Phi,R,I), E(Phi,R,I))$
is central in $quotient(G(Phi,R), E(Phi,R,I))$, with no reason for this to hold
in general.

Another generalisation, considered for linear groups by A.~W.~Mason and
W.~W.~Stothers, #citation[@bib:Mason1974, @bib:Mason1981a, @bib:Mason1981b]
concerns two ideals $A, B$ of $R$:
$
  [E(Phi, R, A), G(Phi, R, B)]
  = [E(Phi, R, A), E(Phi, R, B)].
$
For this mixed formula one must retain the restrictions in the small
non-simply-laced cases.#ed-note[
  A precise later version is the mixed commutator theorem of Hazrat, Vavilov,
  and Zhang #citation[@bib:HazratVavilovZhang2013, Theorem 1]. For $C_2, G_2$
  exclude residue fields $FF_2$; for $C_l$ also require $c ∈ c^2 R + 2 c R$ for
  every $c ∈ R$. Under these hypotheses the principal congruence group may be
  replaced by the full congruence group #citation[@bib:HazratVavilovZhang2013,
    Theorem 1]. The stronger localisation theorem uses $2 ∈ R^times$ in types
  $C_2, G_2$ #citation[@bib:HazratVavilovZhang2013, §9].
] Under the hypotheses stated for the mixed commutator formula, one also has
$
  E(Phi, R, A B) ≤ [E(Phi, R, A), E(Phi, R, B)]
  ≤ G(Phi, R, A B).
$
Determining this group explicitly is difficult (compare
#citation[@bib:Mason1974, @bib:Mason1981a, @bib:Mason1981b]).#ed-note[
  The mixed commutator need not equal $E(Phi, R, A B)$. Explicit generating sets
  were obtained by Hazrat, Vavilov, and Zhang
  #citation[@bib:HazratVavilovZhang2016, Theorems 2–3]. Vavilov and Zhang's
  sequel shows that $[E(Phi, A), E(Phi, B)] = [E(Phi, R, A), E(Phi, R, B)]$
  under the standing ring restrictions of its introduction
  #citation[@bib:VavilovZhang2020, Theorem 1].
]

=== Normal subgroups <ss:normal-subgroups>

The second main structure theorem concerns #source(282) what is traditionally
called the description of normal subgroups. In fact one usually describes
subgroups normalised by the elementary subgroup; normalisation by the full
Chevalley group is a separate matter.

The expected _standard description_ places such subgroups near the natural
congruence subgroups. It holds if every subgroup $F$ of $G(Phi, R)$ normalised
by $E(Phi, R)$ has a unique ideal $I$ with
$ E(Phi, R, I) ≤ F ≤ C(Phi, R, I). $
Some restrictions are inevitable because the description fails over certain
fields of small characteristic or cardinality; nevertheless it holds in most
cases.

#theorem[
  Let $Phi$ be an irreducible root system of rank at least $2$, and $R$ a
  commutative ring with $1$. Suppose $2 ∈ R^times$ for $Phi = C_l, B_l, F_4$.
  For $Phi = G_2$, suppose $3 ∈ R^times$ and $R$ has no residue field of two
  elements. Then the standard description of subgroups of $G(Phi, R)$ normalised
  by $E(Phi, R)$ holds.
] <th:standard-normal-structure>

These sufficient restrictions are established in #citation[@bib:Vaserstein1986b,
  Theorems 3–4].

The history reaches back to the late nineteenth century. Over fields and skew
fields, normal subgroup structure occupied much of classical group theory,
perhaps sixty percent of its publications. Arithmetic examples such as
$SL(2, ZZ)$ were also studied early. This period is well covered elsewhere
#citation[@bib:Dieudonne1957, @bib:OMeara1974, @bib:OMeara1978, @bib:Hahn1989b].

J.~Brenner first approached the problem over rings, followed some twenty years
later by W.~Klingenberg. They and their successors mostly studied local or
semilocal rings and Dedekind domains, with close connections to arithmetic and
the congruence subgroup problem. We cannot describe that history here.

#source(283) For general rings the modern story starts with Bass
#citation[@bib:Bass1964], who proved the standard description for $GL(n, R)$
under $n ≥ max(3, sr(R) + 1)$. Bass and Bak extended it, subject to stability
assumptions, to other split classical groups #citation[@bib:Bass1973a,
  @bib:Bak1969, @bib:Bak1982, @bib:Bak1981].

J.~S.~Wilson proved the standard description over every commutative ring for
$n ≥ 4$, with partial results for $n = 3$ #citation[@bib:Wilson1972]. The
following year I.~Z.~Golubchik announced a proof for $n ≥ 3$, also covering some
noncommutative rings. The _Wilson–Golubchik theorem_ initiated an era in which
arbitrary rings could be considered, although studies restricted to
zero-dimensional rings continued to appear.

Vaserstein gave a localisation and patching proof #citation[@bib:Vaserstein1981,
  Theorem 4; Proposition 18 and Theorem 19]\; Borewicz and the author published
a proof in the spirit of Stepanov's normality argument
#citation[@bib:Borevich1985]. Golubchik extended the result to other split
classical groups and a broad class of unitary groups over noncommutative rings
#citation[@bib:Golubchik1975, @bib:Golubchik1981a, @bib:Golubchik1984].

E.~Abe first treated Chevalley groups over local rings #citation[@bib:Abe1969].
Abe and K.~Suzuki then obtained a close approximation to the standard
description #citation[@bib:Abe1976]. As noted in #citation[@bib:Vavilov1984],
their results easily imply the standard description of normal subgroups of
$E(Phi, R)$ under the usual restrictions.

Passing to subgroups of $G(Phi, R)$ normalised by $E(Phi, R)$ requires normality
of $E(Phi, R)$, which was not proved in general until 1986. Vaserstein first
proved Theorem~@th:standard-normal-structure in this generality
#citation[@bib:Vaserstein1986b]. His sharper condition is that each $a ∈ R$
belongs to $2 a R + a^2 R$ for $Phi = C_l, B_l, F_4$, and to $3 a R + a^3 R$ for
$G_2$, together with the exclusion of residue fields of two elements in types
$B_2,G_2$. Without these conditions nonstandard subgroups may occur. #source(
  284,
) If standardness is modified to distinguish long-root and short-root levels
(see #citation[@bib:Abe1969, @bib:Abe1976]), Abe proved an almost unrestricted
_parastandard_ description #citation[@bib:Abe1989a, @bib:Abe1989b]. D.~L.~Costa
and G.~E.~Keller removed the remaining restrictions in the symplectic case
#citation[@bib:Costa1991].

Wilson also considered subnormal subgroups #citation[@bib:Wilson1972]. A
subgroup $F ≤ G$ is _subnormal of depth_ (or _defect_) $d$ if
$
  G = G_0 ▷ G_1 ▷ dots
  ▷ G_(d - 1) ▷ G_d = F,
$
where each succeeding group is normal in its predecessor. Closely related is the
problem of subgroups normalised by a relative elementary subgroup, independently
proposed by Bak #citation[@bib:Bak1982].

For a commutative ring and $n ≥ 3$, if $F ≤ GL(n, R)$ is normalised by
$E(n, R, I)$, there is an ideal $A$ such that
$ E(n, R, A I^m) ≤ F ≤ C(n, R, A), $
with $m = 4$, by a recent result of Vaserstein #citation[@bib:Vaserstein1990].
Earlier bounds were $m = 7$ for $n ≥ 4$ (Wilson), $24$ under $n ≥ sr(R) + 1$
(Bak), $6$ (Vaserstein), $40$ (Li Fuan and Liu Mulan), and $5$ (the author)
#citation[@bib:Wilson1972, @bib:Vaserstein1986a, @bib:Li1987b,
  @bib:Vavilov1990a]. Consequently, if $F$ is subnormal of depth $d$, then
$
  E(n, R, A^s) ≤ F ≤ C(n, R, A), quad
  s = (m^d - 1) / (m - 1).
$
The author's joint work with Plotkin, _Structure of Chevalley groups over
commutative rings. VI. The main structure theorems_, extends these arguments to
Chevalley groups. Further generalisations are mentioned in the last section.

=== Basic reduction for the standard description <ss:basic-reduction>


#source(285) Since Bass, #citation[@bib:Bass1964] the basic reduction has been
clear. Assume the standard commutator formulae over $R$ and all its quotient
rings. The standard description is equivalent to the following extraction
assertion over each quotient: every noncentral elementary-normalised subgroup
contains a nontrivial root unipotent. A further parabolic-extraction lemma can
reduce this task to finding a noncentral element in a proper parabolic. That
lemma is part of the structure argument, rather than a consequence of the Levi
decomposition alone.

Let $F ≤ G(Phi, R)$ be normalised by $E(Phi, R)$. Let $A$ be the set of
parameters of root unipotents in $F$. Under the restrictions of
Theorem~@th:standard-normal-structure, root-level calculations show that $A$ is
an ideal, independent of the root, and $E(Phi, R, A) ≤ F$. Without these
restrictions one must distinguish root lengths.

Reduce modulo $A$. If the image $overline(F)$ is noncentral, the extraction
assertion gives $x_(α)(overline(ξ)) ∈ overline(F)$ with $ξ ∉ A$. Write
$x_(α)(ξ) = x y$, with $x ∈ F$ and $y ∈ G(Phi, R, A)$. For $g ∈ E(Phi, R)$,
$ [g, x_(α)(ξ)] = [g, x y] = [g, x] x [g, y] x^(-1). $
Both factors belong to $F$: the first by elementary normalisation, the second by
the standard commutator formulae and normality of $E(Phi, R, A)$ in $G(Phi, R)$.
Let $N$ be the normal closure of $x_(α)(ξ)$ in $E(Phi,R)$. The root-level
generation theorem gives $N=E(Phi,R,R ξ)$; relative perfectness gives
$[E(Phi,R),N]=N$ #citation[@bib:Vaserstein1986b, Theorems 3–4]. In
$quotient(E(Phi,R), (F∩E(Phi,R)))$, the element $x_(α)(ξ)$ and all its
conjugates are central. Hence $[E(Phi,R),N]⊆F$, so $N⊆F$ and $ξ∈A$, a
contradiction. Thus $overline(F)$ is central and $F ≤ C(Phi, R, A)$. #metadata((
  kind: "passage",
)) <passage:level-reduction>

The geometry behind parabolic extraction is as follows. Write $x=y z$, with
$y∈L(P)$ and $z∈U(P)$. A suitable commutator can place a nontrivial element in
$U(P)$, and root-level calculations then extract a root unipotent. Over general
rings these steps require a centralizer statement for the action of the Levi
factor on $U(P)$ and an extraction lemma for the particular root system;
noncentrality of $x$ alone does not prove either assertion. We use the
established structure theorem with its stated hypotheses, while the following
sections explain its principal constructions #citation[@bib:Vaserstein1986b,
  Theorem 4].

=== Rank one <ss:rank-one>

All the structure theorems fail in general at rank one, for $SL(2, R)$. As
#source(286) already mentioned, P.~H.~Cohn, R.~Swan (in the arithmetic case) and
Suslin (in the functional case) showed that $E(2, R)$ need not be normal, even
for Dedekind rings of arithmetic type, or Hasse domains #citation[@bib:Cohn1966,
  @bib:Swan1971, @bib:Suslin1981a].

Normal subgroup structure is worse. Positive results of Klingenberg, Lacroix,
Serre, Keller, Costa, Vaserstein, Menal, Mason and others cover special classes
such as semilocal rings and Hasse domains with infinite unit groups. No
comparable description should be expected over arbitrary commutative rings.

Even $SL(2, ZZ)$ has $2^(aleph_0)$ normal subgroups #citation[@bib:Mason1989].
The classical isomorphism
$ PSL(2, ZZ) ≃ (quotient(ZZ, 2 ZZ)) ast (quotient(ZZ, 3 ZZ)) $
shows that its quotients are exactly the groups generated by two elements
satisfying $a^2 = b^3 = e$. When both images are nontrivial their orders are $2$
and $3$. There are many such groups. Two recent results illustrate the
difficulty.

Every countable group embeds in an infinite simple group generated by elements
of orders $2$ and $3$ whose product has infinite order
#citation[@bib:Schupp1976, @bib:Mason1990]. It also seemed plausible that almost
every finite simple group is a quotient of $SL(2, ZZ)$ (see
#citation[@bib:DiMartino1990]). Miller knew in 1901 that the simple alternating
groups $A_n$, $n≥5$, apart from degrees $6, 7, 8$, are $(2, 3)$-generated. In
1989 A.~Woldar verified this for the sporadic groups apart from
$M_11, M_22, M_23$ and $upright("McL")$. Work of Ch.~Tamburini, L.~Di~Martino
and the author shows that failure for finite groups of Lie type is largely
confined to small groups in characteristics $2$ and $3$, including Suzuki groups
and exceptions such as $PSL(2, 9)$ and $upright("PSU")_3(3)$ (the latter is
denoted $upright("PSU")(3,9)$ in the original field-size convention).

A classification of normal subgroups of $SL(2, ZZ)$ would therefore encompass
finite simple groups, large classes of infinite simple groups, and the many
essentially different choices of generating pairs.

=== Noncommutative rings <ss:noncommutative-rings>

#source(287) Over noncommutative rings one restricts attention to classical
groups. There is no natural analogue of the exceptional Chevalley groups with
arbitrary noncommutative coefficients. The naive symplectic definition also does
not carry over; involutions and form parameters lead instead to unitary groups.
The obstruction was studied independently by Li Shangzhi and the author; see the
forthcoming survey _Generation in Chevalley groups_. We concentrate on
$GL(n, R)$; the unitary situation is broadly analogous.

Stable linear results do not require commutativity. Golubchik proved normal
structure for classes including von Neumann regular rings,
#citation[@bib:Golubchik1973] a result rediscovered some ten years later by
Vaserstein. Over the following eight years he extended the standard description
to rings whose primitive quotient rings satisfy the Ore condition and which have
finite localisational dimension.#ed-note[
  A two-sided ideal $J$ of $A$ is _left localising_ if the left localisation
  $(1+J)^(-1) A$ exists. The _left localisational dimension_ of $R$ is the least
  $n≥0$ for which there is a chain of two-sided ideals $0=I_0⊆dots⊆I_(n+1)=R$
  such that, for every $0≤k≤n$, every two-sided ideal of $quotient(R, I_k)$
  contained in $quotient(I_(k+1), I_k)$ is left localising in
  $quotient(R, I_k)$. For $S=1+J$, existence of the localisation is equivalent
  to two conditions: for every $a∈A$, $s∈S$ there are $b∈A$, $t∈S$ with
  $b s=t a$; and $a s=0$ implies $t a=0$ for some $t∈S$. The denominators may be
  zero divisors #citation[@bib:Golubchik1986, Introduction and Lemma 1.2]. PI
  rings have finite left localisational dimension #citation[@bib:Golubchik1986,
    Theorem 3.1].
] This broad class includes PI rings.

Let $S$ consist of the elements that are neither left nor right zero divisors.
The _right Ore condition_ requires $r S ∩ s R != emptyset$ for every $r∈R$ and
$s∈S$; the _left Ore condition_ requires $S r ∩ R s != emptyset$. They permit
the classical rings of fractions $r s^(-1)$ and $s^(-1) r$, respectively
#citation[@bib:Bresar2025, Definition 7.10, Theorem 7.13 and Remark 7.16].
Golubchik proved normal structure without having the standard commutator
formulae at his disposal. Even for PI rings those formulae followed roughly ten
years later; earlier work with A.~V.~Mikhalev established only subnormality of
the elementary group #citation[@bib:Golubchik1985b, @bib:Golubchik1985c]. Finite
localisational dimension was used to extract a transvection in several steps.

The result was announced in 1978 and appeared in Golubchik's thesis
#citation[@bib:Golubchik1981a]. As a member of the thesis jury I can confirm
that the proof existed by 1981. It is puzzling that it was never properly
published: #citation[@bib:Golubchik1985a] is difficult to obtain even in Russia.
I and others repeatedly asked Golubchik and his advisor Mikhalev #source(288)
without obtaining a satisfactory answer. Thirteen years later it still covered
the widest class of rings. Localisation and patching, unlike Golubchik's method,
works mainly with the centre of the ring. Vaserstein and others also treated
further classes of infinite-dimensional rings arising in topology and analysis,
including Banach algebras; a complete bibliography cannot be given here.

There are counterexamples for general rings. For each $m>1$, Gerasimov's example
#citation[@bib:Gerasimov1989, §10] uses two generic $m × m$ matrices
$x = (x_(i j))$, $y = (y_(i j))$ over a field $K$. Their entries are
noncommuting variables commuting with scalars. The quotient
$ R = quotient(K ⟨ x_(i j), y_(i j) ⟩, (x y = e = y x)) $
has $E(m,R)$ neither normal nor subnormal in $GL(m, R)$. Around 1980 rings
without invariant basis number, also called nondimensional rings, were suggested
as further examples, but no definitive proof appeared.

Call a ring _weakly finite_ if $A B=e$ implies $B A=e$ for every $n≥1$ and
$A,B∈M_(n)(R)$. Here _absolutely weakly finite_ means that every quotient
$quotient(R, I)$ by a two-sided ideal is weakly finite; the later terminology is
_completely weakly finite_ #citation[@bib:VavilovStepanov2013, §12].

Determining the exact class of rings admitting both standard commutator formulae
and standard normal structure is attractive but perhaps hopeless. Borewicz and
the author conjectured absolutely weakly finite rings; Stepanov and
S.~G.~Khlebutin disproved this #citation[@bib:Stepanov1988, @bib:Khlebutin1984,
  @bib:Khlebutin1986, @bib:Khlebutin1987]. No plausible replacement was known.
The main obstruction is normality of $E(n, R)$ in $GL(n, R)$; Stepanov supplied
evidence that normal subgroup structure within $E(n, R)$ might nevertheless be
standard for every ring when $n ≥ 3$.#ed-note[
  A later reduction theorem shows that, for $n≥3$ and a two-sided ideal $J$
  contained in the Jacobson radical of $R$, standard normal structure of
  $GL(n, R)$ is equivalent to that of $GL(n, quotient(R, J))$
  #citation[@bib:Stepanov1999, Corollary 4.7]. This reduces the question to the
  semiprimitive quotient; it does not characterise all rings with standard
  normal structure.
]
