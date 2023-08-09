function a = setROIsUI(a, g)
%SETROISUI 

%% UI
cla(a.UIAxes5, "reset"); cla(a.UIAxes5_2, "reset"); cla(a.UIAxes5_3, "reset");
cla(a.UIAxes5_4, "reset");

%% ROIS
if isempty(g.GraFTed.ROIs)
    g.GraFTed.ROIs = 1:size(g.GraFTed.spatial, 3);
end
num = length(g.GraFTed.ROIs);
a.ListBox_2.Items = arrayfun(@(x) ['ROI ' num2str(x)], 1:num, 'UniformOutput', false);


%% Artifacts
% if length(g.GraFTed.ROIs) ~= size(g.GraFTed.spatial,3)
%     original = 1:size(g.GraFTed.spatial,3);
%     idx = ismember(original, g.GraFTed.ROIs);
%     g.GraFTed.artifacts = original(~idx);
% end

%% Colored projection
if isempty(g.GraFTed.projection_cols)
    g.GraFTed.projection_cols = plotDifferentColoredROIS(g.GraFTed.spatial);
end
% First ROI initialized
imagesc(a.G.GraFTed.projection_cols(:,:,1), 'Parent', a.UIAxes5_3);
axis(a.UIAxes5_3, 'image');
title(a.UIAxes5_3, 'ROI-1')
a.UIAxes5_3.Title.Color = 'w';
colormap(a.UIAxes5_3, "gray")
set(a.UIAxes5_3, 'YTick', [], 'XTick', []);

%% Temporal Image Plot
if isempty(g.GraFTed.plot_image)
    g.GraFTed.plot_image = g.GraFTed.temporal;
end
% First temporal initialized
plot(1:size(g.GraFTed.temporal, 1), g.GraFTed.plot_image(:,1), 'Parent', a.UIAxes5_4);
set(a.UIAxes5_4, 'Color', 'k', 'YTick', [], 'Xcolor', 'w', 'Ycolor', 'w');

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
color_map = distinguishable_colors(cols);
plot(1:rows, g.GraFTed.plot_line, 'Parent', a.UIAxes5_2);
% Add a legend to identify each cell trajectory
nam = arrayfun(@(x) ['ROI ' num2str(x)], 1:cols, 'UniformOutput', false);
legend(a.UIAxes5_2, nam);
set(a.UIAxes5_2, 'Color', 'k', 'YTick', [], 'Xcolor', 'w', 'Ycolor', 'w',...
    'Colormap', color_map);
set(get(a.UIAxes5_2, 'ylabel'), 'string', 'ROIs')

%% UIVisibilities
a.GridLayout94.Visible = 'on';   % bottom left and roi stuff
a.GridLayout93.Visible = 'on';
a.GridLayout90.Visible = 'on';   % top two plots
a.UIAxes5_4.Visible = 'on';

%% Out
a.G = g;

