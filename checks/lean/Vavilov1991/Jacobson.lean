import Mathlib.Tactic.NoncommRing
import Mathlib.Data.Matrix.Mul
import Mathlib.Tactic.Abel

namespace Vavilov1991

/- §10, Whitehead–Vaserstein lemma. This proves the inverse identity in
   an arbitrary associative ring; it does not prove elementary membership. -/
theorem jacobson_inverse_right {R : Type*} [Ring R] (x y z : R)
    (hz : (1 + x * y) * z = 1) :
    (1 + y * x) * (1 - y * z * x) = 1 := by
  have h : y * ((1 + x * y) * z) * x = y * x := by rw [hz, mul_one]
  calc
    (1 + y * x) * (1 - y * z * x) =
        1 + y * x - y * ((1 + x * y) * z) * x := by noncomm_ring
    _ = 1 := by rw [h]; noncomm_ring

theorem jacobson_inverse_left {R : Type*} [Ring R] (x y z : R)
    (hz : z * (1 + x * y) = 1) :
    (1 - y * z * x) * (1 + y * x) = 1 := by
  have h : y * (z * (1 + x * y)) * x = y * x := by rw [hz, mul_one]
  calc
    (1 - y * z * x) * (1 + y * x) =
        1 + y * x - y * (z * (1 + x * y)) * x := by noncomm_ring
    _ = 1 := by rw [h]; noncomm_ring

theorem rectangular_jacobson_right {R m n : Type*} [Ring R]
    [Fintype m] [Fintype n] [DecidableEq m] [DecidableEq n]
    (x : Matrix m n R) (y : Matrix n m R) (z : Matrix m m R)
    (hz : (1 + x * y) * z = 1) :
    (1 + y * x) * (1 - y * z * x) = 1 := by
  have h : y * ((1 + x * y) * z) * x = y * x := by
    rw [hz, Matrix.mul_one]
  calc
    (1 + y * x) * (1 - y * z * x) =
        1 + y * x - y * ((1 + x * y) * z) * x := by
      simp only [Matrix.add_mul, Matrix.mul_sub,
        Matrix.mul_add, Matrix.one_mul, Matrix.mul_one, Matrix.mul_assoc]
    _ = 1 := by rw [h]; abel

theorem rectangular_jacobson_left {R m n : Type*} [Ring R]
    [Fintype m] [Fintype n] [DecidableEq m] [DecidableEq n]
    (x : Matrix m n R) (y : Matrix n m R) (z : Matrix m m R)
    (hz : z * (1 + x * y) = 1) :
    (1 - y * z * x) * (1 + y * x) = 1 := by
  have h : y * (z * (1 + x * y)) * x = y * x := by
    rw [hz, Matrix.mul_one]
  calc
    (1 - y * z * x) * (1 + y * x) =
        1 + y * x - y * (z * (1 + x * y)) * x := by
      simp only [Matrix.add_mul, Matrix.sub_mul,
        Matrix.mul_add, Matrix.one_mul, Matrix.mul_one, Matrix.mul_assoc]
      abel
    _ = 1 := by rw [h]; abel

end Vavilov1991

#print axioms Vavilov1991.jacobson_inverse_right
#print axioms Vavilov1991.jacobson_inverse_left
#print axioms Vavilov1991.rectangular_jacobson_right
#print axioms Vavilov1991.rectangular_jacobson_left
