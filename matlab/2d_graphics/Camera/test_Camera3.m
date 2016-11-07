%% Init
close all;
clear;
clc;

%% Properties
n = 10;                     % number of movements
limit = 20;                 % limit of plot

plane = [1, 3];
size_ = [100, 100];
aov = [90, 90];

%%

cam = Camera3();
axis([-limit, limit, -limit, limit]), grid on, grid minor;
xlabel('x'), ylabel('y'), zlabel('z');

% for i = 1:n
%     cla;
%     
%     cam2.t = cam2.t + rand(1, 2);
%     cam2.theta = cam2.theta + 10 * randn;
%     
%     cam2.update_pos();
%     cam2.draw();
%     
%     % pause(delay);
%     pause();
% end

movements = [
    [0, 0, 0], [0, 0, 0]
    [0, 45, 0], [0, 0, 0]
];

for i = 1:size(movements, 1)
    cam.theta = cam.theta + movements(i, 1:3);
    cam.t = cam.local_to_global(movements(i, 4:6));
    
    cam.draw();
    
    pause();
end