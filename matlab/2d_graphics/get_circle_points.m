function [ pts ] = get_circle_points( c, r )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

pts = [];
for x = -r:r
    y = sqrt(r^2 - x^2);
    y = round(y);
    pts(:, end + 1) = [x;  y];
    pts(:, end + 1) = [x; -y];
end

pts = pts + repmat(c, 1, size(pts, 2));

end

