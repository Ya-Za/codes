%% Init
close('all');
clear;
clc;

%% 
cdata = flipdim( imread('peppers.png'), 1 );
cdatar = flipdim( cdata, 2 );
% bottom
surface([-1 1; -1 1], [-1 -1; 1 1], [-1 -1; -1 -1], ...
    'FaceColor', 'texturemap', 'CData', cdatar );
% top
surface([-1 1; -1 1], [-1 -1; 1 1], [1 1; 1 1], ...
    'FaceColor', 'texturemap', 'CData', cdata );
% front
surface([-1 1; -1 1], [-1 -1; -1 -1], [-1 -1; 1 1], ...
    'FaceColor', 'texturemap', 'CData', cdata );
% back
surface([-1 1; -1 1], [1 1; 1 1], [-1 -1; 1 1], ...
    'FaceColor', 'texturemap', 'CData', cdatar );
% left
surface([-1 -1; -1 -1], [-1 1; -1 1], [-1 -1; 1 1], ...
    'FaceColor', 'texturemap', 'CData', cdatar );
% right
surface([1 1; 1 1], [-1 1; -1 1], [-1 -1; 1 1], ...
    'FaceColor', 'texturemap', 'CData', cdata );
view(3);