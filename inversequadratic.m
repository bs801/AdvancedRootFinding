%%%%%%%%%%%%%%%%%%%
%%% Name: Bohan Song
%%% RUID: 180006793
%%% Final Project
%%%%%%%%%%%%%%%%%%%
function g = inversequadratic(f,a,b,c)
%% This function is an implementation of inverse quadratic interpolation for root finding.
% INPUT value:
%             f - function expression
%             a,b,c - initial x values
% OUTPUT value
%             g - approximation of root

g = a*f(b)*f(c)/((f(a)-f(b))*(f(a)-f(c))) + b*f(a)*f(c)/((f(b)-f(a))*(f(b)-f(c))) + c*f(b)*f(a)/((f(c)-f(a))*(f(c)-f(b))) ;



end
