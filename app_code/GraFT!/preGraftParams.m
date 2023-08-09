function str_out = preGraftParams(p)
%PREGRAFTPARAMS Formats PARAMS for GUI output
%   Takes in app.G.Paramaters and outputs the structure in a simple string
%   type for displaying on GUI element 'TextArea_6' on the GraFT! tab.
%
% :param p: Structure app.G.Parameters from GraFT-App
% :type p: structure
%
% :returns: str_out: Simple formatted information about the parameters
% :type: str_out: string
%
%
% 07.30.2023 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Initialize string
str_out = "PARAMS LOADED";

%% Parameters
param_names = fieldnames(p.Parameters);
for i = 1:numel(param_names)
    fld = param_names{i};
    % skip mask + crop
    if strcmp(fld, 'mask') || strcmp(fld, 'crop')
        val = sprintf("[%sx%s] %s", string(size(p.Parameters.(fld))), ...
                                    class(p.Parameters.mask));
    else
        val = p.Parameters.(fld);
    end

    % format
    f = [repmat('-', 1, 10-length(fld))];
    str_out = sprintf("%s\n    %s %s %s", str_out, fld, string(f), string(val));
end

%% Info
info_names = fieldnames(p.About);
for i = 1:numel(info_names)
    fld = info_names{i};
    val = p.About.(fld);
    
    % format
    str_out = sprintf("%s\n *%s: %s", str_out, fld, string(val));
end

