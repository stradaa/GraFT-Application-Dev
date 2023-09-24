function a = newGRAFTUI(a)

a.ALLButton.Enable = 'off';
a.SelectButton.Enable = 'off';
a.ListBox.Enable = 'off';

%% Update TextArea
new_msg = sprintf(">>GRAFT FILE INFO:\n" + ...
                  "     Study Name: %s\n" + ...
                  "     PARAMS: %s\n" + ...
                  "     Author: %s\n" + ...
                  "     Date: %s\n\n" + ...
                  ">>GRAFT Load successful.\n" + ...
                  ">>Continue to other tabs for further analysis.", ...
                  a.G.About.name, ...
                  a.G.Parameters.About.name, ...
                  a.G.About.author, ...
                  a.G.About.date_time);
a.TextArea.Value = vertcat(a.TextArea.Value, new_msg);

%% Log Update
% todo - add more info about current GRAFT load properties
if ~isempty(a.G.Log.pre_processed)
    a.TextArea_2.Value = a.G.Log.pre_processed;
end
if ~isempty(a.G.Log.parameters)
    a.TextArea_4.Value = a.G.Log.parameters;
end

%% Pre-process Update
if ~isempty(a.G.Parameters.Parameters.mask)
    a.Status.show_mask = a.Status.show_mask + 1;
    a.ClearButton.Enable = 'on';
    a.ViewMaskButton.Enable = 'on';
end

%% Parameters Update
if ~isempty(a.G.Parameters.About.name)
    a.NameEditField.Value = a.G.Parameters.About.name;
end

%% GraFTed
if ~isempty(a.G.About.name)
    a.StudyEditField.Value = a.G.About.name;
end
if ~isempty(a.G.About.author)
    a.AuthorEditField.Value = a.G.About.author;
end

% Results Initialize
if ~isempty(a.G.GraFTed.spatial)
    a = plotResults(a);
    a.TimeFrameLimitEditField.Value = size(a.G.GraFTed.temporal, 1);
    a.TimeFrameEditField.Value = size(a.G.GraFTed.temporal, 1);
end

%% Status Update
a.Status.max_m_frame = size(a.G.GraFTed.temporal,1);

end

