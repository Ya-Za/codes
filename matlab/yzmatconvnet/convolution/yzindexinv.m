function [ index_array ] = yzindexinv( size_, index )
%YZINDEXINV inverse of yzindex
%   >> size_ = [2, 2, 2]
%   >> yzindexinv(yzindex(size_, [2, 1, 2]))
%   [2, 1, 2]

size_(2: end) = size_(1: end - 1);
size_(1) = 1;
for i = 2:length(size_)
    size_(i) = size_(i) * size_(i - 1);
end

size_ = int32(size_);

length_ = length(size_);
index_array = zeros(1, length_);

index = index - 1;
for i = length_:-1:1
    index_array(i) = idivide(index, size_(i));
    index = mod(index, size_(i));
end

index_array = index_array + 1;
index_array = int32(index_array);

end

