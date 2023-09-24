function varargout = plotDifferentColoredROIS(imgArray, varargin)
%PLOTDIFFERENTCOLOREDROIS Plots 2D from 3D matrix using unique colors
%
% Plots the ROIs (a 3D array) in different colors to visualize their
% spatial locations.
%
%   EXAMPLE:
%       varargout = plotDifferentColoredROIS(imgArray, varargin)
% 
%
% 2023 - Adam Charles
%
% Added for GraFT-APP 08.07.2023 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


p = inputParser;
p.addParameter('figNo',       1);
p.addParameter('normOpt',     'single');
p.addParameter('filterSize',  [0,Inf]);
p.addParameter('aspectRatio', []);
parse(p,varargin{:});
p = p.Results;

numPix = sum(sum(bsxfun(@gt, imgArray, 0.1*max(max(imgArray,[],1),[],2)  ),1),2);

imgArray = imgArray(:,:,(numPix>=p.filterSize(1))&(numPix<=p.filterSize(2)));

numImgs = size(imgArray,3);
allColors = distinguishable_colors(numImgs,{'w', 'k'});

imgFull = zeros(size(imgArray,1),size(imgArray,2),3);
for ll = 1:numImgs
    TMPimg = imgArray(:,:,ll).*(imgArray(:,:,ll)>0);
    switch p.normOpt
        case 'all'; TMPimg  = TMPimg./max(imgArray(:));
        otherwise;  TMPimg  = TMPimg./max(TMPimg(:));
    end
    imgFull = imgFull + bsxfun(@times, TMPimg,...
                                       reshape(allColors(ll,:),[1,1,3]));
end

if nargout >0; varargout{1} = imgFull;
else
    imagesc(imgFull)
    if isempty(p.aspectRatio); axis image;
    else;                      pbaspect([p.aspectRatio,1]);
    end
    axis off
end



end
