function y = gaussian( x, mu, sigma )
%gaussian multivariate normal distribution
%   x: 1-by-d vectors
%   mu: mean vector
%   sigma: covariance matrix

d = size(x, 2);

c = 1 / sqrt((det(sigma) * power(2 * pi, d)));
sigma_inv = inv(sigma);
y = [];
for i = 1:size(x, 1)
    y(end + 1) =  c * exp(-0.5 * (x(i, :) - mu) * sigma_inv * (x(i, :) - mu)');
end

end

