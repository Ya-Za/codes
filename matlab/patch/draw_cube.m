function draw_cube( scale, translate, face_color, face_alpha, edge_color, line_width )
%Draw Cubic

% default parameters
switch nargin
    case 2
        face_color = 'blue';
        face_alpha = 0.8;
        edge_color = 'black';
        line_width = 2;
    case 3
        face_alpha = 0.8;
        edge_color = 'black';
        line_width = 2;
    case 4
        edge_color = 'black';
        line_width = 2;
    case 5
        line_width = 2;
end

%
vertices = [
    0 0 0
    0 0 1
    0 1 0
    0 1 1
    1 0 0
    1 0 1
    1 1 0
    1 1 1
];

% vertices = vertices .* repmat(scale, size(vertices, 1), 1);
% vertices = vertices + repmat(translate, size(vertices, 1), 1);

vertices = vertices * diag(scale) + translate;

faces = [
    1 2 4 3
    5 6 8 7
    1 5 6 2
    3 7 8 4
    1 5 7 3
    2 6 8 4
];

patch(...
    'Faces', faces, ...
    'Vertices', vertices, ...
    'FaceColor', face_color, ...
    'FaceAlpha', face_alpha, ...
    'EdgeColor', edge_color, ...
    'LineWidth', line_width ...
);

axis('equal');
view(3);

end