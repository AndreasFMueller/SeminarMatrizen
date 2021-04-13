//
// common.inc
//
// (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "colors.inc"

global_settings {
	assumed_gamma 1
}

#declare imagescale = 0.025;
#declare O = <0, 0, 0>;
#declare at = 0.015;

camera {
	location <18, 15, -50>
	look_at <0.0, 0.5, 0>
	right 16/9 * x * imagescale
	up y * imagescale
}

light_source {
	<-40, 30, -50> color White
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

#declare l = 1.2;

arrow(< -l,  0,  0 >, < l, 0, 0 >, at, White)
arrow(<  0,  0, -l >, < 0, 0, l >, at, White)
arrow(<  0, -l,  0 >, < 0, l, 0 >, at, White)

