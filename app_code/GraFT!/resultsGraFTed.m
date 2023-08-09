function [g, s] = resultsGraFTed(g, s)
%INITGRAFTED


%% Check GraFT results
if isempty(g.GraFTed.spatial) || isempty(g.GraFTed.temporal)
    s.result_flag = "GraFT results not detected.";
    return
end

%% ROIS
if isempty(g.GraFTed.ROIs)
    g.GraFTed.ROIs = 1:size(g.GraFTed.spatial, 3);
end

%% Spatial projection
if isempty(g.GraFTed.projection)
    if g.GraFTed.ROIs == 1
        g.GraFTed.projection = g.GraFTed.spatial;
    else
        g.GraFTed.projection = mean(g.GraFTed.spatial, 3);
    end
end

%% Temporal Image Plot
if isempty(g.GraFTed.plot_image)
    g.GraFTed.plot_image = g.GraFTed.temporal;
end

%% Status
s.result_idx = 1;
s.result_flag = "";
s.m_frame = 1;
s.max_m_frame = size(g.GraFTed.temporal, 1);
end

