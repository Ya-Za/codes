close('all');
clear();
clc();

% monthes
hold('on');
% - persian
persianColors = lines(12);
englishColors = prism(12);
plotMonthes(getPersianMonthes(), persianColors, 0, 1, false);
plotMonthes(getPersianMonthes(), persianColors, 360, 1, false);
% - english
plotMonthes(getEnglishMonthes(), englishColors, 9 * 30 + 10, 1.1, true);
hold('off');

% figure
set(gcf, ...
    'Name', 'Monthes', ...
    'Units', 'normalized', ...
    'OuterPosition', [0, 0, 1, 1] ...
);

% axis
axis([0, 2 * 360, 0, 2]);
set(gca, ...
    'Visible', 'off', ...
    'Xtick', [], ...
    'Ytick', [] ...
);

function plotMonthes(names, colors, s, h, up)
    for i = 1:12
        p1 = [s, h];
        p2 = [s + 30, h];
        plotSegment(p1, p2, names{i}, colors(i, :), up)
        
        s = s + 30;
    end
end

function plotSegment(p1, p2, txt, color, up)
    x = [p1(1), p2(1)];
    y = [p1(2), p2(2)];
    line(x, y, ...
        'LineWidth', 6, ...
        'Color', color ...
    );
    h = -0.1;
    if up
        h = 0.1;
    end
    text(...
        mean(x), ...
        mean(y) + h, ...
        txt, ...
        'FontSize', 12, ...
        'FontWeight', 'bold', ...
        'Color', color, ...
        'HorizontalAlignment', 'center' ...
    );
end

function monthes = getEnglishMonthes()
    monthes = {
        'Jan'
        'Feb'
        'Mar'
        'Apr'
        'May'
        'Jun'
        'Jul'
        'Aug'
        'Sep'
        'Oct'
        'Nov'
        'Dec'
    };
end

function monthes = getPersianMonthes()
    monthes = {
        'Far'
        'Ord'
        'Kho'
        'Tir'
        'Mor'
        'Sha'
        'Meh'
        'Aba'
        'Aza'
        'Dey'
        'Bah'
        'Esf'
    };
end
