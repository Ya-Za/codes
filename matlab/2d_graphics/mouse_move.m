function mouse_move (hObject, ~)
st = get(gcf,'SelectionType');
if ~strcmp(st, 'alt')
    return
end
ax = gca;

cp = get(ax, 'CurrentPoint');

x = cp(1, 1);
xlim = ax.XLim;
if x < xlim(1) || x > xlim(2)
    return;
end

y = cp(1, 2);
ylim = ax.YLim;
if y < ylim(1) || y > ylim(2)
    return
end

title(gca, ['(X,Y) = (', num2str(x), ', ',num2str(y), ')']);