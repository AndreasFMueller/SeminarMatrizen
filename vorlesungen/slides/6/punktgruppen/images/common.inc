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

#declare imagescale = 0.22;
#declare O = <0, 0, 0>;
#declare at = 0.015;

camera {
	location <3, 3.2, -10>
	look_at <0, 0, 0>
	right 16/9 * x * imagescale
	up y * imagescale
}

light_source {
	<-21, 20, -50> color 0.7*White
	area_light <10,0,0> <0,0,10>, 10, 10
	adaptive 1
	jitter
}

light_source {
	<8, 80, -5> color 0.6*White
	area_light <10,0,0> <0,0,10>, 10, 10
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
		from, 1.0 * arrowthickness
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
#declare r = 1.2;

arrow(< -r,  0,  0 >, <  r,  0,  0 >, at, Gray)
arrow(<  0,  0, -r >, <  0,  0,  r >, at, Gray)
arrow(<  0, -r,  0 >, <  0,  r,  0 >, at, Gray)

#macro kranzpunkt(r, winkel, h)
	< r * cos(winkel), h, r * sin(winkel) >
#end

#declare N = 13;
#declare h = 0.6;

#macro deckel(r, R, scherwinkel, h)
	#declare phi = 0;
	#declare phistep = 2 * pi / N;
	#while (phi < (2 * pi) - phistep/2)
		triangle {
			<0, h, 0>,
			kranzpunkt(r, phi, h),
			kranzpunkt(R, phi + scherwinkel, h)
		}
		triangle {
			<0, h, 0>,
			kranzpunkt(R, phi + scherwinkel, h)
			kranzpunkt(r, phi + phistep, h)
		}
		#declare phi = phi + phistep;
	#end
#end


#macro mantel(roben, Roben, hoben, runten, Runten, hunten, scherwinkel)
	#declare phi = 0;
	#declare phistep = 2 * pi / N;
	#while (phi < 2 * pi - phistep/2)
		triangle {
			kranzpunkt(runten, phi, hunten),
			kranzpunkt(Runten, phi + scherwinkel, hunten),
			kranzpunkt(roben, phi, hoben)
		}
		triangle {
			kranzpunkt(Runten, phi + scherwinkel, hunten),
			kranzpunkt(Roben, phi + scherwinkel, hoben),
			kranzpunkt(roben, phi, hoben)
		}
		triangle {
			kranzpunkt(Runten, phi + scherwinkel, hunten),
			kranzpunkt(runten, phi + phistep, hunten),
			kranzpunkt(Roben, phi + scherwinkel, hoben)
		}
		triangle {
			kranzpunkt(runten, phi + phistep, hunten),
			kranzpunkt(roben, phi + phistep, hoben),
			kranzpunkt(Roben, phi + scherwinkel, hoben)
		}
		#declare phi = phi + phistep;
	#end
#end

#declare scherwinkel = function(scherfaktor) { (scherfaktor * 2 * pi / N) };

#macro koerper(roben, Roben, hoben, runten, Runten, hunten, scherfaktor)
mesh {
	deckel(roben, Roben, scherwinkel(scherfaktor), hoben)
	deckel(runten, Runten, scherwinkel(scherfaktor), hunten)
	mantel(roben, Roben, hoben, runten, Runten, hunten, scherwinkel(scherfaktor))
	pigment {
		color Gray
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

#macro Hvektor(a)
	<cos(a*2*pi/N),0,sin(a*2*pi/N)>
#end

#declare VachseFarbe = rgb<1,0.6,0>;
#declare HachseFarbe = rgb<0.8,0.2,0.8>;
#declare VebeneFarbe = rgbf<0.2,0.8,1.0,0.7>;
#declare HebeneFarbe = rgbf<0.2,0.4,0.2,0.7>;

#macro ebene(richtung, farbe)
intersection {
	cylinder { <0, -1, 0>, <0, 1, 0>, 1.0 }
	plane { vnormalize(richtung), 0.003 }
	plane { -vnormalize(richtung), 0.003 }
	pigment {
		color farbe
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

#macro Vebene()
	ebene(Hvektor(-1.25), VebeneFarbe)
#end

#macro Hebene()
	ebene(<0,1,0>, HebeneFarbe)
#end

#macro achse(richtung, farbe)
	cylinder { 	 1.1 * vnormalize(richtung),
			-1.1 * vnormalize(richtung),
			 1.5 * at
		pigment {
			color farbe
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end

#macro Vachse()
	achse(<0,1,0>, VachseFarbe)
#end

#macro Hachse()
	achse(Hvektor(-1.5), HachseFarbe)
#end
