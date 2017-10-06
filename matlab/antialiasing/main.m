close('all');
clear();
clc();

x1 = 0;
y1 = 0;

x2 = 10;
y2 = 2;

[x, y, c] = XiaolinWu(x1, y1, x2, y2);
scatter(x, y, 1000, [c, c, c], 'filled', 's');
axis('equal');
