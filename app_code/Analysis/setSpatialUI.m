function a = setSpatialUI(a, selection)
%SETSPATIALUI 
%
%
%
% selection = [original, GraFT_dictionary, Abs.Difference]
%
% 08.04.2023 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Parse selection
index = find(selection);
num_idx = numel(index);
if num_idx == 0
    a.GridLayout80.Visible = 'off';
    a.Status.ready_m_load = 0;
    a.PlayButton.Enable = 'off';
    return
end

titles = ["ORIGINAL", "GraFT Dictionary Learning", "Abs. Difference"];
data_names = ["a.G.Data.pre_graft", "a.G.GraFTed.dl_reconstruct", "a.G.GraFTed.spatial_dl_diff"];

%% Load selected data
a.G = loadSpatialMovies(a.G, index);

%% Set GridLayout Scaling & Visibilities
switch num_idx
    case 1
        % Only Center on
        a.GridLayout80.ColumnWidth = {'0.1x', '1x', '0.1x'};
        a.ORIGINALPanel.Visible             = 'off';
        a.GRAFTRECONSTRUCTEDPanel.Visible   = 'on';
        a.ABSDIFFERENCEPanel.Visible        = 'off';
        % Name
        a.GRAFTRECONSTRUCTEDPanel.Title = titles(index);
        % Plot
        temp1 = eval(data_names(index));
        imagesc(temp1(:,:,a.Status.m_frame), "Parent", a.UIAxes3_2);
        axis(a.UIAxes3_2, 'image')
    case 2
        % 1 and 2
        a.GridLayout80.ColumnWidth = {'1x', '1x', '0.1x'};
        a.ORIGINALPanel.Visible             = 'on';
        a.GRAFTRECONSTRUCTEDPanel.Visible   = 'on';
        a.ABSDIFFERENCEPanel.Visible        = 'off';
        % Name
        a.ORIGINALPanel.Title           = titles(index(1));
        a.GRAFTRECONSTRUCTEDPanel.Title = titles(index(2));
        % Plot
        temp1 = eval(data_names(index(1)));
        temp2 = eval(data_names(index(2)));
        imagesc(temp1(:,:,a.Status.m_frame), 'Parent', a.UIAxes3);
        imagesc(temp2(:,:,a.Status.m_frame), 'Parent', a.UIAxes3_2);
        axis(a.UIAxes3, 'image')
        axis(a.UIAxes3_2, 'image')
    case 3
        % all on
        a.GridLayout80.ColumnWidth = {'1x', '1x', '1x'};
        a.ORIGINALPanel.Visible             = 'on';
        a.GRAFTRECONSTRUCTEDPanel.Visible   = 'on';
        a.ABSDIFFERENCEPanel.Visible        = 'on';
        % Name
        a.ORIGINALPanel.Title           = titles(index(1));
        a.GRAFTRECONSTRUCTEDPanel.Title = titles(index(2));
        a.ABSDIFFERENCEPanel.Title      = titles(index(3));
        % Plot
        temp1 = eval(data_names(index(1)));
        temp2 = eval(data_names(index(2)));
        temp3 = eval(data_names(index(3)));
        imagesc(temp1(:,:,a.Status.m_frame), 'Parent', a.UIAxes3);
        imagesc(temp2(:,:,a.Status.m_frame), 'Parent', a.UIAxes3_2);
        imagesc(temp3(:,:,a.Status.m_frame), 'Parent', a.UIAxes3_3);
        axis(a.UIAxes3, 'image')
        axis(a.UIAxes3_2, 'image')
        axis(a.UIAxes3_3, 'image')
end

%% Save current active plots
a.Status.active_movies = data_names(index);
a.Slider.Limits = [1, a.Status.max_m_frame];

%% Final visibilities
a.GridLayout80.Visible = 'on';
a.Status.ready_m_load = 1;
a.PlayButton.Enable = 'on';

end

