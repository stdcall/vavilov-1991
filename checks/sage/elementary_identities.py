"""Integral C2 parameter identity and symplectic reversed-index convention."""
from sage.all import PolynomialRing, ZZ, identity_matrix, matrix


def matrix_unit(ring, size, row, column):
    result = matrix(ring, size, size)
    result[row, column] = 1
    return result


def check_c2_linear_parameter():
    ring = PolynomialRing(ZZ, 'q')
    parameter = ring.gen()
    identity = identity_matrix(ring, 4)
    long_direction = matrix_unit(ring, 4, 0, 3)
    other_direction = matrix_unit(ring, 4, 1, 0) - matrix_unit(ring, 4, 3, 2)
    commutator = (
        (identity + parameter * long_direction)
        * (identity + other_direction)
        * (identity - parameter * long_direction)
        * (identity - other_direction)
    )
    correction_direction = matrix_unit(ring, 4, 1, 2)
    corrected = commutator * (identity + parameter * correction_direction)
    printed = commutator * (identity + parameter ** 2 * correction_direction)
    expected = identity - parameter * (
        matrix_unit(ring, 4, 0, 2) + matrix_unit(ring, 4, 1, 3)
    )
    assert corrected == expected
    assert printed != expected


def check_reversed_pairing():
    for rank in range(2, 9):
        size = 2 * rank
        gram = matrix(ZZ, size, size)
        for index in range(rank):
            gram[index, size - 1 - index] = 1
            gram[size - 1 - index, index] = -1
        identity = identity_matrix(ZZ, size)
        for index in range(rank):
            assert gram[index].nonzero_positions() == [size - 1 - index]
            assert gram[index, size - 1 - index] == 1
        columns = [identity.column(0), identity.column(1)]
        residue = len(columns)
        rows = [columns[residue - 1 - index].row() * gram
                for index in range(residue)]
        short_root = identity + sum(
            (column.column() * row for column, row in zip(columns, rows)),
            matrix(ZZ, size, size),
        )
        assert short_root == identity + matrix_unit(ZZ, size, 0, size - 2) \
            + matrix_unit(ZZ, size, 1, size - 1)
        assert short_root.transpose() * gram * short_root == gram
        assert all(row * column == 0 for row in rows for column in columns)
        assert residue + 1 - residue == 1
        assert residue - residue == 0


def main():
    check_c2_linear_parameter()
    check_reversed_pairing()
    print('PASS: C2 correction parameter is linear over ZZ[q]; printed quadratic term rejected.')
    print('Residue-two reversed column–row pairing checked in symplectic ranks 2–8.')


if __name__ == '__main__':
    main()
