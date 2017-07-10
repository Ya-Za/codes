function p = bazier2( t, P )
%Bazier curve
% Parameters
% ----------
% - t: double
%   Between 0 and 1
% - P: 2-by-n double matrix
%   Control points
%
% Returns
% -------
% - p: 2-by-1 vector
%   Output point

if size(P, 2) == 1
    p = P;
else
    p = (1 - t) * bazier2(t, P(:, 1:end-1)) + t * bazier2(t, P(:, 2:end));
end

end

