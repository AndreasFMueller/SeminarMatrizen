//
// torus.pov
//
// (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "colors.inc"

global_settings {
        assumed_gamma 1
}

#declare imagescale = 0.1;
#declare r = 0.03;

camera {
        location <43, 25, -20>
        look_at <0, 0, 0>
        right 16/9 * x * imagescale
        up y * imagescale
}

light_source {
        <10, 20, -40> color White
        area_light <1,0,0> <0,0,1>, 10, 10
        adaptive 1
        jitter
}

sky_sphere {
        pigment {
                color rgb<1,1,1>
        }
}

#include "torus.inc"

object {
	torusflaeche()
	pigment {
		color rgbt<0.8,0.8,0.8,0.5>
	}
	finish {
		specular 0.9
		metallic
	}
}

object {
	zyklus1()
	pigment {
		color Red
	}
	finish {
		specular 0.9
		metallic
	}
}

object {
	zyklus2()
	pigment {
		color Blue
	}
	finish {
		specular 0.9
		metallic
	}
}
