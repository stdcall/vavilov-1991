import Mathlib.Data.Matrix.Mul
import Mathlib.Tactic.Ring

namespace Vavilov1991

open Matrix
open scoped BigOperators

/- §10.4: v·w=1 witnesses unimodularity and v·u=0 is the syzygy.
   This component identity avoids both division by 2 and any domain assumption. -/
theorem suslin_component {R ι : Type*} [CommRing R] [Fintype ι]
    (u v w : ι → R) (unimodular : dotProduct v w = 1)
    (syzygy : dotProduct v u = 0) (k : ι) :
    ∑ j, (w j * u k - w k * u j) * v j = u k := by
  calc
    ∑ j, (w j * u k - w k * u j) * v j =
        u k * dotProduct v w - w k * dotProduct v u := by
      simp only [dotProduct, Finset.mul_sum, ← Finset.sum_sub_distrib]
      apply Finset.sum_congr rfl
      intro j _
      ring
    _ = u k := by rw [unimodular, syzygy, mul_one, mul_zero, sub_zero]

def koszulRelation {R ι : Type*} [CommRing R] [DecidableEq ι]
    (v : ι → R) (i j : ι) : ι → R :=
  v j • Pi.single i 1 - v i • Pi.single j 1

theorem koszulRelation_syzygy {R ι : Type*} [CommRing R]
    [Fintype ι] [DecidableEq ι] (v : ι → R) (i j : ι) :
    dotProduct v (koszulRelation v i j) = 0 := by
  simp [koszulRelation, dotProduct, Finset.sum_sub_distrib,
    mul_sub, Pi.single_apply]
  ring

theorem suslin_decomposition {R ι : Type*} [CommRing R]
    [Fintype ι] [DecidableEq ι] (u v w : ι → R)
    (unimodular : dotProduct v w = 1) (syzygy : dotProduct v u = 0) :
    (∑ i, ∑ j, (w j * u i) • koszulRelation v i j) = u := by
  ext k
  simp only [Finset.sum_apply, koszulRelation, Pi.smul_apply,
    Pi.sub_apply, smul_eq_mul, Pi.single_apply]
  simp_rw [mul_sub, mul_ite, mul_one, mul_zero]
  simp only [Finset.sum_sub_distrib]
  rw [Finset.sum_comm]
  simp only [Finset.sum_ite_eq, Finset.mem_univ, ite_true]
  rw [← Finset.sum_sub_distrib]
  simpa only [sub_mul] using suslin_component u v w unimodular syzygy k

theorem suslin_triangular_decomposition {R ι : Type*} [CommRing R]
    [Fintype ι] [LinearOrder ι] (u v w : ι → R)
    (unimodular : dotProduct v w = 1) (syzygy : dotProduct v u = 0) :
    (∑ i, ∑ j ∈ Finset.univ.filter (i < ·),
      (w j * u i - w i * u j) • koszulRelation v i j) = u := by
  ext k
  simp only [Finset.sum_apply, Finset.sum_filter, ite_apply, Pi.zero_apply, koszulRelation,
    Pi.smul_apply, Pi.sub_apply, smul_eq_mul, Pi.single_apply]
  simp_rw [mul_sub, mul_ite, mul_one, mul_zero]
  have split (p : Prop) [Decidable p] (a b : R) :
      (if p then a - b else 0) = (if p then a else 0) - (if p then b else 0) := by
    split_ifs <;> simp
  simp_rw [split, Finset.sum_sub_distrib]
  rw [Finset.sum_comm]
  have swap (p : Prop) [Decidable p] (i : ι) (a : R) :
      (if p then (if k = i then a else 0) else 0) =
      (if k = i then (if p then a else 0) else 0) := by
    by_cases hp : p <;> by_cases hi : k = i <;> simp [hp, hi]
  simp_rw [swap]
  simp only [Finset.sum_ite_eq, Finset.mem_univ, ite_true]
  rw [← Finset.sum_sub_distrib]
  have h : ∀ j, (if k < j then (w j * u k - w k * u j) * v j else 0) -
      (if j < k then (w k * u j - w j * u k) * v j else 0) =
      (w j * u k - w k * u j) * v j := by
    intro j
    rcases lt_trichotomy k j with h | h | h
    · simp [h, not_lt_of_gt h]
    · subst j
      simp
    · simp [h, not_lt_of_gt h]
      ring
  simp_rw [h]
  exact suslin_component u v w unimodular syzygy k

end Vavilov1991

#print axioms Vavilov1991.suslin_component
#print axioms Vavilov1991.koszulRelation_syzygy
#print axioms Vavilov1991.suslin_decomposition
#print axioms Vavilov1991.suslin_triangular_decomposition
