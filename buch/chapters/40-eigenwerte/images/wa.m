#
# wa.m -- Wurzelapproximation
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
global u;
global N;
global t;
global s;

N = 100;
n = 10;
s = 1;

u = zeros(N + 2, n);
t = (0:N+1)' / N;
t = t.^2;

for i = (2:n)
	u(:,i) = u(:,i-1) + 0.5 * (t-u(:,i-1).^2);
end

u

global f;
f = fopen("wa.tex", "w");
fprintf(f, "%%\n");
fprintf(f, "%% Approximation der Wurzelfunktion\n");
fprintf(f, "%%\n");

function pfad(i, name)
	global f;
	global u;
	global t;
	global N;
	fprintf(f, "\\def\\pfad%s{\n", name);
	fprintf(f, "(%.4f,%.4f)\n", t(1,1), u(1,i));
	for j = (2:N+1)
		fprintf(f, "--(%.4f,%.4f)\n", t(j,1), u(j,i));
	end
	fprintf(f, "}\n");
end

pfad( 1, "a")
pfad( 2, "b")
pfad( 3, "c")
pfad( 4, "d")
pfad( 5, "e")
pfad( 6, "f")
pfad( 7, "g")
pfad( 8, "h")
pfad( 9, "i")
pfad(10, "j")

function fehler(i, name)
	global f;
	global u;
	global t;
	global N;
	global s;
	fprintf(f, "\\def\\fehler%s{\n", name);
	fprintf(f, "(%.4f,%.4f)\n", t(1,1), s*(sqrt(t(1,1))-u(1,i)));
	for j = (2:N+2)
		fprintf(f, "--(%.4f,%.4f)\n", t(j,1), s*(sqrt(t(j,1))-u(j,i)));
	end
	fprintf(f, "}\n");
end

fehler( 1, "a")
fehler( 2, "b")
fehler( 3, "c")
fehler( 4, "d")
fehler( 5, "e")
fehler( 6, "f")
fehler( 7, "g")
fehler( 8, "h")
fehler( 9, "i")
fehler(10, "j")

fclose(f);
