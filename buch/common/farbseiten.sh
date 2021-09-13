#! /bin/bsh
#
# farbseiten.sh -- Formattierung der Farbseiteninfo für die Druckerei
#
# (c) 2020 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
awk 'BEGIN {
	result = ""
	counter = 0
} 
/^#/ {
	next
}
{
	if (length(result) == 0) {
		result = $1
	} else {
		result = sprintf("%s,%d", result, $1)
	}
	counter++
}
END {
	printf("%s\n", result)
	printf("Anzahl Farbseiten: %d\n", counter)
}' <<EOF
# Kapitel 1
19
# Kapitel 2
# Kapitel 3
# Kapitel 4
# Kapitel 5
# Kapitel 6
# Kapitel 7
# Kapitel 8
# Kapitel 9
# Kapitel 10
# Kapitel 11
# Kapitel 12
# Kapitel 13
# Kapitel 14
# Kapitel 15
# Kapitel 16
# Kapitel 17
# Kapitel 18
# Kapitel 19
# Kapitel 20
# Kapitel 21


EOF
