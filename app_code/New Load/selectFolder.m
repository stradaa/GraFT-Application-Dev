function out = selectFolder(g, newTable)
%SELECTFOLDER Summary of this function goes here
%   Detailed explanation goes here
%
% 07.15.2023 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Multi-selection
if height(newTable) > 1
    % load selected frames
    out = zeros(newTable.Width(1), newTable.Height(2), height(newTable));
    base = string(g.Encoding.data_path);
    for k=1:height(newTable)
        out(:,:,k) = imread(base + filesep + newTable.Name(k));
    end
end

%% Single Selection
if height(newTable) == 1
    fileName = string(g.Encoding.data_path) + filesep + newTable.Name;
    [~, ~, extension] = fileparts(fileName);
    if strcmp(extension, '.tif')
        % load all tif files
        out = TIFFStack(char(fileName));    % only takes char in lol
    else
        % load selection
        out = imread(fileName);
    end
end


end

