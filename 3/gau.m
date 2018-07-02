function value = gau(p,mu,S)
% GAU - compute the pdf of the normal (Gaussian) distribution with mean mu
%       and diagonal covariance Sigma, evaluated at point p.
%
% Input Parameters:
% p(1,dms)    data vector
% mu(1,dms)   mean
% S(dms,dms)  diagonal covariance matrix
%
% Output Parameters:
% value(1,1)  normal pdf computed at point p

% dimension of input vector (and of mean and covariance)
dms = length(p);

% bivariate Gaussian pdf - see also Eq. 3.82 of Huang's book
value = exp(-0.5*((p-mu)*inv(S)*(p-mu)')) / (sqrt(2*pi)^dms * sqrt(det(S)));