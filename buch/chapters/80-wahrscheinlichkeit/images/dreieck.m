#
# dreieck.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
w = 12
N = 10

rand("seed", 1);

angles = 80 * rand(1,N)
radii = 2 * rand(1,N) + 0.4
angle = 20

radii = radii * w / (cosd(angle) * sum(radii))
radius = sum(radii)
radius * cosd(angle)

points = zeros(2,N);
ray = zeros(2,N);

p = [ 0; 0 ];
for i = (1:N)
	p = p + radii(1,i) * [ cosd(angles(1,i)); sind(angles(1,i)) ];
	points(:, i) = p;
	ray(:, i) = sum(radii(1,1:i)) * [ cosd(angle); sind(angle) ];
end

points

ray

fn = fopen("drei.inc", "w");
for i = (1:N)
	fprintf(fn, "\\coordinate (A%d) at (%.4f,%.4f);\n", i,
		points(1,i), points(2,i));
	fprintf(fn, "\\coordinate (B%d) at (%.4f,%.4f);\n", i,
		ray(1,i), ray(2,i));
end
fprintf(fn, "\\def\\r{%.4f}\n", radius);
fclose(fn);
