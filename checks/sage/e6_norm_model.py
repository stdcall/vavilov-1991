"""An integral signed-permutation isometry to Conrad's three-matrix cubic."""
import json
from pathlib import Path

from sage.all import PolynomialRing, QQ, ZZ, matrix, vector

from e6_representation import invariant_cubic, representation, root_system


# The support-incidence isomorphism fixes the variable/monomial vertex classes;
# solving its coefficient equations over F2 gives these signs.
PERMUTATION = (0, 1, 15, 16, 17, 26, 23, 25, 22, 20, 19, 3, 4, 2, 6, 7,
               12, 9, 13, 10, 14, 11, 24, 21, 18, 5, 8)
SIGNS = (-1, 1, -1, 1, -1, 1, 1, -1, -1, 1, -1, 1, -1, 1, 1, -1,
         1, 1, -1, -1, 1, 1, 1, 1, 1, 1, 1)


def main():
    data_path = Path(__file__).resolve().parents[2] / 'content/diagrams/e6-weights.json'
    data = json.loads(data_path.read_text())
    weights = [tuple(weight) for weight in data['weights']]
    cartan = matrix(ZZ, data['cartan'])
    simple, positive = root_system(cartan)
    raising, _ = representation(weights, cartan, simple, positive)
    ring = PolynomialRing(ZZ, names=[f'u{i}' for i in range(27)])
    cubic = ring(invariant_cubic(weights, raising,
                 PolynomialRing(QQ, names=ring.variable_names())))
    distinguished = [i for i in range(1, 26)
                     if all(weights[0][j] + weights[i][j] + weights[26][j] == 0
                            for j in range(6))]
    assert distinguished == [12]
    u = ring.gens()
    assert cubic.monomial_coefficient(u[0] * u[12] * u[26]) == 1
    assert sorted(PERMUTATION) == list(range(27))
    assert set(SIGNS) == {-1, 1}
    isometry = matrix(ZZ, 27, {(PERMUTATION[i], i): SIGNS[i]
                             for i in range(27)})
    assert abs(isometry.det()) == 1
    assert isometry.transpose() * isometry == matrix.identity(ZZ, 27)
    coordinates = isometry * vector(ring, ring.gens())
    a = matrix(ring, 3, coordinates[:9])
    b = matrix(ring, 3, coordinates[9:18])
    c = matrix(ring, 3, coordinates[18:])
    norm = a.det() + b.det() + c.det() - (a * b * c).trace()
    assert len(cubic.dict()) == len(norm.dict()) == 45
    assert all(sum(exponents) == 3 and max(exponents) == 1
               for exponents in cubic.dict())
    assert set(cubic.coefficients()) == {-1, 1}
    assert norm == cubic
    print('E6 norm model: exact 45-term polynomial identity over ZZ; '
          f'signed-permutation determinant {isometry.det()}.')


if __name__ == '__main__':
    main()
