function dist = euclidean(word1, word2)
% EUCLIDEAN - Euclidean distortion metric.
%
% Input Parameters:
% word1(1,P)  row data vector
% word2(1,P)  row data vector
%
% Output Parameters:
% dist(1,1)   Euclidean distance between the two input vectors
%
% Giovanni Saponaro

[N1,P1] = size(word1);
[N2,P2] = size(word2);
if (N1>1 || N2>1)
    error('euclidean error: inputs are not row vectors.');
end;
if (P1 ~= P2)
    error('euclidean error: inputs have different dimension.');
end;

% Sum of Squared Errors (SSE) among all dimensions
sse = 0;
for i = 1:P1
    sse = sse + (word1(1,i)-word2(1,i))^2;
end;

% Euclidean distance = square root of SSE
dist = sqrt(sse);
