#
# ev.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

L = [
    2, -1,  0, -1,  0;
   -1,  4, -1, -1, -1;
    0, -1,  2,  0, -1;
   -1, -1,  0,  3, -1;
    0, -1, -1, -1,  3
];

[v, lambda] = eig(L);

function knoten(fn, wert, punkt)
	if (wert > 0) 
		farbe = sprintf("red!%02d", round(100 * wert));
	else
		farbe = sprintf("blue!%02d", round(-100 * wert));
	end
	fprintf(fn, "\t\\fill[color=%s] %s circle[radius=0.25];\n",
		farbe, punkt);
	fprintf(fn, "\t\\draw %s circle[radius=0.25];\n", punkt);
endfunction

function vektor(fn, v, name, lambda)
	fprintf(fn, "\\def\\%s{\n", name);
	fprintf(fn, "\t\\coordinate (A) at ({0*\\a},0);\n");
	fprintf(fn, "\t\\coordinate (B) at ({1*\\a},0);\n");
	fprintf(fn, "\t\\coordinate (C) at ({2*\\a},0);\n");
	fprintf(fn, "\t\\coordinate (D) at ({0.5*\\a},{-\\b});\n");
	fprintf(fn, "\t\\coordinate (E) at ({1.5*\\a},{-\\b});\n");
	fprintf(fn, "\t\\draw (A) -- (B);\n");
	fprintf(fn, "\t\\draw (A) -- (D);\n");
	fprintf(fn, "\t\\draw (B) -- (C);\n");
	fprintf(fn, "\t\\draw (B) -- (D);\n");
	fprintf(fn, "\t\\draw (B) -- (E);\n");
	fprintf(fn, "\t\\draw (C) -- (E);\n");
	fprintf(fn, "\t\\draw (D) -- (E);\n");
	fprintf(fn, "\t\\node at (-2.8,{-0.5*\\b}) [right] {$\\lambda=%.4f$};\n",
		round(1000 * abs(lambda)) / 10000);
	w = v / max(abs(v));
	knoten(fn, w(1,1), "(A)");
	knoten(fn, w(2,1), "(B)");
	knoten(fn, w(3,1), "(C)");
	knoten(fn, w(4,1), "(D)");
	knoten(fn, w(5,1), "(E)");
	fprintf(fn, "}\n");
endfunction

function punkt(fn, x, wert)
	fprintf(fn, "({%.4f*\\c},{%.4f*\\d})", x, wert);
endfunction

function funktion(fn, v, name, lambda)
	fprintf(fn, "\\def\\%s{\n", name);
	fprintf(fn, "\t\\draw[color=red,line width=1.4pt]\n\t\t");
	punkt(fn, -2, v(1,1));
	fprintf(fn, " --\n\t\t");
	punkt(fn, -1, v(4,1));
	fprintf(fn, " --\n\t\t");
	punkt(fn, 0, v(2,1));
	fprintf(fn, " --\n\t\t");
	punkt(fn, 1, v(5,1));
	fprintf(fn, " --\n\t\t");
	punkt(fn, 2, v(3,1));
	fprintf(fn, ";\n");
	fprintf(fn, "\t\\draw[->] ({-2.1*\\c},0) -- ({2.1*\\c},0);\n");
	fprintf(fn, "\t\\draw[->] (0,{-1.1*\\d}) -- (0,{1.1*\\d});\n");
	for x = (-2:2)
		fprintf(fn, "\t\\fill ({%d*\\c},0) circle[radius=0.05];\n", x);
	endfor
	fprintf(fn, "}\n");
endfunction

fn = fopen("vektoren.tex", "w");

vektor(fn, v(:,1), "vnull", lambda(1,1));
funktion(fn, v(:,1), "fnull", lambda(1,1));

vektor(fn, v(:,2), "vone", lambda(2,2));
funktion(fn, v(:,2), "fone", lambda(2,2));

vektor(fn, v(:,3), "vtwo", lambda(3,3));
funktion(fn, v(:,3), "ftwo", lambda(3,3));

vektor(fn, v(:,4), "vthree", lambda(4,4));
funktion(fn, v(:,4), "fthree", lambda(4,4));

vektor(fn, v(:,5), "vfour", lambda(5,5));
funktion(fn, v(:,5), "ffour", lambda(5,5));

fclose(fn);


