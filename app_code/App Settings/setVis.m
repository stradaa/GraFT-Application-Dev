function app = setVis(app)
%SETVIS Sets the default visibilities for GraFT App.
%   This function sets the default panels/tabs visibilities, as well as
%   enables/disables buttons, etc. While it works in generalities, this
%   only handles visibilities and does not reset any parameters or other
%   GraFT App properties
%
% 06.24.2023 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ALL
movegui(app.UIFigure, 'center')

%% NEW LOAD
app.NewLoadButton.Enable = 'off';
app.FolderButton.Visible = 'on';
app.FileButton.Visible = 'on';
app.S3Button.Visible = 'on';
app.GRAFTButton.Visible = 'on';
app.FolderButton.Value = 1;
app.FileButton.Value = 1;
app.S3Button.Value = 1;
app.GRAFTButton.Value = 1;
app.TextArea.Value = ">>";
app.ListBox.Items = {};
app.ListBox.Multiselect = 'off';
app.ALLButton.Enable = 'off';
app.SelectButton.Enable = 'off';

%% PREPROCESS
app.TextArea_2.Value = ">>Logs and Comments";
app.UIAxes.Visible = 'off';
app.GridLayout21.Visible = 'off';   % View mode
app.GridLayout16.Visible = 'off';   % UIAxes and PreProcessing Tabs
app.GridLayout53.Visible = 'off';   % UIAxes2
app.GridLayout55.Visible = 'off';   % Log and < / > Buttons
app.DetectButton.Value = 0;
app.DetectButton.Enable = 'on';
app.NewLoadLabel.Enable = 'on';
app.ResettoOriginalLabel.Enable = 'off';
app.ResetButton_2.Enable = 'off';
app.Button.Enable = 'off';      % '<' Button
app.Button_2.Enable = 'off';    % '>' Button
app.TabGroup3.SelectedTab = app.MotionCorrectionTab;
% Crop Tab
app.ApplyButton.Enable = 'off';
app.CancelButton.Enable = 'off';
app.SelectAreaButton.Enable = 'on';
% Mask
app.ApplyButton_2.Enable = 'off';
app.ClearButton.Enable = 'off';
app.ColorButton.Visible = 'off';
app.GridLayout52.Visible = 'off';
app.GridLayout52.BackgroundColor = [1,0,0]; % red
app.ViewMaskButton.Enable = 'off';
app.SelectAreaButton_2.Enable = 'on';
app.SelfLoadButton.Enable = 'on';
app.CreateButton.Enable = 'off';
% Wavelet Denoising
app.TextArea_3.Visible = 'off';
app.GridLayout37.Visible = 'off';

%% PARAMETERS
setappParams(app, 'Reset');
app.NameEditField.Value = "";
app.TextArea_4.Value = ">>PARAMETER LOG";
app.TextArea_5.Value = ">>Mask and Crop Status";

%% GRAFT!
app.TabGroup2.SelectedTab = app.RunTab;
% Run
app.TextArea_6.Value = "";
app.STARTButton.Enable = 'off';
% Results
app.TextArea_7.Value = "";
app.ColormapDropDown.Value = 'gray';

%% Analysis
% Tab
app.TabGroup4.SelectedTab = app.ROIsTab;
% ROIs
app.GridLayout94.Visible = 'off';   % bottom left and roi stuff
app.GridLayout108.Visible = 'off';  % Time frame and temporal view mode
app.GridLayout90.Visible = 'off';   % top two plots
app.UIAxes5_4.Visible = 'off';      % bottom right axes
app.GridLayout109.Visible = 'on';   % detect button
app.DetectButton_3.Visible = 'on';  % explicit button
app.ColormapDropDown_2.Visible = 'off';
app.ColormapLabel.Visible = 'off';
app.TemporalViewModeDropDown.Value = 'Line';    % default view
% Spatial
app.GridLayout80.Visible = 'off';
app.OriginalCheckBox.Value = 0;
app.GraFTDictionaryLearningCheckBox.Value = 0;
app.AbsDifferenceCheckBox.Value = 0;
app.PlayButton.Enable = 'off';
app.fpsEditField.Enable = 'off';
app.PlayButton.Text = 'Play';
app.Slider.Limits = [1,100];
%% Save
% Panels
app.DATAPanel.Visible = 'off';
app.PREPROCESSPanel.Visible = 'off';
app.GRAFTRESULTSPanel.Visible = 'off';
app.PARAMETERSPanel.Visible = 'off';
app.LOGPanel.Visible = 'off';
app.ABOUTPanel.Visible = 'off';
app.ENCODINGPanel.Visible = 'off';
% Saving Area
app.GridLayout104.Visible = 'off';
app.GridLayout104_2.Visible = 'off';
app.SAVEButton.Visible = 'off';
app.dirLabel.Text = pwd;                % default directory to save
%% SETTINGS
end

