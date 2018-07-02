% DT2118, Speech and Speaker Recognition, Spring 2012
% http://www.csc.kth.se/utbildning/kth/kurser/DT2118/
%
% Computational Exercise 5: Baum-Welch
%
% author: Giovanni Saponaro
%
% see also: backwardProbSequence, estimateObsProb, estimateTransProb,
%           forwardProbSequence, gammaProbSequence

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

fprintf('Exercise 5:\n\n');

seq   = [2 1 3 3 4]; % observed symbols 
fprintf('Observed output sequence: [b a c c d], which corresponds to the\n');
fprintf('following indexes of alphabet {a,b,c,d}:'); disp(seq);

alphabet = [1 2 3 4]; % if all symbols are found at least once, this can be
                      % also computed as alphabet=unique(seq)

% Baum-Welch Algorithm with observed sequence seq

fprintf('Running the first iteration of the Baum-Welch algorithm...\n\n');

% compute forward probabilities as in Ex. 4
alpha = forwardProbSequence(seq,P,B,T);

% compute backward probabilities - Eq. 8.28 of Huang's book
beta = backwardProbSequence(seq,B,T);

% compute gamma probabilities - Eq. 8.29 of Huang's book
gamma = gammaProbSequence(seq,alpha,beta,B,T);

% re-estimation of transition probabilities - Eq. 8.40 of Huang's book
Tnew = estimateTransProb(gamma);

% re-estimation of observation probabilities - Eq. 8.41 of Huang's book
Bnew = estimateObsProb(gamma,alphabet,seq);

fprintf('Re-estimated transition probabilities:\n');
disp(Tnew);

fprintf('Re-estimated observation probabilities:\n');
disp(Bnew);

% apply new estimates

% compute forward probabilities; each row is a frame/symbol, and the first
% one is set to the initial probabilities
alphanew = forwardProbSequence(seq,P,Bnew,Tnew);

% transpose to obtain intuitive trellis format: now each column is a
% frame/symbol, and the first one is set to the initial probabilities
alphanew = alphanew';

% termination with requirement to end in the final state, i.e.,
% probability of having generated the observed sequence
prob_seq_new = sum(alphanew(:,end));

fprintf('New trellis for the observed sequence:\n');
fprintf('              X1=b      X2=a      X3=c      X4=c      X5=d \n');
fprintf('    t=0       t=1       t=2       t=3       t=4       t=5 \n');
disp(alphanew);

fprintf('The probability that the re-estimated model has generated the\n');
fprintf('observation sequence is given by the sum of the probabilities in\n');
fprintf('the final column of the trellis diagram:\n');
disp(prob_seq_new);
fprintf('which is higher than the probability computed with the original\n');
fprintf('model at the end of Ex. 4\n');