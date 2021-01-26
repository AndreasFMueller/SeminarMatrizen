#
# positiv.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
N = 10;
p = 0.2;

A = eye(3) + p * rand(3,3);
A = [
 1, 0.2, 0.2;
 0.1, 1, 0.1;
 0.05, 0.05, 1
];
B = eye(3);

function retval = punkt(x)
	retval = sprintf("<%.4f,%.4f,%.4f>", x(1), x(3), x(2));
end

fn = fopen("quadrant.inc", "w");
for i = (1:N)
	fprintf(fn, "quadrant(%s,%s,%s)\n",
		punkt(B(:,1)), punkt(B(:,2)), punkt(B(:,3)))
	B = B * A;
end

x = [ 1; 1; 1 ];
for i = (1:100)
	x = A * x;
	x = x / norm(x);
end
fprintf(fn, "eigenvektor(<%.4f, %.4f, %.4f>)\n", x(1), x(3), x(2));


fclose(fn);
