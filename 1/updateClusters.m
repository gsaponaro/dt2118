function Z = updateClusters(D,c)
% Input Parameters:
% D(N,P)   data (N datapoints, P dimensions)
% c(K,P)   centroids
%
% Output Parameters:
% Z(N)     assignment of each datapoint to a class
%
% See also: kmeans, updateCentroids

[N,~] = size(D);
[K,~] = size(c);

Z = zeros(N,1);
for i = 1:N % for each datapoint
    distances = zeros(K,1);
    for j = 1:K % for each codeword
        % populate vector of distances to each codeword
        distances(j,1) = euclidean(D(i,:), c(j,:));
    end;
    % populate Z(i) with argmin(distances)
    [~,Z(i)] = min(distances);
end;