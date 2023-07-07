function app = setVis(app)
%SETVIS Sets the default visibilities for GraFT App.
%   This function sets the default panels/tabs visibilities, as well as
%   enables/disables buttons, etc. While it works in generalities, this
%   only handles visibilities and does not reset any parameters or other
%   GraFT App properties
%
% 06.24.2023

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
app.UIAxes.Visible = 'off';
app.MeanImageStackProjectionPanel.Visible = 'off';
app.GridLayout21.Visible = 'off';
app.DetectButton.Value = 0;
%% PARAMETERS

%% GRAFT!

%% RESULTS

%% SETTINGS
end

