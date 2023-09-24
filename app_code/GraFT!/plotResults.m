function a = plotResults(a)
%PLOTRESULTS


%% ROIs (UIAxes4)
imagesc(a.G.GraFTed.spatial(:,:,a.Status.result_idx), 'Parent', a.UIAxes4);
set(a.UIAxes4, 'XTick', [], 'YTick', []);
colormap(a.UIAxes4, a.ColormapDropDown.Value);
axis(a.UIAxes4, 'image');

%% Fix FOV
if ~isempty(a.G.Parameters.Parameters.mask)
    % get ranges to cut
    [rows, col] = find(a.G.Parameters.Parameters.mask);
    top_row = min(rows);
    bot_row = max(rows);
    left_col = min(col);
    right_col = max(col);
    set(a.UIAxes4, 'XLim', [left_col, right_col], 'YLim', [top_row, bot_row])
end

%% Temporal (UIAxes4_2)
x = 1:size(a.G.GraFTed.temporal, 1);
y = a.G.GraFTed.temporal(:, a.Status.result_idx);
plot(x, y, 'Parent', a.UIAxes4_2);
set(a.UIAxes4_2, 'Color', 'k','Ycolor', 'w', 'Xcolor', 'w');
yticks(a.UIAxes4_2, 'auto'); yticklabels(a.UIAxes4_2, 'auto');
xticks(a.UIAxes4_2, 'auto'); xticklabels(a.UIAxes4_2, 'auto');

%% Label
a.xxLabel.Text = sprintf('%d/%d', a.Status.result_idx, size(a.G.GraFTed.spatial, 3));
end

