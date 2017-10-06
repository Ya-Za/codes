function [ R ] = lookat( u )
% Get rotation matrix that takes [0, 0, 1] to `u` vector
%
% Parameters
% ----------
% - u: 3-by-1 double vector
%   Target vector for [0, 0, 1]
%
% Returns
% -------
% - R: 3-by-3 double matrix
%   Rotation matrix

% convert to column vector
u = u(:);
z = [0, 0, 1]';

% axis of rotation
ax = cross(z, u);
if all(ax == [0, 0, 0]')
    ax = z;
end
% angle between [0, 0, 1] and `u`
a = getAngle(u, [0, 0, 1]');

R = rotationAroundAxis(ax, a);

end

function a = getAngle(v1, v2)
    a = atan2(norm(cross(v1, v2)), dot(v1, v2));
end
