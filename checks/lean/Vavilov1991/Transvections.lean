import Mathlib.Data.Matrix.Mul
import Mathlib.Tactic.NoncommRing

namespace Vavilov1991

open Matrix

/- §10.1: u is a column, v is a row, and v·u=0. The index set is arbitrary
   finite and the coefficient ring may have zero divisors. -/
theorem rank_one_square_zero {R ι : Type*} [CommRing R] [Fintype ι]
    (u v : ι → R) (h : dotProduct v u = 0) :
    vecMulVec u v * vecMulVec u v = 0 := by
  rw [vecMulVec_mul_vecMulVec, h, zero_smul, vecMulVec_zero]

theorem square_zero_unipotent_inverse {R : Type*} [Ring R]
    (a : R) (h : a * a = 0) :
    (1 + a) * (1 - a) = 1 ∧ (1 - a) * (1 + a) = 1 := by
  constructor
  · calc
      (1 + a) * (1 - a) = 1 - a * a := by noncomm_ring
      _ = 1 := by rw [h, sub_zero]
  · calc
      (1 - a) * (1 + a) = 1 - a * a := by noncomm_ring
      _ = 1 := by rw [h, sub_zero]

end Vavilov1991

#print axioms Vavilov1991.rank_one_square_zero
#print axioms Vavilov1991.square_zero_unipotent_inverse
