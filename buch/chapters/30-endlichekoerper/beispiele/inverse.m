#
# inverse.m -- Inverse mod 2063 berechnen
#
# (c) Prof Dr Andreas Müller, Hochschule Rapperswil
#
function retval = Q(q)
	retval = [ 0, 1; 1, -q ];
end

P = eye(2)
P = Q(1) * P
P = Q(48) * P
P = Q(8) * P
P = Q(2) * P
P = Q(2) * P
