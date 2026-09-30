"""Exact diagram, polarization and pairing checks for §§7–8.

These calculations do not prove the cited group-scheme identifications.
"""
from itertools import combinations, permutations
import json
import re
from pathlib import Path

from sage.all import (
    PolynomialRing, QQ, RootSystem, WeylCharacterRing, ZZ, block_diagonal_matrix, matrix, vector,
)

DIAGRAM_DIRECTORY = Path(__file__).resolve().parents[2] / 'content' / 'diagrams'
GRAPH_SIZES = {
    'e7-weights.json': 56,
    'f4-weights.json': 24,
    'e6-adjoint-piece.json': 36,
    'e7-adjoint-piece.json': 27,
    'e8-adjoint-piece.json': 57,
}


def load_graph(filename):
    return json.loads((DIAGRAM_DIRECTORY / filename).read_text())


def check_graph_edges(filename, node_count):
    graph = load_graph(filename)
    coordinates = [vector(QQ, entry) for entry in graph['coordinates']]
    assert len(coordinates) == node_count
    assert len(set(map(tuple, coordinates))) == node_count
    for source, target, root_index in graph['edges']:
        difference = coordinates[source] - coordinates[target]
        assert difference[root_index - 1] == 1
        assert all(entry == 0 for index, entry in enumerate(difference)
                   if index != root_index - 1)
        assert graph['levels'][target] == graph['levels'][source] + 1
    return len(graph['edges'])


def check_complete_vertices_and_edges():
    for kind, rank, highest_index in (('e7', 7, 7), ('f4', 4, 4)):
        graph = load_graph(f'{kind}-weights.json')
        space = RootSystem([kind[0].upper(), rank]).weight_space(QQ)
        orbit = {tuple(weight.to_vector())
                 for weight in space.fundamental_weights()[highest_index].orbit()}
        assert set(map(tuple, graph['weights'])) == orbit
        assert len(graph['weights']) == len(orbit)
    for rank in (6, 7, 8):
        graph = load_graph(f'e{rank}-adjoint-piece.json')
        positive_roots = RootSystem(['E', rank]).root_lattice().positive_roots()
        expected = {tuple(map(int, root.to_vector())) for root in positive_roots
                    if rank == 6 or root.coefficient(rank) > 0}
        vertices = list(map(tuple, graph['coordinates']))
        assert set(vertices) == expected
        assert len(vertices) == len(expected)
        expected_edges = []
        expected_exits = []
        numbers = {vertex: index for index, vertex in enumerate(vertices)}
        for source, vertex in enumerate(vertices):
            for index in range(rank):
                target = list(vertex)
                target[index] -= 1
                if tuple(target) in numbers:
                    expected_edges.append([source, numbers[tuple(target)], index + 1])
                elif index == rank - 1 and target[index] == 0 and sum(target) > 0:
                    expected_exits.append(source)
        assert len(graph['edges']) == len(set(map(tuple, graph['edges'])))
        assert sorted(graph['edges']) == sorted(expected_edges)
        assert sorted(graph['exits']) == sorted(expected_exits)


def check_e6_variants():
    graph = load_graph('e6-weights.json')
    space = RootSystem(['E', 6]).weight_space(QQ)
    fundamental = space.fundamental_weights()[1]
    orbit = {tuple(weight.to_vector()) for weight in fundamental.orbit()}
    weights = list(map(tuple, graph['weights']))
    assert set(weights) == orbit and len(weights) == len(orbit) == 27
    assert tuple(graph['highest_weight']) == tuple(fundamental.to_vector())
    cartan = space.cartan_type().cartan_matrix()
    highest = vector(QQ, weights[0])
    coordinates = [tuple((highest - vector(QQ, weight)) * cartan.inverse())
                   for weight in weights]
    assert coordinates == list(map(tuple, graph['root_coordinates']))
    numbers = {weight: index for index, weight in enumerate(weights)}
    expected_edges = []
    for source, weight in enumerate(weights):
        for index, root in space.simple_roots().items():
            target = tuple(vector(QQ, weight) - vector(QQ, root.to_vector()))
            if target in numbers:
                expected_edges.append([source, numbers[target], index])
    assert len(graph['edges']) == len(set(map(tuple, graph['edges']))) == 36
    assert sorted(expected_edges) == sorted(graph['edges'])

    def levi_orbits(simple_indices):
        remaining = set(weights)
        orbits = []
        while remaining:
            seed = remaining.pop()
            found, pending = {seed}, [seed]
            while pending:
                weight = pending.pop()
                for index in simple_indices:
                    root = vector(QQ, space.simple_roots()[index].to_vector())
                    reflected = tuple(vector(QQ, weight) - weight[index - 1] * root)
                    if reflected not in found:
                        found.add(reflected)
                        pending.append(reflected)
            remaining -= found
            orbits.append(found)
        return orbits

    for omitted, sizes in (((1, 6), [1, 1, 1, 8, 8, 8]), ((2,), [6, 6, 15])):
        simple_indices = set(range(1, 7)) - set(omitted)
        orbits = levi_orbits(simple_indices)
        assert sorted(map(len, orbits)) == sizes
        partitions = [{numbers[weight] for weight in component} for component in orbits]
        adjacency = {index: set() for index in range(27)}
        for source, target, root_index in graph['edges']:
            if root_index in simple_indices:
                adjacency[source].add(target)
                adjacency[target].add(source)
        components = []
        remaining = set(range(27))
        while remaining:
            seed = remaining.pop()
            found, pending = {seed}, [seed]
            while pending:
                for neighbour in adjacency[pending.pop()] - found:
                    found.add(neighbour)
                    pending.append(neighbour)
            remaining -= found
            components.append(found)
        assert {frozenset(part) for part in partitions} == {frozenset(part) for part in components}

    inverse = cartan.inverse()
    pairing = [3 * (highest * inverse * vector(QQ, weight)) for weight in weights]
    assert pairing.count(4) == 1 and pairing.count(1) == 16 and pairing.count(-2) == 10
    nonadjacent = {index for index, value in enumerate(pairing) if value == -2}
    root_set = {tuple(root.to_vector()) for root in RootSystem(['E', 6]).root_lattice().roots()}
    assert nonadjacent == {index for index, coordinate in enumerate(coordinates)
                          if index != 0 and tuple(coordinate) not in root_set}
    distinguished = [index for index, weight in enumerate(weights)
                     if highest + vector(QQ, weight) + vector(QQ, weights[-1]) == 0]
    assert len(distinguished) == 1
    assert len({0, distinguished[0], 26}) == 3
    root_signs = [weight[0] for weight in weights]
    assert root_signs.count(1) == root_signs.count(-1) == 6
    weight_exponents = [(value - 1) / 3 for value in pairing]
    assert weight_exponents == [1 if index == 0 else -1 if index in nonadjacent else 0
                                for index in range(27)]
    source = (DIAGRAM_DIRECTORY / 'e6-examples.typ').read_text()
    coordinate_alpha = tuple(map(int, re.search(r'let alpha\s*=\s*\(([^)]+)\)', source)
                                 .group(1).split(',')))
    assert coordinate_alpha == (1, 0, 1, 1, 0, 0)
    assert '=> a - b)' in source
    inverse_text = source.split('let inverse-cartan', 1)[1].split('for (i, weight)', 1)[0]
    inverse_rows = [list(map(int, row.split(','))) for row in
                    re.findall(r'\(([0-9,\s]+)\)', inverse_text)]
    assert matrix(ZZ, inverse_rows) == 3 * cartan.inverse()
    assert re.search(r'mode == "jordan" and label in \(1, 6\)', source)
    assert re.search(r'mode == "a5-a1" and label == 2', source)
    assert re.search(r'if pairing == -2', source)
    alpha = sum((coefficient * space.simple_roots()[index + 1]
                 for index, coefficient in enumerate(coordinate_alpha)), space.zero())
    pairs = [(source, numbers[target]) for source, weight in enumerate(weights)
             if (target := tuple(vector(QQ, weight) + vector(QQ, alpha.to_vector()))) in numbers]
    assert len(pairs) == 6
    coordinate_pairs = [(source, coordinates.index(target))
                        for source, coordinate in enumerate(coordinates)
                        if (target := tuple(vector(QQ, coordinate) - vector(QQ, coordinate_alpha)))
                        in coordinates]
    assert pairs == coordinate_pairs
    assert len(set(sum(([source, target] for source, target in pairs), []))) == 12
    dynkin_text = source.split('#let e6-dynkin', 1)[1]
    chain = list(map(int, re.search(r'let labels\s*=\s*\(([^)]+)\)', dynkin_text)
                         .group(1).split(',')))
    dynkin_edges = {frozenset(pair) for pair in zip(chain, chain[1:])}
    dynkin_edges.add(frozenset((chain[2], 2)))
    assert 'line((2, 0), (2, -0.8))' in dynkin_text
    assert dynkin_edges == {frozenset((first + 1, second + 1))
                            for first, second in combinations(range(6), 2)
                            if cartan[first, second] != 0}
    cover = (DIAGRAM_DIRECTORY / 'cover-weights.typ').read_text()
    direction = tuple(map(int, re.search(r'let direction\s*=\s*\(([^)]+)\)', cover)
                              .group(1).split(',')))
    projected = {(sum(coordinate), sum(a * b for a, b in zip(coordinate, direction)))
                 for coordinate in coordinates}
    assert len(projected) == 27

    character_ring = WeylCharacterRing(['F', 4], style='coroots')
    character = character_ring(0, 0, 0, 1)
    assert character.degree() == 26
    multiplicities = character.weight_multiplicities()
    assert sorted(multiplicities.values()) == [1] * 24 + [2]
    assert multiplicities[character_ring.space().zero()] == 2
    f4_graph = load_graph('f4-weights.json')
    assert f4_graph['zero_height'] == sum(f4_graph['coordinates'][0])
    drawing = (DIAGRAM_DIRECTORY / 'exceptional-weights.typ').read_text()
    assert re.search(r'for j in range\(3\)', drawing)


def check_e6_column_variants():
    graph = load_graph('e6-weights.json')
    stabiliser = load_graph('e6-stabiliser.json')
    weights = [vector(QQ, weight) for weight in graph['weights']]
    cartan = matrix(ZZ, graph['cartan'])
    source = (DIAGRAM_DIRECTORY / 'e6-columns.typ').read_text()
    labels_text = source.split('#let coordinates', 1)[1].split('#let coordinate(', 1)[0]
    labels = [label.split() for label in re.findall(r'\$([^$]+)\$', labels_text)]
    roots_text = source.split('#let roots', 1)[1].split('#let coordinates', 1)[0]
    names = re.findall(r'\$([^$]+)\$', roots_text)
    assert len(labels) == 27 and names == ['α', 'β', 'γ', 'δ', 'ε']
    assert labels[:2] == [['ω'], ['τ']]
    families = zip(stabiliser['roots'], stabiliser['actions'])
    for index, (coefficients, action) in enumerate(families):
        root = vector(QQ, coefficients) * cartan
        expected = {(row, column) for row in range(27) for column in range(27)
                    if weights[row] - weights[column] == root}
        actual = [(row, column) for row, column, coefficient in action]
        assert len(actual) == len(set(actual)) == 6
        assert set(actual) == expected
        assert all(coefficient in (-1, 1) for _, _, coefficient in action)
        assert labels[22 + index] == [names[index]]
        for row, column in actual:
            if row < 2:
                assert labels[column] == [names[index]]
            elif column >= 22:
                assert sorted(labels[row]) == sorted((names[index], names[column - 22]))
    attachment = source.split('#let coordinate(', 1)[1].split('#let weight-layout', 1)[0]
    groups = re.findall(r'in\s*\(([0-9,\s]+)\)', attachment)
    assert len(groups) == 2
    double_prime = set(map(int, groups[0].split(',')))
    prime = set(map(int, groups[1].split(',')))
    expected_double = {column for action in stabiliser['actions']
                       for row, column, _ in action if row == 0}
    expected_prime = {column for action in stabiliser['actions']
                     for row, column, _ in action if row == 1}
    assert double_prime == expected_double and prime == expected_prime
    assert not double_prime & prime


def check_fundamental_coordinates(kind, rank, expected_edges):
    graph = load_graph(f'{kind}-weights.json')
    cartan = RootSystem([kind[0].upper(), rank]).cartan_matrix()
    weights = [vector(QQ, weight) for weight in graph['weights']]
    coordinates = [vector(QQ, entry) for entry in graph['coordinates']]
    # Simple roots are Cartan columns in fundamental-weight coordinates.
    assert all(coordinate * cartan.transpose() == weight
               for coordinate, weight in zip(coordinates, weights))
    actual_edges = []
    for source, weight in enumerate(weights):
        for index in range(rank):
            target_weight = weight - vector(QQ, cartan.column(index))
            if target_weight in weights:
                actual_edges.append([source, weights.index(target_weight), index + 1])
    assert sorted(actual_edges) == sorted(graph['edges'])
    assert len(actual_edges) == expected_edges


def check_e6_incidence():
    graph = load_graph('e6-weights.json')
    weights = [vector(QQ, weight) for weight in graph['weights']]
    root_system = RootSystem(['E', 6])
    cartan = root_system.cartan_matrix()
    roots = {tuple(root.to_vector()) for root in root_system.root_lattice().roots()}
    coordinates = [weight * cartan.inverse() for weight in weights]
    neighbours = [
        {target for target in range(27)
         if source != target and tuple(coordinates[source] - coordinates[target]) in roots}
        for source in range(27)
    ]
    assert all(len(adjacent) == 16 for adjacent in neighbours)
    for first, second in combinations(range(27), 2):
        common = neighbours[first] & neighbours[second]
        assert len(common) == (10 if second in neighbours[first] else 8)
        assert second in neighbours[first] or common
    assert any(second in neighbours[first] and third in neighbours[first]
               and third in neighbours[second]
               for first, second, third in combinations(range(27), 3))
    triples = [indices for indices in combinations(range(27), 3)
               if sum((weights[index] for index in indices), vector(QQ, 6)) == 0]
    assert len(triples) == 45
    for first, second, third in triples:
        assert second not in neighbours[first]
        assert third not in neighbours[first] and third not in neighbours[second]


def check_integral_polarization():
    ring = PolynomialRing(ZZ, names=('a', 'b', 'c', 'u', 'v', 'w', 't'))
    a, b, c, u, v, w, parameter = ring.gens()
    first = (a, b, c)
    second = (u, v, w)
    partial = a * b * w + a * c * v + b * c * u
    translated = (a + parameter * u) * (b + parameter * v) * (c + parameter * w)
    assert translated.derivative(parameter).subs({parameter: 0}) == partial
    assert (a + u) * (b + v) * (c + w) - a * b * c - u * v * w - partial \
        == a * v * w + b * u * w + c * u * v

    def complete_polarization(x, y, z):
        arguments = (x, y, z)
        return sum(arguments[order[0]][0] * arguments[order[1]][1]
                   * arguments[order[2]][2] for order in permutations(range(3)))

    assert complete_polarization(first, first, second) == 2 * partial
    assert complete_polarization(first, first, first) == 6 * a * b * c


def check_e8_pairing():
    root_lattice = RootSystem(['E', 8]).root_lattice()
    cartan = matrix(ZZ, root_lattice.cartan_type().cartan_matrix())
    roots = [vector(ZZ, root.to_vector()) for root in root_lattice.roots()]
    assert len(roots) == 240
    eigenvalues = [cartan * root for root in roots]
    killing_cartan = sum((value.column() * value.row() for value in eigenvalues),
                         matrix(ZZ, 8, 8))
    assert killing_cartan == 60 * cartan
    assert 2 * root_lattice.highest_root().height() + 2 == 60
    assert cartan.det() == 1
    # B=Killing/60 has 120 opposite-root hyperbolic blocks and Cartan block.
    hyperbolic_block = matrix(ZZ, [[0, 1], [1, 0]])
    normalized_gram = block_diagonal_matrix([cartan] + [hyperbolic_block] * 120)
    assert normalized_gram.nrows() == 248
    assert normalized_gram.det() == 1


def check_scalar_obstruction():
    ring = PolynomialRing(QQ, 'z')
    scalar = ring.gen()
    for degree, cyclotomic in ((3, scalar ** 2 + scalar + 1),
                               (4, scalar ** 2 + 1)):
        assert (scalar ** degree - 1) % cyclotomic == 0
        assert (scalar ** 2 - scalar) % cyclotomic != 0


def main():
    edge_count = sum(check_graph_edges(filename, size)
                     for filename, size in GRAPH_SIZES.items())
    check_complete_vertices_and_edges()
    check_e6_variants()
    check_e6_column_variants()
    check_fundamental_coordinates('e7', 7, 84)
    check_fundamental_coordinates('f4', 4, 28)
    for rank, count in ((6, 36), (7, 63), (8, 120)):
        roots = RootSystem(['E', rank]).root_lattice().positive_roots()
        assert len(list(roots)) == count
    check_e6_incidence()
    check_integral_polarization()
    check_e8_pairing()
    check_scalar_obstruction()
    print(f'PASS: five exceptional diagrams, {sum(GRAPH_SIZES.values())} nodes, '
          f'{edge_count} edges.')
    print('E6 incidence (27,16,10,8), diameter 2, girth 3; 45 cubic triples; integral polarization.')
    print('E8: 240 root eigenvalues give Killing Cartan block = 60 Cartan; '
          'normalized 248-dimensional Gram determinant = 1.')
    print('Complete Sage vertex/edge sets, eight E6 variants '
          'and three E6 column variants agree.')
    print('Scalar obstructions: cubic roots for trilinear invariants, '
          'fourth roots for quartic invariants.')


if __name__ == '__main__':
    main()
