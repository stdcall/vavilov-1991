#import "main-defs.typ": *
#import "statements.typ": *
#import "diagrams/e6-columns.typ": e6-column-diagram

== The proofs for $E_6$ <sec:proofs-e6>

The proof for $E_6$ follows those for $A_l$ and $D_l$ closely. #source(310) It
is more direct than the symplectic proof, but a new constraint appears: one
constructs a unipotent fixing a _white_ column, rather than an arbitrary column.
This suffices because the columns of matrices in the 27-dimensional
representation of $G(E_6,R)$ are white. The quadratic equations defining white
vectors are therefore part of the argument.

=== Freudenthal transvections <ss:freudenthal-transvections>

Let $V$ be the standard 27-dimensional module of highest weight $ω_1$, with its
invariant cubic form. For a column $u∈V$, a row $v∈V^*$, and $ξ∈R$, the simplest
Freudenthal transvection is
$ T_(u,v)(ξ)x=x+ξ(x,v)u+ξ v×(u×x). $
<eq:freudenthal-transvection>
The cross product of two columns is a row, and that of two rows is a column.
Their signs are fixed by the cubic coefficients $c_(λ μ ν)$ from
§@ss:e6-weight-cubic:
$
  v^λ×v^μ=sum_ν c_(λ μ ν)v_ν, quad
  v_λ×v_μ=-sum_ν c_(λ μ ν)v^ν.
$
Here $(x,v)=v x$. If $(u,v)=0$ and both $u$ and $v$ are white, the
transformation preserves the cubic form #citation[@bib:Vavilov2000, §4.2]. These
are called transformations of long root type in the representation geometry;
this terminology does not introduce roots of two lengths in the root system
$E_6$. More general Freudenthal transformations use three vectors and covectors.
Their theory was developed by Freudenthal, Jacobson, Springer, Veldkamp, Bix,
and others.

Conjugation has the expected form,
$ g T_(u,v)(ξ)g^(-1)=T_(g u,v g^(-1))(ξ). $
The elementary root elements, and hence their conjugates, are special cases.
#source(311) For example take $u=v^ω$ and $v=(v^τ)^*$, using the weight
coordinates of the minimal module. The first term adds $ξ x_τ$ to $x_ω$. The two
successive cross products give the five other coordinate additions prescribed by
the root element $x_(α_1)(ξ)$: each exchanges the appropriate pair of weight
coordinates, with the signs fixed by the Chevalley basis.
#numbered-figure(e6-column-diagram(mode: "weights"), caption: [Weights in the
  27-dimensional minuscule representation of $E_6$.])
<fig:e6-weight-coordinates>
Thus @eq:freudenthal-transvection[the Freudenthal transvection formula] gives
exactly the elementary root element $x_(α_1)(ξ)$.

=== Stabilising a white column <ss:e6-column-stabiliser>

Choose five roots such that every pair forms the angle $π/3$; their differences
are roots. This is a maximal singular family in the geometry of root subgroups.
In the convention where the five coefficients on the horizontal arm are written
above the branch coefficient, take
$
  α & =(1,2,3,2,1;2), quad β=(1,2,3,2,1;1), \
  γ & =(1,2,2,2,1;1), quad δ=(1,2,2,1,1;1), \
  ε & =(1,2,2,1,0;1).
$
<eq:e6-singular-roots>
#source(312) The roots in this family commute as positive root subgroups.
Consider
$ z=x_(α)(z_α)x_(β)(z_β)x_(γ)(z_γ)x_(δ)(z_δ)x_(ε)(z_ε). $
<eq:e6-five-root-product>
#numbered-figure(e6-column-diagram(mode: "actions"), caption: [The actions of
  the five commuting root subgroups.])
<fig:e6-five-root-actions>
The plan is to choose the five parameters so that $z$ fixes a given white
vector, and then to decompose an elementary root element into 27 such factors,
one for each column of $g^(-1)$.

For this calculation the weight coordinates are temporarily named according to
the five roots. The last five are $u_α,u_β,u_γ,u_δ,u_ε$; there are ten
coordinates $u_(ρ σ)$ with $ρ≠σ$ among these five roots, and ten primed
coordinates $u'_ρ,u''_ρ$, in addition to $u_ω,u_τ$. Each root element changes
six coordinates, as indicated by the weight diagram. The names record the
relevant pairings rather than the numerical order of the weights.
#numbered-figure(e6-column-diagram(mode: "coordinates"), caption: [Coordinate
  names for the five-root column stabiliser.])
<fig:e6-stabiliser-coordinates>

#source(313) Choose the integral Chevalley basis so that the signs in this
construction are
$ (s_α,s_β,s_γ,s_δ,s_ε)=(1,1,1,1,-1), quad z_ρ=s_ρ ξ u_ρ. $
For each distinct pair $ρ,σ$, the two contributions to $u_(ρ σ)$ are opposite
multiples of $ξ u_ρ u_σ$ and cancel. This accounts for ten of the changed
coordinates. The remaining changes are sums of the shape
$ ξ(u_α u''_α-u_β u''_β+u_γ u''_γ-u_δ u''_δ+u_ε u''_ε), $
$ ξ(u_α u'_α-u_β u'_β+u_γ u'_γ-u_δ u'_δ+u_ε u'_ε). $
<eq:e6-white-cancellations>
For an arbitrary column these need not vanish. For a white column they are
precisely two of the quadratic equations expressing whiteness, namely components
of the gradient of the invariant cubic form. Both vanish. Hence $z$ fixes the
column.

The cancellation can be read directly from the signed weight diagram or obtained
from the Frenkel–Kac cocycle. The essential point is that the linear
column-stabiliser equations alone would not suffice: the two residual quadratic
equations use the orbit condition on the column. The signed calculations and the
quadratic orbit equations have a systematic later treatment in _A third look at
weight diagrams_, #citation[@bib:Vavilov2000, §§3–5].

=== Normality <ss:e6-normality>

We use the later published elementary parabolic lemma
#citation[@bib:Vavilov2000, §4.3, Proposition 2]: if $G=G(E_6,R)$, $P=P_1$, and
a fake root unipotent of shape $A_m$ belongs to $w P w^(-1)$ for an element $w$
of the extended Weyl group, then it belongs to $E(E_6,R)$. The corresponding
statement for $E_7$ uses $P_7$. Here _shape $A_m$_ means the family obtained
from mutually $π/3$-related roots, as in the five-root column stabiliser of
§@ss:e6-column-stabiliser. The lemma concerns this special class of unipotents;
arbitrary elements of a parabolic need not be elementary.

First let $ξ∈R$ and $g∈G(E_6,R)$, and write $g^(-1)=(g'_(μ λ))$. For each weight
$λ$, apply @eq:e6-five-root-product[the five-root product] to the $λ$th column
to fix that column. #source(314) Multiply its parameters by the common scalar
$g_(λ α)$ and put
$
  x_λ=product_(ρ∈{α,β,γ,δ,ε})
  x_(ρ)(s_ρ ξ g_(λ α)g'_(ρ λ)).
$
<eq:e6-stepanov-factors>
The root coordinates here mean the last five weight coordinates, as in the
preceding calculation, rather than roots serving as matrix indices. The
inverse-matrix identities sum out the four unwanted components and leave the
desired parameter in the $α$-component. Thus
$ product_(λ∈Λ(ω_1)) x_λ=x_(α)(ξ). $
Each $x_λ$ fixes $g^(-1)e_λ$, so $g x_λ g^(-1)$ lies in the Weyl conjugate of
$P_1$ stabilising $e_λ$. It is a fake root unipotent of the same shape. The
elementary parabolic lemma therefore gives $g x_λ g^(-1)∈E(E_6,R)$. Multiplying
proves absolute normality.

Relative normality follows by a separate short argument that applies to every
Chevalley group once absolute normality is known over all coefficient rings
#citation[@bib:Vaserstein1986b, §2, p. 221]. For an ideal $I⊴R$, form
$ R'=\{(a,b)∈R×R:a-b∈I\}, quad J'=\{(a,0):a∈I\}. $
Projection onto the second component is split by the diagonal copy of $R$.
Consequently
$ E(Phi,R')∩G(Phi,R',J')=E(Phi,R',J'). $
Indeed, in a word in root elements split each parameter into its diagonal part
and its $J'$-part. Moving all diagonal factors to one side leaves a product of
their conjugates of root elements of level $J'$. If the original word projects
to the identity, the product of diagonal factors is the identity too.

For $h∈E(Phi,R,I)$ and $g∈G(Phi,R)$, lift them to $(h,1)$ and $(g,g)$ over $R'$.
Absolute normality makes the conjugate $(g h g^(-1),1)$ elementary over $R'$,
while it remains congruent to the identity modulo $J'$. The displayed
split-kernel equality places it in $E(Phi,R',J')$. Projection onto the first
component then yields $g h g^(-1)∈E(Phi,R,I)$. #metadata((
  kind: "passage",
)) <passage:relative-normality-pullback>

The proof therefore combines three separate ingredients: commuting root
subgroups, the quadratic equations of the white orbit, and the elementary
parabolic lemma for fake root unipotents. The pullback argument supplies the
relative version.
