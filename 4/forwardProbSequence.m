function alpha = forwardProbSequence(seq,P,B,T)
% FORWARDPROBSEQUENCE - compute forward probabilities between a given
%                       observation sequence and an HMM model.
%
% Input Parameters:
% seq(1,n_seq)        observed sequence
% P(1,S)              initial state probabilities
% B(S,alphabet_size)  observation (emission) symbol probabilities
% T(S,S)              transition matrix
%
% Output Parameters:
% alpha(1+n_seq,S)    forward probabilities

n_states = length(P); % number of states
n_seq = length(seq); % number of observed symbols

% initialization with symbol seq(1) - in this case 'b' i.e. 2
for si = 1:n_states
    alpha(1,si) = P(si) * B(si,seq(1));
end;
% induction with symbols seq(2) to seq(end)
for t = 2:n_seq
    for j = 1:n_states
        totsum = 0;
        for i = 1:n_states
            totsum = totsum + alpha(t-1,i)*T(i,j);
        end;
        alpha(t,j) = totsum * B(j,seq(t));
    end;
end;
% prepend initial probabilities at the beginning
alpha = [P; alpha];