function a = createMaskApp(a,event)
%createMask sets/creates data mask for PreProcess Tab
%   Utilizes several methods to create/set mask for GraFT-App. Options
%   include an interactive free-hand mask selection, a pre-computed mask
%   (with various methods available), and a self-load of pre-existing mask
%   existing in a GRAFT object or as a .mat binary matrix.
%
% :param a: GraFT-App
% :type a: UIFigure
%
% :returns:   a : GraFT-App
%           type: UIFigure
%
%
% 07.21.23 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Select Loading Type
switch event.Source.Text
    case 'Select Area'
        % Free-Hand Tool
        a.Status.mask_freehand = drawfreehand(a.UIAxes, "Color", a.Status.mask_color);

        % Update
        a.ColorButton.Visible = 'on';
        a.GridLayout52.Visible = 'on';
        a.ClearButton.Text = 'Clear';
        a.ClearButton.Enable = 'on';
        a.Status.mask_method = 'Free_Hand';
        a.ApplyButton_2.Enable = 'on';

    case 'Self-Load'
        % For TextArea
        time = string(datetime("now", "Format","HH:mm:ss"));

        % Select file
        [filename, path] = uigetfile({'*.mat'}, "Select File");
        path = [path, filename];
        if isequal(path(1), 0)
            a.SelectAreaButton_2.Enable = 'on';
            a.SelfLoadButton.Enable = 'on';
%            a.CreateButton.Enable = 'on';
            return
        end

        % Load
        t = load(path);
        [~,sub_extension,~] = fileparts(filename);

        % Check for PARAMS .mat file
        if contains(sub_extension, '.PARAMS')
            a.G.Parameters.Parameters.mask = t.var_to_save.Parameters.mask;
            % Update
            msg = sprintf('%s >> Successful mask load from %s', time, sub_extension);
            a.TextArea_2.Value = sprintf([repmat('%s\n', 1, numel(a.TextArea_2.Value)) '%s\n'], ...
                                      a.TextArea_2.Value{:}, msg);
            a.Status.mask_method = 'Self_Load';
            a.ApplyButton_2.Enable = 'off';
            a.ClearButton.Text = 'Delete Mask';
            a.ViewMaskButton.Enable = 'on';
            a.ClearButton.Enable = 'on';
            a.Status.show_mask = 1;
            return
        end

        % Find logical variables
        f_names = fieldnames(t);
        potential_masks = cell(numel(f_names), 1);
        c = 0;
        for i = 1:numel(f_names)
            fld = t.(f_names{i});
            if islogical(fld)
                % check size
                if isequal(a.G.Data.original_size(1:2), size(fld))
                    c = c + 1;
                    potential_masks{c} = fld;
                end
            end
        end
        
        % Check number of options
        if c == 1
            a.G.Parameters.Parameters.mask = potential_masks{1};
            msg = sprintf('%s >> Successful mask load from %s', time, path);
            a.TextArea_2.Value = sprintf([repmat('%s\n', 1, numel(a.TextArea_2.Value)) '%s\n'], ...
                                      a.TextArea_2.Value{:}, msg);
        else
            msg = sprintf(['%s >> Total of %d logical variables in %s. ' ...
                           'Unable to load mask.'], time, c, path);
            a.TextArea_2.Value = sprintf([repmat('%s\n', 1, numel(a.TextArea_2.Value)) '%s\n'], ...
                                      a.TextArea_2.Value{:}, msg);
            a.SelectAreaButton_2.Enable = 'on';
            a.SelfLoadButton.Enable = 'on';
            a.CreateButton.Enable = 'on';
            a.ClearButton.Enable = 'off';
            return
        end
        
        % Update
        a.Status.mask_method = 'Self_Load';
        a.ApplyButton_2.Enable = 'off';
        a.ClearButton.Text = 'Delete Mask';
        a.ViewMaskButton.Enable = 'on';
        a.ClearButton.Enable = 'on';
        a.Status.show_mask = 1;
        

    case 'Create'
        a.Status.mask_method = 'Pre_Computed';
end

end

