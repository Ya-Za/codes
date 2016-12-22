function [ v ] = yzdconvn( w, u )
%YZDCONVN returns v so that, w = u * v
%     >> u = [1, 2, 3]'
%     >> w = [1, 4, 7, 6]'
%     >> yzdconvn(w, u)
%     [1, 2]'

o = size(w);
m = size(u);
n = o - m + 1;

A = yzconvnmat(n, u);
v = pinv(A) * w;
end

