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
delta = [0.1, 0];

delay = 0.3;
number_of_iterations = 20;

dir_path = './frames';

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
ax = axes();

if exist(dir_path, 'dir')
    rmdir(dir_path)
end
mkdir(dir_path);

for i = 1:number_of_iterations
    cla;
    z = mvnpdf([x(:), y(:)], mu, sigma);
    z = reshape(z, size(x));
    contour(ax, x, y, z)
    set(ax, 'XTick', [], 'YTick', []);
    
    frame = getframe(ax);
    frame = frame.cdata;
    imwrite(frame, fullfile(dir_path, sprintf('frame_%04d.png', i)));
    
    mu = mu + delta;
    pause(delay);
end
