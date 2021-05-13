#
# wilf.m -- chromatische Zahl für einen Graphen
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
N = 9;
A = zeros(N,N);

for i = (1:N)
	j = 1 + rem(i, N)
	A(i,j) = 1;
endfor
for i = (1:3:N-3)
	j = 1 + rem(i + 2, N)
	A(i,j) = 1;
endfor

A(1,3) = 1;

A = A + A'

eig(A)
