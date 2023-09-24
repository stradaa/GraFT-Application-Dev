function a = plotUpdatePreprocess(a, s)
%plotUpdatePreprocess Updates GraFT-App Axes for PreProcess Tab
%   
%
% :param a: GraFT-App
% :type a: UIFigure
%
% :param s: Process done 
% :type s: string
%
% :returns:   a : GraFT-App
%           type: UIFigure
%
%
%
% 07.21.23 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Check for flag based on source
switch s
    case "Motion Correction"
        % check repetition
        if a.Status.is_mcor_rep
            return
        end
    case "Crop"
    case "Mask"
        if ~isempty(a.Status.mask_flag)
            warning('Mask: %s', a.Status.mask_flag)
        end
    case "Reset"
        % reset
        a.Status = setStatus();
        a.G.Data.pre_graft = [];
        a.G.Data.projection = [];
        a.G.Parameters.Parameters.mask = [];
        a.G.Parameters.Parameters.crop = [];
        % Update Log
        t = string(datetime("now", "Format","HH:mm:ss"));
        msg = sprintf("%s >> All pre-processes cleared.", t);
        a.TextArea_2.Value = sprintf([repmat('%s\n', 1, numel(a.TextArea_2.Value)) '%s\n'], ...
                                a.TextArea_2.Value{:}, msg);
end

%% Perform projection
if isempty(a.G.Data.pre_graft)
    a.G.Data.projection = mean(a.G.Data.original,3);
else
    a.G.Data.projection = mean(a.G.Data.pre_graft,3);
end

