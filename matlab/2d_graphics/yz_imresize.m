function [ output_image ] = yz_imresize( input_image, sx, sy )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

input_height = size(input_image, 1);
input_width = size(input_image, 2);
number_of_channels = size(input_image, 3);

output_height = floor(sy * input_height);
output_width = floor(sx * input_width);

output_image = zeros(output_height, output_width, number_of_channels,  'like', input_image);

% % method 1 -> time expensive !
% for y = 1:output_height
%     for x = 1:output_width
%         yy = floor((y - 1) / sy) + 1;
%         xx = floor((x - 1) / sx) + 1;
%         
%         for c = 1:number_of_channels
%             output_image(y, x, c) = input_image(yy, xx, c);
%         end
%     end
% end

% method 2
for y = 1:input_height
    for x = 1:input_width
        yy1 = floor((y - 1) * sy) + 1;
        yy2 = floor(y * sy);
        
        xx1 = floor((x - 1) * sx) + 1;
        xx2 = floor(x * sx);
                
        for c = 1:number_of_channels
            output_image(yy1:yy2, xx1:xx2, c) = input_image(y, x, c); 
        end
    end
end


end

