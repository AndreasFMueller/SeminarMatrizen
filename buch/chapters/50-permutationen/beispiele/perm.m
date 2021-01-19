#
# perm.m -- find a random permutation
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
N = 8
M = N+1

function retval = permutation(n)
	p = (1:n);
	for i = (1:(n-1))
		j = i + 1 + floor(rand() * (n-i));
		s = p(i);
		p(i) = p(j);
		p(j) = s;
	endfor
	retval = p;
end

function retval = compose(p,q)
	n = size(p)(1,2);
	retval = zeros(1,n);
	for i = (1:n)
		retval(i) = q(p(i));
	end
end

sigma = permutation(N)
sigma = compose(sigma, permutation(N))
sigma = compose(sigma, permutation(N))
sigma = compose(sigma, permutation(N))
sigma = compose(sigma, permutation(N))
sigma = compose(sigma, permutation(N))
sigma = compose(sigma, permutation(N))

s = zeros(M,N);
s(1,:) = sigma;
for i = (2:M)
	s(i,:) = compose(s(i-1,:), sigma);
end

s

compose(sigma, permutation(N))
