//
// rodriguez.pov
//
// (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "colors.inc"

global_settings {
	assumed_gamma 1
}

#declare imagescale = 0.020;
#declare O = <0, 0, 0>;
#declare at = 0.015;

camera {
	location <8, 15, -50>
	look_at <0.1, 0.475, 0>
	right 16/9 * x * imagescale
	up y * imagescale
}

light_source {
	<-4, 20, -50> color White
	area_light <1,0,0> <0,0,1>, 10, 10
	adaptive 1
	jitter
}

sky_sphere {
	pigment {
		color rgb<1,1,1>
	}
}

#macro arrow(from, to, arrowthickness, c)
#declare arrowdirection = vnormalize(to - from);
#declare arrowlength = vlength(to - from);
union { 
	sphere {
		from, 1.1 * arrowthickness
	}
	cylinder {
		from,
		from + (arrowlength - 5 * arrowthickness) * arrowdirection,
		arrowthickness
	}
	cone {  
		from + (arrowlength - 5 * arrowthickness) * arrowdirection,
		2 * arrowthickness,
		to,
		0
	}
	pigment {
		color c
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

#declare K = vnormalize(<0.2,1,0.1>);
#declare X = vnormalize(<1.1,1,-1.2>);
#declare O = <0,0,0>;

#declare r = vlength(vcross(K, X)) / vlength(K);

#declare l = 1.0;

arrow(< -l,  0,  0 >, < l, 0, 0 >, at, White)
arrow(<  0,  0, -l >, < 0, 0, l >, at, White)
arrow(<  0, -l,  0 >, < 0, l, 0 >, at, White)

arrow(O, X, at, Red)
arrow(O, K, at, Blue)

#macro punkt(H,phi)
	((H-vdot(K,H)*K)*cos(phi) + vcross(K,H)*sin(phi) + vdot(K,X)*K)
#end

cone { vdot(K, X) * K, r, O, 0
	pigment {
		color rgbt<0.6,0.6,0.6,0.5>
	}
	finish {
		specular 0.9
		metallic
	}
}


union {
	#declare phistep = pi / 100;
	#declare phi = 0;
	#while (phi < 2 * pi - phistep/2) 
		sphere { punkt(K, phi), at/2 }
		cylinder {
			punkt(X, phi),
			punkt(X, phi + phistep),
			at/2
		}
		#declare phi = phi + phistep;
	#end
	pigment {
		color Orange
	}
	finish {
		specular 0.9
		metallic
	}
}

arrow(vdot(K,X)*K, punkt(X, 0), at, Yellow)
#declare Darkgreen = rgb<0,0.5,0>;
arrow(vdot(K,X)*K, punkt(X, pi/2), at, Darkgreen)
