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

#declare imagescale = 0.40;
#declare O = <0, 0, 0>;
#declare at = 0.10;

#declare Xunten = -10;
#declare Xoben = 10;
#declare Yunten = -8;
#declare Yoben = 8;
#declare Zunten = 0;
#declare Zoben = 20;

#declare phi0 = 2 * pi * 290 / 360;

camera {
	location <60 * cos(2*pi*T+phi0), 15, 60 * sin(2*pi*T+phi0) + 10>
	look_at <0, -2, 10>
	right 16/9 * x * imagescale
	up y * imagescale
}

light_source {
	<-14, 20, -50> color White
	area_light <1,0,0> <0,0,1>, 10, 10
	adaptive 1
	jitter
}

light_source {
	<41, 20, -50> color White
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

arrow(< -12.0,   0.0,  0  >, < 12.0,  0.0,  0.0 >, at, Gray)
arrow(<   0.0,   0.0, -2.0>, <  0.0,  0.0, 22.0 >, at, Gray)
arrow(<   0.0, -10.0,  0  >, <  0.0, 10.0,  0.0 >, at, Gray)

#macro kasten()
	box { <-10.5,-8.5,-0.5>, <10.5,8.5,20.5> }
#end

#declare gruen = rgb<0.2,0.4,0.2>;
#declare blau  = rgb<0.0,0.4,0.8>;
#declare rot   = rgb<1.0,0.4,0.0>;

#declare r = 0.4;

#macro Zring()
	union {
		#declare X = Xunten;
		#while (X <= Xoben + 0.5)
			#declare Y = Yunten;
			#while (Y <= Yoben + 0.5)
				#declare Z = Zunten;
				#while (Z <= Zoben + 0.5)
					sphere { <X, Y, Z>, r }

					#declare Z = Z + 1;
				#end
				#declare Y = Y + 1;
			#end
			#declare X = X + 1;
		#end
		pigment {
			color rot
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end

#macro Hauptideal()
	union {
		#declare A = Xunten;
		#while (A <= Xoben + 0.5)
			#declare B = Zunten;
			#while (B <= Zoben + 0.5)
				#declare Y = A + B;
				#if ((Y >= Yunten - 0.5) & (Y <= Yoben + 0.5))
					sphere { <A, Y, B>, r }
				#end
				#declare B = B + 1;
			#end
			#declare A = A + 1;
		#end
		pigment {
			color blau
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end

#macro HauptidealR()
	intersection {
		kasten()
		#declare n = vnormalize(< 1, -2, 1 >);
		plane { n, 0.1 }
		plane { -n, 0.1 }
		pigment {
			color blau
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end

#macro Ideal2()
	union {
		#declare X = Xunten;
		#while (X <= Xoben + 0.5)
			#declare Y = Yunten;
			#while (Y <= Yoben + 0.5)
				#declare Z = Zunten;
				#while (Z <= Zoben + 0.5)
					sphere { <X, Y, Z>, r }
					#declare Z = Z + 2;
				#end
				#declare Y = Y + 2;
			#end
			#declare X = X + 2;
		#end
		pigment {
			color gruen
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end

#macro IdealX()
	union {
		#declare Y = Yunten;
		#while (Y <= Yoben + 0.5)
			#declare Z = Zunten;
			#while (Z <= Zoben + 0.5)
				sphere { <0, Y, Z>, r }
				#declare Z = Z + 1;
			#end
			#declare Y = Y + 1;
		#end
		pigment {
			color gruen
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end

#macro IdealXR()
	intersection {
		kasten()
		plane { <1,0,0>, 0.1 }
		plane { <-1,0,0>, 0.1 }
		pigment {
			color gruen
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end

#macro Nichthauptideal()
	union {
		#declare X = Xunten/2;
		#while (X <= Xoben/2 + 0.5)
			#declare Y = Yunten;
			#while (Y <= Yoben + 0.5)
				#declare Z = 0;
				#while (Z <= Zoben + 0.5)
					sphere { <2*X,Y,Z>, r }
					#declare Z = Z + 1;
				#end
				#declare Y = Y + 1;
			#end
			#declare X = X + 1;
		#end
		pigment {
			color gruen
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end

#macro NichthauptidealKomplement()
	union {
		#declare X = Xunten + 1;
		#while (X <= Xoben + 0.5)
			#declare Y = Yunten;
			#while (Y <= Yoben + 0.5)
				#declare Z = Zunten;
				#while (Z <= Zoben + 0.5)
					sphere { <X,Y,Z>, r }
					#declare Z = Z + 1;
				#end
				#declare Y = Y + 1;
			#end
			#declare X = X + 2;
		#end
		pigment {
			color rot
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end







