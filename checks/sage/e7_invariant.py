"""Check the characteristic-zero E7 quartic and its 126 root operators.

The basis is Λ²(Q^8) ⊕ Λ²(Q^8)*, indexed by increasing pairs.
This verifies polynomial invariance, not the full stabilizer group scheme.
"""
from itertools import combinations

from sage.all import PolynomialRing, QQ, RootSystem, matrix, vector

PAIRS = tuple(combinations(range(8), 2))
PAIR_INDEX = {pair: index for index, pair in enumerate(PAIRS)}


def permutation_sign(sequence):
    inversions = sum(sequence[i] > sequence[j]
                     for i in range(len(sequence)) for j in range(i + 1, len(sequence)))
    return (-1) ** inversions


def alternating_matrix(ring, coordinates):
    result = matrix(ring, 8)
    for (i, j), coefficient in zip(PAIRS, coordinates):
        result[i, j] = coefficient
        result[j, i] = -coefficient
    return result


def pfaffian(matrix_value, indices=tuple(range(8))):
    if not indices:
        return matrix_value.base_ring().one()
    first = indices[0]
    return sum((-1) ** (position + 1) * matrix_value[first, second]
               * pfaffian(matrix_value, indices[1:position] + indices[position + 1:])
               for position, second in enumerate(indices[1:], 1))


def quartic_terms(ring, coordinates):
    first = alternating_matrix(ring, coordinates[:28])
    second = alternating_matrix(ring, coordinates[28:])
    product = first * second
    return pfaffian(first), pfaffian(second), (product * product).trace(), product.trace() ** 2


def exterior_root(first, second):
    """The matrix unit E_first,second on Λ² and its contragredient."""
    exterior = matrix(QQ, 28)
    for column, pair in enumerate(PAIRS):
        if second not in pair or first in pair:
            continue
        image = tuple(first if index == second else index for index in pair)
        exterior[PAIR_INDEX[tuple(sorted(image))], column] = permutation_sign(image)
    result = matrix(QQ, 56)
    result[:28, :28] = exterior
    result[28:, 28:] = -exterior.transpose()
    return result


def half_root(positive_indices):
    negative_indices = tuple(index for index in range(8) if index not in positive_indices)
    orientation = permutation_sign(positive_indices + negative_indices)
    result = matrix(QQ, 56)
    for indices, source_offset, target_offset, factor in (
            (positive_indices, 28, 0, 1),
            (negative_indices, 0, 28, -orientation)):
        for pair in combinations(indices, 2):
            complement = tuple(index for index in indices if index not in pair)
            hodge_sign = permutation_sign(tuple(indices.index(index)
                                                for index in pair + complement))
            result[target_offset + PAIR_INDEX[complement],
                   source_offset + PAIR_INDEX[pair]] = factor * hodge_sign
    return result


def weight_data():
    basis = [vector(QQ, [int(index == coordinate) for index in range(8)])
             for coordinate in range(8)]
    center = vector(QQ, [QQ(1) / 4] * 8)
    positive = [basis[i] + basis[j] - center for i, j in PAIRS]
    weights = positive + [-weight for weight in positive]
    half = vector(QQ, [QQ(1) / 2] * 4 + [-QQ(1) / 2] * 4)
    # Bourbaki numbering: the extra simple root is node 2.
    simple = [basis[6] - basis[5], half, basis[5] - basis[4],
              basis[4] - basis[3], basis[3] - basis[2],
              basis[2] - basis[1], basis[1] - basis[0]]
    sage_space = RootSystem(['E', 7]).weight_lattice()
    assert matrix(QQ, [[first * second for second in simple] for first in simple]) \
        == sage_space.cartan_type().cartan_matrix()
    fundamental = sage_space.fundamental_weights()[7]
    orbit = {tuple(weight.to_vector()) for weight in fundamental.orbit()}
    assert {tuple(weight * root for root in simple) for weight in weights} == orbit
    assert len(weights) == len(set(map(tuple, weights))) == 56
    return basis, weights, simple


def coefficient_kernel(terms, coordinates, operator, ring):
    change = operator * vector(ring, coordinates)
    derivatives = [sum(term.derivative(coordinate) * coefficient
                       for coordinate, coefficient in zip(coordinates, change)) for term in terms]
    supports = set().union(*(derivative.dict() for derivative in derivatives))
    equations = matrix(QQ, [[derivative.monomial_coefficient(ring.monomial(*exponent))
                            for derivative in derivatives] for exponent in supports])
    return equations.right_kernel()


def main():
    ring = PolynomialRing(QQ, names=[f'x{i}{j}' for i, j in PAIRS]
                          + [f'y{i}{j}' for i, j in PAIRS] + ['t'])
    coordinates = ring.gens()[:56]
    parameter = ring.gen(56)
    terms = quartic_terms(ring, coordinates)
    quartic = terms[0] + terms[1] - terms[2] / 4 + terms[3] / 16
    basis, weights, simple = weight_data()
    symplectic = matrix(QQ, 56)
    symplectic[:28, 28:] = matrix.identity(QQ, 28)
    symplectic[28:, :28] = -matrix.identity(QQ, 28)
    assert symplectic.det() == 1
    # This is exactly 1/2(tr(X1^tY2)-tr(X2^tY1)) in pair coordinates.
    assert sum(coordinate * coordinate for coordinate in coordinates[:28]) \
        == (alternating_matrix(ring, coordinates[:28]).transpose()
            * alternating_matrix(ring, coordinates[:28])).trace() / 2
    kernel = coefficient_kernel(terms, coordinates, half_root((0, 1, 2, 3)), ring)
    assert kernel.dimension() == 1
    assert kernel.basis()[0] == vector(QQ, [1, 1, -QQ(1) / 4, QQ(1) / 16])
    roots = [(basis[i] - basis[j], exterior_root(i, j))
             for i in range(8) for j in range(8) if i != j]
    roots += [(vector(QQ, [QQ(1) / 2 if i in indices else -QQ(1) / 2
                           for i in range(8)]), half_root(indices))
              for indices in combinations(range(8), 4)]
    assert len(roots) == len({tuple(root) for root, _ in roots}) == 126
    by_root = {tuple(root): operator for root, operator in roots}
    raising = [by_root[tuple(root)] for root in simple]
    for index, first in enumerate(raising):
        assert first * first.transpose() - first.transpose() * first \
            == matrix.diagonal(QQ, [weight * simple[index] for weight in weights])
        for other, second in enumerate(raising):
            if index == other:
                continue
            assert first * second.transpose() - second.transpose() * first == 0
            bracket = first * second - second * first
            if simple[index] * simple[other] == 0:
                assert bracket == 0
            else:
                assert first * bracket - bracket * first == 0
    for root, operator in roots:
        assert operator * operator == 0
        assert operator.rank() == 12 and len(operator.dict()) == 12
        assert set(operator.list()) <= {-1, 0, 1}
        for row, column in operator.dict():
            assert weights[row] - weights[column] == root
        assert operator.transpose() * symplectic + symplectic * operator == 0
        assert operator.transpose() * symplectic * operator == 0
        transformation = matrix.identity(QQ, 56) + parameter * operator
        assert transformation.transpose() * symplectic * transformation == symplectic
        image = transformation * vector(ring, coordinates)
        assert quartic.subs(dict(zip(coordinates, image))) == quartic
    print('PASS: independent Sage E7 minuscule orbit, 56 weights; all 126 roots.')
    print('Simple generators satisfy Cartan, Serre and all 42 distinct mixed relations.')
    print('Every root operator has 12 signed entries, rank 12 and square zero.')
    print('All root flows preserve the symplectic form and the full 56-variable quartic over QQ[t].')
    print('The coefficient kernel is uniquely (1, 1, -1/4, 1/16); no stabilizer-scheme claim.')


if __name__ == '__main__':
    main()
