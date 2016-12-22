function [ v ] = yzdconv( w, u, shape)
%YZDCONV w = u * v
%     % full
%     >> u = [1, 2, 3]
%     >> w = [1, 4, 7, 6]
%     >> yzdconv(w, u, 'full')
%     [1, 2]
%     % valid
%     >> u = [1, 2, 3]
%     >> w = [4, 7]
%     >> yzdconv(w, u, 'valid')
%     [1, 2]
o = length(w);
m = length(u);

if strcmp(shape, 'full')
    n = o - m + 1;
    u = [zeros(1, n - 1), u, zeros(1, n - 1)];
end

if strcmp(shape, 'valid')
    n = m - o + 1;
end

A = zeros(o, n);
for i = 1:o
    A(i, :) = u(i: i + n - 1);
end

v = A \ w';
v = fliplr(v');
end

