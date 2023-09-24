function s = fixMaskView(a, names)
%FIXMASKVIEW 

s = a.Status;
s.data_movies = {};

if ~isempty(a.G.Parameters.Parameters.mask)
    % get ranges to cut
    [rows, col] = find(a.G.Parameters.Parameters.mask);
    top_row = min(rows);
    bot_row = max(rows);
    left_col = min(col);
    right_col = max(col);
    
    mask = repmat(a.G.Parameters.Parameters.mask, [1,1,size(a.G.Data.pre_graft,3)]);
    
    % pre graft
    if ~isempty(a.G.Data.pre_graft)
        pre_graft_selection = a.G.Data.pre_graft;
        pre_graft_selection(~mask) = NaN;
        s.data_movies{end+1} = pre_graft_selection(top_row:bot_row, left_col:right_col, :);
        clear pre_graft_selection
    end
    
    % dl reconstruct
    if ~isempty(a.G.GraFTed.dl_reconstruct)
        dl_rec_selection = a.G.GraFTed.dl_reconstruct;
        dl_rec_selection(~mask) = NaN;
        s.data_movies{end+1} = dl_rec_selection(top_row:bot_row, left_col:right_col, :);
        clear dl_rec_selection
    end

    % spatial dl diff
    if ~isempty(a.G.GraFTed.spatial_dl_diff)
        spatial_dl_selection = a.G.GraFTed.spatial_dl_diff;
        spatial_dl_selection(~mask) = NaN;
        s.data_movies{end+1} = spatial_dl_selection(top_row:bot_row, left_col:right_col, :);
        clear spatial_dl_selection
    end
else
    % no mask
    for i = 1:length(names)
        s.data_movies{end+1} = eval(names(i));
    end
end

end

