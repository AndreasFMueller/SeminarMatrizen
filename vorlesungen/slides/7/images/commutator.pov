//
// commutator.pov
//
// (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#include "common.inc"

sphere { O, 0.99
	pigment {
		color rgbt<1,1,1,0.5>
	}
	finish {
		specular 0.9
		metallic
	}
}

#declare filename = concat("f/", str(clock, -4, 0), ".inc");

#include filename

#declare n1 = vcross(<0,1,0>, finalXY);
#declare n2 = vcross(<0,1,0>, finalYX);

intersection {
	sphere { O, 1 }
	plane { -n1, 0 }
	plane { n2, 0 }
	pigment {
		color rgb<0,0.4,0.1>
	}
	finish {
		specular 0.9
		metallic
	}
}

union {
        XYkurve()
        pigment {
                color Red
        }
	finish {
		specular 0.9
		metallic
	}
}

union {
        YXkurve()
        pigment {
                color Blue
        }
	finish {
		specular 0.9
		metallic
	}
}

