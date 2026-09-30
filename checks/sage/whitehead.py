"""Exact rectangular block factorization of the Whitehead–Vaserstein matrix."""
from sage.all import PolynomialRing, QQ, block_matrix, identity_matrix, matrix, zero_matrix


def main():
    ring = PolynomialRing(QQ, 12, 'a')
    field = ring.fraction_field()
    variables = list(map(field, ring.gens()))
    x = matrix(field, 2, 3, variables[:6])
    y = matrix(field, 3, 2, variables[6:])
    left = identity_matrix(field, 2)
    right = identity_matrix(field, 3)
    a = left + x * y
    z = a.inverse()
    d = right - y * z * x
    assert d * (right + y * x) == right
    assert (right + y * x) * d == right

    def upper(value):
        return block_matrix([[left, value], [zero_matrix(field, 3, 2), right]])

    def lower(value):
        return block_matrix([[left, zero_matrix(field, 2, 3)], [value, right]])

    target = block_matrix([[a, zero_matrix(field, 2, 3)],
                           [zero_matrix(field, 3, 2), d]])
    assert upper(x) * lower(y) * upper(-z * x) * lower(-y * a) == target
    assert x - z * x == z * x * y * x
    assert upper(x) * lower(y) * upper(-x) * upper(x - z * x) * lower(-y * a) == target
    assert target.det() == 1
    assert matrix(QQ, [[2, 0], [0, 2]]).det() != 1
    print('Generic 2×3 and 3×2 matrices: inverse, five-factor relative decomposition, determinant 1.')


if __name__ == '__main__':
    main()
