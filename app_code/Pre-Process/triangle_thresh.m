function level = triangle_thresh(data)
% Support_Fcn: Computes the threshold level for triangle threshold, which
% calculates the threshold based on the shape of the histogram. Used for
% generating pre-computed mask during pre-processing.
%
% 07.03.2023 - Alex Estrada

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Histogram and Specifics
histCounts = histogram(data, 'NumBins', 255);
edges = histCounts.BinEdges;
counts = histCounts.Values;

% cumulative summation of histogram counts
c_sum = cumsum(counts);

% exclude
bin_edges = edges(2:end);
bin_counts = counts(2:end);
c_sum = c_sum(2:end);

% intensity values
intensity = (bin_edges(1:end-1) + bin_edges(2:end)) ./2;

% mean intensity
meanIntensity = sum(intensity .* bin_counts) ./ sum(bin_counts);

%Compute the squared between-class variance
sigma_b_squared = ((meanIntensity * c_sum - cumsum(intensity .* bin_counts)).^2) ./ (c_sum .* (1 - c_sum));

% Find the threshold that maximizes the squared between-class variance
[~, idx] = max(sigma_b_squared);
threshold = bin_edges(idx);

level = threshold;

end