classdef Camera < handle
    %Camera
    
    properties
        Position
        Target
        UpVector
        
        ViewAngle
    end
    
    properties (Access = private)
        ax
        target_
        upvector_
    end
    
    methods
        function obj = Camera()
            obj.ax = Axes();
            obj.reset();
        end
        
        function reset(obj)
            obj.ax.t = [-9, -12, 9]';
            obj.target_ = [0, 0, 0]';
            obj.upvector_ = [0, 0, 1]';
            obj.setOrientation();
            
            obj.ViewAngle = 10;
        end
        
        function value = get.Position(obj)
            value = obj.ax.t;
        end
        
        function set.Position(obj, value)
            obj.ax.t = value;
            obj.setOrientation();
        end
        
        function value = get.UpVector(obj)
            value = obj.upvector_;
        end
        
        function set.UpVector(obj, value)
            value = value(:);
            value = value / norm(value);
            obj.upvector_ = value;
            
            obj.setOrientation();
        end
        
        function value = get.Target(obj)
            value = obj.target_;
        end
        
        function set.Target(obj, value)
            obj.target_ = value(:);
            obj.setOrientation();
        end
        
        function setOrientation(obj)
            forward = obj.Target - obj.Position;
            forward = forward / norm(forward);
            
            right = cross(obj.UpVector, forward);
            right = right / norm(right);
            
            up = cross(forward, right);
            
            obj.ax.R = [right, up, forward];
        end
    end
    
    % toolbar
    methods
        function pan(obj, angle)
            targetPoint = obj.Target - obj.Position;
            targetPoint = Axes.Rz(angle) * targetPoint;
            targetPoint = targetPoint + obj.Position;
            
            obj.Target = targetPoint;
        end
        
        function tilt(obj, angle)
            targetPoint = obj.Target - obj.Position;
            targetPoint = Axes.Rx(angle) * targetPoint;
            targetPoint = targetPoint + obj.Position;
            
            obj.Target = targetPoint;
        end
        
        function moveH(obj, value)
            % Move horizentally
            % position
            obj.Position = obj.ax.T * [value, 0, 0, 1]';
            % target
            targetPoint = inv(obj.ax.T) * [obj.Target; 1];
            targetPoint(1) = targetPoint(1) + value;
            targetPoint = obj.ax.T * targetPoint;
            obj.Target = targetPoint;
        end
        
        function moveV(obj, value)
            % Move vertically
            % position
            obj.Position = obj.ax.T * [0, value, 0, 1]';
            % target
            targetPoint = inv(obj.ax.T) * [obj.Target; 1];
            targetPoint(2) = targetPoint(2) + value;
            targetPoint = obj.ax.T * targetPoint;
            obj.Target = targetPoint;
        end
        
        function moveF(obj, value)
            % Move forward
            % position
            obj.Position = obj.ax.T * [0, 0, value, 1]';
        end
        
        function zoom(obj, value)
            obj.ViewAngle = obj.ViewAngle + value;
        end
        
        function roll(obj, angle)
            obj.ax.R = Axes.rotation(obj.ax.k, angle) * obj.ax.R;
        end
        
        function orbit(obj, az, el)
            % todo:
            obj.Position = Axes.Ry(-el) * Axes.Rz(az) * obj.Position;
        end
    end
    
end

