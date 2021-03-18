//
// ideal.pov
//
// (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#declare T = clock;
#include "common.inc"

#if (T < 1)
Zring()
#else
    #if (T < 2)
	Hauptideal()
    #else
	#if (T < 3)
	    Ideal2()
	#else
	    #if (T < 4)
		IdealX()
	    #else
		Nichthauptideal()
		NichthauptidealKomplement()
	    #end
	#end
    #end
#end
