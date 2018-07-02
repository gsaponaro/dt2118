function gamma = gammaProbSequence(seq,alpha,beta,B,T)
% GAMMAPROBSEQUENCE - compute 'gamma' probabilities of taking transition
%                     i->j at time t, given a model and an observation
%                     sequence - Eq. 8.29 of Huang's book.
%
% Input Parameters:
% seq(1,n_seq)        observed sequence
% alpha(1+n_seq,S)    forward probabilities
% beta(n_seq,S        backward probabilities
% B(S,alphabet_size)  observation (emission) symbol probabilities
% T(S,S)              transition matrix
%
% Output Parameters:
% gamma(n_seq,S,S)    gamma probabilities

n_seq = length(seq);  % number of observed symbols
n_states = size(B,1); % number of states

gamma = zeros(n_seq,n_states,n_states);
% denominator - common
possible_paths = 0;
for k = 1:n_states
    possible_paths = possible_paths + alpha(end,k);
end;
% numerators - different for every (time t, state i, state j) tuple
grey_paths = zeros(n_seq,n_states,n_states);
for t = 1:n_seq
    for i = 1:n_states
        for j = 1:n_states
            % note: alpha(t,i) instead of alpha(t-1,i) as in book
            grey_paths(t,i,j) = alpha(t,i)*T(i,j)*B(j,seq(t))*beta(t,j);
        end;
    end;
end;
gamma = grey_paths / possible_paths;