#
# spbeispiel.m
#
# (c) 2020 Prof Dr Andreas Müller, Hochschule Rapperswil
#
N = 30
R = 0.05 * rand(N,N);
R = R + R';
A = eye(N) + R;
L = tril(A,-1)
U = tril(A',-1)'
D = diag(diag(A))

A

function r = spektralradius(A)
	r = max(abs(eig(A)));
end

gaussseidel = spektralradius(inverse(L+D)*U)
jacobi = spektralradius(inverse(D)*(L+U))
richardson = spektralradius(A - eye(N))

fd = fopen("sppaths.tex", "w");

fprintf(fd, "\\def\\richardson{\n")
tau = 0.1;
r = spektralradius((1/tau) * A - eye(N))
fprintf(fd, "\\draw[line width=1.4pt,color=red] ({\\sx*0.1},{\\sy*%.5f})", r);
for tau = (11:300) / 100
	r = spektralradius((1/tau) * A - eye(N));
	fprintf(fd, "\n--({\\sx*%.5f},{\\sy*%.5f})", tau, r);
end
fprintf(fd, "\n;}\n");

fprintf(fd, "\\def\\sor{\n");
omega = 1/100
B = (1/omega) * D + L;
C = (1-1/omega) * D + U;
r = spektralradius(inverse(B) * C)
fprintf(fd, "\\draw[line width=1.4pt,color=red] ({\\sx*%.3f},{\\sy*%.3f})", omega, r);
for omega = (2:200) / 100
	B = (1/omega) * D + L;
	C = (1-1/omega) * D + U;
	r = spektralradius(inverse(B) * C);
	fprintf(fd, "\n--({\\sx*%.5f},{\\sy*%.5f})", omega, r);
end
fprintf(fd, ";\n}\n");

fclose(fd);

