% DT2118, Speech and Speaker Recognition, Spring 2012
% http://www.csc.kth.se/utbildning/kth/kurser/DT2118/
%
% Computational Exercise 3: Gaussian Mixtures
%
% author: Giovanni Saponaro
%
% see also: gau, order

y  = [7 12];                                           % data point
m1 = [4 9];       m2 = [0 6];      m3 = [11 18];       % means
S1 = [3 0; 0 21]; S2 = [2 0; 0 5]; S3 = [30 0; 0 73];  % covariances
c1 = 0.4;         c2 = 0.5;        c3 = 0.1;           % weights

% data from Exercise 1
XY = [ 1.1 6.9
       1.5 8.3
       2.0 4.2
       2.5 1.9
       3.3 5.2
       3.9 3.6
       4.2 5.1
       4.6 6.3
       5.1 9.3
       5.4 7.6
       5.6 3.4
       7.4 1.5
       7.5 4.2
       7.6 8.1
       8.3 0.6
       8.6 2.6 ];
   
dmsXY = size(XY,1);

% % using MATLAB Statistics Toolbox
% %
% % 1)
% % create three Gaussian mixture distributions - overkill?
% g1 = gmdistribution(m1,S1);
% g2 = gmdistribution(m2,S1);
% g3 = gmdistribution(m3,S1);
% % pdf(g1,y) indicates the value of pdf g1 at point y
% B = c1*pdf(g1,y) + c2*pdf(g2,y) + c3*pdf(g3,y);
% %
% % 2)
% % mus = [m1;m2;m3];
% % Sigmas = cat(3,S1,S2,S3);
% % weights = [c1 c2 c3];
% % o = gmdistribution(mus,Sigmas,weights);

% manual implementation
g1 = gau(y,m1,S1); % value of Gaussian pdf (with m1,S1) at point y
g2 = gau(y,m2,S2);
g3 = gau(y,m3,S3);
B = c1*g1 + c2*g2 + c3*g3; % mixture of Gaussians

% order of magnitude of B
orderB = order(B);

% number of frames making up one utterance
nframes = 100;

fprintf('Exercise 3:\n\n');

fprintf('a. The likelihood for one frame of an utterance is: %f\n\n', B);

fprintf('b. Because the likelihood for one frame is in the order of 10^(%d),\n', ...
    orderB);

fprintf('the order of magnitude of the total likelihood of ');
fprintf('one utterance of\n%d frames (under the given assumptions) is ', ...
    nframes);
fprintf('10^(%d).\n\n', orderB*nframes);
fprintf('The value range of a 32-bit floating point number is such that\n');
fprintf('the smallest positive value is 2^(-149).\n');
fprintf('[http://www.psc.edu/general/software/packages/ieee/ieee.php]\n\n');
fprintf('Therefore, a 32-bit computer could not possibly represent that\n');
fprintf('total likelihood (underflow problem).\n\n');
fprintf('To prevent this problem, normally the logarithm of the likelihood\n');
fprintf('(log-likelihood) is taken.\n\n');

fprintf('c. In order to re-estimate the parameters of the Gaussian mixture\n');
fprintf('in the Ex. 1 data, Expectation-Maximization (EM) can be used.\n\n');

fprintf('d. Re-estimating the means m1,m2,m3 while keeping the covariance\n');
fprintf('matrices and weights constant, using data from Ex. 1:\n');
fprintf('1. inizialize means, cov, weights and evaluate initial loglik\n');
fprintf('2. (E-step) evaluate weights using current values\n');
fprintf('3. (M-step) re-estimate params using weights found in M-step\n');
fprintf('4. repeat 2. and 3. until loglik converges according to some criterion\n\n');

fprintf('step 1. initial loglik computed with MATLAB Statistics Toolbox:\n');
% using MATLAB Statistics Toolbox
mus = [m1;m2;m3];
Sigmas = cat(3,S1,S2,S3);
weights = [c1 c2 c3];
o = gmdistribution(mus,Sigmas,weights);
[~,nloglik] = posterior(o,XY);
disp(nloglik);

fprintf('remaining steps: similar to 4.4.3 - Multivariate Gaussian Mixture\n');
fprintf('Density Estimation section of Huang''s book, but with a Q function\n');
fprintf('having constant weights and cov. (instead of Eqs. 4.106 and 1.108)\n');