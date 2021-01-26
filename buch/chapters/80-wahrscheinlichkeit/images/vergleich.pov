//
// diffusion.pov
//
// (c) 2021 Prof Dr Andreas Müller, OST Ostscheizer Fachhochschule
//
#version 3.7;
#include "colors.inc"
#include "textures.inc"
#include "transforms.inc"

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
        <20, 60, -80> color White
        area_light <1,0,0> <0,0,1>, 40, 40
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

#declare O = <0,0,0>;
#declare Ex = <1,0,0>;
#declare Ey = <0,1,0>;
#declare Ez = <0,0,1>;
#declare s = 3;

#declare A_transformation = Matrix_Trans(<1.0300,0.2050,0.1050>,<0.4100,1.0250,0.1100>,<0.4200,0.2200,1.0150>,<0,0,0>);
//#declare A_transformation = Matrix_Trans(<1.0300,0.2050,0.1050>,<0.4100,1.0250,0.1100>,<0.4200,0.2200,0.5150>,<0,0,0>);

arrow(O, s * Ex, r, rgb<0.6,0.2,0.4>)
arrow(O, s * Ez, r, rgb<0.2,0.4,0.2>)
arrow(O, s * Ey, r, rgb<0.2,0.2,0.4>)

#declare A = vtransform(Ex, A_transformation);
#declare B = vtransform(Ey, A_transformation);
#declare C = vtransform(Ez, A_transformation);

#macro quadrant(rad)
intersection {
	sphere { <0, 0, 0>, rad
		//A_transformation
		matrix <A.x, A.y, A.z,
			B.x, B.y, B.z,
			C.x, C.y, C.z,
			0,   0,   0    >
	}
	plane { vnormalize(-vcross(A, B)), 0 }
	plane { vnormalize(-vcross(B, C)), 0 }
	plane { vnormalize(-vcross(C, A)), 0 }
	pigment {
		color rgbf<0.8,1,1,0.5>
		//color rgb<0.8,1,1>
	}
	finish {
		specular 0.9
		metallic
	}
}
union {
	cylinder { O, s*A, 0.3*r }
	sphere { s*A, 0.3*r }
	cylinder { O, s*B, 0.3*r }
	sphere { s*B, 0.3*r }
	cylinder { O, s*C, 0.3*r }
	sphere { s*C, 0.3*r }
	pigment {
		color White
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

#declare d = 3;
//union {
//	plane { <0, 1, 0>, -d }
//	plane { <1, 0, 0>, -d }
//	pigment {
//		color Gray
//	}
//	finish {
//		specular 0.9
//	}
//}

quadrant(s)

#declare V = < 1, 1, 0 >;
#declare U = < 1.3, 2.5, 0 >;

#declare VV = vtransform(V, A_transformation);
#declare Vx = vtransform(<V.x, 0, 0>, A_transformation);
#declare Vy = vtransform(<0, V.y, 0>, A_transformation);
#declare UU = vtransform(U, A_transformation);
#declare Ux = vtransform(<U.x, 0, 0>, A_transformation);
#declare Uy = vtransform(<0, U.y, 0>, A_transformation);

union {
	sphere { V, r }
	sphere { U, r }
	cylinder { U, V, 0.5*r }
	pigment {
		color Red
	}
	finish {
		specular 0.9
		metallic
	}
}

union {
	cylinder { < U.x,   0, 0 >, < U.x, U.y,   0>, 0.3 * r }
	cylinder { < V.x,   0, 0 >, < V.x, V.y,   0>, 0.3 * r }
	cylinder { <   0, U.y, 0 >, < U.x, U.y,   0>, 0.3 * r }
	cylinder { <   0, V.y, 0 >, < V.x, V.y,   0>, 0.3 * r }
	pigment {
		color rgb<1, 0.6, 1>
	}
	finish {
		specular 0.9
		metallic
	}
}

union {
	sphere { VV, r }
	sphere { UU, r }
	cylinder { UU, VV, 0.5*r }
	pigment {
		color Yellow
	}
	finish {
		specular 0.9
		metallic
	}
}

union {
	cylinder { Ux, UU, 0.3 * r }
	cylinder { Uy, UU, 0.3 * r }
	cylinder { Vx, VV, 0.3 * r }
	cylinder { Vy, VV, 0.3 * r }
	pigment {
		color rgb<1, 1, 0.6>
	}
	finish {
		specular 0.9
		metallic
	}
}
