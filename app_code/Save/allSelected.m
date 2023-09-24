function a = allSelected(a, tag)
% allSelected(app, tag) responsible for 'all' checkbox behavior
%
% tag = id for each of the sections to save under

switch tag
    case 'data'
        a.AverageProjectionCheckBox.Value = 1;
        a.OriginalDataSizeCheckBox.Value = 1;
        a.PreGraFTDataCheckBox.Value = 1;
        a.OriginalDataCheckBox.Value = 1;
    case 'pre_process'
        a.WaveletDenoisingMethodCheckBox.Value = 1;
        a.MotionCorrectionMethodCheckBox.Value = 1;
    case 'graft_results'
        a.SpatialCheckBox.Value = 1;
        a.DLReconstructionCheckBox.Value = 1;
        a.TemporalCheckBox.Value = 1;
        a.ROIsArtifactsCheckBox.Value = 1;
        a.PlotsforGraFTAppCheckBox.Value = 1;
        a.AbsSpatialvsDLReconstructionCheckBox.Value = 1;
    case 'log'
        a.PreProcessedCheckBox.Value = 1;
        a.ParametersCheckBox.Value = 1;
        a.AnalysisCheckBox.Value = 1;
    case 'about'
        a.StudyNameCheckBox.Value = 1;
        a.AuthorCheckBox.Value = 1;
        a.DateCheckBox.Value = 1;
end

