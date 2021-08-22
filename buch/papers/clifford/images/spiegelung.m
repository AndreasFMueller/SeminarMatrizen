#
# spiegelung.m
#
#
fn = fopen("punkte.tex", "w");


a = [ 2.3; 1.7 ];
b = [ 4.3; 2.5 ];
c = [ 2.8; 2.7 ];
s = (a + b + c)/3;

fprintf(fn, "\\coordinate (A) at (%.3f,%.3f);\n", a(1, 1), a(2, 1));
fprintf(fn, "\\coordinate (B) at (%.3f,%.3f);\n", b(1, 1), b(2, 1));
fprintf(fn, "\\coordinate (C) at (%.3f,%.3f);\n", c(1, 1), c(2, 1));
fprintf(fn, "\\coordinate (S) at (%.3f,%.3f);\n", s(1, 1), s(2, 1));

n1 = [ -2.5; 1.4 ];
n1 = n1 / norm(n1);
S1 = eye(2) - 2 * (n1 * n1');
g1 = [ n1(2,1); -n1(1,1) ];

fprintf(fn, "\\coordinate (G1) at (%.3f,%.3f);\n", g1(1,1), g1(2,1));
fprintf(fn, "\\coordinate (G1oben) at (%.3f,%.3f);\n", 10*g1(1,1), 10*g1(2,1));
fprintf(fn, "\\coordinate (G1unten) at (%.3f,%.3f);\n", -10*g1(1,1), -10*g1(2,1));

n2 = [ 1.4; 0.5 ];
n2 = n2 / norm(n2);
S2 = eye(2) - 2 * (n2 * n2');
g2 = [ n2(2,1); -n2(1,1) ];

fprintf(fn, "\\coordinate (G2) at (%.3f,%.3f);\n", g2(1,1), g2(2,1));
fprintf(fn, "\\coordinate (G2oben) at (%.3f,%.3f);\n", 10*g2(1,1), 10*g2(2,1));
fprintf(fn, "\\coordinate (G2unten) at (%.3f,%.3f);\n", -10*g2(1,1), -10*g2(2,1));

D = S2 * S1;

a1 = S1 * a;
b1 = S1 * b;
c1 = S1 * c;
s1 = S1 * s;

fprintf(fn, "\\coordinate (A1) at (%.3f,%.3f);\n", a1(1, 1), a1(2, 1));
fprintf(fn, "\\coordinate (B1) at (%.3f,%.3f);\n", b1(1, 1), b1(2, 1));
fprintf(fn, "\\coordinate (C1) at (%.3f,%.3f);\n", c1(1, 1), c1(2, 1));
fprintf(fn, "\\coordinate (S1) at (%.3f,%.3f);\n", s1(1, 1), s1(2, 1));

a2 = D * a;
b2 = D * b;
c2 = D * c;
s2 = D * s;

fprintf(fn, "\\coordinate (A2) at (%.3f,%.3f);\n", a2(1, 1), a2(2, 1));
fprintf(fn, "\\coordinate (B2) at (%.3f,%.3f);\n", b2(1, 1), b2(2, 1));
fprintf(fn, "\\coordinate (C2) at (%.3f,%.3f);\n", c2(1, 1), c2(2, 1));
fprintf(fn, "\\coordinate (S2) at (%.3f,%.3f);\n", s2(1, 1), s2(2, 1));

winkel1 = atan2(g1(2,1), g1(1,1)) * (180 / pi);
winkel2 = acosd(g1' * g2);

fprintf(fn, "\\def\\winkela{%.4f}\n", winkel1);
fprintf(fn, "\\def\\winkelb{%.4f}\n", 180 - winkel2);

fprintf(fn, "\\coordinate (G) at (%.3f,%.3f);\n", g1(1,1), g1(2,1));

fclose(fn);
