% DT2118, Speech and Speaker Recognition, Spring 2012
% https://www.kth.se/social/course/DT2118/
%
% Computational Exercise 2: CART algorithm decision tree
%
% author: Giovanni Saponaro
%
% see also: weightedSquaredError

%             X    Y   f1 f2 f3
CARTData = [ 1.1  6.9  0  0  1
             1.5  8.3  1  1  0
             2.0  4.2  1  1  1
             2.5  1.9  1  0  0
             3.3  5.2  1  1  1
             3.9  3.6  0  0  1
             4.2  5.1  0  0  0
             4.6  6.3  1  1  1
             5.1  9.3  1  1  1
             5.4  7.6  0  1  1
             5.6  3.4  1  0  0
             7.4  1.5  1  1  0
             7.5  4.2  1  1  1
             7.6  8.1  1  1  1
             8.3  0.6  0  0  1
             8.6  2.6  0  0  0 ];
         
% more intuitive variable names
XY = [1 2];
all_data = CARTData(:, XY);
f1 = 3;
f2 = 4;
f3 = 5;

% number of training samples
N = size(all_data,1);

% Question Set
Q = {f1, f2, f3}; % each question being if that feature is >0
num_questions = length(Q);

% initialization: tree with 1 root node consisting of all training data
root_idx = [1:N]; % indices of nodes

% weighted squared error before splitting
wse_before = weightedSquaredError(root_idx, all_data);

% evaluate all questions for splitting
for i = 1:num_questions
 
    % boolean mask of samples belonging to node 'f{i}>0?'
    belong_mask = CARTData(:,Q{i});
    
    % indices of samples belonging to node 'f{i}>0?' - e.g. right children
    belong_idx{i} = find(belong_mask);
    
    % indices of remaining samples - e.g. left children
    not_belong_idx{i} = find(~belong_mask);
    
    % weighted squared error of 'belonging' (e.g. right) leaf: V(r)
    wse_belong{i} = weightedSquaredError(belong_idx{i}, all_data);

    % weighted squared error of 'not belonging' (e.g. left) leaf: V(l)
    wse_not_belong{i} = weightedSquaredError(not_belong_idx{i}, all_data);
    
    % decrease in squared error after splitting with question i
    wse_decrease{i} = wse_before - (wse_not_belong{i} + wse_belong{i});
    
end;

% convert cell array to single matrix
wse_decrease_mat = cell2mat(wse_decrease);
% optimization
[best_decrease,best_q] = max(wse_decrease_mat);

fprintf('Exercise 2:\n\n');
fprintf('The question used in the branch is %d, i.e., "f%d>0?".\n',...
    best_q, best_q);
fprintf('The regression error before the split is %f.\n', wse_before);
fprintf('The regression error after the split is %f.\n', ...
    wse_decrease_mat(best_q));
fprintf('The two new nodes have %d and %d samples, respectively.\n', ...
    length(belong_idx{best_q}), length(not_belong_idx{best_q}));
