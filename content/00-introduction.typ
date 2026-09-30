#import "main-defs.typ": *
#source(219)

#heading(level: 2, numbering: none)[Abstract]

This paper is a survey of the theory of Chevalley groups over commutative rings,
centred around two topics: explicit calculations in the groups using their
minimal modules and the main structure theorems (description of the normal
subgroups, normality of the elementary subgroups etc.). We give the necessary
background and compare several approaches to the proofs of these results,
including some new ones.

#heading(level: 2, numbering: none)[Introduction]

The purpose of this talk is to describe two new approaches in the study of
Chevalley groups over commutative rings.#ed-note[
  Historical expressions such as “new”, “recently”, and “forthcoming” refer to
  the 1991 survey. Later developments and revised arguments are identified by
  their sources; references added in this edition use mnemonic citation codes.
] Our chief goal is to show _why_ and _how_ rather than _what_. So we
concentrate on the methods by which the results are proven rather than on the
results themselves.

Our exposition here is centred around the following two problems: normality of
the elementary subgroups and classification of normal subgroups. The solutions
of the problems are called the _main structure theorems_. Of course for the
classical cases the solutions (by J. S. Wilson, I. Z. Golubchik, A. A. Suslin,
V. I. Kopeiko and many others) are very well known, while those for the
exceptional cases have been obtained by E. Abe, G. Taddei and L. N. Vaserstein
#source(220)
#citation[@bib:Taddei1986, @bib:Vaserstein1986b, @bib:Abe1989a, @bib:Abe1989b]
fairly recently. We propose to show that with the right approach the exceptional
cases do not differ substantially from the classical ones. We discuss four
essentially different proofs of these results, two of which have K-theoretical
and further two representation-theoretical flavour. The K-theoretical proofs are
based on stability conditions and “localization and patching” respectively. The
first method which gave complete solutions for the classical groups used direct
matrix calculations taking into account the whole matrix and all the equations
among matrix entries—what we call _general calculations_—and was not easy to
imitate for the exceptional groups. As a result the first complete proofs for
the exceptional groups used “localization and patching”.

Here for the first time we exhibit in some details the fourth method based on
decomposition of unipotents. The starting points for this approach were
Stepanov’s proof #citation[@bib:Stepanov1987]#ed-note[
  The proof cited here is from Stepanov’s 1987 candidate thesis. In his 2014
  doctoral thesis, he recalls it as a proof by decomposition of transvections
  #citation[@bib:Stepanov2014, Introduction, “Commutator formulae”, p. 9]. The
  linear case of this method is presented in §@ss:stepanov-proof below.
] of Suslin’s normality theorem #citation[@bib:Suslin1977, §1, Corollary 1.4]
and the proof by Borewicz and the author #citation[@bib:Borevich1985] of the
Wilson–Golubchik normal subgroup theorem #citation[@bib:Wilson1972,
  @bib:Golubchik1973]. If one studies these proofs thoroughly one realizes that
they never refer to the multiplication of matrices—only to the multiplication of
elementary matrices and the action of elementary matrices on columns or rows,
i.e. what we call _elementary calculations_ and _stable calculations_
respectively. These elementary matrix and column operations are easy to perform
for all the groups, including the exceptional ones. Here we survey some
necessary background facts and discuss the proofs obtained along these lines for
the classical cases and the case $E_6$ which is already fairly difficult but
still not as technically obstructive as $E_7$, $E_8$ and $F_4$. Even for the
classical cases these proofs are often remarkably easier than the extant ones.
For the exceptional groups they involve case by case analysis and so are
somewhat longer than the existing ones but in any case far more elementary.

We discuss also the equations satisfied by the entries of matrices from
exceptional groups in minimal representations. As a pattern we give here a new
construction of the cubic form on a 27-dimensional space invariant with respect
to the action of the simply connected group of type $E_6$ and a new proof of the
theorem (due to E. Cartan—L. Dickson—C. Chevalley—H. Freudenthal— N. Jacobson—T.
Springer—…—M. Aschbacher) which says that the Chevalley group coincides with the
isometry group of the form. We discuss also some of the traditional
constructions of the form which come from the theory
#source(221)
of Jordan algebras as well as analogous constructions of other exceptional
groups. Such realizations give a solid ground for general calculations in the
exceptional groups and indeed recently the author produced analogues of the
original matrix proofs for some of the exceptional cases as well.

The exposition here is rather sketchy: we skip many details—virtually all of
them for the types $E_7$, $E_8$, $F_4$—and do not formulate results in the
strongest possible form. Our excuse is that we attach an extensive bibliography
and the whole contents of the talk with the minutest technical details will be
covered in a series of six forthcoming papers under the same title four of which
are joint with E. B. Plotkin. The present paper serves as an informal
introduction to the field and as an invitation to these much more specialized
and technical works. The basic facts and notations related to the Chevalley
groups over rings are collected here as a common background for our subsequent
publications on the subgroup structure of Chevalley groups, related Steinberg
groups, unstable K-theory, non-split groups etc., which are not related directly
to the main structure theorems presented here but are based on the same
techniques.

The understanding of the Chevalley groups which we present here is a further
development of the viewpoint introduced by H. Matsumoto
#citation[@bib:Matsumoto1969] and M. R. Stein #citation[@bib:Stein1978]. We
believe that it gives a richer and deeper picture than the traditional
approaches. It is also more elementary in many aspects and my teaching
experience suggests that large parts of the proofs are accessible to a good
second year undergraduate student.

Part of the contents of the present paper was announced in
#citation[@bib:Vavilov1988b, @bib:Vavilov1990d].
