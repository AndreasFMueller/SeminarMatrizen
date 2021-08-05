//
// dq.pov -- Drehung und Quaternion
//
// (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#include "common.inc"

arrow(<0,0,0>, <1, sqrt(2), 2>, r, Red)

#declare r = 0.2 * r;

circlearrow(<1,0,0>, <0,0,1>, <1, sqrt(2), 0>, 1,         thick, 1.8*pi/3, 3)
circlearrow(<1,0,0>, <0,1,0>, <1,       0, 2>, sqrt(2)/2, thick, 1.8*pi/3, 3)
circlearrow(<0,0,1>, <1,0,0>, <0, sqrt(2), 2>, 0.5,       thick, 1.8*pi/3, 3)

#declare l = 2.8;
#declare h = 0.0001;
union {
	box { <-l,-l,-h>, <l,l,-h> }
	box { <-l,-h,-l>, <l,-h,l> }
	box { <-h,-l,-l>, <-h,l,l> }
	pigment {
		color rgbt<0.6,0.6,0.6,0.0>
	}
}
