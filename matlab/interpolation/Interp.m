classdef Interp < handle
    %Implements `interpolation` methods
    
    properties (Access = private)
        x
        y
        
        minx
        maxx
    end
    
    methods
        function obj = Interp(x, y)
            % x
            obj.x = x;
            obj.minx = min(x);
            obj.maxx = max(x);
            % y
            obj.y = y;
        end
        
        function index = indexOf(obj, xq)
            %Index of query point in given data
            if xq <= obj.minx
                index = 1;
            elseif xq >= obj.maxx
                index = length(obj.x);
            else
                for index = 1:length(obj.x)
                    if obj.x(index) >= xq
                        break
                    end
                end
            end
        end
        
        function points = selectPoints(obj, xq, n)
            % Select `n` points before and `n` points after query point
            index = obj.indexOf(xq);
            
            % previous points
            previousPoints = zeros(2, n);
            for i = 1:n
                validIndex = max(1, index - i);
                previousPoints(:, i) = ...
                    [obj.x(validIndex); obj.y(validIndex)];
            end
            
            % next points
            nextPoints = zeros(2, n);
            maxIndex = length(obj.x);
            for i = 1:n
                validIndex = min(maxIndex, index + (i-1));
                nextPoints(:, i) = ...
                    [obj.x(validIndex); obj.y(validIndex)];
            end
            
            points = [fliplr(previousPoints), nextPoints];
        end
        
        function Yq = do(obj, Xq, method, n)
            if ~exist('n', 'var')
                if strcmp(method, 'spline')
                    n = 2;
                else
                    n = 1;
                end
            end

            interpolator = Interp.selectInterploator(method);
            
            Yq = zeros(size(Xq));
            for i = 1 : length(Xq)
                xq = Xq(i);
                Yq(i) = interpolator(...
                    xq, ...
                    obj.selectPoints(xq, n) ...
                );
            end
        end
    end
    
    % Interpolators
    methods (Static)
        function interpolator = selectInterploator(method)
            switch method
                case 'next'
                    interpolator = @Interp.next;
                case 'previous'
                    interpolator = @Interp.previous;
                case 'nearest'
                    interpolator = @Interp.nearest;
                case 'poly'
                    interpolator = @Interp.poly;
                case 'spline'
                    interpolator = @Interp.spline;
                case 'bazier'
                    interpolator = @Interp.bazier;
                otherwise
                    interpolator = @Interp.spline;
            end
        end
        
        function yq = next(~, points)
            % Next
            %
            % Parameters
            % ----------
            % - xq: double
            %   `x` of query point
            % - points: 2-by-2n double matrix
            %   `n` points before and `n` points after the query point
            %
            % Returns
            % -------
            % - yq: double
            %   `y` of query point
            
            yq = points(2, 2);
        end
        
        function yq = previous(~, points)
            % Previous
            
            yq = points(2, 1);
        end
        
        function yq = nearest(xq, points)
            % Nearest
            
            if (points(1, 2) - xq) < (xq - points(1, 1))
                yq = points(2, 2);
            else
                yq = points(2, 1);
            end
        end
        
        function yq = poly(xq, points)
            % Polynomial
            x = points(1, :)';
            y = points(2, :)';
            
            % degree of polynomial is `n - 1`
            n = length(x);
            
            % Xa = y
            X = ones(n);
            
            for i = 2:n
                X(:, i) = X(:, i-1) .* x;
            end
            
            % coefficients
            p = X \ y;
            
            % value of polynomial
            yq = polyval(fliplr(p'), xq);
        end
        
        function yq = spline(xq, points)
            % Spline
            x = points(1, :);
            y = points(2, :);
            x1 = x(2);
            x2 = x(3);
            y1 = y(2);
            y2 = y(3);
            y1_ = (y(3) - y(1)) / (x(3) - x(2));
            y2_ = (y(4) - y(2)) / (x(4) - x(2));
            
            % Xa = y
            X = [
                1 x1 x1^2 x1^3
                1 x2 x2^2 x2^3
                0 1  2*x1 3*x1^2
                0 1  2*x2 3*x2^2
            ];
        
            % coefficients
            p = X \ [y1, y2, y1_, y2_]';
            
            % value of polynomical
            yq = polyval(fliplr(p'), xq);
        end
        
        function yq = bazier(xq, points)
            % Bazier
            dx = points(1, end) - points(1, 1);
            if dx == 0
                yq = points(2, 1);
                return;
            end
            t = (xq - points(1, 1)) / dx;
            
            p = [0, 0]';
            n = size(points, 2);
            for i = 1:n
                p = p + b(t, i - 1, n - 1) * points(:, i);
            end

            function value = b(t, i, n)
                value = nchoosek(n, i) * t^i * (1 - t)^(n - i);
            end
            
            yq = p(2);
        end
    end
    
    methods (Static)
        function yq = interp(x, y, xq, method, n)
            if ~exist('n', 'var')
                if strcmp(method, 'spline')
                    n = 2;
                else
                    n = 1;
                end
            end

            interpObj = Interp(x, y);
            yq = interpObj.do(xq, method, n);
        end
        
        function plot(x, y, xq, method, n)
            if ~exist('n', 'var')
                if strcmp(method, 'spline')
                    n = 2;
                else
                    n = 1;
                end
            end

            yq = Interp.interp(x, y, xq, method, n);
            
            figure('Name', method);
            % query points
%             plot(...
%                 xq, yq, ...
%                 'LineStyle', '-', ...
%                 'Color', 'blue' ...
%             );

            scatter(...
                xq, yq, ...
                'FaceColor', 'blue' ...
            );
            
            % points
            hold('on');
            scatter(...
                x, y, ...
                'FaceColor', 'red' ...
            );
            hold('off');
            axis('tight');
        end
    end
    
end

