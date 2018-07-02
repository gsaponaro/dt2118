% taken from
% http://www.mathworks.com/matlabcentral/fileexchange/28559-order-of-magnitude-of-number

function n = order( val )
%Order of magnitude of number.
%order(0.002) will return -3., order(1.3e6) will return 6.
%Author Ivar Smith

n = floor(log10( abs(val) ));
