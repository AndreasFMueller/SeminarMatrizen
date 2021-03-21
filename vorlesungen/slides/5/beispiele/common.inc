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

#declare imagescale = 0.25;
#declare O = <0, 0, 0>;
#declare at = 0.02;

camera {
	location <3, 2, -10>
	look_at <0, 0, 0>
	right 16/9 * x * imagescale
	up y * imagescale
}

//light_source {
//	<-14, 20, -50> color White
//	area_light <1,0,0> <0,0,1>, 10, 10
//	adaptive 1
//	jitter
//}

light_source {
	<41, 20, -50> color White
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
		from, 1.0 * arrowthickness
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
#declare r = 1.1;

arrow(< -r-0.2,    0.0,    0  >, <  r+0.2,    0.0,    0.0 >, at, Gray)
arrow(<    0.0,    0.0, -r-0.2>, <    0.0,    0.0,  r+0.2 >, at, Gray)
arrow(<    0.0, -r-0.2,    0  >, <    0.0,  r+0.2,    0.0 >, at, Gray)

#declare gruen1  = rgb<0.0,0.4,0.0>;
#declare gruen2  = rgb<0.0,0.4,0.8>;
#declare orange1 = rgb<1.0,0.6,0.0>;
#declare orange2 = rgb<0.8,0.0,0.4>;

#macro ebene(v1, v2, farbe)
	intersection {
		box { <-r,-r,-r>, <r,r,r> }
		plane { vnormalize(vcross(v1, v2)), 0.004 }
		plane { vnormalize(-vcross(v1, v2)), 0.004 }
		pigment {
			color rgbt<farbe.x, farbe.y, farbe.z, 0.5>
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end

#macro gerade(v1, farbe)
	intersection {
		box { <-r,-r,-r>, <r,r,r> }
		cylinder { -2 * r * vnormalize(v1),
				2 * r * vnormalize(v1), 0.80*at }
		pigment {
			color farbe
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end

#macro kasten() 
	difference {
		box { <-r-0.01,-r-0.01,-r-0.01>, <r+0.01,r+0.01,r+0.01> }
		union {
			box {	<  -r,        -r,        -r     >,
				<   r,         r,         r     >	}
			box {	<-2*r,        -r+0.03,   -r+0.03>,
				< 2*r,         r-0.03,    r-0.03>	}
			box {	<  -r+0.03, -2*r,        -r+0.03>,
				<   r-0.03,  2*r,         r-0.03>	}
			box {	<  -r+0.03,   -r+0.03, -2*r     >,
				<   r-0.03,    r-0.03,  2*r     >	}
		}
		pigment {
			color rgb<0.8,0.8,0.8>
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end

