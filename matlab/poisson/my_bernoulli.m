function y = my_bernoulli( x, p )
%Bernoulli Distribution

y = zeros(size(x));
for i = 1:length(x)
    if x(i) == 0
        y(i) = (1 - p);
    elseif x(i) == 1
        y(i) = p; 
    end
end

