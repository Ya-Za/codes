classdef LA < handle
    % Linear Algebra
    % https://en.wikipedia.org/wiki/Fundamental_theorem_of_linear_algebra
    
    properties
    end
    
    methods
    end
    
    methods (Static)
        % todo
        function tf = isref(A)
            % Is `A` in row echelon form
        end
        
        % todo
        function tf = isrref(A)
            % Is `A` in reduced row echelon form
        end
            
        function [R, jb] = rref(A, tol)
            % Reduced row echelon form (Gauss-Jordan elimination)
            % A matrix is in row echelon form if
            % - All nonzero rows (rows with at least one nonzero element)
            %   are above any rows of all zeroes (all zero rows, if any,
            %   belong at the bottom of the matrix)
            % - The leading coefficient (the first nonzero number from the
            %   left, also called the pivot) of a nonzero row is always
            %   strictly to the right of the leading coefficient of the row
            %   above it (some texts add the condition that the leading
            %   coefficient must be 1).
            % A matrix is in reduced row echelon form (also called row
            % canonical form) if it satisfies the following conditions:
            % - It is in row echelon form.
            % - Every leading coefficient is 1 and is the only nonzero
            %   entry in its column.
            %
            % There are three types of elementary row operations which may
            % be performed on the rows of a matrix: 
            % Type 1: Swap the positions of two rows.
            % Type 2: Multiply a row by a nonzero scalar.
            % Type 3: Add to one row a scalar multiple of another.
            %
            % - r = length(jb) is this algorithm's idea of the rank of A.
            % - x(jb) are the pivot variables in a linear system Ax = b.
            % - A(:,jb) is a basis for the range of A. 
            % - R(1:r,jb) is the r-by-r identity matrix.
            
            if ~exist('tol', 'var')
                tol = 1e-6;
            end
            R = A;
            jb = [];
            [m, ~] = size(A);
            
            for r = 1:m
                [i, j] = nextPivot(r);
                
                if isempty(i)
                    break;
                end
                
                jb = [jb, j];
                
                % type 1
                if i ~= r
                    swap(i, r);
                end
                
                % type 2
                scale(r, 1/R(r, j));
                
                % type 3
                for rr = 1:m
                    if rr == r
                        continue;
                    end
                    
                    s = R(rr, j);
                    % `s` is negligible
                    if abs(s) < tol
                        R(rr, j) = 0;
                        continue;
                    end
                    
                    add(r, -s, rr);
                end
            end
            
            % Local functions
            function swap(i, j)
                % Type 1: Swap the positions of two rows.
                R([i, j], :) = R([j, i], :);
            end
            function scale(i, s)
                % Type 2: Multiply a row by a nonzero scalar.
                R(i, :) = s * R(i, :);
            end
            function add(i, s, j)
                % Type 3: Add to one row a scalar multiple of another.
                R(j, :) = R(j, :) + s * R(i, :);
            end
            function [i, j] = nextPivot(r)
                % R(i >= r, j) is the next pivot with minimum column index. 
                i = [];
                j = inf;
                
                while r <= m
                    % column of pivot. ignore negligible entries
                    c = find(abs(R(r, :)) > tol, 1);
                    if ~isempty(c) && c < j
                        i = r;
                        j = c;
                    end
                    
                    r = r + 1;
                end
            end
        end
        
        function A = orth(A)
            % Orthonormal basis for range of matrix
            % todo: (https://en.wikipedia.org/wiki/Gram%E2%80%93Schmidt_process)
            A(:, 1) = A(:, 1) / norm(A(:, 1));
            
            for c = 2:size(A, 2)
                u = A(:, c);
                
                % orthogonal
                u = u - LA.proj(u, A(:, 1:c-1));
                % normal
                u = u / norm(u);
                
                A(:, c) = u;
            end
            
        end
        
        function p = proj(u, B)
            % Projection of vector on range of matrix
            p = B * inv(B' * B) * B' * u;
        end
        
        function B = colspace(A)
            % Orthonormal basis for range of matrix
            % the column space (also called the range or image) of a matrix
            % A is the span (set of all possible linear combinations) of
            % its column vectors (any vector, b, that is a solution to the
            % linear equation, A*x = b, is included in the range of A).
            [R, jb] = LA.rref(A);
            B = R(:, jb);
            B = LA.orth(B);
        end
        
        function B = rowspace(A)
            % Row space
            [R, jb] = LA.rref(A);
            r = length(jb);
            B = R(1:r, :)';
            B = LA.orth(B);
        end
        
        function B = null(A)
            % Null space
            [~, n] = size(A);
            % jb is indeces of basis(pivot) columns
            [R, jb] = LA.rref(A);
            % all columns
            j = 1:n;
            % jf_ is indeces of free columns
            j(jb) = 0;
            jf = find(j);
            
            rank = length(jb);
            nullity = length(jf);
            B = zeros(n, nullity);
            if nullity == 0
                return;
            end
            for i = 1:nullity
                col = zeros(n, 1);
                col(jf(i)) = 1;
                for j = 1:rank
                    col(jb(j)) = -R(j, jf(i));
                end
                B(:, i) = col;
            end
            
            B = LA.orth(B);
        end
        
        function r = rank(A)
            % Rank of matrixr
            [~, jb] = LA.rref(A);
            r = length(jb);
        end

        function [U, S, V] = svd(A)
            % Singular value decomposition
            % svd(A) performs a singular value decomposition of matrix A,
            % such that A = U*S*V'.
            
            [m, n] = size(A);
            r = rank(A);
            
            V = LA.rowspace(A);
            U = A * V;
            
            s = zeros(1, r);
            for i = 1:r
                s(i) = norm(U(:, i));
                U(:, i) = U(:, i) / s(i);
            end
            
            % sort
            [s, I] = sort(s, 'descend');
            V = V(:, I);
            U = U(:, I);
            
            V = [V, LA.null(A)];
            U = [U, LA.null(A')];
            S = zeros(m, n);
            S(1:r, 1:r) = diag(s);
        end
        
        function d = det(A)
            % Determinant of square matrix A
            [m, n] = size(A);
            if m ~= n
                error('Matrix must be square.');
            end
            
            if n == 1
                d = A;
                return;
            end
            
            d = 0;
            for j = 1:n
                d = d + A(1, j) * LA.C(A, 1, j);
            end
        end
        
        function c = C(A, i, j)
            % Cofactor of A(i, j)
            c = (-1)^(i + j) * LA.M(A, i, j);
        end
        
        function m = M(A, i, j)
            % Minor of A(i, j)
            A(i, :) = [];
            A(:, j) = [];
            m = LA.det(A);
        end
        
        function d = det2(A)
            % Determinant of square matrix `A` Gaussian elimination
            [m, n] = size(A);
            if m ~= n
                error('Matrix must be square.');
            end
            
            tol = 1e-6;
            d = 1;
            R = A;
            for r = 1:m
                [i, j] = nextPivot(r);
                
                if isempty(i)
                    break;
                end
                
                % type 1
                if i ~= r
                    swap(i, r);
                    d = -1 * d;
                end
                
                % type 2
                s = 1/R(r, j);
                scale(r, s);
                d = s * d;
                
                % type 3
                for rr = 1:m
                    if rr == r
                        continue;
                    end
                    
                    s = R(rr, j);
                    % `s` is negligible
                    if abs(s) < tol
                        R(rr, j) = 0;
                        continue;
                    end
                    
                    add(r, -s, rr);
                end
            end
            
            d = prod(diag(R)) / d;
            
            % Local functions
            function swap(i, j)
                % Type 1: Swap the positions of two rows.
                R([i, j], :) = R([j, i], :);
            end
            function scale(i, s)
                % Type 2: Multiply a row by a nonzero scalar.
                R(i, :) = s * R(i, :);
            end
            function add(i, s, j)
                % Type 3: Add to one row a scalar multiple of another.
                R(j, :) = R(j, :) + s * R(i, :);
            end
            function [i, j] = nextPivot(r)
                % R(i >= r, j) is the next pivot with minimum column index. 
                i = [];
                j = inf;
                
                while r <= m
                    % column of pivot. ignore negligible entries
                    c = find(abs(R(r, :)) > tol, 1);
                    if ~isempty(c) && c < j
                        i = r;
                        j = c;
                    end
                    
                    r = r + 1;
                end
            end
        end
        
        function B = inv(A)
            % Computes the inverse of square matrix X.
            [m, n] = size(A);
            if m ~= n
                error('Matrix must be square.');
            end
            
            B = LA.comatrix(A)' / LA.det(A);
        end
        
        function C = comatrix(A)
            % Matrix of cofactors
            [m, n] = size(A);
            C = zeros(m, n);
            
            for i = 1:m
                for j = 1:n
                    C(i, j) = LA.C(A, i, j);
                end
            end
        end
        
        function B = inv2(A)
            % Computes the inverse of square matrix X.
            [m, n] = size(A);
            if m ~= n
                error('Matrix must be square.');
            end
            
            tol = 1e-6;
            d = 1;
            R = [A, eye(m)];
            for r = 1:m
                [i, j] = nextPivot(r);
                
                if isempty(i)
                    break;
                end
                
                % type 1
                if i ~= r
                    swap(i, r);
                end
                
                % type 2
                scale(r, 1/R(r, j));
                
                % type 3
                for rr = 1:m
                    if rr == r
                        continue;
                    end
                    
                    s = R(rr, j);
                    % `s` is negligible
                    if abs(s) < tol
                        R(rr, j) = 0;
                        continue;
                    end
                    
                    add(r, -s, rr);
                end
            end
            
            if prod(diag(R)) < tol
                warning('Matrix is singular to working precision.');
                B = inf(m);
            else
                B = R(:, n+1:end);
            end
            
            % Local functions
            function swap(i, j)
                % Type 1: Swap the positions of two rows.
                R([i, j], :) = R([j, i], :);
            end
            function scale(i, s)
                % Type 2: Multiply a row by a nonzero scalar.
                R(i, :) = s * R(i, :);
            end
            function add(i, s, j)
                % Type 3: Add to one row a scalar multiple of another.
                R(j, :) = R(j, :) + s * R(i, :);
            end
            function [i, j] = nextPivot(r)
                % R(i >= r, j) is the next pivot with minimum column index. 
                i = [];
                j = inf;
                
                while r <= m
                    % column of pivot. ignore negligible entries
                    c = find(abs(R(r, :)) > tol, 1);
                    if ~isempty(c) && c < j
                        i = r;
                        j = c;
                    end
                    
                    r = r + 1;
                end
            end
        end
    end
    
end
