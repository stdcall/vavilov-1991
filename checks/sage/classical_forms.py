"""Check the explicit matrices in §6, classical cases, on column vectors.

Polynomial identities are checked over Z[t] for ranks 2--5. They therefore
specialize to every commutative coefficient ring. The odd inverse-entry
formula uses Q[t], corresponding to the text's hypothesis that 2 is a unit.
This is a finite-rank check of the formulas, not a proof of their root-datum
identifications or of the full group-scheme assertions.
"""

from sage.all import ZZ, QQ, PolynomialRing, matrix, identity_matrix


def matrix_unit(ring, indices, i, j):
    result = matrix(ring, len(indices))
    result[indices.index(i), indices.index(j)] = 1
    return result


def gram_matrix(ring, indices, odd=False, symplectic=False):
    result = matrix(ring, len(indices))
    for i in indices:
        result[indices.index(i), indices.index(-i)] = (
            2 if odd and i == 0 else
            (-1 if symplectic and i < 0 else 1)
        )
    return result


def check():
    polynomial_ring = PolynomialRing(ZZ, 't')
    t = polynomial_ring.gen()
    counts = {'odd_short': 0, 'orthogonal_long': 0,
              'symplectic_short': 0, 'symplectic_long': 0}
    for rank in range(2, 6):
        even = list(range(1, rank + 1)) + list(range(-rank, 0))
        odd = list(range(1, rank + 1)) + [0] + list(range(-rank, 0))
        for indices in (even, odd):
            identity = identity_matrix(polynomial_ring, len(indices))
            unit = lambda i, j: matrix_unit(polynomial_ring, indices, i, j)
            gram = gram_matrix(polynomial_ring, indices, odd=0 in indices)
            for i in even:
                for j in even:
                    if i == j or i == -j:
                        continue
                    a = identity + t * unit(i, j) - t * unit(-j, -i)
                    assert a.transpose() * gram * a == gram
                    assert a.det() == 1
                    counts['orthogonal_long'] += 1
            if 0 in indices:
                for i in even:
                    a = (identity + 2*t*unit(i, 0) - t*unit(0, -i)
                         - t*t*unit(i, -i))
                    assert a.transpose() * gram * a == gram
                    assert a.det() == 1
                    original = (identity + t*unit(i, 0) - 2*t*unit(0, -i)
                                - t*t*unit(i, -i))
                    assert original.transpose() * gram * original != gram
                    rational_ring = PolynomialRing(QQ, 't')
                    aq = a.change_ring(rational_ring)
                    inverse = aq.inverse()
                    for ii, row in enumerate(indices):
                        for jj, column in enumerate(indices):
                            factor = ((2 if column == 0 else 1) /
                                      QQ(2 if row == 0 else 1))
                            assert inverse[ii, jj] == factor * aq[
                                indices.index(-column), indices.index(-row)]
                    counts['odd_short'] += 1

        identity = identity_matrix(polynomial_ring, len(even))
        unit = lambda i, j: matrix_unit(polynomial_ring, even, i, j)
        gram = gram_matrix(polynomial_ring, even, symplectic=True)
        for i in even:
            a = identity + t * unit(i, -i)
            assert a.transpose() * gram * a == gram
            assert a.det() == 1
            counts['symplectic_long'] += 1
            for j in even:
                if i == j or i == -j:
                    continue
                sign = (1 if i > 0 else -1) * (1 if j > 0 else -1)
                a = identity + t*unit(i, j) - sign*t*unit(-j, -i)
                assert a.transpose() * gram * a == gram
                assert a.det() == 1
                original = identity + t*unit(i, j) - 2*t*unit(-j, -i)
                assert original.transpose() * gram * original != gram
                counts['symplectic_short'] += 1
    return counts


if __name__ == '__main__':
    print(check())
