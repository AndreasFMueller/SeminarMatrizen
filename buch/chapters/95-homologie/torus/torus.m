#
# torus.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

global n;
n = 24;
global m;
m = 12;
global R;
R = 3;
global r;
r = 1;

# Knoten, Kanten, Dreiecke
global nvertices;
nvertices = n * m;
global nedges;
nedges = 3 * nvertices;
global ntriangles;
ntriangles = 2 * nvertices;

edges = zeros(nedges, 2);
global edges;
triangles = zeros(ntriangles, 3);
global triangles;

function retval = torus(x, y)
	global n;
	global m;
	global r;
	global R;
	phi = x * 2 * pi / n;
	theta = y * 2 * pi / m;
	z = -r * sin(theta);
	x = (R + r * cos(theta)) * cos(phi);
	y = -(R + r * cos(theta)) * sin(phi);
	retval = [x, y, z];
endfunction

coordinates = zeros(nvertices, 3);
for x = (0:n-1)
	for y = (0:m-1)
		k = x + n * y;
		coordinates(k+1,:) = torus(x, y);
	endfor
endfor
coordinates

function insert_edges(ll, lr, ul, ur)
	global edges;
	k = 3 * ll + 1;
	edges(k,1) = ll;
	edges(k,2) = lr;
	edges(k+1,1) = ll;
	edges(k+1,2) = ur;
	edges(k+2,1) = ll;
	edges(k+2,2) = ul;
endfunction

function insert_triangles(ll, lr, ul, ur)
	global triangles;
	k = 2 * ll;
printf("ll=%d, k=%d\n", ll, k);
	triangles(k+1,1) = ll;
	triangles(k+1,2) = lr;
	triangles(k+1,3) = ur;
	triangles(k+2,1) = ll;
	triangles(k+2,2) = ur;
	triangles(k+2,3) = ul;
endfunction

# normal squares
for x = (0:n-2)
	for y = (0:m-2)
		ll = x + n * y;
		lr = ll + 1;
		ul = ll + n;
		ur = ul + 1;
		insert_edges(ll, lr, ul, ur);
		insert_triangles(ll, lr, ul, ur);
	endfor
endfor

# right border
x = n-1;
for y = (0:m-2)
	ll = x + n * y;
	lr = ll - (n-1);
	ul = ll + n;
	ur = lr + n;
	insert_edges(ll, lr, ul, ur);
	insert_triangles(ll, lr, ul, ur);
endfor

# top border
y = m-1;
for x = (0:n-2)
	ll = x + n * y;
	lr = ll + 1;
	ul = x;
	ur = ul + 1;
	insert_edges(ll, lr, ul, ur);
	insert_triangles(ll, lr, ul, ur);
endfor

# upper right corner
x = n-1;
y = m-1;
ll = n * m - 1;
lr = n * (m-1);
ur = 0;
ul = n - 1;
insert_edges(ll, lr, ul, ur);
insert_triangles(ll, lr, ul, ur);

edges;
triangles;

d1 = zeros(nvertices, nedges);
for i = (1:nedges)
	d1(edges(i,1) + 1, i) = -1;
	d1(edges(i,2) + 1, i) = +1;
endfor

function retval = find_edge(from, to)
	global edges;
	global nedges;
	retval = 0;
	for i = (1:nedges)
		if ((edges(i,1) == from) && (edges(i,2) == to))
			retval = i;
			printf("    test (%d,%d) == (%d,%d) -> %d\n", from, to,
				edges(i,1), edges(i,2), retval);
		elseif ((edges(i,1) == to) && (edges(i,2) == from))
			retval = -i;
			printf("    test (%d,%d) == (%d,%d) -> %d\n", from, to,
				edges(i,1), edges(i,2), retval);
		endif
	endfor
endfunction

global d2;
d2 = zeros(nedges, ntriangles);
function triangle_edge(i, pointa, pointb)
	global d2;
	edge = find_edge(pointa, pointb);
	if (edge > 0)
		d2(edge, i) = +1;
	elseif (edge < 0)
		d2(-edge, i) = -1;
	endif
endfunction

for i = (1:ntriangles)
	point1 = triangles(i,1);
	point2 = triangles(i,2);
	point3 = triangles(i,3);
	#printf("triangle %d: %d, %d, %d\n", i-1, point1, point2, point3);
	triangle_edge(i, point1, point2);
	triangle_edge(i, point2, point3);
	triangle_edge(i, point3, point1);
endfor

B = d2';

global zyklentableau
zyklentableau = rref(d1)
i=((zyklentableau != 0) .* (1:nedges));
global determined;
determined = min((i+nedges*(i==0))')';
determined = determined(1:nvertices-1,1);

function retval = is_determined(i)
	global nvertices;
	global determined;
#	printf("test i = %d\n", i);
	retval = 0;
	for k = (1:nvertices-1)
#printf("check k=%d, i=%d\n", k, i);
		if (determined(k,1) == i)
			retval = 1;
		endif
	endfor
endfunction

function retval = zyklus(i)
	global zyklentableau
	global nedges
	global nvertices
	global determined
	retval = zeros(nedges,1);
	retval(i,1) = 1;
	for j = (1:nvertices-1)
		retval(determined(j,1),1) = -zyklentableau(j,i);
	endfor
endfunction

Z = zeros(nedges, nedges - nvertices)
current = 1;
for i = (1:nedges)
	if 1 == is_determined(i)
		# printf("skipping %d\n", i);
	else
		Z(:,current) = zyklus(i);
		current = current + 1;
	endif
endfor

Z;

zh = size(Z)(2);
H = zeros(ntriangles + zh,nedges);
H(1:ntriangles,:) = B;
H((ntriangles+1):(ntriangles+zh),:) = Z';

H;
size(H)

rref(B');

function retval = pivotindex(zeile)
	w = size(zeile)(2);
	for k = (1:w)
		if (zeile(1,k) != 0)
			retval = k;
			return;
		endif
	endfor
	retval = 0;
endfunction

h = size(H)(1)
w = size(H)(2)
j = 1;

for i = (1:h-1)
	j = pivotindex(H(i,:));
	printf("reduction for i = %d, j = %d\n", i, j);
	if (j != 0) 
		# find pivot index
		pivot = H(i,j);
		if (pivot != 0)
			H(i,:) = H(i,:) / pivot;
			for k = ((i+1):h)
				H(k,:) = H(k,:) - H(k,j) * H(i,:);
			endfor
		endif
	endif
endfor
H;

Hbasis = zeros(2,nedges);
current = 1;
for i = ((ntriangles+1):h)
	if norm(H(i,:)) > 0
		Hbasis(current,:) = H(i,:)
		current = current + 1;
	endif
endfor
#size(Hbasis)
#nedges
#Hbasis
#Hbasis(1,nedges-2)=0;
#Hbasis(1,nedges-1)=1;
Hbasis

edges(71,:)
coordinates

fn = fopen("torus.inc", "w");

# torusflaeche

fprintf(fn, "#macro torusflaeche()\n");
fprintf(fn, "    mesh {\n");
for k = (1:ntriangles)
	fprintf(fn, "\ttriangle { ");
	punkt1 = coordinates(triangles(k,1)+1,:);
	punkt2 = coordinates(triangles(k,2)+1,:);
	punkt3 = coordinates(triangles(k,3)+1,:);
	fprintf(fn, "<%.4f,%.4f,%.4f>, ", punkt1(1,1), punkt1(1,3), punkt1(1,2));
	fprintf(fn, "<%.4f,%.4f,%.4f>, ", punkt2(1,1), punkt2(1,3), punkt2(1,2));
	fprintf(fn, "<%.4f,%.4f,%.4f> }\n", punkt3(1,1), punkt3(1,3), punkt3(1,2));
endfor
fprintf(fn, "    }\n")
fprintf(fn, "#end\n");

fprintf(fn, "#macro zyklus1()\n");
fprintf(fn, "    union {\n");
for i = (1:nedges)
	h = Hbasis(1,i);
	if h != 0
		if h > 0
			punkt1 = coordinates(edges(i,1)+1,:);
printf("i=%d\n", i);
			punkt2 = coordinates(edges(i,2)+1,:);
		else
			punkt2 = coordinates(edges(i,1)+1,:);
			punkt1 = coordinates(edges(i,2)+1,:);
		endif
		fprintf(fn, "\tcylinder { ");
		fprintf(fn, "<%.4f,%.4f,%.4f>, ", punkt1(1,1), punkt1(1,3), punkt1(1,2));
		fprintf(fn, "<%.4f,%.4f,%.4f>, r }\n", punkt2(1,1), punkt2(1,3), punkt2(1,2));
		fprintf(fn, "\tsphere { <%.4f,%.4f,%.4f>, r }\n", punkt1(1,1), punkt1(1,3), punkt1(1,2));
	endif
endfor
fprintf(fn, "    }\n");
fprintf(fn, "#end\n");

fprintf(fn, "#macro zyklus2()\n");
fprintf(fn, "    union {\n");
for i = (1:nedges)
	h = Hbasis(2,i);
	if h != 0
		if h > 0
			punkt1 = coordinates(edges(i,1)+1,:);
			punkt2 = coordinates(edges(i,2)+1,:);
		else
			punkt2 = coordinates(edges(i,1)+1,:);
			punkt1 = coordinates(edges(i,2)+1,:);
		endif
		fprintf(fn, "\tcylinder { ");
		fprintf(fn, "<%.4f,%.4f,%.4f>, ", punkt1(1,1), punkt1(1,3), punkt1(1,2));
		fprintf(fn, "<%.4f,%.4f,%.4f>, r }\n", punkt2(1,1), punkt2(1,3), punkt2(1,2));
		fprintf(fn, "\tsphere { <%.4f,%.4f,%.4f>, r }\n", punkt1(1,1), punkt1(1,3), punkt1(1,2));
	endif
endfor
fprintf(fn, "    }\n");
fprintf(fn, "#end\n");

fclose(fn);

