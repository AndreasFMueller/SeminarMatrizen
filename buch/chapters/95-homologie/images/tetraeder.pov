//
// tetraeder.pov
//
// (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "colors.inc"

global_settings {
	assumed_gamma 1
}

#declare imagescale = 0.169;
#declare O = <0, 0, 0>;
#declare at = 0.02;

camera {
	location <-2, 3, -10>
	look_at <0, 0.18, 0>
	right 16/9 * x * imagescale
	up y * imagescale
}

//light_source {
//      <-14, 20, -50> color White
//      area_light <1,0,0> <0,0,1>, 10, 10
//      adaptive 1
//      jitter
//}

light_source {
	<-41, 20, -20> color White
	area_light <1,0,0> <0,0,1>, 10, 10
	adaptive 1
	jitter
}

sky_sphere {
	pigment {
		color rgb<1,1,1>
	}
}

#declare v1 = <1,1,1>;
#declare v2 = <-1,1,-1>;
#declare farbe = rgbf<0.8,0.8,1.0,0.5>;

#declare tetraederwinkel = acos(vdot(v1,v2)/(vlength(v1)*vlength(v2)));

#declare O = < 0, 0, 0 >;
#declare A = < 0, 1, 0 >;
#declare B = < sin(tetraederwinkel), cos(tetraederwinkel), 0>;
#declare C = < sin(tetraederwinkel)*cos(2*pi/3), cos(tetraederwinkel),  sin(2*pi/3)>;
#declare D = < sin(tetraederwinkel)*cos(2*pi/3), cos(tetraederwinkel), -sin(2*pi/3)>;

#macro arrow(from, to, arrowthickness, c)
#declare arrowdirection = vnormalize(to - from);
#declare arrowlength = vlength(to - from);
union {
	sphere {
		from, 1.0 * arrowthickness
	}
	cylinder {
		from,
		from + (arrowlength - 8 * arrowthickness) * arrowdirection,
		arrowthickness
	}
	cone {
		from + (arrowlength - 8 * arrowthickness) * arrowdirection,
		2 * arrowthickness,
		to - 3 * arrowthickness * arrowdirection,
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

union {
	arrow(B, C, at, White)
	arrow(D, C, at, White)
	arrow(D, B, at, White)
	arrow(B, A, at, White)
	arrow(C, A, at, White)
	arrow(D, A, at, White)
	sphere { A, 4 * at }
	sphere { B, 4 * at }
	sphere { C, 4 * at }
	sphere { D, 4 * at }
	pigment {
		color White
	}
	finish {
		specular 0.9
		metallic
	}
}

mesh {
	triangle { A, B, C }
	triangle { A, C, D }
	triangle { A, D, B }
	triangle { B, C, D }
	pigment {
		color farbe
	}
//	finish {
//		specular 0.9
//		metallic
//	}
}
