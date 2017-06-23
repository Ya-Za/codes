function plotPlane( point, normal , limits, n)
%Plot 3d plane
%   Parameters
%   ----------
%   - point: [double, double, double]
%     A point on the plane
%   - normal: [double, double, double]
%     Normal vector of the plane
%   - limits: [double, double]
%     Min and max of plotting

if ~exist('n', 'var')
    n = 20;
end

% ax + by + cz = d
normal = normal / norm(normal);
a = normal(1);
b = normal(2);
c = normal(3);
d = dot(normal, point);


if c ~= 0
    x = linspace(limits(1), limits(2), n);
    y = linspace(limits(1), limits(2), n);
    [x, y] = meshgrid(x, y);
    z = (d - a*x - b*y) / c;
else
    if b ~= 0
        x = linspace(limits(1), limits(2), n);
        z = linspace(limits(1), limits(2), n);
        [x, z] = meshgrid(x, z);
        y = (d - a*x - c*z) / b;
    else
        y = linspace(limits(1), limits(2), n);
        z = linspace(limits(1), limits(2), n);
        [y, z] = meshgrid(y, z);
        x = (d - b*y - c*z) / a;
    end
end

surf(x, y, z);
xlabel('x');
ylabel('y');
zlabel('z');

end

