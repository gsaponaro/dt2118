function Bnew = estimateObsProb(gamma,alphabet,seq)
% ESTIMATEOBSPROB - re-estimate observation symbol probability matrix with
%                   the ratio between the expected number of times the
%                   observation emitted from state j with symbol k, and
%                   the expected number of times the observation emitted
%                   from state j; Eq. 8.41 of Huang's book
%
% Input Parameters:
% gamma(n_seq,S,S)          gamma probabilities
% alphabet(1,alphabet_size) row vector with all the alphabet symbols
% seq(1,n_seq)              observed sequence
%
% Output Parameters:
% Bnew(S,alphabet_size)     re-estimated observation symbol prob. matrix

[~,n_states,~] = size(gamma);
alphabet_size = size(alphabet,2);
n_seq = size(seq,2);

Bnew = zeros(n_states,alphabet_size);
for j = 1:n_states
    for k = 1:alphabet_size
        totsum1 = 0; % numerator: exp. number of times observation data
                     % emitted from state j is k
        totsum2 = 0; % denominator: exp. number of times any observation data
                     % emitted from state j
        
        % numerator
                     
        % for each alphabet symbol, compute the set {Xt==k}
        occurrences{alphabet(k)} = find(seq==alphabet(k));
        
        % continue with this k only if there was at least one match
        num_occurrences = length(occurrences{alphabet(k)});
        if num_occurrences>0
            % sum over t \in {Xt==k} in Eq. 8.41 of Huang's book
            contrib1t = 0;
            for t = occurrences{alphabet(k)}(1):occurrences{alphabet(k)}(end)
                % sum over i (starting states of i->j transition)
                contrib1i = 0;
                for i = 1:n_states
                    contrib1i = contrib1i + gamma(t,i,j); % add to sum_i
                end;
                contrib1t = contrib1t + contrib1i; % add sum_i to current t
            end;
        end;
        % now contrib1t includes the contributions of all entries of {Xt==k}
        % of the current k. for example if k=3, {Xt==k} is [3 4], and 
        % contrib1t now includes the numerator values for t=3 plus for t=4
        
        totsum1 = totsum1 + contrib1t; % check
        
        % denominator
        for t = 1:n_seq
            for i = 1:n_states
                totsum2 = totsum2 + gamma(t,i,j);
            end;
        end;
        
        Bnew(j,k) = totsum1 / totsum2;
    end;
end;