#
# matrix.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

n = 4
N = 20;

d = 0;
while d == 0
	A = round(N * rand(n,n));
	B = mod(A, 2);
	d = det(B);
	d = mod(d, 2);
	d = d * B(1,1);
end
A
det(A)
B
det(B)
