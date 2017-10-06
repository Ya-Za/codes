% Init
close('all');
clear();
clc();

% 
theta = pi / 2;
R = getR(pi / 2)

function R = getR(theta)
    c = cos(theta);
    s = sin(theta);
    
    R = [c, -s; s, c];
end
