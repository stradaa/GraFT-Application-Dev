function loadParams(a)
%LOADPAR Loads PARAMS into GraFT-App
%   Files .PARAMS.mat are loaded (using default .mat load function) to
%   update app.G.Parameters property. Function also checks whether or not
%   crop or mask exists in current specifications, and prompts user with
%   options to overwrite, keep current, or cancel load altogether.
%
% :param a: GraFT-App
% :type a: UIFigure
%
% 07.26.2023 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Select file
[filename, path] = uigetfile({'*.mat'}, "Select File");
path = [path, filename];

%% Load
if ~isequal(path(1), 0)
    [~, name, ~] = fileparts(path);
    t = load(path);
else
    return
end

%% Temporary load
t_params = t.var_to_save;

%% Check mask
if ~isempty(t_params.Parameters.mask)
    % Check if mask already existed
    if ~isempty(a.G.Parameters.Parameters.mask)
        if ~isequal(a.G.Parameters.Parameters.mask, t_params.Parameters.mask)
            % Prompt
            msg = "Existing mask detected.";
            title = "Confirm Mask";
            selection = uiconfirm(a.UIFigure, msg, title,...
                    'Options', {'Overwrite', 'Keep current mask', 'Cancel'}, ...
                    'DefaultOption', 1, 'CancelOption', 3);

            switch selection
                case 'Overwrite'
                case 'Keep current mask'
                    % keep mask
                    t_params.Parameters.mask = a.G.Parameters.Parameters.mask;
                case 'Cancel'
                    return
            end
       end
    end
    
    % Visibilities / Enable
    a.ViewMaskButton.Enable = "on";
    a.ClearButton.Text = 'Delete Mask';
    a.ClearButton.Enable = 'on';
    a.Status.show_mask = 1;
end

%% Check crop
if ~isempty(t_params.Parameters.crop)    
    % Check if load exists
    if ~isempty(a.G.Data.original)
        % Check if has been cropped before
        if ~isempty(a.G.Parameters.Parameters.crop)
            curr_crop = a.G.Parameters.Parameters.crop;
            temp_crop = t_params.Parameters.crop;
            if ~isequal(curr_crop, temp_crop)
                % Prompt
                msg = "Existing crop detected. Overwrite will reset pre-processing methods" + ...
                      " and apply new crop";
                title = "Confirm Crop";
                selection = uiconfirm(a.UIFigure, msg, title,...
                            'Options', {'Overwrite', 'Keep current crop', 'Cancel'}, ...
                            'DefaultOption', 1, 'CancelOption', 3);

                % User selection
                switch selection
                    case 'Overwrite'
                        % reset pre-processing
                        a = plotUpdatePreprocess(a, "Reset");
                    case 'Keep current crop'
                        t_params.Parameters.crop = a.G.Parameters.Parameters.mask;
                    case 'Cancel'
                        return
                end

            end
        end
    end
end

%% Set
a.G.Parameters.Parameters = t_params.Parameters;
setappParams(a, '');

%% Update text fields
time = string(datetime("now", "Format","HH:mm:ss"));
msg = sprintf("%s >> '%s' loaded.\n\n" + ...
              "             INFO:\n" + ...
              "                             author: %s\n" + ...
              "              PARAMS name: %s\n" + ...
              "           date-time created: %s\n" + ...
              "Associated GraFT Study: %s", ...
              time, name, t_params.About.author, t_params.About.name, ...
              string(t_params.About.date_time), t_params.About.GraFT_Data);
a.TextArea_4.Value = sprintf([repmat('%s\n', 1, numel(a.TextArea_2.Value)) '%s\n'], ...
a.TextArea_4.Value{:}, msg);
end

