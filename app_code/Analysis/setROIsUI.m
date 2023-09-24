function a = setROIsUI(a, g)
%SETROISUI 

%% UI
cla(a.UIAxes5, "reset"); cla(a.UIAxes5_2, "reset"); cla(a.UIAxes5_3, "reset");
cla(a.UIAxes5_4, "reset");

%% ROIS
if isempty(g.GraFTed.ROIs)
    g.GraFTed.ROIs = 1:size(g.GraFTed.spatial, 3);
end
a.ListBox_2.Items = arrayfun(@(x) ['ROI ' num2str(x)], g.GraFTed.ROIs, 'UniformOutput', false);

%% Artifacts
if length(g.GraFTed.ROIs) ~= size(g.GraFTed.spatial,3)
    limit = size(g.GraFTed.spatial, 3);
    g.GraFTed.artifacts = find(~ismember(1:limit, g.GraFTed.ROIs));
end
a.ListBox_3.Items = arrayfun(@(x) ['ROI ' num2str(x)], g.GraFTed.artifacts, 'UniformOutput', false);

%% Colored projection
if isempty(g.GraFTed.projection_cols)
    g.GraFTed.projection_cols = plotDifferentColoredROIS(g.GraFTed.spatial);
end
% First ROI initialized
imagesc(a.G.GraFTed.projection_cols(:,:,1), 'Parent', a.UIAxes5_3);
axis(a.UIAxes5_3, 'image');
% Fix FOV
if ~isempty(a.G.Parameters.Parameters.mask)
    % get ranges to cut
    [rows, col] = find(a.G.Parameters.Parameters.mask);
    top_row = min(rows);
    bot_row = max(rows);
    left_col = min(col);
    right_col = max(col);
    set(a.UIAxes5_3, 'XLim', [left_col, right_col], 'YLim', [top_row, bot_row])
end
title(a.UIAxes5_3, 'ROI-1')
a.UIAxes5_3.Title.Color = 'w';
colormap(a.UIAxes5_3, a.ColormapDropDown_2.Value)
set(a.UIAxes5_3, 'YTick', [], 'XTick', []);

%% Temporal Image Plot
if isempty(g.GraFTed.plot_image)
    g.GraFTed.plot_image = g.GraFTed.temporal;
end
% First temporal initialized
plot(1:size(g.GraFTed.temporal, 1), g.GraFTed.plot_image(:,1), 'Parent', a.UIAxes5_4);
% Same color as line plot
color_all = a.UIAxes5_2.ColorOrder;
color_new = color_all(1, :);
% Modify
set(a.UIAxes5_4, 'Color', 'k', 'Xcolor', 'w', 'Ycolor', 'w', ...
    'XLim', [0, a.TimeFrameEditField.Value], ...
    'ColorOrder', color_new);
yticks(a.UIAxes5_4, 'auto'); yticklabels(a.UIAxes5_4, 'auto');
% Legend
legend(a.UIAxes5_4, 'ROI 1', 'Color', 'w');

%% Temporal line plot
[rows, cols] = size(g.GraFTed.temporal);
if isempty(g.GraFTed.plot_line)
    % Vertical offset
    offset = max(g.GraFTed.temporal(:)) * (0:cols-1)';
    % Create data
    data = zeros(rows, cols);
    for col = 1:cols
        data(:,col) = g.GraFTed.temporal(:, col) + offset(col);
    end
    g.GraFTed.plot_line = data;
end
% Color Map per ROI
color_map = distinguishable_colors(cols, {'w', 'k'});
plot(1:rows, g.GraFTed.plot_line, 'Parent', a.UIAxes5_2);

% Add a legend to identify each cell trajectory
line_names = arrayfun(@(x) ['ROI ' num2str(x)], 1:cols, 'UniformOutput', false);
x_lines = zeros(1, cols);
y_lines = g.GraFTed.plot_line(1, 1:cols);
text(x_lines, y_lines, line_names, 'Color', 'w', 'Parent', a.UIAxes5_2)

set(a.UIAxes5_2, 'Color', 'k', 'Xcolor', 'w', 'YTick', [], 'Ycolor', 'w',...
    'ColorOrder', color_map);
set(get(a.UIAxes5_2, 'ylabel'), 'string', 'ROIs')

%% UIVisibilities
a.GridLayout94.Visible = 'on';          % bottom left and roi stuff
a.GridLayout108.Visible = 'on';         % Time frame and temporal view mode
a.GridLayout90.Visible = 'on';          % top two plots
a.UIAxes5_4.Visible = 'on';             % bottom right axes
a.ColormapDropDown_2.Visible = 'on';    % colormap
a.ColormapLabel.Visible = 'on';         % colormap label

%% Out
a.G = g;

