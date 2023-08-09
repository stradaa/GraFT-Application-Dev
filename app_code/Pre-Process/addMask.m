function mask_final = addMask(a, selection)
%ADDMASK Adds logical mask to existing mask for GraFT-App
%   Adds separate binary/logical pixel values for mask. Ultimately creates
%   a findal logical mask with region(s) desired for GraFT analysis.
%
% :param a: GraFT-App
% :type a: UIFigure
%
% :param selection: new selection
% :type selection: logical
%
% :returns: mask_final : final mask selection
%                  type: logical
%
% 07.24.2023 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Check sizes
size_data = a.G.Data.original_size(1:2);
size_mask = size(selection);

if ~isequal(size_data, size_mask)
    a.Status.mask_flag = a.Status.flag + "size of mask does not match size " + ...
                         "of the original data size.";
    return
end

%% Selection
if isempty(a.G.Parameters.Parameters.mask)
    a.G.Parameters.Parameters.mask = zeros(size_data);
end

%% Combine
mask_final = a.G.Parameters.Parameters.mask | selection;

end

