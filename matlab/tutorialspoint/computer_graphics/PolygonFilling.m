classdef PolygonFilling
    %POLYGONFILLING
    
    properties
    end
    
    methods
    end
    
    methods (Static)
        function floodfill(boundary_image, in_point)
            % FLOODFILL
            
            % parameters
            delay = 0.001;
            queue = {};
            [height, width] = size(boundary_image);
            
            % mark and enqueue `in_point`
            boundary_image(in_point(2), in_point(1));
            queue{end + 1} = in_point;
            imshow(boundary_image);
            
            while ~isempty(queue)
                % dequeue
                point = queue{1};
                queue(1) = [];
                % neighbours
                % - get
                neighbours = PolygonFilling.get_neighbours(point);
                % - validate
                neighbours = PolygonFilling.validate_neighbours(neighbours, height, width);
                
                % mark and enqueue if it's not seen
                for i = 1:length(neighbours)
                    x = neighbours{i}(1);
                    y = neighbours{i}(2);
                    if ~boundary_image(y, x)
                        boundary_image(y, x) = true;
                        queue{end + 1} = neighbours{i};
                    end
                end
                
                imshow(boundary_image);
                pause(delay);
            end
        end
        
%         function scanline(bw)
%             % SCANLINE
%             
%             % params
%             delay = 0.001;
%             
%             % fill inside
%             box = Utils.get_bounding_box(bw);
%             
%             filled_bw = bw;
%             
%             x_min = max(2, box.x);
%             x_max = box.x + box.width - 1;
%             y_min = box.y;
%             y_max = box.y + box.height - 1;
%             % main loop
%             for y = y_min:y_max
%                 inside = false;
%                 for x = x_min:x_max
%                     if ~bw(y, x - 1) && bw(y, x)
%                         inside = ~inside;
%                     end
%                     
%                     if ~bw(y, x) && inside
%                         filled_bw(y, x) = true;
%                     end
%                 end
%                 
%                 % show progress
%                 imshow(filled_bw);
%                 pause(delay);
%             end
%         end

            function scanline(bw)
            % SCANLINE
            
            % params
            delay = 0.001;
            
            % fill inside
            box = Utils.get_bounding_box(bw);
            
            filled_bw = bw;
            
            x_min = box.x;
            x_max = box.x + box.width - 1;
            y_min = box.y;
            y_max = box.y + box.height - 1;
            % main loop
            for y = y_min:y_max
                edges = [];
                for x = x_min:x_max
                    if ~bw(y, x - 1) && bw(y, x)
                        edges(end + 1) = x;
                    end
                    
                    if mod(length(edges), 2) == 0
                        for i = 1:2:length(edges)
                            filled_bw(y, edges(i):edges(i + 1)) = true;
                        end
                    end
                end
                
                % show progress
                imshow(filled_bw);
                pause(delay);
            end
        end
        
        function neighbours = get_neighbours(point)
            % GET_NEIGHBOURS
            x = point(1);
            y = point(2);
            neighbours = {
                [x    , y - 1] % up
                [x + 1, y    ] % right
                [x    , y + 1] % down
                [x - 1, y    ] % left
            };
        end
        
        function valid_neighbours = validate_neighbours(neighbours, height, width)
            valid_neighbours = {};
            for i = 1:length(neighbours)
                x = neighbours{i}(1);
                y = neighbours{i}(2);
                if x >= 1 && x <= width && y >= 1 && y <= height
                    valid_neighbours{end + 1} = neighbours{i};
                end
            end
        end
    end
end

