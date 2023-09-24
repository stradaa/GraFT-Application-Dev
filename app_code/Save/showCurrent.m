function a = showCurrent(a)


%% FILE NAME + DIR
a.nameLabel.Text = a.StudyEditField.Value;

%% DATA
d = a.G.Data;

% original data
if ~isempty(d.original)
    a.Label_7.Text = 'Present';
else
    a.Label_7.Text = 'Empty';
end
% original data size
if ~isempty(d.original_size)
    if length(d.original_size)==2
        temp = sprintf('[%dx%d]', d.original_size);
    else
        temp = sprintf('[%dx%dx%d]', d.original_size);
    end
    a.Label_8.Text = temp;
else
    a.Label_8.Text = 'Empty';
end
% pre_graft
if ~isempty(d.pre_graft)
    temp = sprintf('[%dx%dx%d]', size(d.pre_graft, 1:3));
    a.Label_9.Text = temp;
else
    a.Label_9.Text = 'Empty';
end
% projection
if isempty(d.projection)
    a.Label_10.Text = 'Present';
else
    a.Label_10.Text = 'Empty';
end
clear d

%% PREPROCESS
p = a.G.PreProcess;

% Motion Correction Method
a.Label_11.Text = p.motco_method;

% Wavelet Denoising
a.Label_12.Text = p.wav_method;
clear p

%% GRAFT RESULTS
g = a.G.GraFTed;

% Spatial
if ~isempty(g.spatial)
    temp = sprintf('[%dx%dx%d]', size(g.spatial, 1:3));
    a.Label_14.Text = temp;
else
    a.Label_14.Text = 'Empty';
end
% Temporal
if ~isempty(g.temporal)
    temp = sprintf('[%dx%d]', size(g.spatial, 1:2));
    a.Label_15.Text = temp;
else
    a.Label_15.Text = 'Empty';
end
% DL Reconstruction
if ~isempty(g.dl_reconstruct)
    temp = sprintf('Frames: %d', size(g.dl_reconstruct, 3));
    a.Label_16.Text = temp;
else
    a.Label_16.Text = 'Empty';
end
% Spatial vs DL Difference
if ~isempty(g.spatial_dl_diff)
    temp = sprintf('Frames: %d', size(g.spatial_dl_diff, 3));
    a.Label_25.Text = temp;
else
    a.Label_25.Text = 'Empty';
end
% ROIs & Artifacts
if ~isempty([g.ROIs, g.artifacts])
    a.Label_17.Text = 'Present';
else
    a.Label_17.Text = 'Empty';
end
% GraFTed Plots
if ~isempty({g.plot_image, g.plot_line, g.projection, g.projection_cols})
    a.Label_18.Text = 'Present';
else
    a.Label_18.Text = 'Empty';
end

%% PARAMS
a = saveParams(a);
if ~isempty(a.G.Parameters)
    temp = sprintf('Name: %s\nDate Time: %s', ...
           a.G.Parameters.About.name, ...
           a.G.Parameters.About.date_time);
    a.Label_26.Text = temp;
else
    a.Label_26.Text = 'None';
end

%% LOG
% Update
a.G.Log.pre_processed = a.TextArea_2.Value;
a.G.Log.parameters = a.TextArea_4.Value;

% Pre-Processed
if length(a.TextArea_2.Value) > 1
    a.Label_19.Text = 'Present';
elseif length(a.TextArea_2.Value)==1
    a.Label_19.Text = 'None';
end

% Parameters
if length(a.TextArea_4.Value) > 1
    a.Label_20.Text = 'Present';
elseif length(a.TextArea_4.Value)==1
    a.Label_20.Text = 'None';
end

% Analysis ?

%% About
% Study name
a.Label_22.Text = a.G.About.name;
% Author
a.Label_23.Text = a.G.About.author;
% Date
a.Label_24.Text = string(a.G.About.date_time);

%% Encoding
if ~isempty(a.G.Encoding)
    a.Label_27.Text = 'Empty';
else
    a.Label_27.Text = 'Present';
end

end

