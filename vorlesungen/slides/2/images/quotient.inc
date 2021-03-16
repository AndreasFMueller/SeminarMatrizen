//
// quotient.pov
//
// (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "colors.inc"

global_settings {
	assumed_gamma 1
}

#declare imagescale = 0.035;
#declare O = <0, 0, 0>;
#declare at = 0.015;

camera {
	location <8, 15, -50>
	look_at <0.4, 0.2, 0.4>
	right 16/9 * x * imagescale
	up y * imagescale
}

light_source {
	<-4, 20, -50> color White
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

#macro kasten()
	box { <-0.5,-0.5,-0.5>, <1.5,1,1.5> }
#end


arrow(<-0.6,0,0>, <1.6,0,0>, at, White)
arrow(<0,0,-0.6>, <0,0,1.6>, at, White)
arrow(<0,-0.6,0>, <0,1.2,0>, at, White)

#declare U = <-1,3,-0.5>;
#declare V1 = <1,0.2,0>;
#declare V2 = <0,0.2,1>;

#macro gerade(richtung, farbe)
	intersection {
		kasten()
		cylinder { -U + richtung, U + richtung, at }
		pigment {
			color farbe
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end

#declare A = <0.8, -0.2, 0>;
#declare B = <0.2, 0.8, 0>;

#macro ebene(vektor1, vektor2)
#declare n = vcross(vektor1,vektor2);


intersection {
	kasten()
	plane { n, 0.005 }
	plane { -n, 0.005 }
	pigment {
		color rgbf<0.8,0.8,1,0.7>
	}
	finish {
		specular 0.9
		metallic
	}
}

intersection {
	kasten()
	union {
		#declare Xstep = 0.45;
		#declare X = -5 * Xstep;
		#while (X < 5.5 * Xstep)
			cylinder { X*vektor1 - 5*vektor2, X*vektor1 + 5*vektor2, at/2 }
			#declare X = X + Xstep;
		#end
		#declare Ystep = 0.45;
		#declare Y = -5 * Ystep;
		#while (Y < 5.5 * Ystep)
			cylinder { -5*vektor1 + Y*vektor2, 5*vektor1 + Y*vektor2, at/2 }
			#declare Y = Y + Ystep;
		#end
	}
	pigment {
		color rgb<0.9,0.9,1>
	}
	finish {
		specular 0.9
		metallic
	}
}
#end


gerade(O, Red)

#declare gruen = rgb<0.2,0.4,0.2>;
#declare blau = rgb<0,0.4,0.8>;
#declare rot = rgb<1,0.4,0.0>;

#macro repraesentanten(vektor1, vektor2) 

#declare d1 = A.x*vektor1 + A.y*vektor2;
#declare d2 = B.x*vektor1 + B.y*vektor2;

arrow(0, d1 + d2, at, rot)
gerade(d1 + d2, rot)

gerade(d1, blau)
arrow(O, d1, at, blau)
cylinder { d1, d1 + d2, 0.6 * at
	pigment {
		color gruen
	}
	finish {
		specular 0.9
		metallic
	}
}

gerade(d2, gruen)
arrow(O, d2, at, gruen)
cylinder { d2, d1 + d2, 0.6 * at
	pigment {
		color blau
	}
	finish {
		specular 0.9
		metallic
	}
}

#end

#macro vektorraum(s)
#declare b1 = V1 + s * 0.03 * U;
#declare b2 = V2 + s * 0.03 * U;

ebene(b1, b2)
repraesentanten(b1, b2)
#end

