#
# interpolation.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
global N;
N = 50;
global A;
global B;

A = (pi / 2) * [
  0, 0,  0;
  0, 0, -1;
  0, 1,  0
];
g0 = expm(A)

B = (pi / 2) * [
  0, 0, 1;
  0, 0, 0;
 -1, 0, 0
];
g1 = expm(B)

function retval = g(t)
	global A;
	global B;
	retval = expm((1-t)*A+t*B);
endfunction

function dreibein(fn, M, funktion)
	fprintf(fn, "%s(<%.4f,%.4f,%.4f>, <%.4f,%.4f,%.4f>, <%.4f,%.4f,%.4f>)\n",
		funktion,
		M(1,1), M(3,1), M(2,1),
		M(1,2), M(3,2), M(2,2),
		M(1,3), M(3,3), M(2,3));
endfunction

G = g1 * inverse(g0);
[V, lambda] = eig(G);
H = real(V(:,3));

D = logm(g1*inverse(g0));

for i = (0:N)
	filename = sprintf("dreibein/d%03d.inc", i);
	fn = fopen(filename, "w");
	t = i/N;
	dreibein(fn, g(t), "quadrant");
	dreibein(fn, expm(t*D)*g0, "drehung");
	fprintf(fn, "achse(<%.4f,%.4f,%.4f>)\n", H(1,1), H(3,1), H(2,1));
	fclose(fn);
endfor

