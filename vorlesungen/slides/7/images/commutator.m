#
# commutator.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

X = [
	0, 0,  0;
	0, 0, -1;
	0, 1,  0
];

Y = [
	 0, 0, 1;
	 0, 0, 0;
	-1, 0, 0
];

Z = [
	0, -1, 0;
	1,  0, 0;
	0,  0, 0
];

function retval = Dx(alpha)
	retval = [
		1, 0,           0         ;
		0, cos(alpha), -sin(alpha);
		0, sin(alpha),  cos(alpha)
	];
end

function retval = Dy(beta)
	retval = [
		 cos(beta), 0, sin(beta);
		 0,         1, 0        ;
		-sin(beta), 0, cos(beta)
	];
end

t = 0.9;
P = Dx(t) * Dy(t)
Q = Dy(t) * Dx(t)
P - Q
(P - Q) * [0;0;1]

function	retval = kurven(filename, t)
	retval = -1;
	N = 20;
	fn = fopen(filename, "w");
	fprintf(fn, "//\n");
	fprintf(fn, "// %s\n", filename);
	fprintf(fn, "//\n");
	fprintf(fn, "#macro XYkurve()\n");
	for i = (0:N-1)
		v1 = Dx(t * i / N) * [0;0;1];
		v2 = Dx(t * (i+1) / N) * [0;0;1];
		fprintf(fn, "sphere { <%.4f,%.4f,%.4f>, at }\n",
			v1(1,1), v1(3,1), v1(2,1));
		fprintf(fn, "cylinder { <%.4f,%.4f,%.4f>, <%.4f, %.4f, %.4f>, at }\n",
			v1(1,1), v1(3,1), v1(2,1), v2(1,1), v2(3,1), v2(2,1));
	end
	for i = (0:N-1)
		v1 = Dx(t) * Dy(t * i / N) * [0;0;1];
		v2 = Dx(t) * Dy(t * (i+1) / N) * [0;0;1];
		fprintf(fn, "sphere { <%.4f,%.4f,%.4f>, at }\n",
			v1(1,1), v1(3,1), v1(2,1));
		fprintf(fn, "cylinder { <%.4f,%.4f,%.4f>, <%.4f, %.4f, %.4f>, at }\n",
			v1(1,1), v1(3,1), v1(2,1), v2(1,1), v2(3,1), v2(2,1));
	end
	fprintf(fn, "sphere { <%.4f,%.4f,%.4f>, at }\n",
		v2(1,1), v2(3,1), v2(2,1));
	fprintf(fn, "#end\n");
	fprintf(fn, "#declare finalXY = <%.4f, %.4f, %.4f>;\n",
		v2(1,1), v2(3,1), v2(2,1));
	fprintf(fn, "#macro YXkurve()\n");
	for i = (0:N-1)
		v1 = Dy(t * i / N) * [0;0;1];
		v2 = Dy(t * (i+1) / N) * [0;0;1];
		fprintf(fn, "sphere { <%.4f,%.4f,%.4f>, at }\n",
			v1(1,1), v1(3,1), v1(2,1));
		fprintf(fn, "cylinder { <%.4f,%.4f,%.4f>, <%.4f, %.4f, %.4f>, at }\n",
			v1(1,1), v1(3,1), v1(2,1), v2(1,1), v2(3,1), v2(2,1));
	end
	for i = (0:N-1)
		v1 = Dy(t) * Dx(t * i / N) * [0;0;1];
		v2 = Dy(t) * Dx(t * (i+1) / N) * [0;0;1];
		fprintf(fn, "sphere { <%.4f,%.4f,%.4f>, at }\n",
			v1(1,1), v1(3,1), v1(2,1));
		fprintf(fn, "cylinder { <%.4f,%.4f,%.4f>, <%.4f, %.4f, %.4f>, at }\n",
			v1(1,1), v1(3,1), v1(2,1), v2(1,1), v2(3,1), v2(2,1));
	end
	fprintf(fn, "sphere { <%.4f,%.4f,%.4f>, at }\n",
		v2(1,1), v2(3,1), v2(2,1));
	fprintf(fn, "#end\n");
	fprintf(fn, "#declare finalYX = <%.4f, %.4f, %.4f>;\n",
		v2(1,1), v2(3,1), v2(2,1));

	fclose(fn);
	retval = 0;
end

function	retval = kurve(i)
	n = pi / 180;
	filename = sprintf("f/%04d.inc", i);
	kurven(filename, n * i);
end

for i = (1:60)
	kurve(i);
end
