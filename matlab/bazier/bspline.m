function p = bspline( t, S )
%B-spline curve
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

[t, P] = findTargetInterval(t, S);
p = bazier3(t, P);

end

function [t, P] = findTargetInterval(t, S)
if t == 1
    P = S(:, end);
    return;
end
% find `B` points
B = findBazierPoints(S);

% number of intervals
n = size(S, 2) - 1;

% cubic bazier needs `4` points
index = floor(t * n) + 1;
P = zeros(size(S, 1), 4);
P(:, 1) = S(:, index);
P(:, 2) = 2/3 * B(:, index) + 1/3 * B(:, index + 1);
P(:, 3) = 1/3 * B(:, index) + 2/3 * B(:, index + 1);
P(:, 4) = S(:, index + 1);

% t
t = (t * n) - floor(t * n);
end

function B = findBazierPoints(S)
% A * B = T
n = size(S, 2) - 2;
A = diag(ones(1, n-1), -1) + ...
    4 * eye(n) + ...
    diag(ones(1, n-1), 1);

T = 6 * S(:, 2:end-1);
T(:, 1) = T(:, 1) - S(:, 1);
T(:, end) = T(:, end) - S(:, end);
T = T';

B = A \ T;
B = B';
B = [S(:, 1), B, S(:, end)];
end
