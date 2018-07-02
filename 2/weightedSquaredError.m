function wse = weightedSquaredError(idx, data)
% WEIGHTEDSQUAREDERROR - compute regression error in a CART node, as per
%                        Eq. 4.128 of Huang's book
%
% Input Parameters:
% idx(1,S)          list of samples (indices) belonging to the node
% data(Ntotal,P)    data (Ntotal datapoints, P dimensions)
% Output Parameters:
% wse(1,1)          weighted squared error

if ~issorted(idx)
    fprintf('weightedSquaredError warning: idx is not sorted.\n');
end;

% number of total samples in the data
[Ntotal,~] = size(data);

% number of samples in the node
N = length(idx);

% node average, 2-dimensional in the exercise case: mu = (mu_x,mu_y)
node_avg = mean(data(idx,:));

% expected squared error for the node (not yet weighted)
% assumption: idx is sorted
se = 0;
for i = idx(1):idx(end) % for all samples in the node
    % hardcoded method (instead of using exercise 1 euclidean.m)
    se = se + (data(i,1)-node_avg(1))^2 + (data(i,2)-node_avg(2))^2;
end;
% normalize
se = (1/N) * se;

% prior probability (weight) of being in the node
prior = N / Ntotal; % uniform

wse = se * prior;
