function a = popROI(a, item, tag)
% popROI Switches selected ROI from current list to other


switch tag
    case 'roi'
        % Get index and remove from ROI
        idx = find(ismember(a.G.GraFTed.ROIs, item));
        a.G.GraFTed.ROIs(idx) = [];
        % Add to artifacts
        a.G.GraFTed.artifacts = sort([a.G.GraFTed.artifacts, item]);
    case 'artifact'
        % Get index and remove from artifacts
        idx = find(ismember(a.G.GraFTed.artifacts, item));
        a.G.GraFTed.artifacts(idx) = [];
        % Add to ROI
        a.G.GraFTed.ROIs = sort([a.G.GraFTed.ROIs, item]);
end

% Update UI
a.ListBox_2.Items = arrayfun(@(x) ['ROI ' num2str(x)], a.G.GraFTed.ROIs, 'UniformOutput', false);
a.ListBox_3.Items = arrayfun(@(x) ['ROI ' num2str(x)], a.G.GraFTed.artifacts, 'UniformOutput', false);
end

