function plotSphere( c, r, n )
%Plot 3d sphere
% Parameters
% ----------
% - c: [double, double, double]
%   Center of sphere
% - r: double
%   Radius of sphere
% - n: int
%   n-by-n sphere

% [x, y, z] = sphere();
% 
% x = r * x + c(1);
% y = r * y + c(2);
% z = r * z + c(3);
% 
% surf(x, y, z);

if ~exist('n', 'var')
    n = 20;
end

% unit circle

% % Method 1
% % x^2 + y^2 + z^2 = 1
% % -1 <= x, y <= 1, z = +-sqrt(1 - x^2 - y^2)
% % +z
% x = linspace(-1, 1, n);
% y = linspace(-1, 1, n);
% [x, y] = meshgrid(x, y);
% z = zeros(n, n);
% for i = 1:n
%     for j = 1:n
%         z(i, j) = 1 - x(i, j)^2 - y(i, j)^2; 
%         if z(i, j) < 0
%             z(i, j) = 0;
%         else
%             z(i, j) = sqrt(z(i, j));
%         end 
%     end
% end
% 
% % -z
% x = [x, rot90(x,2)];
% y = [y, rot90(y,2)];
% z = [z, rot90(-z,2)];

% % Method 2
% x = zeros(n, n);
% y = zeros(n, n);
% z = zeros(n, n);
% xx = linspace(-1, 1, n);
% for i = 1:n
%     tmp = sqrt(1 - xx(i)^2);
%     yy = linspace(-tmp, tmp, n);
%     for j = 1:n
%         x(i, j) = xx(i);
%         y(i, j) = yy(j);
%         z(i, j) = 1 - x(i, j)^2 - y(i, j)^2;
%     end
% end
% 
% z(z < 0) = 0;
% z = sqrt(z);
% 
% x = [x, rot90(x,2)];
% y = [y, rot90(y,2)];
% z = [z, rot90(-z,2)];

% Method 3
% 0 <= alpha <= pi, 0 <= beta <= 2pi, 
% (sin(alpha)cos(beta), sin(alpha)sin(beta), cos(alpha))
alpha = linspace(0, pi, n);
beta = linspace(0, 2 * pi, n);
x = zeros(n, n);
y = zeros(n, n);
z = zeros(n, n);
for i = 1:n
    for j = 1:n
        z(i, j) = cos(alpha(i));
        x(i, j) = sin(alpha(i)) * cos(beta(j));
        y(i, j) = sin(alpha(i)) * sin(beta(j));
    end
end

% scale
x = r * x;
y = r * y;
z = r * z;
% translate
x = x + c(1);
y = y + c(2);
z = z + c(3);
% plot
surf(x, y, z);
% axis('equal');
set(gca, ...
    'XLim', [-2*r + c(1), 2*r + c(1)], ...
    'YLim', [-2*r + c(2), 2*r + c(2)], ...
    'ZLim', [-2*r + c(3), 2*r + c(3)], ...
    'DataAspectRatio', [1, 1, 1], ...
    'XAxisLocation', 'origin', ...
    'YAxisLocation', 'origin' ...
);

end

