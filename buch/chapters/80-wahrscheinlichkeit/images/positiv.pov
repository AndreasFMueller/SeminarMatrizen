//
// diffusion.pov
//
// (c) 2021 Prof Dr Andreas Müller, OST Ostscheizer Fachhochschule
//
#version 3.7;
#include "colors.inc"

global_settings {
	assumed_gamma 1
}

#declare imagescale = 0.077;
#declare N = 30;
#declare vscale = 10;
#declare r = 0.04;

camera {
        location <43, 20, -20>
        look_at <1, 0.83, 2.5>
        right 16/9 * x * imagescale
        up y * imagescale
}

light_source {
        <40, 20, -10> color White
        area_light <1,0,0> <0,0,1>, 10, 10
        adaptive 1
        jitter
}

sky_sphere {
        pigment {
                color rgb<1,1,1>
        }
}

//
// draw an arrow from <from> to <to> with thickness <arrowthickness> with
// color <c>
//
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

arrow(<0,0,0>, <3,0,0>, r, White)
arrow(<0,0,0>, <0,3,0>, r, White)
arrow(<0,0,0>, <0,0,3>, r, White)

#macro quadrant(A, B, C)
intersection {
	sphere { <0, 0, 0>, 1 
		matrix <A.x, A.y, A.z,
			B.x, B.y, B.z,
			C.x, C.y, C.z,
			0,   0,   0    >
	}
	plane { vnormalize(vcross(A, B)), 0 }
	plane { vnormalize(vcross(B, C)), 0 }
	plane { vnormalize(vcross(C, A)), 0 }
	pigment {
		//color rgbf<0.8,1,1,0.7>
		color rgb<0.8,1,1>
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

#macro eigenvektor(E)
union {
	cylinder { -E, 8 * E, r }
	#declare r0 = 0.7 * r;

	sphere { 3 * <   0, E.y, E.z >, r0 }
	sphere { 3 * < E.x,   0, E.z >, r0 }
	sphere { 3 * < E.x, E.y,   0 >, r0 }
	sphere { 3 * E, r0 }

	cylinder { 3*< E.x,   0,   0 >, 3*< E.x,   0, E.z >, r0 }
	cylinder { 3*< E.x,   0,   0 >, 3*< E.x, E.y,   0 >, r0 }
	cylinder { 3*<   0, E.y,   0 >, 3*< E.x, E.y,   0 >, r0 }
	cylinder { 3*<   0, E.y,   0 >, 3*<   0, E.y, E.z >, r0 }
	cylinder { 3*<   0,   0, E.z >, 3*<   0, E.y, E.z >, r0 }
	cylinder { 3*<   0,   0, E.z >, 3*< E.x,   0, E.z >, r0 }

	cylinder { 3*< E.x, E.y,   0 >, 3*E, r0 }
	cylinder { 3*<   0, E.y, E.z >, 3*E, r0 }
	cylinder { 3*< E.x,   0, E.z >, 3*E, r0 }
	pigment {
		color rgb<1,0.6,1>*0.6
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

#include "quadrant.inc"

//union {
//	pigment {
//		color rgb<0.8,1,1>*0.6
//	}
//	finish {
//		specular 0.9
//		metallic
//	}
//}

