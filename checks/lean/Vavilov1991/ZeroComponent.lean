import Mathlib.Data.Matrix.Mul
import Mathlib.Tactic.NoncommRing
import Mathlib.RingTheory.Ideal.Defs

namespace Vavilov1991

open Matrix

private theorem nilpotent_commutator {S : Type*} [Ring S] (a b : S)
    (haa : a * a = 0) (hbb : b * b = 0) (hba : b * a = 0) :
    (1 + a) * (1 + b) * (1 - a) * (1 - b) = 1 + a * b := by
  have haba : a * b * a = 0 := by rw [mul_assoc, hba, mul_zero]
  have habb : a * b * b = 0 := by rw [mul_assoc, hbb, mul_zero]
  calc
    (1 + a) * (1 + b) * (1 - a) * (1 - b) =
        (1 + b + a * b - a * a - b * a - a * b * a) * (1 - b) := by
      congr 1
      noncomm_ring
    _ = (1 + b + a * b) * (1 - b) := by rw [haa, hba, haba]; simp
    _ = 1 + a * b - b * b - a * b * b := by noncomm_ring
    _ = 1 + a * b := by rw [hbb, habb]; simp

variable {R ι : Type*} [Ring R] [Fintype ι] [DecidableEq ι]

/- Coefficients occur in the order u_i ξ v_j; no centrality of ξ is assumed. -/
theorem zero_coordinate_commutator (u v : ι → R) (ξ : R) (j : ι)
    (hu : u j = 0) (hv : v j = 0) (hvu : dotProduct v u = 0) :
    let e : ι → R := Pi.single j 1
    let a := vecMulVec u e
    let b := vecMulVec e (fun i => ξ * v i)
    (1 + a) * (1 + b) * (1 - a) * (1 - b) =
      1 + vecMulVec u (fun i => ξ * v i) := by
  dsimp
  have hd : dotProduct (fun i => ξ * v i) u = 0 := by
    simp only [dotProduct, mul_assoc, ← Finset.mul_sum]
    change ξ * dotProduct v u = 0
    rw [hvu, mul_zero]
  have haa : vecMulVec u (Pi.single j 1) * vecMulVec u (Pi.single j 1) = 0 := by
    simp [vecMulVec_mul_vecMulVec, hu]
  have hbb : vecMulVec (Pi.single j 1) (fun i => ξ * v i) *
      vecMulVec (Pi.single j 1) (fun i => ξ * v i) = 0 := by
    simp [vecMulVec_mul_vecMulVec, hv]
  have hba : vecMulVec (Pi.single j 1) (fun i => ξ * v i) *
      vecMulVec u (Pi.single j 1) = 0 := by
    simp [vecMulVec_mul_vecMulVec, hd]
  have hab : vecMulVec u (Pi.single j 1) *
      vecMulVec (Pi.single j 1) (fun i => ξ * v i) =
      vecMulVec u (fun i => ξ * v i) := by
    simp [vecMulVec_mul_vecMulVec]
  rw [nilpotent_commutator _ _ haa hbb hba, hab]


theorem zero_component_factorization (u v : ι → R) (ξ : R) (j : ι)
    (hv : v j = 0) (hvu : dotProduct v u = 0) :
    let e : ι → R := Pi.single j 1
    let u' := u - Pi.single j (u j)
    let r := fun i => ξ * v i
    let a := vecMulVec u' e
    let b := vecMulVec e r
    let c := vecMulVec (Pi.single j (u j)) r
    (1 + c) * ((1 + a) * (1 + b) * (1 - a) * (1 - b)) =
      1 + vecMulVec u r := by
  dsimp
  have hu' : ((u - Pi.single j (u j)) : ι → R) j = 0 := by simp
  have hvu' : dotProduct v (u - Pi.single j (u j)) = 0 := by
    rw [dotProduct_sub, dotProduct_single, hvu, hv, zero_mul, sub_zero]
  rw [zero_coordinate_commutator _ _ ξ j hu' hv hvu']
  have hd : dotProduct (fun i => ξ * v i) (u - Pi.single j (u j)) = 0 := by
    simp only [dotProduct, mul_assoc, ← Finset.mul_sum]
    change ξ * dotProduct v (u - Pi.single j (u j)) = 0
    rw [hvu', mul_zero]
  have hprod : vecMulVec (Pi.single j (u j)) (fun i => ξ * v i) *
      vecMulVec (u - Pi.single j (u j)) (fun i => ξ * v i) = 0 := by
    simp [vecMulVec_mul_vecMulVec, hd]
  simp only [Matrix.add_mul, Matrix.mul_add, Matrix.one_mul, Matrix.mul_one, hprod,
    add_zero]
  rw [add_assoc, ← add_vecMulVec]
  congr 1
  congr 1
  funext i
  simp only [Pi.add_apply, Pi.sub_apply]
  abel

omit [Fintype ι] [DecidableEq ι] in
theorem transvection_entries_in_ideal (I : Ideal R) [I.IsTwoSided]
    (u v : ι → R) (ξ : R) (hξ : ξ ∈ I) (i k : ι) :
    vecMulVec u (fun j => ξ * v j) i k ∈ I := by
  exact I.mul_mem_left (u i) (I.mul_mem_right (v k) hξ)

end Vavilov1991

#print axioms Vavilov1991.zero_coordinate_commutator

#print axioms Vavilov1991.zero_component_factorization
#print axioms Vavilov1991.transvection_entries_in_ideal
