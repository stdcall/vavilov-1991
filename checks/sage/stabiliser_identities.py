"""Exact matrix identities for §§11–12 over integral polynomial rings.

These checks concern the displayed products and fixed columns. They do
not prove elementary membership, parabolic reduction, or normality.
"""
from sage.all import PolynomialRing, ZZ, identity_matrix, matrix, vector

PARAMETER_NAMES = (
    'a', 'b', 'c', 'eta', 'zeta', 'theta', 'xi',
    'u2', 'u3', 'u4', 'v2', 'v3', 'v4',
)


def check_orthogonal_three_space(ring, parameters):
    """formula:orthogonal-three-space, coordinates 1,2,3,-3,-2,-1."""
    a, b, c, eta, zeta, theta, xi, *_ = parameters
    identity = identity_matrix(ring, 6)
    gram = matrix(ring, 6, 6)
    for index in range(6):
        gram[index, 5 - index] = 1

    def transvection(first, second, parameter):
        u = identity.column(first)
        v = identity.column(second)
        return identity + parameter * (
            u.column() * v.row() - v.column() * u.row()
        ) * gram

    product = (
        transvection(0, 1, eta)
        * transvection(0, 2, zeta)
        * transvection(1, 2, theta)
    )
    expected = matrix(ring, [
        [1, 0, 0, zeta, eta, 0],
        [0, 1, 0, theta, 0, -eta],
        [0, 0, 1, 0, -theta, -zeta],
        [0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 1, 0],
        [0, 0, 0, 0, 0, 1],
    ])
    assert product == expected
    assert product.transpose() * gram * product == gram
    assert product.det() == 1
    assert (product - identity) ** 2 == 0
    column = vector(ring, [0, 0, 0, c, b, a])
    stabiliser = product.subs({eta: -xi * c, zeta: xi * b, theta: -xi * a})
    assert stabiliser * column == column


def check_symplectic_long_product(ring, parameters, gram):
    """formula:symplectic-long-product."""
    a, b, _, eta, _, theta, *_ = parameters
    identity = identity_matrix(ring, 4)
    u, v = identity.column(0), identity.column(1)

    def transvection(column, parameter):
        return identity + parameter * column.column() * column.row() * gram

    def mixed_transvection(first, second, parameter):
        return identity + parameter * (
            first.column() * second.row() + second.column() * first.row()
        ) * gram

    product = (
        mixed_transvection(u, v, eta * theta)
        * transvection(u, eta ** 2)
        * transvection(v, theta ** 2)
    )
    assert product == transvection(eta * u + theta * v, ring.one())
    assert product == matrix(ring, [
        [1, 0, eta * theta, eta ** 2],
        [0, 1, theta ** 2, eta * theta],
        [0, 0, 1, 0],
        [0, 0, 0, 1],
    ])
    assert product.transpose() * gram * product == gram
    column = vector(ring, [0, 0, b, a])
    assert product.subs({eta: b, theta: -a}) * column == column


def check_symplectic_short_product(ring, parameters, gram):
    """formula:symplectic-short-product and short-factorisation."""
    _, _, _, eta, zeta, theta, *_ = parameters
    identity = identity_matrix(ring, 4)

    def matrix_unit(row, column):
        result = matrix(ring, 4, 4)
        result[row, column] = 1
        return result

    first = identity + zeta * (matrix_unit(0, 1) - matrix_unit(2, 3))
    second = identity + eta * (matrix_unit(0, 2) + matrix_unit(1, 3))
    third = identity + (2 * theta - zeta * eta) * matrix_unit(0, 3)
    product = first * second * third
    assert product == matrix(ring, [
        [1, zeta, eta, 2 * theta],
        [0, 1, 0, eta],
        [0, 0, 1, -zeta],
        [0, 0, 0, 1],
    ])
    for factor in (first, second, third, product):
        assert factor.transpose() * gram * factor == gram
        assert factor.det() == 1
    lower_factor = identity + theta * matrix_unit(0, 3)
    lower_factor += eta * matrix_unit(1, 3) - zeta * matrix_unit(2, 3)
    upper_factor = identity + zeta * matrix_unit(0, 1)
    upper_factor += eta * matrix_unit(0, 2) + theta * matrix_unit(0, 3)
    assert lower_factor * upper_factor == product
    assert lower_factor.det() == upper_factor.det() == 1
    return upper_factor


def check_minor_syzygy(ring, parameters, upper_factor):
    """formula:symplectic-minor-syzygy."""
    _, _, _, eta, zeta, theta, _, u2, u3, u4, v2, v3, v4 = parameters
    minors = (
        u3 * v4 - u4 * v3,
        u4 * v2 - u2 * v4,
        u2 * v3 - u3 * v2,
    )
    for coordinates in ((u2, u3, u4), (v2, v3, v4)):
        assert sum(coefficient * entry for coefficient, entry in zip(minors, coordinates)) == 0
    specialised = upper_factor.subs(dict(zip((zeta, eta, theta), minors)))
    for coordinates in ((u2, u3, u4), (v2, v3, v4)):
        column = vector(ring, [0, *coordinates])
        assert specialised * column == column


def main():
    ring = PolynomialRing(ZZ, names=PARAMETER_NAMES)
    parameters = ring.gens()
    gram = matrix(ring, [
        [0, 0, 0, 1], [0, 0, 1, 0],
        [0, -1, 0, 0], [-1, 0, 0, 0],
    ])
    check_orthogonal_three_space(ring, parameters)
    check_symplectic_long_product(ring, parameters, gram)
    upper_factor = check_symplectic_short_product(ring, parameters, gram)
    check_minor_syzygy(ring, parameters, upper_factor)
    print('PASS: orthogonal-three-space; symplectic-long-product, short-product,')
    print('minor-syzygy and short-factorisation over ZZ in 13 independent parameters.')
    print('Includes both fixed-column minor equations and the actual root-factor products.')


if __name__ == '__main__':
    main()
