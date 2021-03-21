#
# kernbild.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

rand("seed", 1291)
rand("seed", 4711)

lambda1 = 1;
lambda2 = 1.8;

A = [
	lambda1,  0,  0;
	0,  lambda2,  1;
	0,  0, lambda2
];

B = eye(3) + rand(3,3);
det(B)


C = B*A*inverse(B)
rank(C)

# Eigenwert lambda1
E2 = C - lambda1 * eye(3)
rref(E2)

# Eigenwert lambda2, k = 1
E1 = C - lambda2 * eye(3)
D = rref(E1);
K1 = [
	-D(1,3);
	-D(2,3);
	1
];
K1(:,1) = K1(:,1) / norm(K1(:,1));
K1

f = fopen("JK.inc", "w");
fprintf(f, "//\n// JK.inc\n//\n// (c) 2021 Prof Dr Andreas Müller\n//\n\n");
fprintf(f, "// Kern und Bild von C - %.3f I\n", lambda2);
fprintf(f, "#declare k11 = < %.5f, %.5f, %.5f>;\n", K1(1,1), K1(2,1), K1(3,1));
fprintf(f, "#declare j11 = < %.5f, %.5f, %.5f>;\n", E1(1,1), E1(2,1), E1(3,1));
fprintf(f, "#declare j12 = < %.5f, %.5f, %.5f>;\n", E1(1,2), E1(2,2), E1(3,2));
fprintf(f, "\n");

# k = 2
E12 = E1 * E1
D = rref(E12);
K2 = [
	-D(1,2), -D(1,3);
	      1,       0;
	      0,       1
]
K2(:,1) = K2(:,1) / norm(K2(:,1));
K2(:,2) = K2(:,2) / norm(K2(:,2));
K2

fprintf(f, "// Kern und Bild von (C - %.3f I)^2\n", lambda2);
fprintf(f, "#declare k21 = < %.5f, %.5f, %.5f>;\n", K2(1,1), K2(2,1), K2(3,1));
fprintf(f, "#declare k22 = < %.5f, %.5f, %.5f>;\n", K2(1,2), K2(2,2), K2(3,2));
fprintf(f, "#declare j21 = < %.5f, %.5f, %.5f>;\n", E12(1,1), E12(2,1), E12(3,1));
fprintf(f, "\n");

fclose(f);

# Verifikation
x = K2 \ K1
K2 * x

eig(C)

[U, S, V] = svd(C)


s = rand("seed")

