#import "main-defs.typ": *

== Stable and general calculations <sec:stable-general-calculations>

In this section we describe calculations produced using the minimal modules of a
Chevalley group.

=== Stable calculations <ss:stable-calculations>

Fix the base $v^lambda$, $lambda in Lambda(pi)$, described in the preceding
section. Then any element $g$ of the Chevalley group $G_pi (Phi, R)$ is
presented by its matrix $g=(g_(lambda mu))$, $lambda,mu in Lambda(pi)$, in this
base. This means that $g_(lambda mu)$ is the
#source(240)
$lambda$-th coefficient in the expansion of $g v^mu$. Thus the columns and rows
of the matrix are indexed by the weights of $pi$—as we see in the next paragraph
it is not expedient to index them by the natural numbers.

By _stable calculations_ we understand calculations involving just one column or
one row of the matrix $g=(g_(lambda mu))$. This expression refers to the fact
that it is precisely the sort of calculations one needs to solve the problems
_at the stable level_, i.e. when the rank of the group is large with respect to
the “dimension” of the ground ring, whatever it should mean. These calculations
were used in proving stability theorems for the functors $K_1(Phi,R)$ and
$K_2(Phi,R)$, see #citation[@bib:Matsumoto1969, @bib:Stein1978].

Actually the notions of “dimension” which were most commonly used here were
Krull dimension, $dim op("Max")(R)$, “stable rank” and “absolute stable rank”.
Recall that the last two notions are defined as follows. One says that the
_stable rank_ of the ring $R$ does not exceed $d$ and writes $op("sr")(R) ≤ d$
if for any unimodular row $(a_1,dots,a_d,a_(d+1))$ of length $d+1$ with
coordinates in $R$ there exist $c_1,dots,c_d in R$ such that the row
$(a_1+a_(d+1)c_1,dots,a_d+a_(d+1)c_d)$ is again unimodular. One says that the
_absolute stable rank_ of the ring $R$ does not exceed $d$ and writes
$op("asr")(R) ≤ d$ if for _any row_ $(a_1,dots,a_d,a_(d+1))$ of length $d+1$
with coordinates in $R$ there exist $c_1,dots,c_d in R$ such that every maximal
ideal of $R$ containing the ideal $(a_1+a_(d+1)c_1,dots,a_d+a_(d+1)c_d)$
contains also the ideal $(a_1,dots,a_d,a_(d+1))$. The notion of the stable rank
was introduced by H.~Bass and then studied by D.~Estes and J.~Ohm
#citation[@bib:Estes1967], L.~N.~Vaserstein #citation[@bib:Vaserstein1971],
A.~A.~Suslin and many others in some detail. The absolute stable rank appears
naturally when one passes from the linear and symplectic groups to other
classical and exceptional cases and was implicitly studied by D.~Estes and
J.~Ohm #citation[@bib:Estes1967] and explicitly introduced by M.~R.~Stein
#citation[@bib:Stein1978].

A column of a matrix $g=(g_(lambda mu))$ is obtained by freezing the second
index. Thus the columns may be represented by some vectors from $V$. Analogously
the rows are obtained by freezing the first index and correspond to the vectors
from the dual module $V^*$. Now if we multiply $g$ on the right by an
$x_alpha (xi)$ the resulting transformation of the columns of $g$ may be easily
recovered with the help of the Matsumoto lemma. The same applies of course to
the rows of $g x_alpha (xi)$. These calculations are very similar in spirit to
the “matrix problems” as developed by P.~Gabriel, L.~A.~Nazarova, A.~V.~Roiter
and others in the non-classical representation theory, say in the study of
representations of
#source(241)
posets, graphs and analogous combinatorial objects (see
#citation[@bib:Gabriel1990] for some details and further references).
Calculations of analogous nature appeared also in the enumeration of
Borel-orbits by A.~G.~Elashvili, W.~H.~Hesselink and H.~Bürgstein (see
#citation[@bib:Hesselink1985, @bib:Burgstein1987]). W.~Hesselink compared the
whole business to a sort of chessboard game.

=== Equations on columns <ss:equations-columns>

It should be noticed that not every vector from $V$ corresponds to a column of a
matrix from $G$. There are of course two obvious restrictions. First, any column
of an invertible matrix is unimodular. Second, its coordinates should satisfy
some quadratic equations. Namely for a vector $v in V$ the condition to be the
$lambda$-th column of a matrix from $G$ means precisely that $v$ lies in the
$G$-orbit of $v^lambda$. In our case there are essentially two possibilities for
$lambda$: a zero weight and a non-zero weight. First consider an algebraically
closed field $R=K$. The projective highest-weight orbit is defined by quadratic
equations; in $V$ these equations define its affine cone, including the zero
vector. Thus the nonzero highest-weight orbit is obtained by deleting the vertex
of that cone, see #citation[@bib:Lichtenstein1982]. These equations can easily
be written also using the Bruhat decomposition. Since these equations are
“characteristic free” the matrix entries of a matrix $g in G$ over any ring
satisfy the same polynomial equations as for the case of fields.

For the groups of types $A_ell$ and $C_ell$ in the usual representations there
are no equations: over a field any nonzero vector can be a column of a
determinant-one matrix, and any nonzero vector of even length can be a column of
a symplectic matrix. In all the other cases it is not true. It is obvious that
to be a column of an orthogonal matrix a vector has to satisfy a quadratic
equation, see §@sec:classical-cases below. Let us give another classical example
of such equations. Look at the fundamental representation of the group
$SL(n, K)$ with the highest weight $overline(omega)_k$. These representations
are furnished by the $k$-th exterior power $⋀^k V$ of the natural
$n$-dimensional module $V$. Then the orbit of the highest weight vector in this
representation corresponds to nonzero _decomposable_ $k$-vectors. Thus the image
of the orbit in the corresponding projective space $P(⋀^k V)$ is the Grassmann
variety $op("Gr")_(n,k)$ of $k$-dimensional subspaces in an $n$-dimensional
space in the _Plücker embedding_ #citation[@bib:Griffiths1978,
  @bib:Hartshorne1977]. It is classically known that this image is defined by a
system of quadratic equations—the _Plücker equations_— and using this fact and
the standard realizations of the fundamental representations of the classical
groups #citation[@bib:Bourbaki1975] it is immediate to check that the affine
cone over the highest-weight orbit is cut out by a system of quadrics. Analogous
equations for the $27$-dimensional representation of $E_6$ and the
#source(242)
$56$-dimensional representation of $E_7$ (see §@sec:cubic-form and
§@sec:other-exceptional-groups below) were written by J.~Tits and H.~Freudenthal
#citation[@bib:Tits1953, @bib:Tits1954, @bib:Faulkner1977]. In fact as we’ll see
the orbit of the highest weight vector for the first of these cases corresponds
to the elements of rank 1 in the exceptional Jordan algebra. The rank 1
condition amounts to the fact that all the minors of degree 2 vanish—which is of
course a system of quadratic equations again. An extremely beautiful system of
quadratic equations in the general case using the Casimir operator has been
written by W.~Lichtenstein #citation[@bib:Lichtenstein1982].

Over an algebraically closed field, a nonzero vector on the highest-weight cone
can be a column of a matrix from $G$. Over an arbitrary field one must also
check that the rational vector lies in the required $G(K)$-orbit. This is not
any more true for rings since there is a much less obvious K-theoretical
obstacle. In general not every unimodular column over a ring may be included in
an invertible matrix (whether it was so for the polynomial rings constituted the
famous Serre problem). In our approach we ignore this K-theoretical obstruction,
but the quadratic equations play a very important role.

=== General calculations <ss:general-calculations>

By the _general calculations_ we understand the usual matrix calculations taking
into account the matrix $g=(g_(lambda mu))$ as a whole and all the equations
among its matrix entries. Such calculations are very easy to produce for the
classical groups since the dimensions of the minimal modules are fairly small
and there are very few dependencies among matrix entries, and we recall some
basic facts in the next paragraph. For the classical groups most of the results
were first proven by direct matrix calculations.

One is much less happy to calculate with matrices in the exceptional cases and
it is easy to attach obvious reasons for that. Apart from the $G_2$ case the
dimensions of the minimal modules are rather large for the direct calculations.
The groups themselves are sort of thinly spread in the corresponding $GL(V)$ and
so there is a lot of equations among the matrix entries to look after. The
simplest elements of the groups have a pretty large _residue_
$op("res") x=rk(x-e)$—whereas for the classical cases there are elements of
residue 1 or 2, for the exceptional cases you cannot find anything smaller than
6 or 10. Nevertheless we think that with the right approach the general
calculations may be very useful even in the exceptional cases and one of the
goals of the present paper is to illustrate an easy way to control all the
equations among the matrix entries. But what is even more remarkable, is that
one
#source(243)
does not need general calculations to solve the above-mentioned problems and a
lot of further ones! In fact we outline here some procedures which allow us to
reorganize the calculations necessary to prove normality of $E$ in $G$, to
describe normal subgroups of $G$, etc. in such a way as to _completely_ avoid
the general calculations! Everything will be performed as a combination of steps
involving just the elementary and stable calculations! What is really striking
about this is the fact that even in the case of a field and for the classical
groups our proofs are sometimes _very much simpler_ than the previously known
ones (this is precisely what was stated in the Russian original of
#citation[@bib:Vavilov1990d] and mistranslated in the following bizarre way “We
note that for the classical types and for the field case our proofs have already
been in the literature for a considerable time”—traduttore-traditore!). It is
precisely on the classical examples that we illustrate our methods first.

=== Chevalley–Matsumoto decomposition <ss:chevalley-matsumoto>

Since it has been known for some time that a simply-connected Chevalley group
and the corresponding elementary Chevalley group over a field coincide, there
should have been some way to relate the Chevalley group with the elementary
subgroup. Such a technique is provided by what M.~R.~Stein has christened the
Chevalley–Matsumoto decomposition theorem (compare #citation[@bib:Matsumoto1969,
  Theorem 4.3]) which in turn is a further development of the method of “grosse
cellule” #citation[@bib:Chevalley1960].

Recall that if $pi$ is a basic representation of a Chevalley group $G(Phi,R)$
with the highest weight $omega$ then with the sole exception of the adjoint
representation for the group of type $A_ell$ there exists a unique fundamental
root $alpha_r in Pi$ such that $omega-alpha_r$ is a weight of the representation
$pi$. For the adjoint representation of $A_ell$ there are two such roots
$alpha_1$ and $alpha_ell$. For the decomposition below assume that $omega$ is a
fundamental weight; this excludes the adjoint $A_ell$ representation. Let
$Delta$ be generated by $J=Pi without {alpha_r}$, the simple roots orthogonal to
$omega$. Then $Delta$ is the reductive part of the standard parabolic subset
corresponding to $J$. Set further $Sigma=Phi^+ without Delta$ and
$-Sigma=Sigma^-=Phi^- without Delta$. Then $Sigma$ and $Sigma^-$ are the
unipotent parts of $P$ and the opposite parabolic set $P^-$ respectively and
$Phi$ is a disjoint union of $Sigma,Delta$ and $Sigma^-$. As we know from
§@ss:reduction-smaller-ranks the groups
$ U(Sigma,R)=⟨x_alpha (xi),alpha in Sigma,xi in R⟩, $
$ U^-(Sigma,R)=⟨x_alpha (xi),alpha in Sigma^-,xi in R⟩ $
are normalized by the Chevalley group $G(Delta,R)$.

#source(244)
Now the Chevalley–Matsumoto decomposition theorem says that if an element
$g in G(Phi,R)$ of the group $G(Phi,R)$ in the representation $pi$ satisfies
$g_(omega omega) in R^*$, then $g=v z u$, where $v in U^-(Sigma,R)$,
$u in U(Sigma,R)$, and $z in T(Phi,R)G(Delta,R)$ where $v,u,z$ are uniquely
determined by $g$. Since $G(Delta,R)$ normalizes $U^-(Sigma,R)$ and
$U(Sigma,R)$, the element $g$ can be written also in the form
$g=z(z^(-1)v z)u=v(z u z^(-1))z$, where $z^(-1)v z in U^-(Sigma,R)$ and
$z u z^(-1) in U(Sigma,R)$. In other words if one denotes by $Omega_pi$ the set
of all $g in G(Phi,R)$ such that $g_(omega omega) in R^*$, then
$
  Omega_pi & = U^-(Sigma,R)T(Phi,R)G(Delta,R)U(Sigma,R) \
           & = U^-(Sigma,R)U(Sigma,R)T(Phi,R)G(Delta,R) \
           & = T(Phi,R)G(Delta,R)U^-(Sigma,R)U(Sigma,R).
$
For a simply connected group with this fundamental highest weight, if moreover
$g_(omega omega)=1$, then $z in G(Delta,R)$ so that the factor $T(Phi,R)$ in the
above decomposition can be omitted. Indeed, the simple coroots form a basis of
the torus of a simply connected group. Write $z=t d$ with
$t=product_(i=1)^ell alpha_i^∨(a_i)$ and $d in G(Delta,R)$. The fundamental
character $omega$ is trivial on $G(Delta,R)$ and satisfies $omega(t)=a_r$. Since
$z_(omega omega)=1$, we have $a_r=1$; all remaining coroot factors lie in
$G(Delta,R)$.

Under the same hypotheses, if $g$ stabilizes a primitive vector or, what is the
same, if $g_(omega omega)=1$ and $g_(lambda omega)=0$, for all the weights
$lambda != omega$, then $g=z u$, where as above $z in G(Delta,R)$ and
$u in U(Sigma,R)$.

The thing which really matters here is that the factors in the decomposition are
defined internally, without any reference to the representation. Thus this
decomposition gives a good start with the reduction of questions concerning
$G(Phi,R)$ to the groups of smaller ranks. For a field $R=K$ the Bruhat
decomposition already gives $G(Phi,K)=E(Phi,K)T(Phi,K)$: its unipotent factors
belong to $E$, and each representative $n_w$ may be chosen in the extended Weyl
group, hence in $E$. This avoids assuming that a nonzero entry adjacent to the
highest weight is present in every unimodular column.

Now if $alpha_r$ is any fundamental root (not necessarily the one for which
$omega-alpha_r$ is a weight) then the same decomposition holds _mutatis
mutandis_ under condition that an appropriate minor of the matrix $g$ is
invertible (for the preceding case this minor happens to have order 1). In fact
invertibility of a minor of order $m$ on a module is equivalent to invertibility
of one matrix entry in the $m$-th exterior power of the module. With this idea
in mind Chevalley has taken care of all these conditions simultaneously looking
at one entry in a very large representation. The set of elements $g in G(Phi,R)$
for which this entry is invertible is called the _grosse cellule_ and denoted by
$Omega=Omega(Phi, R)$. Actually $Omega={g in G(Phi,R), f(g) in R^*}$ for some
function $f$ from the affine
#source(245)
algebra $ZZ[G]$. Chevalley then proves that
$ Omega(Phi, R)=U^-(Phi,R)T(Phi,R)U(Phi,R) $
and this is one of his starting points in the construction of the group scheme
$G(Phi, dot)$, see #citation[@bib:Chevalley1960, @bib:Borel1970].
