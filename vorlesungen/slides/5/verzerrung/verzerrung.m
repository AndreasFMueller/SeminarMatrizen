#
# verzerrung.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

rand("seed", 4712);

A = eye(2) + 1.0 * (rand(2,2) - 0.5 * ones(2,2))

[V, lambda] = eig(A)

B = A - lambda(1,1) * eye(2)
