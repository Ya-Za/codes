function [ v1, v2 ] = yz_meshgrid( u1, u2 )
%UNTITLED16 Summary of this function goes here
%   Detailed explanation goes here

m = length(u2);
n = length(u1);

v1 = repmat(u1, m, 1);
v2 = repmat(u2', 1, n);

end

