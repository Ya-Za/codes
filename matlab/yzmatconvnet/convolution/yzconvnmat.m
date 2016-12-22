function A = yzconvnmat( m, v, shape)
%YZCONVN if w = u * v, yzconvnmat reterns matrix 'A' so that w = A * u
%     >> u = [1, 2, 3]
%     >> v = [1, 2]
%     >> yzconvnmat(u, v)
%     1 0 0
%     2 1 0
%     0 2 1
%     0 0 2

if length(m) ~= ndims(v)
    error('Error: ndims(u) != ndims(v)');
end

ndims_ = length(m);

n = size(v);
o = m + n - 1;

A = zeros(prod(o), prod(m));

% w indexes
lists = cell(ndims_);
for i = 1:ndims_
    lists{i} = 1:o(i);
end
w_indexes = Product(lists);

for k = w_indexes.values'
    k = k';
    % u, v indexes
    lists = cell(ndims_);
    for i = 1:ndims_
        lists{i} = max(1, k(i) + 1 - n(i)):min(k(i), m(i));
    end
    uv_indexes = Product(lists);
    
    for j = uv_indexes.values'
        j = j';
        A(yzindex(o, k), yzindex(m, j)) = v(yzindex(n, k - j + 1));
    end
end

end
