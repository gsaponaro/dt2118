function [c, Z, niter] = kmeans(D, c0, endcrit, miniter)
% KMEANS - K-means algorithm
% 
% Input Parameters:
% D(N,P)   data matrix (N datapoints, P dimensions)
% c0(K,P)  K initial centroids
% endcrit  end criterion: stop when the distortion decrease between
%          iterations is lower than endcrit
% miniter  ignore endcrit as long as the number of iteration is
%          lower than miniter
%
% Output Parameters:
% c(K,P)   final centroids
% Z(N)     assignment of each datapoint to a class
% niter    number of iterations before end criterion is reached
%
% See also: updateCentroids, updateClusters

[~,P_data] = size(D);
[K,P_c0]   = size(c0);
if P_data ~= P_c0
    error('kmeans error: data points and codewords have different dimensions.');
end;

% workaround to simulate a do-while loop in MATLAB
done = false;

% initial conditions
niter = 0;
c = c0; % centroids

while ~done
    
    % iteration counter
    niter = niter + 1;
    
    % for debugging
    if exist('Z','var')
        oldZ = Z;
    end;

    % nearest neighbour (minimum-distance) classification
    Z = updateClusters(D,c);
    
    % for debugging
    if exist('oldZ','var')
        if Z==oldZ
            fprintf('kmeans warning: iteration %d, ', niter);
            fprintf('assignments Z did not change\n');
        end;
    end;

    % vector of the average distortions within each cell/cluster
    distor = distortions(D,c,Z);
    % overall average distortion of all cells - Eq. 4.79 of Huang's book
    overall_distor_curr = mean(distor);
    
    % codebook updating: compute the new centroid of each cell according to
    % Eqs. 4.84, 4.86 of Huang's book
    c = updateCentroids(D,Z,K);
    
    % compute overall distortion again, update variables
    overall_distor_prev = overall_distor_curr;
    Z = updateClusters(D,c);
    distor = distortions(D,c,Z);
    overall_distor_curr = mean(distor);
    
    % distortion decrease can be either computed like this
    % (simpler and more adherent to the exercise text):
    % 1)
    distor_decrease = abs(overall_distor_curr - overall_distor_prev);
    % or like this (more general, adherent to book):
    % 2)
    %distor_decrease = abs(overall_distor_curr - overall_distor_prev) / ...
    %    abs(overall_distor_prev)
    
    done = distor_decrease<endcrit && niter>=miniter;
        
end;

%fprintf('kmeans final centroids:');
%c
