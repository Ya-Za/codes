%% Init
close all;
clear;
clc;

%% Parameters
limits = [-5, 5];
number_of_points = 100;
sigma = [
    1, 0
    0, 1
];
mu = [0, 0];

number_of_iterations = 40;

delay = 0.3;

%%
x = linspace(limits(1), limits(2), number_of_points)';
y = x;
[x, y] = meshgrid(x, y);

fig = figure(...
    'Name', 'Moving Gaussian', ...
    'Units', 'normalize', ...
    'OuterPosition', [0, 0, 1, 1], ...
    'NumberTitle', 'off' ...
);
ax = axes(fig);

z = mvnpdf([x(:), y(:)], mu, sigma);
z = reshape(z, size(x));
surf(ax, x, y, z);
shading interp;

set(ax, 'Visible', 'off');

[a, e] = view(ax);
da = (0 - a) / number_of_iterations;
de = (90 - e) / number_of_iterations;
for i = 1:number_of_iterations
    [a, e] = view(ax);
    view(ax, a + da, e + de);

    pause(delay);
end
