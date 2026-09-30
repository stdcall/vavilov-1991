"""Check §6, G2: the Zorn algebra and its seven-dimensional invariant forms.

The signs follow Asok--Hoyois--Wendt, Definition 2.1.9. Polynomial
identities hold over Z; reconstruction of the product from Q and F uses
1/2. The Lie-dimension calculation over Q diagnoses the original erroneous
coefficient. These checks do not prove Conrad's group-scheme theorem.
"""

from itertools import combinations, permutations
from sage.all import ZZ, QQ, PolynomialRing, vector, matrix


def zorn_product(x, y):
    a, b = x[0], x[7]
    c, d = y[0], y[7]
    u, v = vector(x[1:4]), vector(x[4:7])
    w, z = vector(y[1:4]), vector(y[4:7])
    top = a*w + d*u + v.cross_product(z)
    bottom = c*v + b*z + u.cross_product(w)
    return vector([a*c-u.dot_product(z)] + list(top) + list(bottom)
                  + [b*d-v.dot_product(w)])


def norm(x):
    return x[0]*x[7] + sum(x[i]*x[i+3] for i in range(1, 4))


def polar(x, y):
    return norm(x+y)-norm(x)-norm(y)


def check():
    ring = PolynomialRing(ZZ, ['x'+str(i) for i in range(8)]
                          + ['y'+str(i) for i in range(8)])
    x, y = vector(ring.gens()[:8]), vector(ring.gens()[8:])
    assert norm(zorn_product(x, y)) == norm(x)*norm(y)
    indices = [1, 2, 3, 0, -3, -2, -1]
    basis = []
    for i in indices:
        element = vector(ZZ, 8)
        if i == 0:
            element[0], element[7] = 1, -1
        else:
            element[i if i > 0 else 3-i] = 1
        basis.append(element)
    tensor = {}
    monomials = [(0, 1, -1), (0, 2, -2), (0, 3, -3),
                 (1, 2, 3), (-1, -2, -3)]
    for triple in monomials:
        positions = tuple(indices.index(i) for i in triple)
        for permutation in permutations(positions):
            inversions = sum(positions.index(permutation[i]) >
                             positions.index(permutation[j])
                             for i in range(3) for j in range(i+1, 3))
            tensor[permutation] = (-1)**inversions
    for i in range(7):
        for j in range(7):
            product = zorn_product(basis[i], basis[j])
            for k in range(7):
                assert polar(product, basis[k]) == tensor.get((i, j, k), 0)
            assert product[0]+product[7] == -polar(basis[i], basis[j])
    rows = []
    for i, j, k in combinations(range(7), 3):
        row = [0]*49
        for q in range(7):
            row[q*7+i] += tensor.get((q, j, k), 0)
            row[q*7+j] += tensor.get((i, q, k), 0)
            row[q*7+k] += tensor.get((i, j, q), 0)
        rows.append(row)
    linearization = matrix(QQ, rows)
    assert 49-linearization.rank() == 14
    dimensions = {}
    for coefficient in (-4, -2):
        gram = matrix(QQ, 7)
        for i in range(7):
            gram[i, 6-i] = coefficient if i == 3 else 1
        constraints = []
        for i in range(7):
            for j in range(i, 7):
                row = [0]*49
                for q in range(7):
                    row[q*7+i] += gram[q, j]
                    row[q*7+j] += gram[i, q]
                constraints.append(row)
        dimensions[coefficient] = 49-linearization.stack(
            matrix(QQ, constraints)).rank()
    assert dimensions == {-4: 8, -2: 14}
    parameter_ring = PolynomialRing(ZZ, 't')
    t = parameter_ring.gen()
    short_root = matrix.identity(parameter_ring, 7)
    short_root[0, 3] = 2*t
    short_root[3, 6] = t
    short_root[0, 6] = t*t
    short_root[5, 2] = -t
    short_root[4, 1] = t
    gram = matrix(ZZ, 7, {(i, 6-i): -2 if i == 3 else 1
                          for i in range(7)})
    assert short_root.transpose()*gram*short_root == gram
    assert short_root.det() == 1
    coordinate_ring = PolynomialRing(ZZ, ['t']+[f'v{i}' for i in range(7)])
    v = vector(coordinate_ring, coordinate_ring.gens()[1:])
    transformed_v = short_root.change_ring(coordinate_ring)*v
    quadratic = lambda z: -z[3]**2+z[0]*z[6]+z[1]*z[5]+z[2]*z[4]
    assert quadratic(transformed_v) == quadratic(v)
    for i in range(7):
        for j in range(7):
            for k in range(7):
                transformed = sum(coefficient*short_root[a, i]
                                  *short_root[b, j]*short_root[c, k]
                                  for (a, b, c), coefficient in tensor.items())
                assert transformed == tensor.get((i, j, k), 0)
    original_support = matrix.identity(parameter_ring, 7)
    original_support[0, 3] = 2*t
    original_support[3, 6] = t
    original_support[0, 6] = t*t
    original_support[1, 4] = t
    original_support[2, 5] = -t
    assert sum(coefficient*original_support[a, 3]
               *original_support[b, 1]*original_support[c, 2]
               for (a, b, c), coefficient in tensor.items()) == 2*t
    octonion_root = matrix.identity(parameter_ring, 8)
    for row, column, coefficient in ((0, 4, t), (7, 4, -t),
                                     (1, 0, t), (1, 7, -t), (1, 4, t*t),
                                     (5, 3, -t), (6, 2, t)):
        octonion_root[row, column] = coefficient
    octonion_basis = matrix.identity(parameter_ring, 8).columns()
    unit = vector(parameter_ring, [1, 0, 0, 0, 0, 0, 0, 1])
    assert octonion_root*unit == unit
    for left in octonion_basis:
        for right in octonion_basis:
            assert octonion_root*zorn_product(left, right) == zorn_product(
                octonion_root*left, octonion_root*right)
    for i, element in enumerate(basis):
        assert octonion_root*element == sum(
            (short_root[j, i]*basis[j] for j in range(7)),
            vector(parameter_ring, 8))
    addition_ring = PolynomialRing(ZZ, ['t', 's'])
    tau, sigma = addition_ring.gens()
    for operator in (short_root, octonion_root):
        def evaluate(parameter):
            return matrix(addition_ring, operator.nrows(), operator.ncols(),
                          [entry(parameter) for entry in operator.list()])
        assert evaluate(tau)*evaluate(sigma) == evaluate(tau+sigma)
        assert evaluate(tau)*evaluate(-tau) == matrix.identity(
            addition_ring, operator.nrows())
    epsilon = {1: vector(ZZ, [1, 0]), 2: vector(ZZ, [0, 1]),
               3: vector(ZZ, [-1, -1])}
    weights = {i: epsilon[i] for i in epsilon}
    weights.update({-i: -weight for i, weight in epsilon.items()})
    weights[0] = vector(ZZ, [0, 0])
    chain = [1, -2, -3, 0, 3, 2, -1]
    alpha1, alpha2 = -weights[3], weights[3]-weights[2]
    marks = [1, 2, 1, 1, 2, 1]
    for left, right, mark in zip(chain, chain[1:], marks):
        assert weights[left]-weights[right] == (alpha1 if mark == 1 else alpha2)
    root = 2*alpha1+alpha2
    assert root == weights[1]
    for target, source in ((1, 0), (0, -1), (-2, 3), (-3, 2)):
        assert weights[target]-weights[source] == root
    return {'norm_composition': True, 'Dickson_basis_triples': 343,
            'short_root_Q_and_F_over_ZZ_t': True,
            'short_root_octonion_products': 64, 'short_root_addition_law': True,
            'Lie_dimensions_by_Gram_central_coefficient': dimensions}


if __name__ == '__main__':
    print(check())
