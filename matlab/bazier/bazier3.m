function p = bazier3( t, P )
%Bazier curve
% Parameters
% ----------
% - t: double
%   Between 0 and 1
% - P: 2-by-n double matrix
%   Control points
%
% Returns
% -------
% - p: 2-by-1 vector
%   Output point

p = [0, 0]';

n = size(P, 2);
for i = 1:n
    p = p + b(t, i - 1, n - 1) * P(:, i);
end

end

function value = b(t, i, n)
    value = nchoosek(n, i) * t^i * (1 - t)^(n - i);
end

