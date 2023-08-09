function [out, encoding] = selectFile(encoding, newTable)
%SELECTFILE Summary of this function goes here
%   Detailed explanation goes here
%
% 7.16.2023 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%% Initiating
out = [];

%% Parsing Selection
[~, ~, extension] = fileparts(encoding.data_path);
new_name = newTable.Name{:};
% Determine if Class exists
if any(strcmpi('Class', newTable.Properties.VariableNames))
    new_class = newTable.Class{:};
else
    new_class = [];
end

%% Types
switch extension
    case '.mat'
        if strcmp(new_class, 'struct') 
            if numel(fields(encoding.nest))==0
                encoding.nest = struct('field_name', ".", 'base', string(new_name));
            else
                encoding.nest.field_name = new_name;
            end
            % Re-run file selection
            encoding.flag = encoding.flag + "struct";
            return
        end

        % Load
        out = encoding.temp_load.(new_name);

        case '.tif'
            % load selected frames
            frames = double(newTable.Name');
            temp = TIFFStack(encoding.data_path);
            out = temp(:,:,frames);
        case '.h5'
end

end

