function plotRegularPolygon(n, l)
% Plot `regular polygon`
%
% Parameters
% ----------
% - n: int
%   Number of sideds > 2
% - l: double
%   Length of each side > 0

points = getRegularPolygonPoints(n, l);
printSummary(points);

plot(...
    points(1, :), points(2, :), ...
    'Color', 'blue' ...
);
hold('on');

scatter(...
    points(1, :), points(2, :), ...
    'FaceColor', 'red');
hold('off');

axis('square');
set(gca, ...
    'XTick', [], ...
    'YTick', [], ...
    'XLim', [-l, l], ...
    'YLim', [-l, l], ...
    'XAxisLocation', 'origin', ...
    'YAxisLocation', 'origin' ...
);

end

function points = getRegularPolygonPoints(n, l)
% Get points of `regular polygon`
%
% Returns
% -------
% - points: 2-by-(n + 1) double matrix
%   Vertices of `regular polygon`

% value of each anlge of `regular polygon` in radians 
theta = ((n - 2) * pi) / n;
% radius of circumcirle
r = (l / 2) / sin(theta / 2);
% initial point
P = [0, r]';
% initial return points
points = zeros(2, n + 1);
points(:, 1) = P;
% closed polygon
points(:, n + 1) = P;
% angle of rotation between two consecutive points 
alpha = (2 * pi) / n;
% rotation matrix
R = [
    cos(alpha), -sin(alpha)
    sin(alpha),  cos(alpha)
];
% make points
for i = 2:n
   P =  R * P;
   points(:, i) = P;
end

% `n` is even
if mod(n, 2) == 0
    a = -(alpha / 2);
    R = [
        cos(a) -sin(a)
        sin(a)  cos(a)
    ];
    points = R * points;
end

end

function printSummary(points)

points = points(:, 1:end - 1);
s = sum(points, 2);
disp('sum');
display(s);

minx = min(points(1, :));
maxx = max(points(1, :));
fprintf('x in [%.3f, %.3f]\n', minx, maxx);

miny = min(points(2, :));
maxy = max(points(2, :));
fprintf('y in [%.3f, %.3f]\n', miny, maxy);

end
