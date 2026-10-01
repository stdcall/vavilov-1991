#import "main-defs.typ": *
#import "diagrams/chapter1-chain.typ": zero-weight-chain

== Minimal modules <sec:minimal-modules>

In fact the equations which determine the Chevalley groups may be written down
explicitly so that these groups may be identified with stabilizers of certain
systems of tensors. For example the _Ree–Dieudonné theorem_ establishes
isomorphisms between Chevalley groups of classical series and split classical
groups in the usual sense: special linear, symplectic, and orthogonal groups,
with the appropriate central covers. Their defining tensors are volume,
alternating bilinear, or quadratic forms, respectively. We believe that it is
quite natural also to think of the exceptional Chevalley groups of types
$G_2,F_4,E_6,E_7,E_8$ as just certain groups of $7 times 7$, $26 times 26$,
$27 times 27$, $56 times 56$, $248 times 248$ matrices respectively. Another
purpose of this survey is to show how to easily control the equations on the
entries of these matrices and why it might be useful in the study of the
exceptional groups. In this paragraph we introduce the main tool which we use to
study Chevalley groups—the so called “minimal”, or “basic” representations.

=== Basic representations <ss:basic-representations>

Return to the notations of §@sec:chevalley-groups. Let us recall that a
nontrivial irreducible representation $pi$ of the complex simple Lie algebra $L$
is called _basic_ if the Weyl group $W=W(Phi)$ acts transitively on the set
$overline(Lambda)^*(pi)$ of non-zero weights of the representation $pi$. This is
equivalent to saying that if for any two non-zero weights $lambda,mu$ their
difference is a fundamental root $alpha=lambda-mu$, then $w_alpha lambda=mu$ for
the corresponding fundamental reflection $w_alpha in W$. Such representations
were first considered in #citation[@bib:Chevalley1956] and first used to study
Chevalley groups over rings by H.~Matsumoto #citation[@bib:Matsumoto1966,
  @bib:Matsumoto1969].

It is straightforward to enumerate all the basic representations. It is clear
that all the non-zero weights of such a representation have multiplicity 1 (they
are in the Weyl orbit of the highest weight). Thus
$Lambda^*(pi)=overline(Lambda)^*(pi)$. It is easy to show that the multiplicity
of the zero weight is $m=|hat(Delta)(pi)|$, where
$hat(Delta)(pi)=Pi∩Lambda^*(pi)$ is the set of fundamental roots which are the
weights of the representation $pi$. Thus we may speak about $m$ “zero-weights”
$hat(alpha)_1,dots,hat(alpha)_m$ where $hat(Delta)(pi)={alpha_1,dots,alpha_m}$.

Now if $pi$ actually has zero weight then all the remaining weights of $pi$
#source(236)
must be the short roots of the root system $Phi$. Thus every complex simple Lie
algebra has a unique such representation, called the “short-root
representation”. Its highest weight $omega$ coincides with the short dominant
root of $Phi$. If there is just one root length then $omega$ is the maximal root
and this representation is just the adjoint representation of $L$. If there is
no zero weight then $Lambda(pi)=Lambda^*(pi)$ and all the weights of $pi$ form
one Weyl orbit. Such a representation is called a _microweight representation_
and of course a list of these representations is very well known (see
#citation[@bib:Bourbaki1975]).

Let’s give the list of possible highest weights $omega$ for the basic
representations. With the sole exception of the adjoint representation for
$A_ell$ all these weights are fundamental. Our numbering of the simple roots
follows Bourbaki #citation[@bib:Bourbaki2002, Chapter VI, Plates I–IX].

#table(
  columns: (auto, auto, 1fr),
  stroke: none,
  [$A_ell$],
  [$overline(omega)_k$, $k=1,dots,ell$],
  [the $k$-th exterior power of the usual representation;],

  [],
  [$omega=overline(omega)_1+overline(omega)_ell$],
  [the adjoint representation;],

  [$B_ell$], [$omega=overline(omega)_1$], [the usual representation;],
  [], [$omega=overline(omega)_ell$], [the spinorial representation;],
  [$C_ell$], [$omega=overline(omega)_1$], [the usual representation;],
  [], [$omega=overline(omega)_2$], [the short root representation;],
  [$D_ell$], [$omega=overline(omega)_1$], [the usual representation;],
  [], [$omega=overline(omega)_2$], [the adjoint representation;],
  [],
  [$omega=overline(omega)_(ell-1),overline(omega)_ell$],
  [the two half-spinorial representations;],

  [$E_6$],
  [$omega=overline(omega)_1,overline(omega)_6$],
  [the two minimal dimensional representations;],

  [], [$omega=overline(omega)_2$], [the adjoint representation;],
  [$E_7$], [$omega=overline(omega)_1$], [the adjoint representation;],
  [], [$omega=overline(omega)_7$], [the minimal dimensional representation;],
  [$E_8$], [$omega=overline(omega)_8$], [the adjoint representation;],
  [$F_4$], [$omega=overline(omega)_4$], [the short root representation;],
  [$G_2$], [$omega=overline(omega)_1$], [the short root representation.],
)
Thus the total number of basic representations of the Lie algebra $L$ of type
$Phi$ equals $|P(Phi):Q(Phi)|$.

=== Weight diagrams <ss:weight-diagrams>

Now we’ll describe a very useful device to visualize the action of elements of a
Chevalley group on vectors of a given representation—the corresponding _weight
diagrams_. It is very difficult to trace their origin. The Moscow State
University folklore tells that they were systematically drawn by the Dynkin’s
school in early fifties (though never #source(237) appeared in the published
works) and that Dynkin has even coined a special word referring to their form,
something like “shuttleness” (this is what is now called unimodality in the
theory of posets). The earliest appearance of these or similar pictures in print
which I was able to trace had been #citation[@bib:Curtis1971]. They were
systematically used by M.~Stein in his stability paper #citation[@bib:Stein1983,
  @bib:Stein1978] and have appeared many times since then in different places
(see some references at the end of this subsection).

Let’s associate with a representation a graph which is _almost_ the Hasse
diagram of the set $overline(Lambda)(pi)$ of its weights with respect to the
usual partial order defined by the choice of a fundamental system $Pi$, viz.
$lambda ≥ mu$ if and only if $lambda-mu$ is a linear combination of the
fundamental roots with non-negative coefficients. Actually, for the basic
representations with $op("mult")(0) ≤ 1$ it will be _precisely_ this Hasse
diagram.

Namely let’s construct a marked graph in the following way. Its vertices
correspond to the weights $lambda in Lambda(pi)$ _with multiplicities_ of the
representation $pi$, and the vertex corresponding to $lambda$ is actually marked
by $lambda$ (often the marks are omitted). Usually we read the diagram from
right to left and from bottom to top, which means that a larger weight tends to
stand to the left of and higher than a smaller one, with the landscape
orientation being primary. The vertices corresponding to
$lambda,mu in Lambda(pi)$ are linked by a bond marked $alpha_i$ (or just $i$) if
and only if $lambda-mu=alpha_i in Pi$. When $lambda$ and $mu$ are non-zero
weights this definition is unambiguous. We have to explain how to understand the
equality when $lambda$ or $mu$ is a zero weight. If $lambda=hat(alpha)$,
$alpha in hat(Delta)(pi)$, then we stipulate $mu=-alpha$ and $alpha_i=alpha$, so
that $hat(alpha)=(-alpha)+alpha$. If $mu=hat(alpha)$, $alpha in hat(Delta)(pi)$,
then $lambda=alpha_i=alpha$ and $alpha=hat(alpha)+alpha$. This means that to any
root $alpha in hat(Delta)(pi)$ there corresponds the following weight chain of
length three:

#align(center, zero-weight-chain())

and $hat(alpha)$ is not adjacent to any other vertex by an ordinary bond. In
fact to really calculate with the zero weights we have to introduce also another
sort of bonds, which we denote by dotted lines and which join $hat(alpha)$ to
$±beta$ if $alpha,beta in hat(Delta)(pi)$, $alpha != beta$, are not orthogonal.
But these bonds have to be read in one direction, from a zero weight to a
non-zero one and we omit the details here. We try to draw the diagrams in such a
way that the marks on the opposite sides of a parallelogram are equal and in
that case at least one of them is omitted.

#source(238)
For the case of a microweight representation there is another natural way to
look at these diagrams. Let $omega=omega_k$ be the highest weight of a
microweight representation. Then all the other weights lie in the Weyl orbit of
$omega$ and thus correspond bijectively to the cosets $quotient(W, W_k)$, where
$W_k$ is the Weyl subgroup of the Weyl group $W=W(Phi)$ generated by reflections
in all the fundamental roots except $alpha_k$. Now of course there is a usual
way to introduce a partial order on the set of such cosets, viz. the _(induced)
Bruhat order_. Namely in each coset there is a unique element of the smallest
length (the _distinguished coset representative_) and one takes the ordinary
Bruhat order of $W$ on these representatives. What we’ve defined before
corresponds rather to the _weak Bruhat order_, but a well-known combinatorial
result (see #citation[@bib:Proctor1984]) guarantees that for a microweight these
two definitions coincide. When there is a zero-weight the dotted lines occur
precisely because the corresponding Bruhat order on the non-zero weights is
actually stronger than the weak order (a pair of an ordinary and a dotted line
with common vertex corresponds to a bond in the Hasse diagram of the Bruhat
order which does not come from a fundamental reflection).

In this form the diagrams appeared in #citation[@bib:Stein1978]. To show the
relevance of the microweights and the corresponding posets we attach some
references picked up almost at random out of the huge literature of the subject
#citation[@bib:Aschbacher1988, @bib:Baston1984, @bib:Bjorner1984,
  @bib:Bjorner1983, @bib:Bjorner1988, @bib:Boe1985, @bib:Cline1975,
  @bib:Curtis1971, @bib:Deodhar1977, @bib:Deodhar1978, @bib:Deodhar1987,
  @bib:Hartley1984, @bib:Hiller1982a, @bib:Hiller1982b, @bib:Idowu1987,
  @bib:Irving1985, @bib:Kac1980, @bib:Matsumoto1966, @bib:Matsumoto1969,
  @bib:Mizuno1977, @bib:Mizuno1980, @bib:Plotkin1984a, @bib:Plotkin1984b,
  @bib:Plotkin1985a, @bib:Plotkin1985b, @bib:Plotkin1989, @bib:Plotkin1991,
  @bib:Proctor1982, @bib:Proctor1984, @bib:Proctor1986, @bib:Ronan1985,
  @bib:Seshadri1978, @bib:Springer1973, @bib:Stanley1980, @bib:Stein1983,
  @bib:Stein1978, @bib:Vavilov1987, @bib:Vavilov1988a, @bib:Vavilov1988c,
  @bib:Vavilov1990c, @bib:Vavilov1982, @bib:Vavilov1990d, @bib:Verma1971,
  @bib:Zalesski1980, @bib:Zarhin1984].

=== Action on a minimal module <ss:action-minimal-module>

Fix a basic representation $pi$ of a Chevalley group $G=G(Phi,R)$ on the free
$R$-module $V=V_R=V_(ZZ) ⊗_(ZZ) R$. We tend to identify $G$ with its image
$pi(G)=G_pi (Phi, R)$ under this representation and often omit the symbol $pi$
in the action of $G$ on $V$. Thus for an $x in G$ and $v in V$ we write $x v$
for $pi(x)v$. Decompose the module $V$ into the direct sum of its weight
submodules
$ V=⊕_(lambda in Lambda^*(pi)) V^lambda ⊕ V^0. $
H.~Matsumoto #citation[@bib:Matsumoto1969, Lemma 2.3] has shown that one may
choose a base of weight vectors $v^lambda in V^lambda$,
$lambda in Lambda^*(pi)$, $v_alpha^0 in V^0$, $alpha in hat(Delta)(pi)$, in
which the action of the root unipotents $x_alpha (xi)$, $alpha in Phi$,
$xi in R$, is described by the following very nice formulas:

+ If $lambda in Lambda^*(pi)$, $lambda+alpha ∉ Lambda(pi)$, then
  $x_alpha (xi)v^lambda=v^lambda$;
+ If $lambda,lambda+alpha in Lambda^*(pi)$, then
  $x_alpha (xi)v^lambda=v^lambda ± xi v^(lambda+alpha)$;
+ If $alpha ∉ Lambda^*(pi)$, then $x_alpha (xi)v^0=v^0$, for any $v^0 in V^0$;
+ If $alpha in Lambda^*(pi)$, then
  $x_alpha (xi)v^(-alpha)=v^(-alpha)+xi v^0(alpha)±xi^2 v^alpha$,
#source(239)
$x_alpha (xi)v^0=v^0±xi alpha_*(v^0)v^alpha$;

where $alpha_*$ is a certain integral linear functional on the zero-weight
submodule, an element of the dual space $(V^0)^*=Hom_R (V^0,R)$ and $v^0(alpha)$
is a unimodular element of $V^0$ (recall that an element $v$ of a free
$R$-module $V$ is _unimodular_ if there exists a $phi in V^*=Hom_R (V,R)$ such
that $phi(v) in R^*$; equivalently, the map $R -> V$, $r |-> r v$, is a split
injection). We refer to this fact as the _Matsumoto lemma_. The zero-weight
vectors in the adjoint representation come from the Cartan subalgebra; in the
other short-root representations one obtains the analogous formulas from the
chosen integral weight basis. We will not use their explicit coefficients here.
For the sake of brevity we write $v^(hat(alpha))$ instead of $v_alpha^0$. Then
our base ${v^lambda}$ of $V$ is indexed by all the weights
$lambda in Lambda(pi)$ _with multiplicities_.

Now we may expand any $v in V$ in the chosen base,
$v=sum c_lambda v^lambda + sum c_alpha^0 v_alpha^0$, $lambda in Lambda^*(pi)$,
$alpha in hat(Delta)(pi)$. If we prefer to suppress the distinction between zero
and non-zero weights we write simply $v=sum c_lambda v^lambda$,
$lambda in Lambda(pi)$ and refer to $c_lambda$ as the $lambda$-th coordinate of
$v$. Then of course the Matsumoto lemma provides explicit formulas for the
action of $x_alpha (xi)$ on $v$ and on its coordinates. This action is most
suggestively described in the following way. Conceive a vector $v in V$ as the
marked graph which is obtained by putting marks $c_lambda$ and $c_alpha^0$ to
the corresponding vertices of the weight diagram of type $(Phi,pi)$. Expand a
root $alpha in Phi$ in the fixed base of the root system:
$alpha=sum m_i alpha_i$, $alpha_i in Pi$. Then the action of $x_alpha (xi)$ on
$v$ looks as follows: it adds the $lambda$-th coordinate of $v$ multiplied by
$±xi$ to the coordinate standing in the vertex $mu$ such that there is a
directed path (we go in the positive/negative direction if $m_i$ are
positive/negative) from $lambda$ to $mu$ having precisely $|m_i|$ bonds with the
mark $i$ for any $i=1,dots,ell$. There are slightly more complicated rules if
the path starts/stops at zero and the path which has $2|m_i|$ bonds with mark
$i$ has to be taken into account too.
