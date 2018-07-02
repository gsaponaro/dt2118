function Tnew = estimateTransProb(gamma)
% ESTIMATETRANSPROB - re-estimate transition probability matrix with
%                     the ratio between expected number of i->j transitions
%                     and expected number of all transitions from i;
%                     Eq. 8.40 of Huang's book
% Input Parameters:
% gamma(n_seq,S,S)    gamma probabilities
%
% Output Parameters:
% Tnew(S,S)           re-estimated transition matrix

[n_seq,n_states,~] = size(gamma);

Tnew = zeros(n_states,n_states);
for i = 1:n_states
    for j = 1:n_states
        totsum1 = 0; % numerator: exp. number of i->j transitions
        totsum2 = 0; % denominator: exp. number of all transitions from i
        for t = 1:n_seq
            totsum1 = totsum1 + gamma(t,i,j);
            
            contrib2 = 0; % the sum_k part of the denominator
            for k = 1:n_states
                contrib2 = contrib2 + gamma(t,i,k);
            end;
            totsum2 = totsum2 + contrib2;
        end;
        Tnew(i,j) = totsum1 / totsum2;
    end;
end;