//
// q31.pov -- Drehung und Quaternion
//
// (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#include "common.inc"

circlearrow(<1,0,0>, 0.01*<0,-1,0>, <0, 0, 0>, 1.0,         thick, 0.98*pi/2, 4)

arrow( <0,0,0>, <-2.0,0,0>, 0.99*thick, Blue)
arrow( <0,0,0>, <0,2.0,0>, 0.99*thick, Red)
arrow( <0,0,0>, <0,0,2.0>, 0.99*thick, Blue)

bogen( <0,0,1.7>, <-1.7, 0, 0>, <0,0,0>, pi/2, Blue)

