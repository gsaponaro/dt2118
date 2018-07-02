% DT2118, Speech and Speaker Recognition, Spring 2012
% https://www.kth.se/social/course/DT2118/
%
% Computational Exercise 1: Vector Quantization
%
% author: Giovanni Saponaro
%
% see also: distortions, euclidean, kmeans, updateCentroids, updateClusters

% input data
XY = [ 1.1 6.9
       1.5 8.3
       2.0 4.2
       2.5 1.9
       3.3 5.2
       3.9 3.6
       4.2 5.1
       4.6 6.3
       5.1 9.3
       5.4 7.6
       5.6 3.4
       7.4 1.5
       7.5 4.2
       7.6 8.1
       8.3 0.6
       8.6 2.6 ];

% initial codewords
c0 = [ 3.0 3.0; 7.0 3.0; 3.0 7.0; 7.0 7.0 ];

% k-Means parameters
endcrit = 0.1;
miniter = 3;

fprintf('Exercise 1:\n\n');

fprintf('Running plain k-Means (no LBG yet) with codebook c0...\n');
[c,~,~] = kmeans(XY,c0,endcrit,miniter);
fprintf('...k-Means returned these centroids:\n');
disp(c);

% Linde-Buzo-Gray implementation
% (taken from http://www.data-compression.com/vq.html#lbg , more detailed
% than Huang's book)
fprintf('Now running LBG algorithm...\n');

% Linde-Buzo-Gray parameters
epsilon = 0.01; % percentage of perturbation when splitting
desired_codebook_size = size(c0,1);

% initialization: 1-vector codebook, i.e., only 1 partition set to the
% average of all training data
M = mean(XY);

% nearest neighbour (minimum-distance) classification
Z = updateClusters(XY,M);
% vector of the average distortions within each cell/cluster; in this case
% the codebook still has only 1 cell so this step is redundant, but shown
% for consistency
distor = distortions(XY,M,Z);
% overall average distortion of all cells - Eq. 4.79 of Huang's book
overall_distor_curr = mean(distor);

% workaround to simulate a do-while loop in MATLAB
done = false;

while ~done
    
    % splitting: double current codebook
    fprintf('LBG codebook splitting in progress, %d -> %d centroids\n', ...
        size(M,1), size(M,1)*2);
    M = repmat(M,2,1);
    % perturb first half positively
    M(1:end/2,:) = M(1:end/2,:) * (1+epsilon);
    % perturb second half negatively
    M((end/2)+1:end,:) = M((end/2)+1:end,:) * (1-epsilon);

    [K,~] = size(M);

    % k-Means
    [~, Z, ~] = kmeans(XY, M, endcrit, miniter);
    
    % check if this is needed here
    % codebook updating: compute the new centroid of each cell according to
    % Eqs. 4.84, 4.86 of Huang's book
    M = updateCentroids(XY,Z,K);
    
    % compute overall distortion again, update variables
    overall_distor_prev = overall_distor_curr;
    Z = updateClusters(XY,M);
    distor = distortions(XY,M,Z);
    overall_distor_curr = mean(distor);
    
    % end criterion for LBG: size of codebook reaches desired size
    done = (size(M,1)==desired_codebook_size);
    if done
        fprintf('LBG converged, codebook has %d centroids\n', ...
            size(M,1));
    end;

end;

fprintf('...LBG returned these centroids:\n');
disp(M);
