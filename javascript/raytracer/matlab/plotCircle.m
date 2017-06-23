function plotCircle( c, r )
% Plot circle
% Parameters
% ----------
% - c: [double, double]
%   Center of circle
% - r: double
%   Radius of circle
% - n: int
%   n-by-n circle

if ~exist('n', 'var')
    n = 100;
end

% unit circle
% x^2 + y^2 = 1
% -1 <= x <= 1, y = +-sqrt(1 - x^2)
% +y
x = linspace(-1, 1, n);
y = sqrt(1 - x .^ 2);
% -y
x = [x, rot90(x, 2)];
y = [y, rot90(-y, 2)];

% % 0 <= alpha <= 2pi, (cos(alpha), sin(alpha))
% alpha = linspace(0, 2*pi);
% x = cos(alpha);
% y = sin(alpha);


% scale
x = r * x;
y = r * y;
% translate
x = x + c(1);
y = y + c(2);

% plot
plot(x, y);
% axis('equal');
set(gca, ...
    'XLim', [-2*r + c(1), 2*r + c(1)], ...
    'YLim', [-2*r + c(2), 2*r + c(2)], ...
    'DataAspectRatio', [1, 1, 1], ...
    'XAxisLocation', 'origin', ...
    'YAxisLocation', 'origin' ...
);

end

