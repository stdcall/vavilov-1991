"""§11: test the printed three-factor ESD identity in a split 6-space."""
from sage.all import PolynomialRing, QQ, block_matrix, identity_matrix, vector, zero_matrix


def main():
    ring = PolynomialRing(QQ, names=('eta', 'zeta', 'theta'))
    eta, zeta, theta = ring.gens()
    unit = identity_matrix(ring, 3)
    zero = zero_matrix(ring, 3)
    form = block_matrix([[zero, unit], [unit, zero]])
    basis = identity_matrix(ring, 6)
    u, v, w = (vector(ring, basis.row(i)) for i in range(3))
    assert all(a * form * b == 0 for a in (u, v, w) for b in (u, v, w))

    def esd(a, b, coefficient):
        return basis + coefficient * (a.column() * b.row() - b.column() * a.row()) * form

    product = esd(u, v, eta) * esd(u, w, zeta) * esd(v, w, theta)
    assert product.transpose() * form * product == form
    assert product.det() == 1
    x = u + v + w
    y = ((eta + zeta - theta) * u + (eta - zeta + theta) * v
         + (-eta + zeta + theta) * w) / 2
    printed = esd(x, y, ring.one())
    assert printed == esd(u, v, theta - zeta) * esd(u, w, theta - eta) * esd(v, w, zeta - eta)
    specialization = {eta: QQ.one(), zeta: QQ.zero(), theta: QQ.zero()}
    assert product.subs(specialization) != printed.subs(specialization)
    print('Split O6 over QQ, η=1 and ζ=θ=0: printed three-factor ESD formula fails.')


if __name__ == '__main__':
    main()
