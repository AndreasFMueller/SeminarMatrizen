#
# diffusion.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
e1 = [ 1; 0; 0; 0; 0; 0 ];
A = 0.8*eye(6) + 0.1*shift(eye(6),1) + 0.1*shift(eye(6),-1);
A(1,1) = 0.9;
A(6,6) = 0.9;
A(1,6) = 0;
A(6,1) = 0;

N = 30;
b = zeros(6,N);
b(:,1) = e1;
for i = (2:N)
	b(:,i) = A * b(:,i-1);
end
b

f = fopen("vektoren.inc", "w");
for i = (1:N)
	fprintf(f, "vektor(%d,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f)\n", i,
		b(1,i), b(2,i), b(3,i), b(4,i), b(5,i), b(6,i))
end
fclose(f);

A1=A
A2=A*A
A3=A*A2
A4=A*A3
A5=A*A4
A6=A*A5
