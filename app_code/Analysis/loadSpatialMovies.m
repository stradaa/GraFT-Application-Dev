function g = loadSpatialMovies(g, index)
%LOADSPATIALMOVIES


%% Sizes
[s_1, s_2, s_3] = size(g.GraFTed.spatial);

%% Set fields 
if any(ismember(index, 2))
    % dic learn
    if isempty(g.GraFTed.dl_reconstruct)
        s_res = reshape(g.GraFTed.spatial, [], s_3);
        dl = s_res*g.GraFTed.temporal';
        dl_res = reshape(dl, s_1, s_2, []);
        % set
        g.GraFTed.dl_reconstruct = dl_res;
    end
end

if any(ismember(index, 3))
    % abs diff
    if isempty(g.GraFTed.spatial_dl_diff) && isempty(g.GraFTed.dl_reconstruct)
        % get dic learn results
        s_res = reshape(g.GraFTed.spatial, [], s_3);
        dl = s_res*g.GraFTed.temporal';
        dl_res = reshape(dl, s_1, s_2, []);
        % set
        g.GraFTed.dl_reconstruct = dl_res;
        
        % get abs difference
        g.GraFTed.spatial_dl_diff = abs(g.Data.pre_graft - g.GraFTed.dl_reconstruct);
    elseif isempty(g.GraFTed.spatial_dl_diff)
        g.GraFTed.spatial_dl_diff = abs(g.Data.pre_graft - g.GraFTed.dl_reconstruct);
    end
end

end

