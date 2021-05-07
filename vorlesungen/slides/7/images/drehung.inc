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

#declare imagescale = 0.23;
#declare O = <0, 0, 0>;
#declare at = 0.02;

camera {
	location <8.5, 2, 6.5>
	look_at <0, 0, 0>
	right x * imagescale
	up y * imagescale
}

//light_source {
//	<-14, 20, -50> color White
//	area_light <1,0,0> <0,0,1>, 10, 10
//	adaptive 1
//	jitter
//}

light_source {
	<41, 20, 10> color White
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
#declare r = 1.0;

arrow(< -r-0.2,    0.0,    0  >, <  r+0.2,    0.0,    0.0 >, at, Gray)
arrow(<    0.0,    0.0, -r-0.2>, <    0.0,    0.0,  r+0.2 >, at, Gray)
arrow(<    0.0, -r-0.2,    0  >, <    0.0,  r+0.2,    0.0 >, at, Gray)

#declare farbeX = rgb<1.0,0.2,0.6>;
#declare farbeY = rgb<0.0,0.8,0.4>;
#declare farbeZ = rgb<0.4,0.6,1.0>;

#declare farbex = rgb<1.0,0.0,0.0>;
#declare farbey = rgb<0.0,0.6,0.0>;
#declare farbez = rgb<0.0,0.0,1.0>;

#macro quadrant(X, Y, Z)
	intersection {
		sphere { O, 0.5 }
		plane { -X, 0 }
		plane { -Y, 0 }
		plane { -Z, 0 }
		pigment {
			color rgb<1.0,0.6,0.2>
		}
		finish {
			specular 0.95
			metallic
		}
	}
	arrow(O, X, 1.1*at, farbex)
	arrow(O, Y, 1.1*at, farbey)
	arrow(O, Z, 1.1*at, farbez)
#end

#macro drehung(X, Y, Z)
//	intersection {
//		sphere { O, 0.5 }
//		plane { -X, 0 }
//		plane { -Y, 0 }
//		plane { -Z, 0 }
//		pigment {
//			color Gray
//		}
//		finish {
//			specular 0.95
//			metallic
//		}
//	}
	arrow(O, 1.1*X, 0.9*at, farbeX)
	arrow(O, 1.1*Y, 0.9*at, farbeY)
	arrow(O, 1.1*Z, 0.9*at, farbeZ)
#end

#macro achse(H)
	cylinder { H, -H, at
		pigment {
			color rgb<0.6,0.4,0.2>
		}
		finish {
			specular 0.95
			metallic
		}
	}
	cylinder { 0.003 * H, -0.003 * H, 1
		pigment {
			color rgbt<0.6,0.4,0.2,0.5>
		}
		finish {
			specular 0.95
			metallic
		}
	}
#end
