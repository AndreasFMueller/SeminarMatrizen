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

#declare imagescale = 0.14;
#declare r = 0.02;
#declare thick = 0.040;

camera {
	location <40, 12, 15>
	look_at <0, 0, 0>
	right 16/9 * x * imagescale
	up y * imagescale
}

light_source {
	<40, 20, 20> color White
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


arrow(< -3,  0,  0 >, < 3, 0, 0 >, r, White)
arrow(<  0, -3,  0 >, < 0, 3, 0 >, r, White)
arrow(<  0,  0, -3 >, < 0, 0, 3 >, r, White)

#macro circlearrow0(e1, e2, e3, r1, r2, h, winkel)  

mesh {
	#declare N = 100;
	#declare phi = 0;
	#declare phimax = winkel - pi / 12;
	#declare phistep = (phimax - phi) / N;
	#while (phi < phimax - phistep/2)
	triangle {
		center + r1 * (cos(phi        ) * e1 + sin(phi        ) * e2) - h * e3,
		center + r2 * (cos(phi        ) * e1 + sin(phi        ) * e2) - h * e3,
		center + r1 * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2) - h * e3
	}
	triangle {
		center + r1 * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2) - h * e3,
		center + r2 * (cos(phi        ) * e1 + sin(phi        ) * e2) - h * e3,
		center + r2 * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2) - h * e3
	}
	triangle {
		center + r1 * (cos(phi        ) * e1 + sin(phi        ) * e2) + h * e3,
		center + r2 * (cos(phi        ) * e1 + sin(phi        ) * e2) + h * e3,
		center + r1 * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2) + h * e3
	}
	triangle {
		center + r1 * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2) + h * e3,
		center + r2 * (cos(phi        ) * e1 + sin(phi        ) * e2) + h * e3,
		center + r2 * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2) + h * e3
	}
	triangle {
		center + r1 * (cos(phi        ) * e1 + sin(phi        ) * e2) - h * e3,
		center + r1 * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2) - h * e3,
		center + r1 * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2) + h * e3
	}
	triangle {
		center + r1 * (cos(phi        ) * e1 + sin(phi        ) * e2) - h * e3,
		center + r1 * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2) + h * e3,
		center + r1 * (cos(phi        ) * e1 + sin(phi        ) * e2) + h * e3
	}
	triangle {
		center + r2 * (cos(phi        ) * e1 + sin(phi        ) * e2) - h * e3,
		center + r2 * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2) - h * e3,
		center + r2 * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2) + h * e3
	}
	triangle {
		center + r2 * (cos(phi        ) * e1 + sin(phi        ) * e2) - h * e3,
		center + r2 * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2) + h * e3,
		center + r2 * (cos(phi        ) * e1 + sin(phi        ) * e2) + h * e3
	}
	#declare phi = phi + phistep;
	#end

	triangle {
		center + r1 * e1 - h * e3,
		center + r1 * e1 + h * e3,
		center + r2 * e1 + h * e3
	}
	triangle {
		center + r2 * e1 - h * e3,
		center + r2 * e1 + h * e3,
		center + r1 * e1 - h * e3
	}
	triangle {
		center + r1 * cos(phi) * e1 + r1 * sin(phi) * e2 - h * e3,
		center + r2 * cos(phi) * e1 + r2 * sin(phi) * e2 - h * e3,
		center + 0.5*(r1+r2) * (cos(phi + pi/12) * e1 + sin(phi + pi/12) * e2) - h * e3
	}
	triangle {
		center + r1 * cos(phi) * e1 + r1 * sin(phi) * e2 + h * e3,
		center + r2 * cos(phi) * e1 + r2 * sin(phi) * e2 + h * e3,
		center + 0.5*(r1+r2) * (cos(phi + pi/12) * e1 + sin(phi + pi/12) * e2) + h * e3
	}
	triangle {
		center + r1 * cos(phi) * e1 + r1 * sin(phi) * e2 - h * e3,
		center + 0.5*(r1+r2) * (cos(phi + pi/12) * e1 + sin(phi + pi/12) * e2) - h * e3
		center + r1 * cos(phi) * e1 + r1 * sin(phi) * e2 + h * e3
	}
	triangle {
		center + 0.5*(r1+r2) * (cos(phi + pi/12) * e1 + sin(phi + pi/12) * e2) - h * e3
		center + r1 * cos(phi) * e1 + r1 * sin(phi) * e2 + h * e3,
		center + 0.5*(r1+r2) * (cos(phi + pi/12) * e1 + sin(phi + pi/12) * e2) + h * e3
	}
	triangle {
		center + 0.5*(r1+r2) * (cos(phi + pi/12) * e1 + sin(phi + pi/12) * e2) - h * e3,
		center + r2 * cos(phi) * e1 + r2 * sin(phi) * e2 - h * e3,
		center + r2 * cos(phi) * e1 + r2 * sin(phi) * e2 + h * e3
	}
	triangle {
		center + 0.5*(r1+r2) * (cos(phi + pi/12) * e1 + sin(phi + pi/12) * e2) - h * e3,
		center + r2 * cos(phi) * e1 + r2 * sin(phi) * e2 + h * e3,
		center + 0.5*(r1+r2) * (cos(phi + pi/12) * e1 + sin(phi + pi/12) * e2) + h * e3
	}
	
	pigment {
		color rgb<1, 0.4, 0.4>
	}
}

#end


#macro circlearrow(fromdirection, axis, center, r, h, winkel, anzahl)

#declare e1 = vnormalize(fromdirection);
#declare e2 = -vnormalize(vcross(axis, fromdirection));
#declare e3 = vnormalize(axis);

#declare r1 = 0.4 * r;
#declare r2 = r;

#declare w = 0;
#while (w < anzahl)
	#declare a = 2 * w * pi / anzahl;
	circlearrow0(e1 * cos(a) - e2 * sin(a), e1 * sin(a) + e2 * cos(a), e3, r1, r2, 1.2 * h, winkel)
	#declare w = w + 1;
#end

mesh {
	#declare vlu = center - r * e1 - r * e2 - h * e3;
	#declare vlo = center - r * e1 - r * e2 + h * e3;
	#declare vru = center - r * e1 + r * e2 - h * e3;
	#declare vro = center - r * e1 + r * e2 + h * e3;
	#declare hlu = center + r * e1 - r * e2 - h * e3;
	#declare hlo = center + r * e1 - r * e2 + h * e3;
	#declare hru = center + r * e1 + r * e2 - h * e3;
	#declare hro = center + r * e1 + r * e2 + h * e3;
	triangle { vlu, vru, vro }
	triangle { vlu, vro, vlo }

	triangle { vru, hru, hro }
	triangle { vru, hro, vro }

	triangle { hru, hlu, hlo }
	triangle { hru, hlo, hro }

	triangle { hlu, vlu, vlo }
	triangle { hlu, vlo, hlo }

	triangle { vlu, vru, hru }
	triangle { vlu, hru, hlu }

	triangle { vlo, vro, hro }
	triangle { vlo, hro, hlo }

	pigment {
		color rgb<0.6,0.6,1>
	}
	finish {
		specular 0.96
		metallic
	}
}

#if (vlength(axis) > 0.1)
cone {
	center + 1.19 * h * e3, r, center + 2 * r * e3, 0
	pigment {
		color rgbt<0.6,0.6,1,0.8>
	}
}
#end

cylinder {
	center, center + 2 * r * e3, 0.04*0.2
        pigment {
                color rgb<1.0,0.6,0.6>
        }
	finish {
		specular 0.96
		metallic
	}
}

#end

