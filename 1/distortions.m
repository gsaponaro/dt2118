function distor = distortions(D,c,Z)
% DISTORTIONS - compute distortions of data clusters resulting from
%               given centroids
%
% Input Parameters:
% D(N,P)      data (N datapoints, P dimensions)
% c(K,P)      centroids
% Z(N)        assignment of each datapoint to a class
%
% Output Parameters:
% distor(1,K) distortion of each cell

[N,P] = size(D);
[K,~] = size(c);

distor = zeros(K,1);
for j = 1:K % for each codeword
    cluster = D(Z==j, :);
    cardinality = size(cluster,1);
    for p = 1:cardinality % for each point in this cell
        distor(j,1) = distor(j,1) + euclidean(cluster(p,:), c(j,:));
    end;
    % divide the sum by total number of training vectors - Eq. 4.83 of
    % Huang's book
    distor(j,1) = (1/N) * distor(j,1);
end;
