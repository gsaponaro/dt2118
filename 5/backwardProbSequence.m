function beta = backwardProbSequence(seq,B,T)
% FORWARDPROBSEQUENCE - compute backward probabilities between a given
%                       observation sequence and an HMM model.
%
% Input Parameters:
% seq(1,n_seq)        observed sequence
% B(S,alphabet_size)  observation (emission) symbol probabilities
% T(S,S)              transition matrix
%
% Output Parameters:
% beta(n_seq,S)       backward probabilities

n_seq = length(seq);  % number of observed symbols
n_states = size(B,1); % number of states

beta = zeros(n_seq, n_states);
% initialize to 1/n_states or to 1
beta(end,:) = 1 / n_states;
% induction
for t = n_seq-1:-1:1
    for i = 1:n_states
        totsum = 0;
        for j = 1:n_states
            totsum = totsum + T(i,j)*B(j,seq(t+1))*beta(t+1,j);
        end;
        beta(t,i) = totsum;
    end;
end;