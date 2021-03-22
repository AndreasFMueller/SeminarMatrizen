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

#declare imagescale = 0.270;
#declare N = 30;
#declare vscale = 10;
#declare r = 0.08;

camera {
        location <43, 20, -50>
        look_at <N/2+2, vscale*0.49, 3>
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

#macro saeule(xx,yy,h)
box { <xx+0.1,0,yy+0.1>, <xx+0.9,vscale*h,yy+0.9> }
#end

#macro vektor(xx,a,b,c,d,e,f)
	saeule(xx,5,a)
	saeule(xx,4,b)
	saeule(xx,3,c)
	saeule(xx,2,d)
	saeule(xx,1,e)
	saeule(xx,0,f)
#end

union {
#include "vektoren.inc"
	pigment {
		color rgb<0.8,1,1>*0.6
	}
	finish {
		specular 0.9
		metallic
	}
}

union {
#declare xx = 1;
#while (xx <= N+1)
	cylinder { <xx, 0, 0>, <xx, 0, 6>, r }
	#declare xx = xx + 1;
#end
#declare yy = 0;
#while (yy <= 6)
	cylinder { <1, 0, yy>, <N+1, 0, yy>, r }
	#declare yy = yy + 1;
#end
	sphere { <1,0,0>, r }
	sphere { <1,0,6>, r }
	sphere { <N+1,0,0>, r }
	sphere { <N+1,0,6>, r }
	cylinder { <1,0,6>, <1,1.1*vscale,6>, r }
	cylinder { <1,vscale-r/2,6>, <1,vscale+r/2,6>, 2*r }
	cone { <1,1.1*vscale,6>, 2*r, <1,1.15*vscale,6>, 0 }
	pigment {
		color rgb<1,0.6,1>*0.6
	}
	finish {
		specular 0.9
		metallic
	}
}
