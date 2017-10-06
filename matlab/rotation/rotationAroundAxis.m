function [ R ] = rotationAroundAxis( ax, a )
% Rotate `a` radian around `ax` axis
%
% Parameters
% ----------
% - ax: 3-by-1 double vector
%   Rotation axis
% - a: double
%   Angle in radian
%
% Returns
% -------
% - R: 3-by-3 double matrix
%   Rotation matrix

% new `z` axis
z = ax(:) / norm(ax);
% up vector
u = [0, 1, 0]';
if all(u == z)
    u = [1, 0, 0]';
end
% new `x` axis
x = cross(u, z);
x = x / norm(x);
% new `y` axis
y = cross(z, x);
y = y / norm(y);

% trasformation matrix from `[0, 0, 1]'` to `ax`
T = [x, y, z];

% rotation matrix around `z` axis
Rz = [
    cos(a), -sin(a), 0
    sin(a),  cos(a), 0
    0     ,       0, 1
];

% rotation matrix around `ax`
R = T * Rz * T';

end

