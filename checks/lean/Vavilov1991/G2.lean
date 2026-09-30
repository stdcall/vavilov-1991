import Mathlib.Tactic.Ring

namespace Vavilov1991

theorem g2_short_root_preserves_quadratic {R : Type*} [CommRing R]
    (ξ x0 x1 x2 x3 xm1 xm2 xm3 : R) :
    -(x0 + ξ * xm1) ^ 2 +
      (x1 + 2 * ξ * x0 + ξ ^ 2 * xm1) * xm1 +
      x2 * (xm2 - ξ * x3) + x3 * (xm3 + ξ * x2) =
        -x0 ^ 2 + x1 * xm1 + x2 * xm2 + x3 * xm3 := by
  ring

end Vavilov1991

#print axioms Vavilov1991.g2_short_root_preserves_quadratic
