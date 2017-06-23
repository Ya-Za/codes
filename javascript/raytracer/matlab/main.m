%% Init
close('all');
clear();
clc();

%% Scene
limits = [-10, 10];
elements = {};
% axes
elements{end + 1} = Axes(...
    [0.0, 0.0, 0.0], ...
    [1.0, 0.0, 0.0], ...
    [0.0, 1.0, 0.0], ...
    [0.0, 0.0, 1.0] ...
);
% lights
elements{end + 1} = Light([-2.0, 2.5, 0.0], [0.49, 0.07, 0.07]);
elements{end + 1} = Light([1.5, 2.5, 1.5], [0.07, 0.07, 0.49]);
elements{end + 1} = Light([1.5, 2.5, -1.5], [0.07, 0.49, 0.07]);
elements{end + 1} = Light([0.0, 3.5, 0.0], [0.21, 0.21, 0.35]);
% planes
elements{end + 1} = Plane([0.0, 0.0, 0.0], [0.0, 1.0, 0.0], limits);
% spheres
elements{end + 1} = Sphere([0.0, 1.0, -0.25], 1.0);
elements{end + 1} = Sphere([-1.0, 0.5, 1.5], 0.5);
% camera
elements{end + 1} = Camera([3.0, 2.0, 4.0], [-1.0, 0.5, 0.0]);


% scene
scene = Scene(elements);

%% Plot
hold('on');

scene.plot();

axis('equal');
set(gca, ...
    'XLim', limits, ...
    'YLim', limits, ...
    'ZLim', limits, ...
    'XAxisLocation', 'origin', ...
    'YAxisLocation', 'origin' ...
);
xlabel('x');
ylabel('y');
zlabel('z');
