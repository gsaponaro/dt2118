function newc = updateCentroids(D,Z,K)
% Input Parameters:
% D(N,P)    data (N datapoints, P dimensions)
% Z(N)      assignment of each datapoint to a class
% K         number of centroids (classes)
%
% Output Parameters:
% newc(K,P) new centroids
%
% See also: kmeans, updateClusters

[~,P] = size(D);

% codebook updating: set the codeword of each cell as the sample mean of
% the training vectors quantized to that cell - Eq. 4.86 of Huang's book
newc = zeros(K,P);
for j = 1:K
    newc(j,:) = mean( D(Z==j,:) );
end;