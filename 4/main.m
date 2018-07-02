% DT2118, Speech and Speaker Recognition, Spring 2012
% http://www.csc.kth.se/utbildning/kth/kurser/DT2118/
%
% Computational Exercise 4: Viterbi and Forward Probabilities
%
% author: Giovanni Saponaro
%
% see also: forwardProbSequence

%      s1  s2  s3
P = [ 0.4 0.3 0.3 ]; % initial state probabilities
T = [ 0.4 0.4 0.2    % transition probabilities
      0.3 0.6 0.1
      0.3 0.2 0.5 ];
% observation symbol probabilities
%      a   b   c   d
B = [ 0.3 0.2 0.1 0.4    % s1
      0.1 0.3 0.4 0.2    % s2
      0.4 0.1 0.3 0.2 ]; % s3
  
seq   = [2 1 3 3 4]; % observed symbols in numeric format

fprintf('Exercise 4:\n\n');

fprintf('Observed output sequence: [b a c c d], which corresponds to the\n');
fprintf('following indexes of alphabet {a,b,c,d}:'); disp(seq);

% compute forward probabilities; each row is a frame/symbol, and the first
% one is set to the initial probabilities
alpha = forwardProbSequence(seq,P,B,T);

% transpose to obtain intuitive trellis format: now each column is a
% frame/symbol, and the first one is set to the initial probabilities
alpha = alpha';

% termination with requirement to end in the final state, i.e.,
% probability of having generated the observed sequence
prob_seq = sum(alpha(:,end));

fprintf('Trellis for the observed sequence:\n');
fprintf('              X1=b      X2=a      X3=c      X4=c      X5=d \n');
fprintf('    t=0       t=1       t=2       t=3       t=4       t=5 \n');
disp(alpha);

fprintf('The probability of having generated the observed sequence is given\n');
fprintf('by the sum of the probabilities in the final column:\n');
disp(prob_seq);

fprintf('Viterbi algorithm: after having arrived at the last state, follow\n');
fprintf('the backtracking indexes (max) - this gives the optimal path\n');
