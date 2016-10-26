function [ y ] = my_binomial( x, n, p )
%Binomial Distribution

y = zeros(size(x));

q = 1 - p;
for i = 1:length(x)
    if x(i) >= 0 && x(i) <= n
        y(i) = nchoosek(n, x(i)) * p ^ x(i) * q ^ (n - x(i)); 
    end
end

end

