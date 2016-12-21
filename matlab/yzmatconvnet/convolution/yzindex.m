function [ index ] = yzindex( size_, index_array )
%YZINDEX returns eqevalent 1d index of index_array
%   >> size_ = [2, 2, 2]
%   >> a = reshape(1:8, size_)
%   >> yzindex(size_, [2, 1, 2]) == a(2, 1, 2)
%   true

size_(2: end) = size_(1: end - 1);
size_(1) = 1;
for i = 2:length(size_)
    size_(i) = size_(i) * size_(i - 1);
end

index = dot(size_, index_array - 1) + 1;
