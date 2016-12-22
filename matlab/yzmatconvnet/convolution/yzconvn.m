function w = yzconvn( u, v, shape)
%YZCONVN w = u * v

if ndims(u) ~= ndims(v)
    error('Error: ndims(u) != ndims(v)');
end

ndims_ = ndims(u);

m = size(u);
n = size(v);
o = m + n - 1;

w = zeros(o);

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
        w(yzindex(o, k)) = w(yzindex(o, k)) + ...
            u(yzindex(m, j)) * ...
            v(yzindex(n, k - j + 1));
    end
end

if strcmp(shape, 'valid')
    lists = cell(1, ndims_);
    for i = 1:ndims_
        lists{i} = n(i):m(i);
    end
    w = yzsubmatrix(w, lists);
end

if strcmp(shape, 'same')
    lists = cell(1, ndims_);
    for i = 1:ndims_
        begin_index = int32((o(i) - m(i)) / 2) + 1;
        end_index = begin_index + m(i) - 1;
        lists{i} = begin_index:end_index;
    end
    
    w = yzsubmatrix(w, lists);
end

end
