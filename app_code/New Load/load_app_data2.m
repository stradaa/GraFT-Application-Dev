function a = load_app_data2(a)
%LOAD_APP_DATA2 loads a preview for GraFT App Data 
%   Flexible file type search for user data. Allows for entire directory
%   search or individual file info.
% 
%   Supports following type of loading:
%       - Local Folder/File
%       - Remote S3 (Coming soon)
%
%   Supports following extensions:
%       - .TIF / .JPEG / .PNG
%       - .MAT
%       - GRAFT Object
%       - .NWB -TODO-
% 
% :param a: Data structure for GraFT App
% :type a: GRAFT Class Object
%
% :returns: a :GRAFT Class Object: Data structure containing loaded files
%                                  within the a.Encoding.files parameter.
% 
% 
% 06.24.2023 - Alex Estrada


switch a.Encoding.loading_type 
    case 'Folder'
        %% Folder
        % Get a list of all files and folders in the given directory
        files = dir(a.Encoding.data_path);
        
        % select fields
        desiredFieldNames = {'Name', 'Format', 'FileSize', 'Width', 'Height', 'ColorType'};
        out = cell2table(cell(0, numel(desiredFieldNames)), 'VariableNames', desiredFieldNames);

        % Iterate over each file/folder in the directory
        for i = 1:numel(files)
            % Skip directories and files starting with a dot (e.g., '.', '..')
            if files(i).isdir || files(i).name(1) == '.'
                continue;
            end
            
            % Check if the file has an image extension
            [~, ~, extension] = fileparts(files(i).name);
            imageExtensions = {'.tif', '.tiff', '.jpeg', '.jpg', '.png'}; % Add more extensions if needed
            if any(strcmpi(extension, imageExtensions))
                % get image file info
                imagePath = fullfile(a.Encoding.data_path, files(i).name);
                info = imfinfo(imagePath);
                % check for image stack
                if length(info)>1
                    t = {files(i).name, info(1).Format, files(i).bytes,...
                         info(1).Width, info(1).Height, info(1).ColorType};
                    out = [out; t];
                    continue
                elseif length(info)==1
                    t = {files(i).name, info.Format, info.FileSize, info.Width,...
                     info.Height, info.ColorType};
                    out = [out; t];
                else
                    a.Encoding.flag = 'Problem searching directory file.';
                    return
                end
            end
        end

        % Update Data.files if items found
        if ~isempty(out)
            a.Encoding.files = out;
        else
            a.Encoding.flag = sprintf("No files found." + ...
                "Only searches for following extensions:\n" + ...
                "-%s\n" + ...
                "-%s\n" + ...
                "-%s\n" + ...
                "-%s\n" + ...
                "-%s", imageExtensions{:});
        end
    
    case 'File'
        %% File
        % Determmine extension
        [~, ~, extension] = fileparts(a.Encoding.data_path);
        
        % for tiff stack use numel(imfinfo(path))
        switch extension
            case '.tif'
                % get .tif information
                try
                    info = struct2table(imfinfo(a.Encoding.data_path));
                catch
                    a.Encoding.flag = a.Ecoding.flag + " Unable to open tif file for reading.";
                end
                num_img = size(info,1);

                % select fields
                desiredFieldNames = {'Type', 'FileSize', 'Width', 'Height', 'ColorType'};
                out = table();
                out.Name = string(1:num_img)';
                for i = 1:numel(desiredFieldNames)
                    fieldName = desiredFieldNames{i};
                    if ismember(fieldName, info.Properties.VariableNames)
                        out.(fieldName) = info.(fieldName);
                    end
                end

                % Update encoding
                a.Encoding.files = out;

            case '.mat'
                % first time load
                if isempty(a.Encoding.temp_load)
                    info = matfile(a.Encoding.data_path);

                    % remove 'Properties' from matfile loading
                    field_names = fields(info);
                    if strcmp(field_names{1}, 'Properties')
                        field_names = field_names(2:end);
                    end

                    % update
                    a.Encoding.temp_load = info;    % still MatFile
                end

                % 2+ loads
                if numel(fields(a.Encoding.nest))
                    
                    % update temp_load
                    if isequal(class(a.Encoding.temp_load), 'matlab.io.MatFile')
                        nest_name = a.Encoding.nest.base;
                        a.Encoding.temp_load = a.Encoding.temp_load.(nest_name);
                    end
                    
                    % info and field_names
                    try
                    if startsWith(a.Encoding.nest.field_name, '.')          % base struct
                        % remove "." and update
                        new_fieldname = a.Encoding.nest.field_name(2:end);
                        a.Encoding.nest.field_name = new_fieldname;
                        % set
                        info = a.Encoding.temp_load;
                    else                                                    % nested
                        % update temp load
                        nest_name = a.Encoding.nest.field_name;
                        a.Encoding.temp_load = a.Encoding.temp_load.(nest_name);
                        % set
                        info = a.Encoding.temp_load;
                    end
                    catch
                    error("Something wrong with nested structure load")
                    end

                    field_names = fields(info);

                end
                
                % check if proper load
                if isempty(field_names)
                    a.Encoding.flag = a.Encoding.flag + " No fields to load.";
                    return
                end

                % create table
                table_names = {'Name', 'Size', 'Class'};
                out = cell2table(cell(0, numel(table_names)), 'VariableNames', table_names);
                for i = 1:numel(field_names)
                    name = field_names{i};
                    field_class = class(info.(name));
                    field_size = num2str(size(info.(name)));
                    new_line = {name, field_size, field_class};
                    out = [out; new_line];
                end
                
                % Update encoding
                a.Encoding.files = out;

            case '.NWB'
                % TODO

            case '.h5'
                % get info
                info = h5info(a.Encoding.data_path);
                
                % initiate table
                tbl_names = {'Name','Type','Size','Datasets'};
                out = cell2table(cell(0, numel(tbl_names)), 'VariableNames', tbl_names);
                
                % root name
                root_name = string(info.Name);

                % root groups
                if ~isempty(info.Groups)
                    for i = 1:length(info.Groups)
                        % name
                        dir_out = string(info.Groups(i).Name);

                        % datasets w/in
                        datasets_out = "";
                        for j = 1:length(info.Groups.Datasets)
                            name = string(info.Groups.Datasets(j).Name);
                            datasets_out = datasets_out + name + "|";
                        end
                        
                        % new line
                        new_ln = {dir_out,"Group","--",datasets_out};
                        out = [out; new_ln];
                    end
                end
                
                % root datasets
                if ~isempty(info.Datasets)
                    for i = 1:length(info.Datasets)
                        % name
                        dir_out = root_name + string(info.Datasets(i).Name);

                        % size + type
                        dataspace = info.Datasets(i).Dataspace;
                        if length(fieldnames(dataspace)) > 1            % not empty structure
                            size_out = num2str(dataspace.Size);
                            if ischar(size_out)
                                size_out = string(size_out);
                            end
                        else
                            size_out = "";
                        end

                        % new line
                        new_ln = {dir_out,"Dataset",size_out,"--"};
                        out = [out; new_ln];
                    end
                end
                
                % Update encoding
                a.Encoding.files = out;
        end

    case 'S3'
        %% Remote S3

end % switch end

end % function end