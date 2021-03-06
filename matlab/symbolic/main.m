%%
close('all');
clear();
clc();

%%
syms('x');
x0 = 0;
x1 = 1;
x2 = 2;
x3 = 3;

f(x) = piecewise(...
    x >= x0 & x < x1, -x, ...
    x >= x1 & x < x2, 0, ...
    x >= x2 & x <= x3, x ...
);

% fplot(f(x));

% hold('on');
% fplot(f(x), [x0, x1]);
% fplot(f(x), [x1, x2]);
% fplot(f(x), [x2, x3]);
% hold('on');


axis('tight');