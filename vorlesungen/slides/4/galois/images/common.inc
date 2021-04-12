//
// common.inc
//
// (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "colors.inc"
#include "textures.inc"
#include "stones.inc"

global_settings {
	assumed_gamma 1
}

#declare imagescale = 0.133;
#declare O = <0, 0, 0>;
#declare E = <1, 1, 1>;
#declare a = pow(2, 1/3);
#declare at = 0.02;

camera {
	location <3, 2, 12>
	look_at E * (a / 2) * 0.93
	right x * imagescale
	up y * imagescale
}

light_source {
	<11, 20, 16> color White
	area_light <1,0,0> <0,0,1>, 10, 10
	adaptive 1
	jitter
}

sky_sphere {
	pigment {
		color rgb<1,1,1>
	}
}

#macro wuerfelgitter(A, AT)
	cylinder { O, <A, 0, 0>, AT }
	cylinder { O, <0, A, 0>, AT }
	cylinder { O, <0, 0, A>, AT }
	cylinder { <A, 0, 0>, <A, A, 0>, AT }
	cylinder { <A, 0, 0>, <A, 0, A>, AT }
	cylinder { <0, A, 0>, <A, A, 0>, AT }
	cylinder { <0, A, 0>, <0, A, A>, AT }
	cylinder { <0, 0, A>, <A, 0, A>, AT }
	cylinder { <0, 0, A>, <0, A, A>, AT }
	cylinder { <A, A, 0>, <A, A, A>, AT }
	cylinder { <A, 0, A>, <A, A, A>, AT }
	cylinder { <0, A, A>, <A, A, A>, AT }
	sphere { <0, 0, 0>, AT }
	sphere { <A, 0, 0>, AT }
	sphere { <0, A, 0>, AT }
	sphere { <0, 0, A>, AT }
	sphere { <A, A, 0>, AT }
	sphere { <A, 0, A>, AT }
	sphere { <0, A, A>, AT }
	sphere { <A, A, A>, AT }
#end

#macro wuerfel()
	union {
		box { O, E }
		wuerfelgitter(1, 0.5*at)
		texture {
			T_Grnt24
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end

#macro wuerfel2()
	union {
		wuerfelgitter(a, at)
		pigment {
			color rgb<0.8,0.4,0.4>
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end
