#
# 4003.m
#
# (c) 2020 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

A = [
  -13,   5, -29,  29;
  -27,  11, -51,  51;
   -3,   1,  -2,   5;
   -6,   2, -10,  13
];

eig(A)


lambda = 2
B = A - lambda*eye(4)
rref(B)

D = B*B*B*B

lambda = 3
B = A - lambda*eye(4)
rref(B)

D = B*B*B*B

b1 = [0;0;1;1]
b2 = [1;0;0;0]
b3 = [0;1;0;0]
b4 = [0;0;1;2]

T = zeros(4,4);
T(:,1) = b1;
T(:,2) = b2;
T(:,3) = b3;
T(:,4) = b4;

AA = inverse(T)*A*T

A1 = AA(2:4,2:4)
B1 = A1 - 2*eye(3)
B1 * B1
B1 * B1 * B1

c30 = [ 0; 1; 3; 1 ]

c3 = T*c30

lambda=2
B=A-lambda*eye(4)
c2=B*c3
c1=B*c2

T = zeros(4,4);
T(:,1) = [0;0;1;1]
T(:,2) = c1;
T(:,3) = c2;
T(:,4) = c3
det(T)
inverse(T)
det(T)*inverse(T)

inverse(T)*A*T

