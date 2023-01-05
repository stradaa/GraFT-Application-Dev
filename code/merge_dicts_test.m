% Adapted from mergeGraFTdictionaries.m and merge_components.m
%
%
% 2021 - Alex

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Loading Data for Testing Purposes
clear, clc
% load('post_combineDictionaryPatches.mat')
load('post_combineDictionaryPatches_16_patches.mat')

normalizeSpatial = 2;

%% Initialization and input parsing

D = D';                                                                    % Transpose the time-courses for easier processing
if size(params)<1; params = []; end                                        % Make sure there is an options variable
[~, mx]  = parseMergeParameters(params);                                   % parse out the merging parameters (max & threshold)
d  = size(S,1);                                                            % Get number of pixels
T  = size(D,2);                                                            % Get number of time steps
nr = size(S,2);                                                            % Get the total number of components 
if nr == 0                                                                 % If there are no components, nothing to merge and so return an empty matrix
    merged_ROIs = [];                                                      % No components, so nothing to merge: return an empty array
    return                                                                 % Nothing else to do here
end

thr = 0.85;     % Not sure why 0.75 on parseMergeParameters

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1 & 2 - Spatial and Temporal Correlation Matrix

% Spatial
A_corr              = triu(S'*S);                                          % Calculate all inner products between spatial components
A_corr(1:nr+1:nr^2) = 0;                                                   % Set diagonal to zero
FF2                 = A_corr > 0;                                          % Find graph of overlapping spatial components (positive inner products)
                                                                                % contains (+) inner products
% Temporal
D_corr = zeros(nr);
for i = 1:nr                                                               % Loop over correlations since many time-traces don't overlap, so there's no reason to compute those correlations at all
    overlap_idx = find(A_corr(i,:));                                       % Get the set of pixels that overlap
    if ~isempty(overlap_idx)                                               % If there are actually overlapping indices...
        corr_values = corr(D(i,:)',D(overlap_idx,:)');                     % ...Calculate the correlation between then 
        D_corr(i,overlap_idx) = corr_values;                               % ...Save the correlation value in the matrix
        D_corr(overlap_idx,i) = corr_values;                               % ...And make sure everything is symmetric
    end
end

%% 3- Merge Indices (MC)

FF1    = triu(D_corr)>= thr;                                               % find graph of strongly correlated temporal components
FF3    = and(FF1,FF2);                                                     % intersect the two graphs
[l, c] = graph_connected_comp(sparse(FF3+FF3'));                           % extract connected components
                                                                                % l = unique labels, c = # of components
MC     = [];                                                               % Start with no components to merge

for i = 1:c                                                                % Loop through all connections
    if length(find(l==i))>1                                                % Find if any componentes are strongly connected and to who
%       MC = [MC,(l==i)'];
        MC = cat(2,MC,(l==i)');                                            % If there are strong connections, add that merge to the list of components to merge
    end
end

%% 4 - Sum Correlations for Potential Merge

cor = zeros(size(MC,2),1);
for i = 1:length(cor)
    fm = find(MC(:,i));
    for j1 = 1:length(fm)
        for j2 = j1+1:length(fm)
            cor(i) = cor(i) + D_corr(fm(j1),fm(j2));
        end
    end
end

%% 5 - Re-order Indices (High -> Low)

[~,ind]     = sort(cor,'descend');
nm          = min(length(ind),mx);                                         % number of merging operations
merged_ROIs = cell(nm,1);

for i = 1:nm
    merged_ROIs{i} = find(MC(:,ind(i)));
end

%% 6 - Initialing Merged Profiles

S_merged = zeros(d,nm);                                                    % Spatial profiles
D_merged = zeros(nm,T);                                                    % Temporal profiles

%% 7 - Ratios and Merging (Changed)

for i = 1:nm
    MASK = createMergingMask(S, merged_ROIs, i);                           % Create a mask over the spatial area of the profiles to merge
%     nC   = calculatePatchNormalizations(D, merged_ROIs, i);                 % NOT USED ANYWAYS
    
    A_subset = S(:,merged_ROIs{i});                                        
    C_subset = D(merged_ROIs{i},:);

    % Trying to find aa & cc such that aa*cc ~ A_subset*C_subset via
    %    argmin_{aa,cc} ||aa*cc - A_subset*C_subset||_F^2
    aRatio  = getSpatialWeights(A_subset, C_subset);

    % changed
    [aa,nA] = mergeSingleSpatial(A_subset,aRatio,MASK);
    cc      = mergeSingleTempotal(C_subset,nA);
    

    S_merged(:,i) = aa;
    D_merged(i,:) = cc;
end


%% reorderDictionary() replacement for now
                  
[D, S] = reorderDictionary(Y, D, S);                                       % Reorders te dictionary elements based on magnitude

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Functions

function [thr, mx] = parseMergeParameters(options)

if ~isfield(options, 'merge_thr') || isempty(options.merge_thr)            % merging threshold 
    thr = 0.75; 
else
    thr = options.merge_thr;
end     
if ~isfield(options,'max_merg')                                            % maximum merging operations
    mx = Inf; 
else 
    mx = options.max_merg; 
end

end
%%
function [Dm, Sm] = reorderDictionary(Y, Dm, Sm)

Dm = Dm';   % quick fix

Dnorms   = sqrt(sum(Dm.^2,1));                                             % Get norms of each dictionary element
Smax     = max(Sm,[],1);                                                   % Get maximum value of each spatial map
actMeas  = Dnorms(:).*Smax(:);                                             % Total activity metric is the is the product of the above
[~,IX]   = sort(actMeas,'descend');                                        % Get the indices of the activity metrics in descending order
Dm       = Dm(:,IX);                                                       % Reorder the dictionary
Sm       = Sm(:,IX);                                                       % Reorder the spatial maps
Sm       = reshape(full(Sm),size(Y,1),size(Y,2),[]);                       % Reshape presence maps to be an image stack

end
%%
function MASK = createMergingMask(A, merged_ROIs, i)

MASK             = sum(A(:,merged_ROIs{i})>0,2);
MASK(MASK(:)==0) = 1;
end
%%
function aRatio = getSpatialWeights(S, D)

if ndims(S)==3
    S = reshape(S,[],size(S,3));
end

aRatio = diag(ones(1,size(S,2)));                                          % Initialize the ratio matrix to be the identity
combs  = combnk(1:size(S,2),2);                                            % Get all combinations of spatial profiles
numOL  = diag(sum(S>0,1));
for ll = 1:size(combs,1)
    TMP = sum((S(:,combs(ll,1))>0)&(S(:,combs(ll,2))>0));                  % Get the number of pixels overlapping between 
    numOL(combs(ll,1),combs(ll,2)) = TMP;                                  % Store the number of overlaps
    numOL(combs(ll,2),combs(ll,1)) = TMP;                                  % Overlap count is symmetric
    if TMP ==0                                                             % If NO OVERLAP...
        aRatio(combs(ll,1),combs(ll,2)) = NaN;                             % ... save NaNs as the ratio (0/0)
        aRatio(combs(ll,2),combs(ll,1)) = NaN;                             % ... 1/(0/0) is also a NaN
    else                                                                   % If there IS OVERLAP...
        aRatio(combs(ll,1),combs(ll,2)) = nanmedian(...
            (D(combs(ll,1),:) - median(D(combs(ll,1),:)))./ ...
            (D(combs(ll,2),:) - median(D(combs(ll,2),:))));                % ... aRatio is the median ratio between significant pixels
        aRatio(combs(ll,2),combs(ll,1)) = nanmedian(...
            (D(combs(ll,2),:) - median(D(combs(ll,2),:)))./ ...
            (D(combs(ll,1),:) - median(D(combs(ll,1),:))));                % ... aRatio is the median ratio between significant pixels% ... This matrix is NOT symmetric as Aij = 1/Aji
    end
end

aRatio = pickBestRatios(aRatio,numOL);                                     % Pick the best ratios

end
%%
function ratioOut = pickBestRatios(aRatio,numOL)

ratioOut = zeros(size(numOL,1),1);                                         % Initialize outputs to a zeros vector
numOL(1:(size(numOL,1)+1):end) = 0;                                        % Remove the diagonal for convenience
numOL(isnan(numOL)) = 0;                                                   % Just in case NaNs exist... those should be zero

meanOLs   = nanmean(numOL,1);                                              % Find out all the average overlaps
baseIdx   = find(meanOLs==max(meanOLs(:)),1);                              % The base index has the most overlap pixels with other profiles
ratioOut(baseIdx) = 1;                                                     % The base index is not scaled

idxPassed = baseIdx;                                                       % Initialize the passed nodes with the base index

while numel(idxPassed) < size(numOL,1)                                     % Conutnue until no nodes are left to cycle through
    neighborIdx = setdiff(find(sum(numOL(idxPassed,:),1) > 0),idxPassed);  % Find all the profiles that overlap with 
    numOL(neighborIdx,neighborIdx) = 0;                                    % Zero out connections between neighbors
    for ll = 1:numel(neighborIdx)
        allConnect  = numOL(neighborIdx(ll),:);                            % Get the connectivity of each node in sequence
        backConnect = allConnect(idxPassed);                               % Pull out the connections up the tree only
        maxBackConn = find(backConnect==max(backConnect),1);               % Find the max connection up the tree
        idxMaxBC    = idxPassed(maxBackConn);                              % Pull out the relevent index
        numOL(neighborIdx(ll),setdiff(idxPassed, idxMaxBC)) = 0;           % Remove the other back projections
        numOL(setdiff(idxPassed, idxMaxBC),neighborIdx(ll)) = 0;           % Remove the other back projections (keeping things symmetric
        ratioOut(neighborIdx(ll)) = ratioOut(idxMaxBC)*aRatio(idxMaxBC,...
                                                         neighborIdx(ll)); % Store the correct ratio value
    end
    idxPassed = union(idxPassed,neighborIdx);                              % Add the neightborhood into the set of passed neurons 
end

end
%%
function [aa,nA] = mergeSingleSpatial(A_subset,aRatio,MASK)

MASK(MASK~=0) = 1./MASK(MASK~=0);                                          % Set mask to be averaging weights
aa            = MASK.*(sum(A_subset*diag(aRatio),2));                      % Average using the MASK weights

nA            = vec(sum(A_subset>0,1)./sum(sum(A_subset>0)));              % AXE THIS???

end
%%
function cc = mergeSingleTempotal(C_subset,aRatio)

medVals = median(C_subset,2);
minMed  = min(medVals);
% cc      = vec(sum(diag(nA)*bsxfun(@minus,C_subset,medVals)));
% cc      = cc+ minMed;
cc      = vec(mean(diag(1./aRatio)*bsxfun(@minus,C_subset,medVals)));
cc      = cc+ minMed;

end