#import "main-defs.typ": *

== Elementary calculations <sec:elementary-calculations>

#source(227)
Here we start to discuss the interrelation of Chevalley groups and elementary
Chevalley groups and recall very briefly some fundamental facts about
calculations in an elementary Chevalley group. We refer to the calculations
based on the elementary generators $x_alpha (xi)$ and the Steinberg relations as
the _elementary calculations_.

=== Chevalley and elementary groups <ss:groups-versus-elementary>

Let now $alpha in Phi$, and $u$ be a variable. The homomorphism of $ZZ[G]$ on
$ZZ[u]$ which sends a coordinate function $x_(lambda,mu)$ to its value on
$x_alpha (u)$ induces a homomorphism
$ G_a (R)=Hom(ZZ[u], R) -> G(Phi,R)=Hom(ZZ[G], R) $
from the additive group $R^+=G_a (R)$ of the ring $R$ to the Chevalley group
$G(Phi,R)$. The image of this homomorphism is the root subgroup
$X_alpha={x_alpha (xi), xi in R}$. Thus the elementary Chevalley group
$E_pi (Phi, R)$ is contained in the Chevalley group $G_pi (Phi, R)$. The
interrelations between these two groups constitute one of the major problems in
the theory of Chevalley groups over rings. Whereas for an elementary Chevalley
group there is a very nice system of generators $x_alpha (xi)$, $alpha in Phi$,
$xi in R$, and the relations among these generators are fairly well understood
(see below), nothing like that is available for the Chevalley group itself.

This distinction is not that essential for fields. Let $K$ be an _algebraically
closed field_. Then always $G_pi (Phi, K)=E_pi (Phi, K)$. It is very easy to
verify that this equality is not true in general even for the case of a field
but if the group $G$ is _simply-connected_, then for an _arbitrary field_ one
has $G_("sc")(Phi,K)=E_("sc")(Phi,K)$. This was proven by the method of the
“grosse cellule”, which is a particular case of the Chevalley–Matsumoto
decomposition #citation[@bib:Chevalley1960, @bib:Demazure1971, @bib:Borel1970,
  @bib:Matsumoto1969, @bib:Stein1978, @bib:Abe1988b]. In fact the equality
$G_("sc")(Phi,R)=E_("sc")(Phi,R)$ holds even in the case when $R$ is a
_semilocal ring_, see #citation[@bib:Matsumoto1969, @bib:Abe1969,
  @bib:Stein1973, @bib:Abe1976]. Recall that a commutative ring is _semilocal_
if it has only finitely many maximal ideals. There are also some further cases
when the groups $G_("sc")$ and $E_("sc")$ are known to coincide, say, the
euclidean rings #citation[@bib:Steinberg1962], the Dedekind rings of arithmetic
type which are not totally imaginary #citation[@bib:Bass1967,
  @bib:Matsumoto1969] and the polynomial rings with coefficients in a field or a
principal ideal ring #citation[@bib:Suslin1977, @bib:Suslin1982,
  @bib:Kopeiko1978, @bib:Abe1983, @bib:Vorst1981, @bib:Costa1988,
  @bib:Grunewald1991]. These extensions have hypotheses on the type and rank;
the polynomial-ring assertion must not be read as a rank-one theorem. For
example, Suslin proves the special-linear result for $SL(n, R[X_1,dots,X_m])$
with $n≥3$ over a field #citation[@bib:Suslin1977, §6, Corollary 6.7].#ed-note[
  The polynomial-ring result now holds for every split simply connected simple
  group of rank at least two over any field, without exceptions in small
  characteristic. More generally, over a regular algebra containing a perfect
  field, the corresponding nonstable $K_1$ is invariant under adjoining a
  polynomial variable #citation[@bib:Stavrova2014, Theorems 1.2–1.3].
]

If we work with fields or semilocal rings then the distinction between a
Chevalley group and the corresponding elementary subgroup is easily bridged
#source(228)
even for non simply-connected cases by adding certain semisimple generators (see
§@ss:diagonal-extensions for details). But for general rings the situation
becomes much more complicated as the $K_1$-functor comes into play and there is
no hope to give an explicit presentation for the Chevalley group itself. So one
of the first questions which arise here is
_whether the elementary subgroup is normal in a Chevalley group?_

It is very well-known that the elementary group $E(2,R)=E_("sc")(A_1,R)$ is _not
necessarily normal_ in the special linear group $SL(2, R)=G_("sc")(A_1,R)$ (see
#citation[@bib:Cohn1966, @bib:Swan1971, @bib:Suslin1981a]), but it turns out
that _if_ $Phi$ _is an irreducible root system of rank_ $ell ≥ 2$, _then_
$E(Phi,R)$ _is always normal in_ $G(Phi,R)$ #citation[@bib:Suslin1977,
  @bib:Suslin1982, @bib:Kopeiko1978, @bib:Taddei1982, @bib:Taddei1985,
  @bib:Taddei1986]. In fact to sketch a new direct proof of this statement is
one of the main objectives of the present survey.

Thus for these cases one can define a quotient group
$ K_1(Phi,R)=quotient(G_("sc")(Phi,R), E_("sc")(Phi,R)), $
which is the famous _$K_1$-functor of type_ $Phi$ _over_ $R$ (see
#citation[@bib:Stein1971b, @bib:Stein1973, @bib:Stein1983, @bib:Stein1978,
  @bib:Abe1983]). Algebraic K-theory shows that this functor is generally
speaking non-trivial so that for a ring the group $E_("sc")(Phi,R)$ _may be
strictly smaller than_ $G_("sc")(Phi,R)$.

This normality statement is important also because a lot of natural questions
can be comfortably answered for $E(Phi,R)$ and if we know that it is normal in
$G(Phi,R)$ the answers can be extended to the latter group as well.

=== Steinberg group <ss:steinberg-group>

The most common way to calculate in a Chevalley group is to use the elementary
generators $x_alpha (xi)$ and the relations between those—the so called
_Steinberg relations_, see #citation[@bib:Steinberg1962, @bib:Carter1972a].

Now we recall very briefly some properties of the elementary root unipotents
$x_alpha (xi)$ which do not depend on a representation. It is obvious that for
any $xi,eta in R$ one has
$ x_alpha (xi+eta)=x_alpha (xi)x_alpha (eta), $
and thus for a fixed $alpha in Phi$ the map $x_alpha:xi |-> x_alpha (xi)$ is a
homomorphism of the additive group $R^+$ of $R$ to a one-parameter subgroup
$X_alpha={x_alpha (xi) | xi in R}$, which is called the _elementary unipotent
root subgroup_ corresponding to $alpha$. In fact $x_alpha$ is an isomorphism of
$R^+$ on $X_alpha$. When it does not lead to a confusion we omit the epithets
“elementary” and “unipotent” and speak about _root elements_ and _root
subgroups_ (these expressions are given a wider sense in §@sec:relative-groups).
For elements $x,y$ of a group $G$ we denote by $[x,y]$ their commutator
$x y x^(-1)y^(-1)$. Let now $alpha,beta in Phi$,
#source(229)
$alpha+beta != 0$, and $xi,eta in R$. Then the _Chevalley commutator formula_
asserts that
$
  [x_alpha (xi),x_beta (eta)]
  = product x_(i alpha+j beta)(N_(alpha beta i j) xi^i eta^j),
$
where the product in the right hand side is taken over all the roots of the form
$i alpha+j beta in Phi$; $i,j in NN_(>0)$, in a fixed order and the constants
$N_(alpha beta i j)$ do not depend on $xi,eta$ (though they may in general
depend on the order). The integral numbers $N_(alpha beta i j)$ are called the
_structure constants_ of the Chevalley group and it’s easy to check that they
may take just the values $±1,±2,±3$ (eventually
$N_(alpha beta 1 1)=N_(alpha beta)$ are just the structure constants of $L$ in
the Chevalley base). It is a much more delicate task to determine the signs of
the constants, and we refer to #citation[@bib:Chevalley1955, @bib:Steinberg1967,
  @bib:Demazure1971, @bib:Ree1961a, @bib:Ree1961b, @bib:Ree1964,
  @bib:Hurley1971, @bib:Carter1972b, @bib:Azad1982, @bib:Azad1983,
  @bib:Springer1973, @bib:Splitthoff1986] for the details. Tables for a
particular choice of the structure constants and some further related
information are reproduced in a forthcoming paper by the author and
E.~B.~Plotkin “Structure of Chevalley groups over commutative rings. I.
Structure constants”.

Now if $rk Phi ≥ 2$, the _Steinberg group_ $St(Phi, R)$ has generators
$y_alpha (xi)$, $alpha in Phi$, $xi in R$, subject to the relations above:
additivity in $xi$ and the Chevalley commutator formula (for $Phi=A_1$ the
second relation is vacuous and one has to replace it by another one, involving
$w_alpha (epsilon)$). Since $x_alpha (xi)$ satisfy these relations and generate
$E(Phi,R)$, there is a natural epimorphism $pi(Phi, R):St(Phi, R) -> E(Phi,R)$
sending $y_alpha (xi)$ to $x_alpha (xi)$ and in fact most of the elementary
calculations could be done equally well in the Steinberg group (see, for
example, #citation[@bib:Stein1971b, @bib:Stein1973, @bib:Stein1983,
  @bib:Stein1978]). In general the kernel of $pi(Phi, R)$ is _very far from
being trivial_ even for the case of a field—this is the _$K_2$-functor of type_
$Phi$ _over_ $R$:
$ 1 -> K_2(Phi,R) -> St(Phi, R) -> E(Phi,R) -> 1, $
see #citation[@bib:Stein1971b, @bib:Stein1978] and its calculation in each
particular case is a highly nontrivial task (compare, for example,
#citation[@bib:Matsumoto1969, @bib:Milnor1971, @bib:Bass1973b] and of course a
huge number—maybe something like 200—of papers devoted to the calculation of
$K_2$ for the rings of arithmetic and algebro-geometric nature has appeared
since then which we cannot quote here). For the case of a field (or a semi-local
ring) though it is rather easy to supplement the relations among root unipotents
to get an explicit presentation for $E(Phi,R)$, see below.

Another major problem in the theory of Chevalley groups over rings asks
_whether_ $K_2(Phi,R)$ _is central in_ $St(Phi, R)$ _when_ $rk Phi ≥ 4$? This is
true at the stable level (see #citation[@bib:Stein1971b, @bib:Stein1978,
  @bib:VanDerKallen1980] and the references therein) and for $Phi=A_ell$ (see
#citation[@bib:VanDerKallen1977, @bib:Tulenbaev1981]), but even for the other
classical cases definitive proofs are #source(230) missing. It is our belief
that the methods exposed in the present paper should lead also to a complete
solution of this problem.#ed-note[
  This question has since been answered affirmatively, with the stronger bound
  $rk Phi≥3$, for every reduced irreducible root system $Phi$ and every
  commutative ring $R$: $K_2(Phi,R)⊆Z(St(Phi, R))$. See
  #citation[@bib:LavrenovSinchukVoronetsky2024, §1, theorem on central
    extensions (arXiv version)]. The proof uses localisation in pro-groups; the
  case $F_4$ completes the earlier results for the other types.
]

=== Some important elements and subgroups <ss:important-elements-subgroups>

Let now $alpha in Phi$ and $epsilon in R^*$, where $R^*$ is the multiplicative
group of units of $R$. As usual we set
$w_alpha (epsilon)=x_alpha (epsilon)x_(-alpha)(-epsilon^(-1))x_alpha (epsilon)$
and $h_alpha (epsilon)=w_alpha (epsilon)w_alpha (1)^(-1)$. The elements
$h_alpha (epsilon)$—and their conjugates—are called _semisimple root elements_.

Then by a famous _Steinberg theorem_ (#citation[@bib:Steinberg1962],
#citation[@bib:Steinberg2016, Chapter 6, Theorem 8(b)]) to get the actual
presentation of the simply-connected Chevalley group over a field one has only
to add to the Steinberg relations one additional type of relations, viz. the
multiplicativity of $h_alpha (epsilon)$ in $epsilon$:
$
  h_alpha (epsilon eta)=h_alpha (epsilon)h_alpha (eta),
  quad epsilon,eta in R^*.
$
In rank one the commutator relations are replaced by relation (B′) in the
statement of the cited theorem.

Thus for a field the (elementary) Chevalley groups admit a very nice
presentation. As we’ve mentioned before for an arbitrary ring there is no way
even to control the generators—not to say relations—of a Chevalley group. The
case of a field is particularly pleasant because there is a canonical form—the
_reduced Bruhat decomposition_—which guarantees that any simply connected
Chevalley group $G$ has _finite width_ in terms of the generators
$x_alpha (xi)$. To state this we have to recall definitions of some very
important subgroups of $G$.

The group $tilde(W)=tilde(W)(Phi,R)$ generated by $w_alpha (1)$, $alpha in Phi$,
is called the _extended Weyl group_ (or else the _Tits–Demazure group_) of type
$Phi$. For a simply connected group over a field $R=K$ with $"char" K != 2$, one
has $|tilde(W)|=2^ell |W|$ and the structure of the group has been studied in
some detail in #citation[@bib:Tits1966b, @bib:Demazure1971]. This group plays
the crucial role in our construction of the cubic invariant forms for the
exceptional groups.

Let $T=T(Phi,R)$ be the split maximal torus and $N=N(Phi,R)$ be the group,
generated by $T(Phi,R)$ and $tilde(W)(Phi,R)$. For the case of a field $K$,
$|K| ≥ 4$, it coincides with the normaliser of the torus $T$ in $G$. Often $N$
is referred to as the _torus normaliser_—in the algebraic sense. Of course for
the rings the actual normaliser of $T$ in $G$—in the abstract sense—can be much
larger than $N$. The quotient group $quotient(N, T)$ is canonically isomorphic
to the Weyl group $W$ and for any $w in W$ we fix a preimage $n_w$ of $w$ in
$N$.

Recall that we’ve fixed an order of $Phi$, with $Phi^+$ and $Phi^-$ being the
corresponding sets of positive and negative roots respectively. Set
$ U=U(Phi,R)=⟨x_alpha (xi), alpha in Phi^+, xi in R⟩, $
$ U^-=U^-(Phi,R)=⟨x_alpha (xi), alpha in Phi^-, xi in R⟩. $

#source(231)
Then $U=U(Phi,R)$ is the product of elementary root subgroups $X_alpha$,
$alpha in Phi^+$, in any fixed order. In other words any element $u in U$ may be
written in the form $u=product x_alpha (u_alpha)$, where $alpha$ runs over the
set $Phi^+$ of the positive roots and the coordinates $u_alpha in R$ are
uniquely determined by $u$ itself and by the order on $Phi^+$. The product
$B=B(Phi,R)$ of the groups $T$ and $U$ is called the _standard Borel subgroup
of_ $G$ (corresponding to the given choice of $T$ and $Phi^+$), $U$ is called
the _unipotent radical of_ $B$. The product $B^-=B^-(Phi,R)$ of $T$ and $U^-$ is
called a _Borel subgroup opposite to_ $B$.

Now if $R=K$ is a field the _Bruhat lemma_ asserts that $n_w$, $w in W$, form a
system of double coset representatives for $B$ in $G$, or, in other words, that
any element $x$ of $G=G(Phi,K)$ may be written in the form $x=b_1 n_w b_2$ where
$b_1,b_2 in B$ and $w$ is uniquely determined by $x$. This decomposition of
$x$—referred to as its _Bruhat decomposition_—shows that, for simply connected
$G$, actually any $x in G$ is—to give a very rough bound—a product of not more
than $2m+7ell$ elementary generators $x_alpha (xi)$, where $m$ is the number of
positive roots and $ell$ the rank of $Phi$.

Bruhat decomposition is limited to the case of a field. But if $R$ is semilocal
$G$ still admits a very useful decomposition, namely the so called _Gauss
decomposition_ $G=B U^- U$ (see #citation[@bib:Stein1973, @bib:Abe1976,
  @bib:Vavilov1984]) which shows, in the simply connected case, that any
$x in G$ is a product of not more than $3m+4ell$ elementary generators.#ed-note[
  Semilocality can be replaced by Bass stable rank one for the elementary group:
  $E(Phi,R)=H(Phi,R) U(Phi,R) U^-(Phi,R) U(Phi,R)$, where $H=T inter E$, for
  every reduced irreducible root system #citation[@bib:Smolensky2012, Theorem
    1]. This factorization alone does not assert $G=E$.
] Now for a general ring $R$ even if the groups $G$ and $E$ happen to coincide
no upper bound for the minimal length of an elementary expression of elements
from $G$ exists in general (see #citation[@bib:VanDerKallen1982,
  @bib:CarterD1983, @bib:CarterD1984, @bib:Tavgen1990] for some examples and
positive results—one may note that the original proofs of the estimates for the
elementary expressions for Hasse domains were based on the generalized Riemann
hypothesis).#ed-note[
  An unconditional uniform result is now available: for each reduced irreducible
  root system of rank at least two, a bound depending only on the root system
  suffices for elementary generation of the simply connected group over every
  Dedekind ring of arithmetic type, including totally imaginary number-field
  cases #citation[@bib:Kunyavskii2026, Theorem A]. The theorem asserts existence
  of this uniform bound; it does not supply explicit bounds for every
  number-field ring.
] This is one of the reasons why the elementary calculations tend to be less and
less efficient for rings which are not so close to fields. Anyhow the elementary
calculations are entirely in terms of the group $E$ and they are not suitable to
study the interrelation of $E$ and $G$. That’s why to approach this problem we
have to develop different techniques.

=== Diagonal extensions <ss:diagonal-extensions>

Here we recall construction of some semi-simple elements which together with the
elementary subgroup generate the whole Chevalley group—or even some larger
groups—in the case of a field (see #citation[@bib:Seligman1967,
  @bib:Jacobson1971, @bib:Vavilov1986, @bib:Vavilov1988a, @bib:Vavilov1988e]).

Recall that the split maximal torus is isomorphic to the group of $R$-characters
of the weight lattice $P$:
#source(232)
$ T=T_P (Phi,R) ≅ Hom(P, R^*). $
At the same time the intersection of $T$ with the elementary subgroup
$E=E_P (Phi,R)$ which is usually denoted by $H=H_P (Phi,R)$ is generally
speaking somewhat smaller. Its elements are the restrictions to $P$ of
characters of the full weight lattice:
$
  H=H_P (Phi,R)
  = Im(Hom(P(Phi), R^*) -> Hom(P, R^*)).
$
This means that the elements of $H$ correspond to those characters of $P$ which
can be extended to the whole weight lattice $P(Phi)$. Later we think of $P$ as
being fixed and suppress it in the notations. Actually one has
$ H=H(Phi,R)=⟨h_alpha (epsilon),alpha in Phi,epsilon in R^*⟩. $
To verify the equality $H=T∩E$ over an arbitrary ring, consider the central
isogeny $f:G_("sc") -> G_P$. Every product of root elements in $E_P (R)$ lifts,
with the same parameters, to $E_("sc")(R)$. The scheme-theoretic inverse image
of $T_P$ is $T_("sc")$, so a lift of an element of $T_P (R)∩E_P (R)$ lies in
$T_("sc")(R)$. The simple coroots form a basis of the cocharacter lattice of
this simply connected torus; hence its $R$-points are products of
$h_(alpha_i)(epsilon_i)$ with $epsilon_i∈R^*$. Their images give exactly the
displayed subgroup $H$. This proves both inclusions without assuming that $f$ is
surjective on all $R$-points.

Following #citation[@bib:Abe1969] we may introduce the subgroup
$ G_o=G_o (Phi,R)=T(Phi,R)E(Phi,R). $
Then one has $G_o (Phi,R)=G(Phi,R)$ for every group—not just the
simply-connected one—if $R$ is a field or, more generally, a semi-local ring
#citation[@bib:Abe1969, @bib:Matsumoto1969, @bib:Abe1976].

The elements $h(chi)$ are related to the elementary generators $x_alpha (xi)$ by
the following formula
$ h(chi)x_alpha (xi)h(chi)^(-1)=x_alpha (chi(alpha)xi). $
One may think of $chi$ here as being an arbitrary $R$-character of the lattice
$Q(Phi)$, not just a character of $P$. Such a map realizes a _diagonal
automorphism_ of the group $G$ (see #citation[@bib:Stein1973, @bib:Carter1972a])
which is not necessarily internal (often one understands under diagonal
automorphisms the cosets of diagonal automorphisms by internal diagonal
automorphisms). Sometimes it is convenient to look at extensions of the
Chevalley group where all the diagonal automorphisms become internal. It is very
easy to construct such an extension for the adjoint groups. One has just to
consider linear operators on the Chevalley algebra which act on a Chevalley base
as follows: $h(chi)h_i=h_i$ and $h(chi)e_alpha=chi(alpha)e_alpha$ (see
#citation[@bib:Seligman1967, @bib:Carter1972a]). Then the group
$overline(T)_("ad")=overline(T)_("ad")(Phi,R)$ consisting of all such $h(chi)$
for $chi in Hom(Q(Phi), R^*)$ normalizes $E_("ad")$ and the product
$overline(G)_("ad")=overline(T)_("ad")E_("ad")$ is the _extended adjoint
Chevalley group of type_ $Phi$ _over_ $R$. In #citation[@bib:Seligman1967] one
may find identification of these groups for the classical series. It is much
more difficult to construct such an extension for the simply-connected case
since here to keep the maximal torus connected one has to increase its
dimension. Such an extension was
#source(233)
constructed only in #citation[@bib:Berman1975]. As examples of the extended
Chevalley group one may think of $GL(n, R)$ for the series $A_ell$ and
$op("GSp")(2ell,R)$ for the series $C_ell$. Below we occasionally refer to the
_weight elements_ $h_omega (epsilon)$, $omega in P(Phi^∨)$, $epsilon in R^*$.
These are the elements acting as $h(chi)$ for the character
$chi=chi_(omega,epsilon)$ defined by
$chi_(omega,epsilon)(alpha)=epsilon^((alpha,omega))$. Look
#citation[@bib:Vavilov1986, @bib:Vavilov1988a, @bib:Vavilov1988e] for details.

=== Reduction to smaller ranks <ss:reduction-smaller-ranks>

Usually the elementary calculations lead to a complete success if the problem
may be reduced to the groups of smaller rank.

Let first $S$ be any closed set of roots in $Phi$ i.e. such a subset that if
$alpha,beta in S$ and $alpha+beta in Phi$, then $alpha+beta in S$. One can
associate with this set a subgroup $G(S,R)$ of the Chevalley group $G=G(Phi,R)$
which is the group of points of a certain group scheme (see
#citation[@bib:Matsumoto1969] for details). This group is very close to the
group $G_o (S,R)=T(Phi,R)E(S,R)$, where as usual $T=T(Phi,R)$ is a split maximal
torus of $G(Phi,R)$ and $E(S,R)$ is the subgroup generated by all the elementary
root subgroups $X_alpha$, $alpha in S$, with respect to $T$:
$ E(S,R)=⟨x_alpha (xi),alpha in S,xi in R⟩. $
For example $G_o (Phi,R)=G(Phi,R)$ when $R$ is semilocal (look
#citation[@bib:Vavilov1982] where it is proven for a more general class of
subgroups, the so called “net subgroups” of $G$ which are defined in terms of
certain congruences). The groups $E(S,R)$ are particularly important when the
set $S$ is _special_ (alias _unipotent_), i.e. $S∩(-S)=∅$.

Two sets of roots $S_1,S_2 ⊆ Phi$ are called _conjugate_ if there exists an
element $w$ of the Weyl group $W=W(Phi)$ such that $w S_1=S_2$. If the sets
$S_1$ and $S_2$ are conjugated then there exists an $n in tilde(W)(Phi)$ such
that $n G(S_1,R)n^(-1)=G(S_2,R)$. Recall that we have fixed an order on the root
system $Phi$ which determines $Pi,Phi^+$ and $Phi^-$.

A _standard parabolic subset_ $P$ is a closed set of roots containing $Phi^+$. A
_parabolic subset_ $Q$ is a subset conjugated to a standard parabolic one.

It is well known that the parabolic subsets fall into $2^ell$ conjugacy classes,
where $ell=rk(Phi)$ is the rank of $Phi$. The standard parabolic subsets are
pairwise not conjugated and correspond bijectively to all of the subsets
$J ⊆ Pi$ of the fundamental system. Namely if $J ⊆ Pi$ is such a subset then we
may define $P_J$ to be the smallest closed set of roots containing $Phi^+$ and
$-J$. The most important parabolic subsets are the maximal ones. A maximal
parabolic subset corresponds to a set $J=J_r$, $1 ≤ r ≤ ell$, which contains all
the fundamental roots apart
#source(234)
from $alpha_r$. The corresponding parabolic set $P_(J_r)$ is maximal among the
proper closed subsets and will be denoted $P_r$. Thus there are precisely $ell$
conjugacy classes of the maximal parabolic subsets.

In the sequel we will use only the parabolic subgroups of the form $G(Q,R)$,
where $Q$ is a parabolic subset. We commonly practice the following abusive
expression: when we say that an element or a subgroup is contained in a proper
parabolic subgroup we actually mean that it is contained in one of the
$G(Q,R)$’s for a $Q != Phi$. Since any such subgroup $G(Q,R)$ is conjugated to a
standard parabolic subgroup $G(P,R)$ by an element from $tilde(W)(Phi)$, we may
consider only the standard parabolic subgroups.

Now recall the structure of $G(P,R)$. Let again $S ⊆ Phi$ be any closed set of
roots. Then $S$ is the disjoint union of its _reductive_ (alias _symmetric_)
part $S^r$ which consists of $alpha in S$ such that $-alpha in S$ and its
_unipotent part_ $S^u$ which consists of $alpha in S$ such that $-alpha ∉ S$.
The set $S^r$ is a closed subsystem of roots while the set $S^u$ is special.
Moreover $S^u$ is an ideal in $S$, i.e. if $alpha in S$, $beta in S^u$ and
$alpha+beta in Phi$, then $alpha+beta in S^u$. The group $G(S,R)$ is the
semidirect product of the reductive subgroup $G(S^r,R)$ (a _Levi subgroup_ of
$G(S,R)$) and the unipotent subgroup $E(S^u,R)$ (the _unipotent radical_ of
$G(S,R)$). In the case when $S=P$ is parabolic the Levi subgroup and the
unipotent radical of the parabolic subgroup $G(P,R)$ are usually denoted by
$L(P,R)$ and $U(P,R)$ respectively.

By $U^-(P,R)$ we denote the unipotent radical of the _opposite parabolic
subgroup_ (recall that all of our parabolic subgroups contain the same $T$ and
thus there is just one opposite subgroup corresponding to the opposite parabolic
subset $P^-=P^r union(-P^u)$). In other words $U^-(P,R)$ is generated by the
root subgroups $X_alpha$ where $alpha in (-P^u)$. An obvious but very important
consequence of the Chevalley commutator formula is that both $U(P,R)$ and
$U^-(P,R)$ are normalized by $L(P,R)$. Usually we adhere to the following
notation. For a parabolic subset $P ⊆ Phi$ we denote $P^r$ by $Delta$ and $P^u$
by $Sigma$. Thus $U(P,R)=E(Sigma,R)$ and $U^-(P,R)=E(-Sigma,R)$. By the
definition of a parabolic subset $Phi=Sigma union Delta union(-Sigma)$ is a
partition of $Phi$.

Now of course for a proper parabolic subset $P$ the system $Delta$ has smaller
rank than $Phi$. One is in a very good position when one can reduce to a smaller
rank since in that case one can either argue by induction on the rank or
sometimes even finish the proof immediately. Here $G(Delta,R)$ denotes the
points of the semisimple derived subgroup of the Levi, with the root datum
induced by its embedding in $G$; it does not include the whole ambient torus.
Thus $L(P,R)=T(Phi,R)G(Delta,R)$. An inclusion $Delta ⊆ Phi$ of root systems
induces inclusions of the corresponding groups $G(Delta,R) ≤ G(Phi,R)$,
$E(Delta,R) ≤ E(Phi,R)$
#source(235)
and so on. In turn these inclusions induce a map of the corresponding
$K_1$-functors $K_1(Delta,R) -> K_1(Phi,R)$ and as we’ll see later a lot can be
said about the structure of the group $G(Phi,R)$ if there exists a proper
subsystem $Delta ⊂ Phi$ such that this map is bijective.
