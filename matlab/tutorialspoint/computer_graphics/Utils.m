classdef Utils
    %UTILS
    
    properties
    end
    
    methods (Static)
        function boundary = get_boundary(bw)
            % GET_BOUNDARY
            
            % parameters
            [height, width]= size(bw);
            boundary = {};
            
            % if bw(y, x) is true then (y, x) on boundary
            for y = 1:height
                for x = 1:width
                    if bw(y, x)
                        boundary{end + 1} = [x, y];
                    end
                end
            end
            
            % convert row-vector to column-vector
            boundary = boundary';
        end
        
        function box = get_bounding_box(bw)
            % GET_BOUNDING_BOX
            % get boundary
            boundary = Utils.get_boundary(bw);
            
            % x, y
            x = cellfun(@(x) x(1), boundary);
            y = cellfun(@(x) x(2), boundary);
            
            % x_min, x_max, y_min, x_max
            x_min = min(x);
            x_max = max(x);
            y_min = min(y);
            y_max = max(y);
            
            % box
            box.x = x_min;
            box.y = y_min;
            box.width = x_max - x_min + 1;
            box.height = y_max - y_min + 1; 
        end
        
        function insert_bounding_box(bw)
            % INSERT_BOUNDING_BOX
            box = Utils.get_bounding_box(bw);
            bw = double(bw);
            bw = insertShape(bw, 'rectangle', [box.x, box.y, box.width, box.height]);
            figure(), imshow(bw);
        end
        
        function alpha = angle(u, v)
            % ANGLE
            alpha = abs(...
                atan2(u(2), u(1)) - ...
                atan2(v(2), v(1)) ...
            );
        
            alpha = acos(...
                dot(u, v) / ...
                (norm(u) * norm(v)) ...
            );
        end
        
        function alpha = angled(u, v)
            % ANGLED
            alpha = rad2deg(...
                Utils.angle(u, v)...
            );
        end
    end
end

