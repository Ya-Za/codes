function [ b ] = yzsubmatrix( a, lists_a )
%YZSUBMATRIX b = a(lists)
%   a : array
%   lists : cell array
%   b : array
%   >> a = reshape(1:9, 3, 3)
%   >> lists = {};
%   >> lists{1} = [1, 2];
%   >> lists{2} = [2, 3];
%   >> yzsubmatrix(a, lists)
%   4 7
%   5 8

ndims_b = length(lists_a);
size_b = zeros(1, ndims_b);
for i = 1:ndims_b
    size_b(i) = length(lists_a{i});
end

b = zeros(size_b);

% b indexes
lists_b = cell(ndims_b, 1);
for i = 1:ndims_b
    lists_b{i} = 1:size_b(i);
end
indexes_b = Product(lists_b);

% a indexes
indexes_a = Product(lists_a);
size_a = size(a);

for i = 1:prod(size_b)
    b(yzindex(size_b, indexes_b.values(i, :))) = ...
        a(yzindex(size_a, indexes_a.values(i, :)));
end

end

