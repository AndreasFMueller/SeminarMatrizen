#
# sbox.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
A=[
1,0,0,0,1,1,1,1;
1,1,0,0,0,1,1,1;
1,1,1,0,0,0,1,1;
1,1,1,1,0,0,0,1;
1,1,1,1,1,0,0,0;
0,1,1,1,1,1,0,0;
0,0,1,1,1,1,1,0;
0,0,0,1,1,1,1,1;
]

R = zeros(8,16);
R(:,1:8) = A;
R(:,9:16) = eye(8);

for k = (1:5)
	for i=(k+1:8)
		pivot = R(i,k);
		R(i,:) = R(i,:) + pivot * R(k,:);
	end
	R = mod(R, 2)
end

P = [
1,0,0,0,0,0,0,0;
0,1,0,0,0,0,0,0;
0,0,1,0,0,0,0,0;
0,0,0,1,0,0,0,0;
0,0,0,0,1,0,0,0;
0,0,0,0,0,0,0,1;
0,0,0,0,0,1,0,0;
0,0,0,0,0,0,1,0;
]

R = P * R

for k = (8:-1:2)
	for i = (1:k-1)
		pivot = R(i,k);
		R(i,:) = R(i,:) + pivot * R(k,:);
	end
	R = mod(R, 2)
end

B = R(:,9:16)

A * B
