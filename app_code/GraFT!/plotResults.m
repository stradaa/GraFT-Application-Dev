function a = plotResults(a)
%PLOTRESULTS


%% ROIs (UIAxes4)
imagesc(a.G.GraFTed.spatial(:,:,a.Status.result_idx), 'Parent', a.UIAxes4);
set(a.UIAxes4, 'XTick', [], 'YTick', []);
colormap(a.UIAxes4, a.ColormapDropDown.Value);

%% Temporal (UIAxes4_2)
x = 1:size(a.G.GraFTed.temporal, 1);
y = a.G.GraFTed.temporal(:, a.Status.result_idx);
plot(x, y, 'Parent', a.UIAxes4_2);
set(a.UIAxes4_2, 'Color', 'k', 'YTick', [], 'Xcolor', 'w');

%% Label
a.xxLabel.Text = sprintf('%d/%d', a.Status.result_idx, size(a.G.GraFTed.spatial, 3));
end

