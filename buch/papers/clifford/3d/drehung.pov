//
// drehung.pov -- Drehung um (1,1,1)
//
// (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#include "common.inc"

#declare n = vnormalize(<1,1,1>);
#declare V = <0,2.6,0>;
#declare W = <0,0,2.6>;

#declare Vparallel = vdot(n, V) * n;
#declare Vperp = V - Vparallel;
#declare Wparallel = vdot(n, W) * n;
#declare Wperp = W - Wparallel;

arrow(<0,0,0>, 2*n, thick, Red)

arrow(<0,0,0>, V, thick, rgb<0.0,1.0,1.0>)
arrow(<0,0,0>, W, thick, rgb<0.0,1.0,1.0>)

circlearrow(vnormalize(vcross(<-1,0,1>,n)), -0.01 * <1,1,1>, <0,0,0>, 1, 0.8*thick, 1.98*pi/3, 3)

arrow(<0,0,0>, Vperp, 0.99*thick, Blue)
arrow(<0,0,0>, Wperp, 0.99*thick, Blue)

arrow(Vperp, V, thick, Green)
arrow(Wperp, W, thick, Green)

#declare l = 2.4;
intersection {
	box { <-l,-l,-l>, <l,l,l> }
	//cylinder { -n, n, 3 }
	plane { n, 0.01 }
	plane { -n, 0.01 }
	pigment {
		color rgbt<0.6,0.6,1.0,0.8>
	}
}

#declare e1 = vnormalize(Vperp);
#declare e3 = n;
#declare e2 = vnormalize(vcross(e3, e1));
#declare r = vlength(Vperp);

mesh {
	#declare phi = 0;
	#declare phimax = 2*pi/3;
	#declare phistep = (phimax - phi) / N;
	#while (phi < phimax - phistep/2)
		triangle {
			<0,0,0>,
			r * (cos(phi        ) * e1 + sin(phi        ) * e2),
			r * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2)
		}
		#declare phi = phi + phistep;
	#end
	pigment {
		color rgbt<0.2,0.2,1.0,0.4>
	}
}

union {
	#declare phi = 0;
	#declare phimax = 2*pi/3;
	#declare phistep = (phimax - phi) / N;
	#while (phi < phimax - phistep/2)
		cylinder {
			r * (cos(phi        ) * e1 + sin(phi        ) * e2),
			r * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2),
			0.01
		}
		sphere { r * (cos(phi        ) * e1 + sin(phi        ) * e2), 0.01 }
		#declare phi = phi + phistep;
	#end
	pigment {
		color Blue
	}
}

mesh {
	#declare phi = 0;
	#declare phimax = 2*pi/3;
	#declare phistep = (phimax - phi) / N;
	#while (phi < phimax - phistep/2)
		triangle {
			r * (cos(phi        ) * e1 + sin(phi        ) * e2),
			r * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2),
			r * (cos(phi        ) * e1 + sin(phi        ) * e2) + Vparallel
		}
		triangle {
			r * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2),
			r * (cos(phi        ) * e1 + sin(phi        ) * e2) + Vparallel,
			r * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2) + Vparallel
		}
		#declare phi = phi + phistep;
	#end
	pigment {
		color rgbt<0.2,1,0.2,0.4>
	}
}

union {
	#declare phi = 0;
	#declare phimax = 2*pi/3;
	#declare phistep = (phimax - phi) / N;
	#while (phi < phimax - phistep/2)
		cylinder {
			r * (cos(phi        ) * e1 + sin(phi        ) * e2) + Vparallel,
			r * (cos(phi+phistep) * e1 + sin(phi+phistep) * e2) + Vparallel,
			0.01
		}
		sphere { r * (cos(phi        ) * e1 + sin(phi        ) * e2) + Vparallel, 0.01 }
		#declare phi = phi + phistep;
	#end
	pigment {
		color Green
	}
}

