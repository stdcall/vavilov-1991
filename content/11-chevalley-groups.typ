#import "main-defs.typ": *

== Chevalley groups <sec:chevalley-groups>


An _affine group scheme over_ $ZZ$ can be described by a commutative Hopf
$ZZ$-algebra $A$ #citation[@bib:Milne2022, Definition 3.3]. This is a
commutative $ZZ$-algebra equipped with algebra maps $Delta:A -> A ⊗_(ZZ) A$,
$epsilon:A -> ZZ$ and $S:A -> A$ (comultiplication, counit and antipode),
satisfying coassociativity, the counit identities and the antipode identities.
Its group of $R$-points is $Hom_("Alg"_ZZ)(A,R)$: for points $a,b:A -> R$, their
product is $m_R compose (a ⊗ b) compose Delta$, the identity is the composite
$A arrow.r^epsilon ZZ -> R$, and the inverse of $a$ is $a compose S$. A ring map
$f:R -> R'$ induces the group homomorphism $a |-> f compose a$. Thus the group
law is part of the representing algebra; representability of the underlying
set-valued functor alone does not supply it.

Here a _split semisimple group scheme over_ $ZZ$ means a smooth affine group
scheme of finite presentation whose geometric fibres are connected semisimple
algebraic groups, with a split maximal torus $T ≅ (G_m)^ell$. For such a torus
the characters $T -> G_m$ form a lattice $X^*(T)$; its roots and coroots form
the associated root datum. The Chevalley–Demazure scheme used below is specified
by the reduced root system $Phi$, character lattice $X^*(T)=P$, and the
corresponding coroots in the dual lattice #citation[@bib:Conrad2014, Definition
  3.1.1, Definition 5.1.1, Example 5.1.4, and Proposition 5.1.6]. For the
functor-of-points and integral-lattice constructions see
#citation[@bib:Stepanov2014, §§1.5, 1.9].


Let
$Phi$
be a reduced root system of rank $ell$, $P$—a lattice lying between the root
lattice $Q( Phi )$ and the weight lattice $P( Phi )$. From this data one can
construct an affine group scheme $G_P ( Phi ,dot)$ over $ZZ$, (i.e. a
representable covariant functor from the category of commutative rings with 1 to
the category of groups), such that for any algebraically closed field $K$ the
value $G_P ( Phi ,K)$ of this functor on $K$ is the semisimple algebraic group
over $K$ corresponding to $Phi ,P$. The existence of this group scheme was first
proven by C. Chevalley #citation[@bib:Chevalley1960], and its uniqueness—by M.
Demazure #citation[@bib:Demazure1965]. We will call it the _Chevalley–Demazure
group scheme of type $( Phi ,P)$_, and its value $G_P ( Phi ,R)$ on a
commutative ring $R$ with 1 (“the group of rational points $G_P ( Phi ,dot)$
with the coefficients in $R$”)—_the Chevalley group of type $( Phi ,P)$ over
$R$_. Usually we’ll omit $P$ in the
#source(223)
notation and speak about “a Chevalley group $G=G( Phi ,R)$ of type
$Phi$
over $R$”. When we want to stress that we are talking about the _simply
connected_ group (i.e. $P=P( Phi )$) we write $G=G_( "sc" )( Phi ,R)$, and if
the group $G$ is _adjoint_ (i.e. $P=Q( Phi )$) we write $G=G_( "ad" )( Phi ,R)$.
Usually we may (and will) assume that the group $G$ is simply connected.

Recall the construction of Chevalley groups.

=== Chevalley algebras <ss:chevalley-algebras>

Let $L=L_( CC )$ be a complex semisimple Lie algebra of type $Phi$,
$[dot,dot]$—Lie bracket in $L$, $H$—a Cartan subalgebra of $L$. Then $L$ admits
the root decomposition $L=H ⊕ sum L_alpha$, $alpha in Phi$, where the
$L_alpha$’s are the root subspaces i.e. one-dimensional $H$-invariant subspaces.
For a root
$alpha$
we denote by the same letter a linear functional $alpha in H^*$ on $H$, such
that $[h,e_alpha ]= alpha (h)e_alpha$, for any $h in H$ and
$e_alpha in L_alpha$. Restriction of the Killing form of $L$ to $H$ is
nondegenerate and will be denoted by $(dot,dot)$. This inner product allows us
to identify $H$ with $H^*$. For a root $alpha in H^*$ we denote by
$h_alpha =2 alpha /( alpha , alpha )$ the corresponding coroot. Let us fix an
order on $Phi$. We denote by $Phi^+$, $Phi^-$, and
$Pi = { alpha_1, dots , alpha_ell }$
the corresponding sets of positive, negative and fundamental roots respectively.
If for $alpha in Phi^+$ we fix elements $e_alpha in L_alpha$, $e_alpha != 0$,
then there is a unique choice of $e_(- alpha ) in L_(- alpha )$,
$alpha in Phi^+$, such that $[e_alpha ,e_(- alpha )]=h_alpha$. Then the set
${ e_alpha , alpha in Phi ;h_alpha , alpha in Pi }$
is called a _Weyl base_ of the Lie algebra $L$. All the structure constants in
this base, apart from probably the $N_( alpha beta )$’s, where
$[e_alpha ,e_beta ]=N_( alpha beta )e_( alpha + beta )$, are integers. Let $p$
be such that
$beta -p alpha , dots , beta , dots ,q alpha + beta$
is the $alpha$-series of roots passing through $beta$. C. Chevalley
#citation[@bib:Chevalley1955] has shown that one can choose $e_alpha$ in such a
manner that $N_( alpha beta )= plus.minus (p+1)$, i.e. _all the structure
constants are integers_— this fact is called a _Chevalley theorem_ (see
#citation[@bib:Bourbaki1975, @bib:Steinberg1962, @bib:Carter1972b,
  @bib:Humphreys1980] for the proof). The set $e_alpha$,
$alpha in Phi$
satisfying this condition is called a _Chevalley system_ and a Weyl base with
integral structure constants —a _Chevalley base_. An explicit choice of the
signs of the structure constants is rather tricky (see #citation[@bib:Tits1966a,
  @bib:Ree1961a, @bib:Ree1961b, @bib:Carter1972b, @bib:Burgoyne1971,
  @bib:Shoji1974, @bib:Milnor1971, @bib:Mizuno1977]). For what follows we fix
the same choice of signs as in #citation[@bib:Gilkey1988]. Of course the only
cases which present real difficulties are the algebras of types $E_6$, $E_7$ and
$E_8$ (the signs for $F_4$ may be deduced from those for $E_6$). The most
elegant way to explicitly control the signs for these cases is via the
Frenkel–Kac cocycle (see #citation[@bib:Frenkel1980, @bib:Springer1973,
  @bib:Frenkel1988]).

Let now $L_( ZZ )$ be the integral span of a Chevalley base. Then $L_( ZZ )$ is
a Lie algebra over $ZZ$, which is a $ZZ$-form of $L$, i.e.
$L=L_( ZZ ) ⊗_( ZZ ) CC$. This $ZZ$-form is called an _admissible $ZZ$-form_ or
a _Chevalley order_ in $L$. Let now $R$ be an arbitrary
#source(224)
commutative ring. Set $L_R=L_( ZZ ) ⊗_( ZZ )R$. In other words $L_R$ is a Lie
algebra over $R$, which is a free $R$-module with base $e_alpha =e_alpha ⊗ 1$,
$h_beta =h_beta ⊗ 1$, with the Lie bracket induced from $L_(ZZ)$. The algebra
$L_R$ is called a _split semisimple Lie algebra of type
$Phi$
over $R$_ or a _Chevalley algebra of type
$Phi$
over $R$_. At this stage one can construct the _adjoint_ Chevalley groups (see
#citation[@bib:Chevalley1955, @bib:Carter1965, @bib:Carter1972b,
  @bib:Humphreys1980, @bib:Seligman1967]) to construct simply-connected groups
one also needs to choose integral bases in the finite dimensional
representations of $L$.

=== Weyl modules <ss:weyl-modules>

Let again $L=L_( CC )$ be a complex semisimple Lie algebra,
$pi :L -> frak("gl") (V)$ its representation in a finite dimensional vector
space $V$ over $CC$. For an element $lambda in H^*$ we denote by $V^lambda$ the
corresponding _weight subspace_ of the space $V$ viewed as an $H$-module, i.e.
$V^lambda = { v in V | pi (h)v= lambda (h)v,h in H }$. Then
$lambda$
is called a _weight_ of the representation $pi$, if $V^lambda != 0$. The
dimension $m_lambda = op("mult") ( lambda )$ of $V^lambda$ is called the
_multiplicity_ of the weight $lambda$. Let’s denote by $overline(Lambda) ( pi )$
the _set of weights of the representation
$pi$_, (all the weights in $overline(Lambda) ( pi )$ are distinct) and by
$Lambda ( pi )$—the _set of weights with multiplicities_. This means that we
assign to each weight $lambda in overline(Lambda) ( pi )$ a set of $m$ distinct
“weights” $lambda_1, dots , lambda_m in Lambda ( pi )$, where
$m= op("mult") ( lambda )$. By $Lambda^*( pi )$ and $overline(Lambda)^*( pi )$
we denote the corresponding sets of non-zero weights. Let $P=P( pi )$ be the
lattice of weights of the representation $pi$, i.e. the subgroup of $P( Phi )$
spanned by $overline(Lambda) ( pi )$. Then $V= ⊕ V^lambda$,
$lambda in overline(Lambda) ( pi )$. In the case of the adjoint representation
$pi = "ad"$
one has $V=L$, $Lambda^*( pi )= Phi$,
$Lambda ( pi )= Phi union { 0_1, dots ,0_ell }$; $P=Q( Phi )$,
$V^alpha =L_alpha$ for
$alpha in Phi$
and $V^0=H$.

Let $omega in overline(Lambda)(pi)$ and $0 != v^+ in V^omega$. Then the weight
$omega = omega ( pi )$ is called the _highest weight_, and the nonzero vector
$v^+ in V^omega$ a _highest weight vector_ (or a _primitive element_), if
$pi (e_alpha )v^+=0$ for all $alpha in Phi^+$. Obviously this notion depends on
the choice of the order on the root system $Phi$. The representation
$pi$
is irreducible if and only if $V$ is generated as an $L$-module by a primitive
element. The multiplicity of the highest weight of an irreducible representation
is 1, so that a primitive vector $v^+$ is unique up to a nonzero scalar
multiple. It is well known that the correspondence $pi |-> omega ( pi )$
establishes a bijection between the set of isomorphism classes of
finite-dimensional irreducible $L$-modules and the set $P( Phi )_(++)$ of
_integral dominant_ (with respect to a given order) weights. Recall that
$
  P( Phi )_(++)= { omega in P( Phi ) | ( omega , alpha ) ≥ 0,
    forall alpha in Pi }.
$

The _Chevalley–Ree theorem_ #citation[@bib:Ree1964, Definition 1.5 and Theorem
  1.6] asserts that every finite-dimensional $L$-module $V$ contains a
$ZZ$-lattice $M$ invariant with respect to all $pi (e_alpha )^m/m!$,
$alpha in Phi$, $m in ZZ^+$,
#source(225)
and that such lattice is a direct sum of its weight components
$M^lambda =M ∩ V^lambda$ #citation[@bib:Chevalley1960, @bib:Steinberg1962,
  @bib:Borel1970,
  @bib:Humphreys1980]. Such a lattice $V_( ZZ )$ is called an _admissible
$ZZ$-form_ of the module $V$, and a base $v^lambda$, $lambda in Lambda ( pi )$
of the lattice $V_( ZZ )$, consisting of weight vectors such that for any
$alpha in Phi$, $m in ZZ^+$, $mu in Lambda ( pi )$ the vector
$pi (e_alpha^((m)))v^mu$
is an integral linear combination of the base vectors is called an _admissible
base_. Ree proves this by tensor products and a case-by-case construction
#citation[@bib:Ree1964, §§1.7–1.9 and the proof of Theorem 1.6], but the current
approach is to use _Kostant’s theorem_ #citation[@bib:Kostant1966, Theorem 1 and
  Corollary 1] (see also #citation[@bib:Borel1970, @bib:Stein1973,
  @bib:Humphreys1980, @bib:Jantzen1987,
  @bib:Taddei1985]), which says that the divided powers
$e_alpha^((m))=e_alpha^m/m!$, $alpha in Phi$, $m in ZZ^+$ generate a $ZZ$-form
$U(L)_( ZZ )$ of the universal enveloping algebra $U(L)$ of $L$ (the so called
_Kostant form_). Now it is straightforward to construct an admissible $ZZ$-form
of an irreducible $V$. One has just to take a highest-weight vector $v^+ in V$
and set $V_( ZZ )=U(L)_( ZZ )v^+$.

Now again let $R$ be a commutative ring with 1. Set $V_R=V_( ZZ ) ⊗_( ZZ )R$. In
other words $V_R$ is a free $R$-module with base $v^lambda =v^lambda ⊗ 1$,
$lambda in Lambda ( pi )$. Obviously $V_R$ is a $L_R$-module: $e_alpha$’s and
$h_i$’s act on the first component of $v ⊗ xi$, $v in V_( ZZ )$, $xi in R$,
while the scalars from $R$ act on the second. For the canonical lattice
$V_(ZZ)=U(L)_(ZZ)v^+$ just constructed, if $V$ is an irreducible $L$-module with
highest weight $omega$, then $V_R$ is called the _Weyl module_ of the Chevalley
algebra $L_R$ corresponding to the highest weight $omega$.

=== Elementary Chevalley groups <ss:elementary-chevalley-groups>

For the group constructions of type $Phi$, choose a faithful $L$-module $V$;
this ensures that its weight lattice contains the root lattice. Let $v^lambda$,
$lambda in Lambda ( pi )$ be an admissible $ZZ$-base of $V$,
$alpha in Phi$
and $xi in CC$. Then the linear operator $pi ( xi e_alpha ) in frak("gl") (V)$
is nilpotent and we can define its exponential by the usual formula

$
  exp ( xi pi (e_alpha ))=e+ xi pi (e_alpha )+ xi^2 pi (e_alpha^((2)))+ dots.c .
$

The image of a base vector under this operator is a linear combination of the
base vectors whose coefficients are linear combinations of powers of
$xi$
with integral coefficients. This means that we can define an automorphism

$ x_alpha ( xi )=x_alpha^pi ( xi )= exp ( xi pi (e_alpha )) in GL (V_R) $

of the $R$-module $V_R$ by the same formula as above for any commutative ring.
The subgroup of the automorphism group of the $R$-module $V_R$, generated by all
the automorphisms of the form $x_alpha ( xi )=x_alpha^V ( xi )$, is called the
_elementary Chevalley group of type
$Phi$
over $R$_ and is denoted by $E_pi ( Phi ,R)$. Thus we have

$
  E_pi ( Phi ,R)= ⟨ x_alpha ( xi ), alpha in Phi , xi in R ⟩
  ≤ GL (V_R).
$

So the elementary Chevalley group from the very start arises as a _linear
group_. As an _abstract group_ $E=E_pi ( Phi ,R)$ depends up to isomorphism not
on the
$pi$
#source(226)
itself but just on its lattice of weights $P=P( pi )$. If we want to stress this
we write $E=E_P ( Phi ,R)$. But according to our definition the groups
$E_P ( Phi ,R)$ always arise in some _particular representations_
$E_pi ( Phi ,R)$. For an irreducible module with the canonical highest-weight
lattice, the corresponding $V_R$ is the Weyl module.

=== Chevalley groups <ss:chevalley-groups>

Let now $G=G_( CC )$ be the connected complex semisimple group with the Lie
algebra $L=L_( CC )$ and the weight lattice $P$. Denote by $CC [G]$ the _affine
algebra_ of $G$, i.e. the algebra of regular complex-valued functions on $G$,
viewed as a _Hopf algebra_ in the usual fashion #citation[@bib:Borel1969,
  @bib:Hahn1989a, @bib:Abe1980, @bib:Springer1973]. Denote by the same letter
$pi$
the representation of $G$ on $V=V_( CC )$ whose differential equals
$pi :L_( CC ) -> frak("gl") (V_( CC ))$. The choice of an admissible base
$v^lambda$, $lambda in Lambda ( pi )$, allows us to identify $V_( CC )$ with
$CC^n$, $n= dim V$, and thus introduces coordinate functions
$x_( lambda , mu )$, $lambda , mu in Lambda ( pi )$ on $GL (V_( CC ))$. If we
identify $GL (V_( CC ))$ with $GL (n, CC )$ using these coordinates then their
restrictions on $pi (G_( CC ))$ generate a subring $ZZ [G]$ of the affine
algebra $CC [G]$. Chevalley has shown that this subring is in fact a _Hopf
subalgebra_ of $CC [G]$ (see #citation[@bib:Chevalley1960, @bib:Demazure1965,
  @bib:Demazure1971]) and thus provides an _affine group scheme over
$ZZ$_ by

$ R |-> G_P ( Phi ,R)= Hom_( ZZ )( ZZ [G],R). $

The image of a ring $R$ under this functor is denoted by $G_P ( Phi ,R)$ and is
called a _Chevalley group of type
$Phi$
over $R$_. Up to isomorphism of algebraic groups it depends on
$Phi$
and $P$, but not on $pi$. At the same time again by the very definition we may
consider corresponding linear groups $G_pi ( Phi ,R)$ as subgroups of
$GL (n,R)$, $n= dim pi$.

Let $T=T_P ( Phi ,dot)$ be a split maximal torus of a Chevalley–Demazure group
scheme $G_P ( Phi ,dot)$. If $R$ is a commutative ring $T=T_P ( Phi ,R)$ is
called a _split maximal torus_ of the Chevalley group $G=G_P ( Phi ,R)$. It is
well known that

$
  T=T_P ( Phi ,R)= Hom ( ZZ [T],R)
  tilde.eq Hom (P,R^*)
$

where $ZZ [T]= ZZ [ lambda_1, lambda_1^(-1), dots ,
  lambda_ell , lambda_ell^(-1)]$ is the algebra of Laurent polynomials for some
$ZZ$-base
$lambda_1, dots , lambda_ell$
of the lattice $P$. This means that the elements of the torus correspond
bijectively to the $R$-characters of the weight lattice $P$. For such a
character
$chi$
let us denote the corresponding element of the torus $T$ by $h( chi )$. We
choose our maximal torus $T$ to act diagonally in the chosen admissible base
$v^lambda$, $lambda in Lambda ( pi )$. We refer to this torus $T$ as the _split
maximal torus_.
