//
// kombiniert.pov
//
// (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//

#include "common.inc"
#include "JK.inc"

arrow(O, j21, at, orange2)
arrow(O, k21, at, gruen2)
arrow(O, k22, at, gruen2)
gerade(j21, orange2)
ebene(k21, k22, gruen2)

#declare at = 0.7 * at;

arrow(O, j11, at, orange1)
arrow(O, j12, at, orange1)
arrow(O, k11, at, gruen1)
gerade(k11, gruen1)
ebene(j11, j12, orange1)

