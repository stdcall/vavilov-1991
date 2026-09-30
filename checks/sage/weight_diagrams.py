"""Bourbaki E₆: the minuscule orbit of ω₁ and its labelled simple-root edges."""
from collections import deque
from itertools import permutations
import argparse
import json
from pathlib import Path

from sage.all import CartanMatrix, QQ, RootSystem, vector


def weight_graph(cartan, highest):
    highest.set_immutable()
    seen = {highest}
    pending = deque([highest])
    while pending:
        weight = pending.popleft()
        for index, root in enumerate(cartan.rows()):
            reflected = weight - weight[index] * root
            reflected.set_immutable()
            if reflected not in seen:
                seen.add(reflected)
                pending.append(reflected)
    inverse = cartan.inverse()
    heights = {w: sum((highest - w) * inverse) for w in seen}
    weights = sorted(seen, key=lambda w: (heights[w], tuple(w)))
    numbers = {w: i for i, w in enumerate(weights)}
    edges = []
    for weight in weights:
        for index, root in enumerate(cartan.rows()):
            lowered = weight - root
            lowered.set_immutable()
            if lowered in numbers:
                edges.append((numbers[weight], numbers[lowered], index + 1))
    return weights, edges, heights


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write', action='store_true')
    args = parser.parse_args()
    cartan = CartanMatrix(['E', 6])
    highest = vector(QQ, [1, 0, 0, 0, 0, 0])
    weights, edges, heights = weight_graph(cartan, highest)
    assert len(weights) == 27
    assert len(edges) == 36
    assert all(set(w) <= {-1, 0, 1} for w in weights)
    assert all(heights[weights[b]] == heights[weights[a]] + 1
               for a, b, _ in edges)
    lattice = RootSystem(['E', 6]).weight_lattice()
    orbit = {tuple(w.to_vector()) for w in lattice.fundamental_weights()[1].orbit()}
    assert orbit == {tuple(w) for w in weights}
    roots = RootSystem(['E', 6]).root_lattice().roots()
    assert len(roots) == 72
    for root in roots:
        coordinates = vector(QQ, root.to_vector()) * cartan
        assert sum(1 for source in weights for target in weights
                   if target - source == coordinates) == 6
    paths = []
    for source in range(len(weights)):
        for marks in permutations((1, 3, 4)):
            path = [source]
            for mark in marks:
                successors = [b for a, b, label in edges
                              if a == path[-1] and label == mark]
                if not successors:
                    break
                assert len(successors) == 1
                path.append(successors[0])
            if len(path) == 4:
                paths.append(tuple(path))
    assert len(paths) == 8
    assert len({(path[0], path[-1]) for path in paths}) == 6
    remaining = set(range(len(weights)))
    components = []
    while remaining:
        component = {remaining.pop()}
        previous = set()
        while previous != component:
            previous = component.copy()
            component |= {b for a, b, label in edges
                          if label not in (1, 6) and a in component}
            component |= {a for a, b, label in edges
                          if label not in (1, 6) and b in component}
        remaining -= component
        components.append(component)
    scalars = sorted((c for c in components if len(c) == 1),
                     key=lambda c: heights[weights[next(iter(c))]])
    octonions = sorted((c for c in components if len(c) == 8),
                       key=lambda c: sum(heights[weights[i]] for i in c))
    assert [next(iter(c)) for c in scalars] == [0, 12, 26]
    assert len(octonions) == 3
    for scalar, component in zip(scalars, reversed(octonions)):
        alpha = weights[next(iter(scalar))]
        pairs = [(i, j) for i in component for j in component if i < j
                 and alpha + weights[i] + weights[j] == 0]
        assert len(pairs) == 4
        assert {index for pair in pairs for index in pair} == component
    data = {
        'type': 'E6', 'highest_weight': [1, 0, 0, 0, 0, 0],
        'cartan': [[int(x) for x in row] for row in cartan.rows()],
        'weights': [[int(x) for x in w] for w in weights],
        'root_coordinates': [[int(x) for x in (highest - w) * cartan.inverse()]
                             for w in weights],
        'edges': edges,
    }
    output = Path(__file__).resolve().parents[2] / 'content/diagrams/e6-weights.json'
    encoded = json.dumps(data, indent=2) + '\n'
    if args.write:
        output.write_text(encoded)
    else:
        assert output.read_text() == encoded, 'Regenerate the diagram data deliberately.'
    print('E6 ω1: 27 weights, 36 simple-root edges; Sage orbit agrees.')


if __name__ == '__main__':
    main()
