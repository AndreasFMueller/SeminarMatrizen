#
# approx.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
x = zeros(7,7);
y = zeros(7,7);

s = 1.05;

for i = (1:7)
	winkel = (i-1) * 8.333333 + 20;
	for j = (1:7)
		radius = (j-1) * 0.5 + 3;
		x(i,j) = 1.05 * radius * cosd(winkel);
		y(i,j) = 1.05 * radius * sind(winkel);
	endfor
endfor

X = x;
Y = y;
for i = (1:7)
	for j = (1:7)
		X(i,j) = round(2 * x(i,j)) / 2;
		Y(i,j) = round(2 * y(i,j)) / 2;
	endfor
endfor

fn = fopen("approx.tex", "w");


for i = (1:6)
	for j = (1:6)
		winkel = (i-1+0.6666) * 8.33333 + 20;
		radius = (j-1+0.3333) * 0.5 + 3;
		fprintf(fn, "\\definecolor{mycolor}{rgb}{%.2f,%.2f,%.2f};\n",
			(winkel - 20) / 50, 0.8, (radius-3)/3);
		fprintf(fn, "\\fill[color=mycolor] (%.3f,%.3f) -- (%.3f,%.3f) -- (%.3f,%.3f) -- cycle;\n",
			X(i,j), Y(i,j),
			X(i+1,j+1), Y(i+1,j+1),
			X(i+1,j), Y(i+1,j));
		winkel = (i-1+0.3333) * 8.33333 + 20;
		radius = (j-1+0.6666) * 0.5 + 3;
		fprintf(fn, "\\definecolor{mycolor}{rgb}{%.2f,%.2f,%.2f};\n",
			(winkel - 20) / 50, 0.8, (radius-3)/3);
		fprintf(fn, "\\fill[color=mycolor] (%.3f,%.3f) -- (%.3f,%.3f) -- (%.3f,%.3f) -- cycle;\n",
			X(i,j), Y(i,j),
			X(i,j+1), Y(i,j+1),
			X(i+1,j+1), Y(i+1,j+1));
	endfor
endfor

linewidth = 0.4;

fprintf(fn, "\\gitter\n");
	
for i = (1:7)
	for j = (1:6)
		fprintf(fn, "\\draw[color=darkred,line width=%.1fpt] (%.3f,%.3f) -- (%.3f,%.3f);\n", linewidth,
			X(i,j), Y(i,j), X(i,j+1), Y(i,j+1));
	endfor
endfor
for i = (1:6)
	for j = (1:7)
		fprintf(fn, "\\draw[color=darkred,line width=%.1fpt] (%.3f,%.3f) -- (%.3f,%.3f);\n", linewidth,
			X(i,j), Y(i,j), X(i+1,j), Y(i+1,j));
	endfor
endfor
for i = (1:6)
	for j = (1:6)
		fprintf(fn, "\\draw[color=darkred,line width=%.1fpt] (%.3f,%.3f) -- (%.3f,%.3f);\n", linewidth,
			X(i,j), Y(i,j), X(i+1,j+1), Y(i+1,j+1));
	endfor
endfor

fclose(fn)

