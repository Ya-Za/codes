function image = subplot_boxes( m, n, width, height )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

spaces_per_box = 4;

box.width = get_box_width(width, n, spaces_per_box);
box.height = get_box_width(height, m, spaces_per_box);

space.width = floor(box.width / spaces_per_box);
space.height = floor(box.height / spaces_per_box);

image = 0.94 * ones(height, width);
for r = 1:m
    for c = 1:n
        x1 = (c - 1) * (box.width + space.width) + 1;
        x2 = x1 + box.width - 1;
        
        
        y1 = (r - 1) * (box.height + space.height) + 1;
        y2 = y1 + box.height - 1;
        
        if r == m && c == n
            image(y1:end, x1:end) = 1;
        elseif r == m
            image(y1:end, x1:x2) = 1;
        elseif c == n
            image(y1:y2, x1:end) = 1;
        else
           image(y1:y2, x1:x2) = 1; 
        end
    end
end

end

function box_width = get_box_width(total_width, number_of_boxes, spaces_per_box)
    box_width = floor(...
        (spaces_per_box * total_width) / ...
        ((spaces_per_box + 1) * number_of_boxes - 1));
end

