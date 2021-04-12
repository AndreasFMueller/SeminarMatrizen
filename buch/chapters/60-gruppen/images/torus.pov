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

#declare imagescale = 0.034;
#declare N = 100;
#declare r = 0.43;
#declare R = 1;

camera {
        location <43, 25, -20>
        look_at <0, -0.01, 0>
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

#macro rotiere(phi, vv)
	< cos(phi) * vv.x - sin(phi) * vv.z, vv.y, sin(phi) * vv.x + cos(phi) * vv.z >
#end

#macro punkt(phi,theta)
	rotiere(phi, < R + r * cos(theta), r * sin(theta), 0 >)
#end

mesh {
	#declare phistep = 2 * pi / N;
	#declare thetastep = 2 * 2 * pi / N;
	#declare phi = 0;
	#while (phi < 2 * pi - phistep/2)
		#declare theta = 0;
		#while (theta < 2 * pi - thetastep/2)
			triangle {
				punkt(phi          , theta            ), 
				punkt(phi + phistep, theta            ), 
				punkt(phi + phistep, theta + thetastep)
			}
			triangle {
				punkt(phi          , theta            ), 
				punkt(phi + phistep, theta + thetastep), 
				punkt(phi          , theta + thetastep)
			}
			#declare theta = theta + thetastep;
		#end
		#declare phi = phi + phistep;
	#end
	pigment {
		color Gray
	}
	finish {
		specular 0.9
		metallic
	}
}

#declare thetastart = -0.2;
#declare thetaend = 1.2;
#declare phistart = 5;
#declare phiend = 6;

union {
	#declare thetastep = 0.2;
	#declare theta = thetastart;
	#while (theta < thetaend + thetastep/2)
		#declare phistep = (phiend-phistart)/N;
		#declare phi = phistart;
		#while (phi < phiend - phistep/2)
			sphere { punkt(phi,theta), 0.01 }
			cylinder {
				punkt(phi,theta),
				punkt(phi+phistep,theta),
				0.01
			}
			#declare phi = phi + phistep;
		#end
		sphere { punkt(phi,theta), 0.01 }
		#declare theta = theta + thetastep;
	#end

	pigment {
		color Red
	}
	finish {
		specular 0.9
		metallic
	}
}

union {
	#declare phistep = 0.2;
	#declare phi = phistart;
	#while (phi < phiend + phistep/2)
		#declare thetastep = (thetaend-thetastart)/N;
		#declare theta = thetastart;
		#while (theta < thetaend - thetastep/2)
			sphere { punkt(phi,theta), 0.01 }
			cylinder {
				punkt(phi,theta),
				punkt(phi,theta+thetastep),
				0.01
			}
			#declare theta = theta + thetastep;
		#end
		sphere { punkt(phi,theta), 0.01 }
		#declare phi = phi + phistep;
	#end
	pigment {
		color Blue
	}
	finish {
		specular 0.9
		metallic
	}
}

#macro punkt2(a,b)
	punkt(5.6+a*sqrt(3)/2-b/2,0.2+a/2 + b*sqrt(3)/2)
#end

#declare darkgreen = rgb<0,0.6,0>;

#declare astart = 0;
#declare aend = 1;
#declare bstart = -0.2;
#declare bend = 1.2;
union {
	#declare a = astart;
	#declare astep = 0.2;
	#while (a < aend + astep/2)
		#declare b = bstart;
		#declare bstep = (bend - bstart)/N;
		#while (b < bend - bstep/2)
			sphere { punkt2(a,b), 0.01 }
			cylinder { punkt2(a,b), punkt2(a,b+bstep), 0.01 }
			#declare b = b + bstep;
		#end
		sphere { punkt2(a,b), 0.01 }
		#declare a = a + astep;
	#end
	pigment {
		color darkgreen
	}
	finish {
		specular 0.9
		metallic
	}
}
union {
	#declare b = bstart;
	#declare bstep = 0.2;
	#while (b < bend + bstep/2)
		#declare a = astart;
		#declare astep = (aend - astart)/N;
		#while (a < aend - astep/2)
			sphere { punkt2(a,b), 0.01 }
			cylinder { punkt2(a,b), punkt2(a+astep,b), 0.01 }
			#declare a = a + astep;
		#end
		sphere { punkt2(a,b), 0.01 }
		#declare b = b + bstep;
	#end
	pigment {
		color Orange
	}
	finish {
		specular 0.9
		metallic
	}
}
