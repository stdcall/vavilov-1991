import Mathlib.RingTheory.Ideal.Quotient.Basic
import Mathlib.Algebra.Ring.Subring.Basic
import Mathlib.Tactic.NoncommRing

namespace Vavilov1991

variable {R S : Type*} [CommRing R] [CommRing S]

/-- The double is the ring of pairs with equal images modulo the ideal. -/
def ringDouble (I : Ideal R) : Subring (R × R) :=
  RingHom.eqLocus ((Ideal.Quotient.mk I).comp (RingHom.fst R R))
    ((Ideal.Quotient.mk I).comp (RingHom.snd R R))

def doubleFirst (I : Ideal R) : ringDouble I →+* R :=
  (RingHom.fst R R).comp (ringDouble I).subtype

def doubleSecond (I : Ideal R) : ringDouble I →+* R :=
  (RingHom.snd R R).comp (ringDouble I).subtype

def doubleDiagonal (I : Ideal R) : R →+* ringDouble I :=
  ((RingHom.id R).prod (RingHom.id R)).codRestrict (ringDouble I) (by
    intro x
    rfl)

def doubleLift (I : Ideal R) (f g : S →+* R)
    (h : (Ideal.Quotient.mk I).comp f = (Ideal.Quotient.mk I).comp g) :
    S →+* ringDouble I :=
  (f.prod g).codRestrict (ringDouble I) (by
    intro x
    exact RingHom.congr_fun h x)

theorem mem_ringDouble_iff (I : Ideal R) (a b : R) :
    (a, b) ∈ ringDouble I ↔ a - b ∈ I :=
  Ideal.Quotient.eq

theorem double_square_commutes (I : Ideal R) :
    (Ideal.Quotient.mk I).comp (doubleFirst I) =
      (Ideal.Quotient.mk I).comp (doubleSecond I) := by
  ext x
  exact x.property

theorem double_projections_split (I : Ideal R) :
    (doubleFirst I).comp (doubleDiagonal I) = RingHom.id R ∧
      (doubleSecond I).comp (doubleDiagonal I) = RingHom.id R := by
  constructor <;> ext x <;> rfl

theorem double_lift_projections (I : Ideal R) (f g : S →+* R)
    (h : (Ideal.Quotient.mk I).comp f = (Ideal.Quotient.mk I).comp g) :
    (doubleFirst I).comp (doubleLift I f g h) = f ∧
      (doubleSecond I).comp (doubleLift I f g h) = g := by
  constructor <;> ext x <;> rfl

theorem double_lift_unique (I : Ideal R) (f g : S →+* R)
    (h : (Ideal.Quotient.mk I).comp f = (Ideal.Quotient.mk I).comp g)
    (k : S →+* ringDouble I)
    (hk₁ : (doubleFirst I).comp k = f)
    (hk₂ : (doubleSecond I).comp k = g) : k = doubleLift I f g h := by
  apply RingHom.ext
  intro x
  apply Subtype.ext
  exact Prod.ext (RingHom.congr_fun hk₁ x) (RingHom.congr_fun hk₂ x)

theorem double_first_kernel (I : Ideal R) (x : ringDouble I) :
    doubleFirst I x = 0 ↔ x.val.1 = 0 ∧ x.val.2 ∈ I := by
  constructor
  · intro hx
    change x.val.1 = 0 at hx
    refine ⟨hx, ?_⟩
    have h := x.property
    change Ideal.Quotient.mk I x.val.1 = Ideal.Quotient.mk I x.val.2 at h
    rw [hx, map_zero] at h
    exact Ideal.Quotient.eq_zero_iff_mem.mp h.symm
  · exact fun h => h.1

theorem double_second_kernel (I : Ideal R) (x : ringDouble I) :
    doubleSecond I x = 0 ↔ x.val.2 = 0 ∧ x.val.1 ∈ I := by
  constructor
  · intro hx
    change x.val.2 = 0 at hx
    refine ⟨hx, ?_⟩
    have h := x.property
    change Ideal.Quotient.mk I x.val.1 = Ideal.Quotient.mk I x.val.2 at h
    rw [hx, map_zero] at h
    exact Ideal.Quotient.eq_zero_iff_mem.mp h
  · exact fun h => h.1

theorem double_semidirect_product {A : Type*} [Ring A] (a b c d : A) :
    (a, a + c) * (b, b + d) =
      (a * b, a * b + (a * d + c * b + c * d)) := by
  apply Prod.ext
  · rfl
  · change (a + c) * (b + d) = a * b + (a * d + c * b + c * d)
    noncomm_ring

end Vavilov1991

#print axioms Vavilov1991.mem_ringDouble_iff
#print axioms Vavilov1991.double_square_commutes
#print axioms Vavilov1991.double_projections_split
#print axioms Vavilov1991.double_lift_projections
#print axioms Vavilov1991.double_lift_unique
#print axioms Vavilov1991.double_first_kernel
#print axioms Vavilov1991.double_second_kernel
#print axioms Vavilov1991.double_semidirect_product
