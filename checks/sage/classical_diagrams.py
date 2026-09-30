"""Check the actual classical diagram literals against Sage root data.

The ellipsis diagrams show selected vertices of the natural modules. All
visible vertices and all induced labelled edges are checked in ranks 8–12;
these ranks cover every distinct position in the symbolic patterns. The G2
chain is checked in full. This is not a group-scheme identification proof.
"""
import ast
from itertools import combinations
from pathlib import Path
import re

from sage.all import QQ, RootSystem, vector

SOURCE = Path(__file__).resolve().parents[2] / 'content/diagrams/classical-weights.typ'


def index_expression(text, rank):
    node = ast.parse(text.replace('ell', str(rank)), mode='eval').body

    def evaluate(expression):
        if isinstance(expression, ast.Constant) and isinstance(expression.value, int):
            return expression.value
        if isinstance(expression, ast.UnaryOp) and isinstance(expression.op, ast.USub):
            return -evaluate(expression.operand)
        if isinstance(expression, ast.BinOp) and isinstance(expression.op, (ast.Add, ast.Sub)):
            sign = 1 if isinstance(expression.op, ast.Add) else -1
            return evaluate(expression.left) + sign * evaluate(expression.right)
        raise ValueError(text)

    return evaluate(node)


def literal_tokens(text):
    return [match.group(1).strip() if match.group(1) is not None else None
            for match in re.finditer(r'\$([^$]+)\$|\b(none)\b', text)]


def basis_index(token, rank):
    if token is None:
        return None
    if token == '0':
        return 0
    match = re.fullmatch(r'e_(?:\(([^)]+)\)|([\w-]+))', token)
    assert match, token
    return index_expression(match.group(1) or match.group(2), rank)


def canonical_edge(first, second, root_index):
    return (*sorted((tuple(first), tuple(second))), root_index)


def independent_edges(vertices, simple_roots):
    edges = set()
    for first, second in combinations(vertices, 2):
        difference = first - second
        for root_index, root in simple_roots.items():
            if difference in (root, -root):
                edges.add(canonical_edge(first, second, root_index))
    return edges


def natural_weights(kind, rank):
    space = RootSystem([kind, rank]).ambient_space()
    dimension = rank + 1 if kind == 'A' else rank

    def weight(index):
        if index == 0:
            return vector(QQ, dimension)
        result = vector(QQ, dimension)
        result[abs(index) - 1] = 1 if index > 0 else -1
        return result

    orbit = {tuple(entry.to_vector()) for entry in space.fundamental_weights()[1].orbit()}
    if kind == 'B':
        orbit.add(tuple(weight(0)))
    roots = {index: vector(QQ, root.to_vector())
             for index, root in space.simple_roots().items()}
    return weight, orbit, roots


def check_chain(source, kind, rank):
    function = re.search(rf'#let type-{kind.lower()}\(\)\s*=\s*weight-chain\(\s*'
                         r'\((.*?)\),\s*\((.*?)\)', source, re.S)
    assert function
    weight_tokens = literal_tokens(function.group(1))
    mark_tokens = literal_tokens(function.group(2))
    assert len(mark_tokens) == len(weight_tokens) - 1
    weight, orbit, roots = natural_weights(kind, rank)
    vertices = [None if token is None else weight(basis_index(token, rank))
                for token in weight_tokens]
    present = [entry for entry in vertices if entry is not None]
    assert len(present) == len(set(map(tuple, present)))
    assert set(map(tuple, present)) <= orbit
    edges = set()
    for index, mark in enumerate(mark_tokens):
        if mark is not None:
            assert vertices[index] is not None and vertices[index + 1] is not None
            edge = canonical_edge(vertices[index], vertices[index + 1],
                                  index_expression(mark, rank))
            assert edge not in edges
            edges.add(edge)
    assert edges == independent_edges(present, roots)
    return len(present), len(edges)


def check_diamond(source, rank):
    function = source[source.index('#let type-d'):]
    left_text = re.search(r'let left\s*=\s*(.*?)\n\s*let labels', function, re.S).group(1)
    marks_text = re.search(r'let labels\s*=\s*(.*?)\n\s*for', function, re.S).group(1)
    right_text = re.search(r'let shown\s*=.*?else\s*\{(.*?)\.at\(i\)', function, re.S).group(1)
    left = [basis_index(token, rank) for token in literal_tokens(left_text)]
    right = [basis_index(token, rank) for token in literal_tokens(right_text)]
    marks = [None if token is None else index_expression(token, rank)
             for token in literal_tokens(marks_text)]
    weight, orbit, roots = natural_weights('D', rank)
    assert right == [None if index is None else -index for index in left]
    vertices = [weight(index) for index in left + right if index is not None]
    edges = set()
    for chain in (left, right):
        for position, mark in enumerate(marks):
            if mark is not None:
                edges.add(canonical_edge(
                    weight(chain[position]), weight(chain[position + 1]), mark,
                ))
    middle = re.search(r'for \(y,\s*weight\) in (.*?)\{', function, re.S).group(1)
    central_indices = [basis_index(token, rank) for token in literal_tokens(middle)]
    labels = re.findall(r'if y > 0\s*\{\s*\$([^$]+)\$\s*\}\s*else\s*'
                        r'\{\s*\$([^$]+)\$\s*\}', function)
    assert len(labels) == 2 and len(central_indices) == 2
    for position, index in enumerate(central_indices):
        centre = weight(index)
        vertices.append(centre)
        edges.add(canonical_edge(weight(left[-1]), centre,
                                  index_expression(labels[0][position], rank)))
        edges.add(canonical_edge(centre, weight(right[-1]),
                                  index_expression(labels[1][position], rank)))
    assert len(vertices) == len(set(map(tuple, vertices)))
    assert set(map(tuple, vertices)) <= orbit
    assert edges == independent_edges(vertices, roots)
    return len(vertices), len(edges)


def check_g2_chain(source):
    function = re.search(r'#let type-g\(\)\s*=\s*weight-chain\(\s*'
                         r'\((.*?)\),\s*\((.*?)\)', source, re.S)
    names = [basis_index(token, 2) for token in literal_tokens(function.group(1))]
    marks = [index_expression(token, 2) for token in literal_tokens(function.group(2))]
    space = RootSystem(['G', 2]).weight_space(QQ)
    roots = {index: vector(QQ, root.to_vector())
             for index, root in space.simple_roots().items()}
    highest = space.fundamental_weights()[1]
    vertices = [vector(QQ, highest.to_vector())]
    for root_index in marks:
        vertices.append(vertices[-1] - roots[root_index])
    named = dict(zip(names, vertices))
    assert named[0] == 0
    assert all(named[-index] == -named[index] for index in (1, 2, 3))
    orbit = {tuple(weight.to_vector()) for weight in highest.orbit()}
    orbit.add(tuple(named[0]))
    assert set(map(tuple, vertices)) == orbit and len(vertices) == len(orbit) == 7
    edges = {canonical_edge(vertices[index], vertices[index + 1], root_index)
             for index, root_index in enumerate(marks)}
    assert len(edges) == 6 and edges == independent_edges(vertices, roots)


def main():
    source = SOURCE.read_text()
    totals = [check_chain(source, kind, rank)
              for rank in range(8, 13) for kind in ('A', 'B', 'C')]
    totals.extend(check_diamond(source, rank) for rank in range(8, 13))
    check_g2_chain(source)
    print('PASS: actual A/B/C/D diagram literals in ranks 8–12, '
          'including every visible root label.')
    print(f'20 compressed diagrams: {sum(size for size, _ in totals)} displayed vertices, '
          f'{sum(edges for _, edges in totals)} induced edges; '
          'complete G2 graph: 7 vertices, 6 edges.')


if __name__ == '__main__':
    main()
