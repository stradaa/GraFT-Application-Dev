function app = setVis(app)
%SETVIS Sets the default visibilities for GraFT App.
%   This function sets the default panels/tabs visibilities, as well as
%   enables/disables buttons, etc. While it works in generalities, this
%   only handles visibilities and does not reset any parameters or other
%   GraFT App properties
%
% 06.24.2023

%% ALL

%% NEW LOAD
app.NewLoadButton.Enable = 'off';
app.FolderButton.Visible = 'on';
app.FileButton.Visible = 'on';
app.S3Button.Visible = 'on';
app.FolderButton.Value = 1;
app.FileButton.Value = 1;
app.S3Button.Value = 1;
app.TextArea.Value = ">>";
app.ListBox.Items = {};
app.ALLButton.Enable = 'off';
app.SelectButton.Enable = 'off';

%% PREPROCESS

%% PARAMETERS

%% GRAFT!

%% RESULTS

%% SETTINGS
end

