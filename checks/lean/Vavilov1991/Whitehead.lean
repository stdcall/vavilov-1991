import Mathlib.Data.Matrix.Block
import Mathlib.Tactic.Abel

namespace Vavilov1991

open Matrix

variable {R m n : Type*} [Ring R]
  [Fintype m] [Fintype n] [DecidableEq m] [DecidableEq n]

def blockUpper (X : Matrix m n R) : Matrix (m ⊕ n) (m ⊕ n) R :=
  fromBlocks 1 X 0 1

def blockLower (Y : Matrix n m R) : Matrix (m ⊕ n) (m ⊕ n) R :=
  fromBlocks 1 0 Y 1

/- Universal rectangular identities; elementary membership is a separate claim. -/
omit [DecidableEq n] in
theorem whitehead_relative_parameter (X : Matrix m n R) (Y : Matrix n m R)
    (Z : Matrix m m R) (hleft : Z * (1 + X * Y) = 1) :
    X - Z * X = Z * X * Y * X := by
  have h : Z + Z * X * Y = 1 := by
    simpa only [Matrix.mul_add, Matrix.mul_one, ← Matrix.mul_assoc] using hleft
  have h' : (Z + Z * X * Y) * X = X := by rw [h, Matrix.one_mul]
  simp only [Matrix.add_mul] at h'
  exact (sub_eq_iff_eq_add).2 (by simpa only [add_comm] using h'.symm)

theorem whitehead_four_factors (X : Matrix m n R) (Y : Matrix n m R)
    (Z : Matrix m m R) (hright : (1 + X * Y) * Z = 1)
    (hleft : Z * (1 + X * Y) = 1) :
    blockUpper X * blockLower Y * blockUpper (-Z * X) *
        blockLower (-Y * (1 + X * Y)) =
      fromBlocks (1 + X * Y) 0 0 (1 - Y * Z * X) := by
  have hax : (1 + X * Y) * (Z * X) = X := by
    rw [← Matrix.mul_assoc, hright, Matrix.one_mul]
  have hzxy : Z * X * Y = 1 - Z := by
    apply (eq_sub_iff_add_eq).2
    have h : Z + Z * X * Y = 1 := by
      simpa only [Matrix.mul_add, Matrix.mul_one, ← Matrix.mul_assoc] using hleft
    simpa only [add_comm] using h
  have hdy : (1 - Y * Z * X) * (Y * (1 + X * Y)) = Y := by
    simp only [Matrix.sub_mul, Matrix.one_mul, Matrix.mul_assoc]
    rw [← Matrix.mul_assoc X Y, ← Matrix.mul_assoc Z (X * Y)]
    rw [← Matrix.mul_assoc Z X Y, hzxy]
    simp only [Matrix.mul_sub, Matrix.one_mul, Matrix.sub_mul,
      hleft, Matrix.mul_one]
    abel
  simp only [blockUpper, blockLower, fromBlocks_multiply,
    Matrix.one_mul, Matrix.mul_one, Matrix.mul_zero,
    zero_add, add_zero, Matrix.neg_mul, Matrix.mul_neg]
  rw [hax]
  have hd : -(Y * (Z * X)) + 1 = 1 - Y * Z * X := by
    rw [← Matrix.mul_assoc]
    abel
  rw [hd, hdy]
  simp only [neg_add_cancel, add_neg_cancel, Matrix.zero_mul, neg_zero, add_zero]


theorem whitehead_five_factors (X : Matrix m n R) (Y : Matrix n m R)
    (Z : Matrix m m R) (hright : (1 + X * Y) * Z = 1)
    (hleft : Z * (1 + X * Y) = 1) :
    blockUpper X * blockLower Y * blockUpper (-X) *
        blockUpper (X - Z * X) * blockLower (-Y * (1 + X * Y)) =
      fromBlocks (1 + X * Y) 0 0 (1 - Y * Z * X) := by
  have h : blockUpper (-X) * blockUpper (X - Z * X) = blockUpper (-Z * X) := by
    simp only [blockUpper, fromBlocks_multiply, Matrix.one_mul,
      Matrix.mul_one, Matrix.zero_mul, Matrix.mul_zero, zero_add, add_zero]
    congr 1
    simp only [Matrix.neg_mul]
    abel
  rw [Matrix.mul_assoc (blockUpper X * blockLower Y), h]
  exact whitehead_four_factors X Y Z hright hleft

end Vavilov1991

#print axioms Vavilov1991.whitehead_relative_parameter
#print axioms Vavilov1991.whitehead_four_factors
#print axioms Vavilov1991.whitehead_five_factors
