"""Integral minuscule E6 matrices, their invariant cubic and the five-root stabiliser."""
from collections import deque
from itertools import combinations_with_replacement, product
import argparse
import json
from pathlib import Path

from sage.all import PolynomialRing, QQ, ZZ, matrix, vector


def root_system(cartan):
    simple = [tuple(int(i == j) for i in range(6)) for j in range(6)]
    roots = set(simple)
    pending = deque(simple)
    while pending:
        root = vector(ZZ, pending.popleft())
        pairings = root * cartan
        for i, coroot in enumerate(pairings):
            reflected = list(root)
            reflected[i] -= coroot
            reflected = tuple(reflected)
            if reflected not in roots:
                roots.add(reflected)
                pending.append(reflected)
    assert len(roots) == 72
    return simple, sorted((r for r in roots if min(r) >= 0),
                          key=lambda r: (sum(r), r))


def representation(weights, cartan, simple, positive):
    numbers = {w: i for i, w in enumerate(weights)}
    raising = []
    for i in range(6):
        operator = matrix(ZZ, 27)
        for j, weight in enumerate(weights):
            if weight[i] == -1:
                target = tuple(vector(ZZ, weight) + cartan.row(i))
                operator[numbers[target], j] = 1
        raising.append(operator)
    for i, e in enumerate(raising):
        assert e * e == 0
        assert e * e.transpose() - e.transpose() * e == matrix.diagonal(
            ZZ, [w[i] for w in weights])
        for j, f in enumerate(raising):
            bracket = e * f - f * e
            if cartan[i, j] == 0:
                assert bracket == 0
            elif i != j:
                assert e * bracket - bracket * e == 0
            if i != j:
                assert e * f.transpose() - f.transpose() * e == 0
    operators = dict(zip(simple, raising))
    for root in positive:
        if root in operators:
            continue
        for i, e in enumerate(raising):
            predecessor = tuple(a - b for a, b in zip(root, simple[i]))
            if predecessor in operators:
                f = operators[predecessor]
                operators[root] = e * f - f * e
                break
        operator = operators[root]
        assert operator.rank() == 6
        assert operator * operator == 0
        assert set(operator.list()) <= {-1, 0, 1}
        for row, column in operator.dict():
            assert vector(ZZ, weights[row]) - vector(ZZ, weights[column]) == \
                vector(ZZ, root) * cartan
    return raising, operators


def invariant_cubic(weights, raising, ring):
    variables = ring.gens()
    monomials = []
    for indices in combinations_with_replacement(range(27), 3):
        if all(sum(weights[i][j] for i in indices) == 0 for j in range(6)):
            monomials.append(product_monomial(variables, indices))
    assert len(monomials) == 45
    relations = []
    for operator in raising:
        action = operator * vector(ring, variables)
        derivatives = [sum(m.derivative(x) * dx for x, dx in
                           zip(variables, action)) for m in monomials]
        supports = set().union(*(d.dict() for d in derivatives))
        relations.extend([[d.monomial_coefficient(ring.monomial(*exponent))
                           for d in derivatives] for exponent in supports])
    kernel = matrix(QQ, relations).right_kernel()
    assert kernel.dimension() == 1
    coefficients = kernel.basis()[0]
    coefficients /= coefficients[0]
    assert set(coefficients) <= {-1, 1}
    return sum(c * m for c, m in zip(coefficients, monomials))


def product_monomial(variables, indices):
    result = 1
    for i in indices:
        result *= variables[i]
    return result


def check_freudenthal_cross_products(cubic, raising, operators):
    # Columns use the cubic tensor; rows use its negative in the dual basis.
    tensors = [matrix(ZZ, 27) for _ in range(27)]
    for exponents, coefficient in cubic.dict().items():
        indices = [i for i, exponent in enumerate(exponents[:27]) if exponent]
        assert len(indices) == 3 and all(exponents[i] == 1 for i in indices)
        for i in indices:
            j, k = [index for index in indices if index != i]
            tensors[i][j, k] = tensors[i][k, j] = coefficient
    root_actions = list(operators.values())
    root_actions += [operator.transpose() for operator in operators.values()]
    matched = cancelled = 0
    for i in range(27):
        for j in range(27):
            if i == j:
                continue
            rank_one = matrix(ZZ, 27, {(i, j): 1})
            action = rank_one - tensors[j] * tensors[i]
            if action == 0:
                cancelled += 1
                assert rank_one + tensors[j] * tensors[i] == 2 * rank_one
            else:
                matches = [operator for operator in root_actions
                           if operator[i, j]
                           and action == operator[i, j] * operator]
                assert len(matches) == 1
                matched += 1
    rank_one = matrix(ZZ, 27, {(0, 1): 1})
    assert rank_one - tensors[1] * tensors[0] == raising[0]
    assert rank_one + tensors[1] * tensors[0] != raising[0]
    assert (matched, cancelled) == (432, 270)
    # One white argument is insufficient: a nonwhite dual vector breaks the cubic.
    ring = cubic.parent()
    variables = ring.gens()[:27]
    column = vector(ZZ, [1] + [0] * 26)
    dual = vector(ZZ, 27)
    dual[1] = dual[14] = 1
    assert dual * column == 0
    gradients = [cubic.derivative(variable) for variable in variables]
    evaluate = lambda polynomial, point: polynomial.subs(dict(zip(variables, point)))
    assert all(evaluate(gradient, column) == 0 for gradient in gradients)
    assert [evaluate(gradient, dual) for gradient in gradients] == \
        [int(index == 25) for index in range(27)]
    action = matrix(ZZ, 27, {(0, 1): 1, (0, 14): 1}) \
        - (tensors[1] + tensors[14]) * tensors[0]
    image = (matrix.identity(ZZ, 27) + action) * vector(ring, variables)
    difference = cubic.subs(dict(zip(variables, image))) - cubic
    expected = variables[15] * (-variables[21] * variables[22]
        + variables[19] * variables[23] - variables[17] * variables[24]
        + variables[15] * variables[25] - variables[12] * variables[26])
    assert difference == expected and difference != 0
    point = vector(ZZ, [index % 5 - 2 for index in range(27)])
    transformed = (matrix.identity(ZZ, 27) + action) * point
    assert evaluate(cubic, point) == 13
    assert evaluate(cubic, transformed) == 1
    print('Freudenthal scope: one white argument is insufficient; '
          'an exact nonzero cubic difference is verified.')
    print('Freudenthal cross products: 432 exact root matrices and 270 cancellations; '
          'the dual tensor must have the opposite sign.')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write', action='store_true')
    args = parser.parse_args()
    path = Path(__file__).resolve().parents[2] / 'content/diagrams/e6-weights.json'
    data = json.loads(path.read_text())
    weights = [tuple(w) for w in data['weights']]
    cartan = matrix(ZZ, data['cartan'])
    simple, positive = root_system(cartan)
    raising, operators = representation(weights, cartan, simple, positive)
    ring = PolynomialRing(ZZ, names=[f'u{i}' for i in range(27)] + ['t'])
    variables = ring.gens()[:27]
    parameter = ring.gen(27)
    cubic_ring = PolynomialRing(QQ, names=[f'u{i}' for i in range(27)])
    cubic = ring(invariant_cubic(weights, raising, cubic_ring))
    for operator in operators.values():
        for action in (operator, operator.transpose()):
            image = vector(ring, variables) + parameter * action * vector(ring, variables)
            assert cubic.subs(dict(zip(variables, image))) == cubic
    check_freudenthal_cross_products(cubic, raising, operators)
    family = [(1, 2, 2, 3, 2, 1), (1, 1, 2, 3, 2, 1),
              (1, 1, 2, 2, 2, 1), (1, 1, 2, 2, 1, 1),
              (1, 1, 2, 2, 1, 0)]
    chosen = [operators[root] for root in family]
    assert all(vector(ZZ, a) * cartan * vector(ZZ, b) == 1
               for i, a in enumerate(family) for b in family[i + 1:])
    for a in chosen:
        for b in chosen:
            assert a * b == 0
    candidates = []
    u = vector(ring, variables)
    gradients = [cubic.derivative(x) for x in variables]
    for signs in product((-1, 1), repeat=4):
        signs = (1,) + signs
        change = sum((sign * variables[22 + i] * operator * u
                      for i, (sign, operator) in enumerate(zip(signs, chosen))),
                     vector(ring, [0] * 27))
        if all(change[i] == 0 for i in range(2, 27)):
            assert all(c == 0 or c in gradients or -c in gradients for c in change)
            candidates.append((signs, change))
    assert len(candidates) == 1
    signs, change = candidates[0]
    stabiliser = {
        'roots': family,
        'parameter_signs': signs,
        'actions': [[[i, j, int(value)] for (i, j), value in sorted(a.dict().items())]
                    for a in chosen],
        'cubic': [[list(exponent[:27]), int(coefficient)]
                  for exponent, coefficient in sorted(cubic.dict().items())],
    }
    output = path.with_name('e6-stabiliser.json')
    encoded = json.dumps(stabiliser, indent=2) + '\n'
    if args.write:
        output.write_text(encoded)
    else:
        assert output.read_text() == encoded, 'Regenerate the stabiliser data deliberately.'
    print('E6: six integral Chevalley generators; all 30 mixed [e_i,f_j] vanish for i != j.')
    print('All 36 positive-root matrices and their transposes preserve the cubic over ZZ[t].')
    print('The 45-term cubic is preserved over Z[t], including negative simple roots.')
    print('Five-root signs:', signs)
    print('Residual coordinate changes:', [(i, str(c)) for i, c in enumerate(change) if c])
    print('Each residual is a gradient of the cubic; white columns are fixed.')


if __name__ == '__main__':
    main()
