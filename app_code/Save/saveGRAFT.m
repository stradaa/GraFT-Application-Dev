function saveGRAFT(a)

%% File
GRAFT_obj = GRAFT();

%% DATA
if a.OriginalDataCheckBox.Value
    GRAFT_obj.Data.original = a.G.Data.original;
end
if a.PreGraFTDataCheckBox.Value
    GRAFT_obj.Data.pre_graft = a.G.Data.pre_graft;
end
if a.OriginalDataSizeCheckBox.Value
    GRAFT_obj.Data.original_size = a.G.Data.original_size;
end
if a.AverageProjectionCheckBox.Value
    GRAFT_obj.Data.projection = a.G.Data.projection;
end

%% PREPROCESS
if a.MotionCorrectionMethodCheckBox.Value
    GRAFT_obj.PreProcess.motco_method = a.G.PreProcess.motco_method;
end
if a.WaveletDenoisingMethodCheckBox.Value
    GRAFT_obj.PreProcess.wav_method = a.G.PreProcess.wav_method;
    GRAFT_obj.PreProcess.wav_fam = a.G.PreProcess.wav_fam;
    GRAFT_obj.PreProcess.wav_order = a.G.PreProcess.wav_order;
    GRAFT_obj.PreProcess.wav_lvl = a.G.PreProcess.wav_lvl;
    GRAFT_obj.PreProcess.wav_noise_est = a.G.PreProcess.wav_noise_est;
    GRAFT_obj.PreProcess.wav_thresh = a.G.PreProcess.wav_thresh;
end

%% GRAFT RESULTS
if a.SpatialCheckBox.Value
    GRAFT_obj.GraFTed.spatial = a.G.GraFTed.spatial;
end
if a.TemporalCheckBox.Value
    GRAFT_obj.GraFTed.temporal = a.G.GraFTed.temporal;
end
if a.DLReconstructionCheckBox.Value
    GRAFT_obj.GraFTed.dl_reconstruct = a.G.GraFTed.dl_reconstruct;
end
if a.AbsSpatialvsDLReconstructionCheckBox.Value
    GRAFT_obj.GraFTed.spatial_dl_diff = a.G.GraFTed.spatial_dl_diff;
end
if a.ROIsArtifactsCheckBox.Value
    GRAFT_obj.GraFTed.ROIs = a.G.GraFTed.ROIs;
    GRAFT_obj.GraFTed.artifacts = a.G.GraFTed.artifacts;
end
if a.PlotsforGraFTAppCheckBox.Value
    GRAFT_obj.GraFTed.plot_image = a.G.GraFTed.plot_image;
    GRAFT_obj.GraFTed.plot_line = a.G.GraFTed.plot_line;
    GRAFT_obj.GraFTed.projection = a.G.GraFTed.projection;
    GRAFT_obj.GraFTed.projection_cols = a.G.GraFTed.projection_cols;
end

%% PARAMS
% save current selections
a = saveParams(a);
if a.PARAMSCheckBox.Value
    if isempty(a.G.Parameters.About.name)
        date = string(datetime('now', 'Format', 'MM_d_yyy'));
        def_name = sprintf('dict%d_lda%.3f_lfb%.3f_lcr%.3f_date%s', ...
                    a.G.Parameters.Parameters.n_dict, ...
                    a.G.Parameters.Parameters.lambda, ...
                    a.G.Parameters.Parameters.lamForb, ...
                    a.G.Parameters.Parameters.lamCorr, ...
                    date);
        a.G.Parameters.About.name = def_name;
    end
    GRAFT_obj.Parameters = a.G.Parameters;
end

%% LOG
if a.PreProcessedCheckBox.Value
    GRAFT_obj.Log.pre_processed = a.G.Log.pre_processed;
end
if a.ParametersCheckBox.Value
    GRAFT_obj.Log.parameters = a.G.Log.parameters;
end

%% ABOUT
if a.StudyNameCheckBox.Value
    if isempty(a.G.About.name)
        date = string(datetime('now', 'Format', 'MM_d_yyy'));
        def_name = sprintf('dict%d_lda%.3f_lfb%.3f_lcr%.3f_date%s', ...
                    a.G.Parameters.Parameters.n_dict, ...
                    a.G.Parameters.Parameters.lambda, ...
                    a.G.Parameters.Parameters.lamForb, ...
                    a.G.Parameters.Parameters.lamCorr, ...
                    date);
        GRAFT_obj.About.name = def_name;
    else
        GRAFT_obj.About.name = a.G.About.name;
    end
end
if a.AuthorCheckBox.Value
    GRAFT_obj.About.author = a.G.About.author;
end
if a.DateCheckBox.Value
    GRAFT_obj.About.date_time = a.G.About.date_time;
end

%% ENCODING
% problem, saves old encoding values. Not desired... ?
% if a.ALLCheckBox_6.Value
%     GRAFT_obj.Encoding = a.G.Encoding;
% end
GRAFT_obj.Encoding.loading_type = 'GRAFT';

%% SAVE
% uiprogressdlg
d = uiprogressdlg(a.UIFigure,'Title','Saving File',...
    'Cancelable','on', 'Indeterminate','on');
d.Message = 'Just read the instructions...';
try
    save([a.dirLabel.Text, '\', GRAFT_obj.About.name, '.GRAFT.mat'],'GRAFT_obj','-v7.3')
    close(d);
    msg = 'Saved Successfully!';
    uialert(a.UIFigure, msg, 'Save', 'Icon','success', 'Modal',true); 
catch
    close(d);
    msg = 'Something went wrong. File not saved.';
    uialert(a.UIFigure, msg, 'Warning', 'Icon','warning', 'Modal',true); 
end

