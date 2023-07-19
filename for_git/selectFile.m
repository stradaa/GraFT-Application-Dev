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
new_class = newTable.Class{:};


%% Types
switch extension
    case '.mat'
        if strcmp(new_class, 'struct') 
            if numel(fields(encoding.nest))==0
                encoding.nest = struct('field_name', string(new_name));
            else
                new_name = encoding.nest.field_name + "." + new_name;
                encoding.nest.field_name = new_name;
            end
            % Re-run file selection
            encoding.flag = encoding.flag + "struct";
            return
        end

        % Load
        temp = matfile(encoding.data_path);

        % Direct load
        if numel(fields(app.G.Encoding.mat_struct))==0
            out = temp.(new_name);
        else
            % If struct
            path2load = getStructPath(encoding.nest.field_name);

            first_lvl = app.G.Encoding.mat_struct.field_name;
            second_lvl = temp.(first_lvl);
            out = second_lvl.(value);
        end

        case '.tif'
            % load selected frames
            frames = double(newTable.Name');
            temp = TIFFStack(app.G.Encoding.data_path);
            out = temp(:,:,frames);
        case '.h5'
end

end

