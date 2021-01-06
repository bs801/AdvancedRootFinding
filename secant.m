%%%%%%%%%%%%%%%%%%%
%%% Name: Bohan Song
%%% RUID: 180006793
%%%%%%%%%%%%%%%%%%%
function g = secant(f,x0,x1)
%% This function is an implementation of secant method 
% INPUT Value:
%          f - function
%          x0 - first initial guess
%          x1 - second initial gues
% OUTPUT Value
%          g - approximation of root
%% Check which one of x0 or x1 is an upper bound

if x0 < x1
   lep = x0;
   rep = x1;
else
   lep = x1;
   rep = x0; 
end

% tol = 1e-10;
%Maxnum = 15;
g = rep - f(rep)*(rep-lep)/(f(rep)-f(lep));

% count = 1;

%while abs(x3-x1)>= tol && count <= Maxnum
%   lep = rep;
%   rep = x2;
%   x2 = rep - f(rep)*(rep-lep)/(f(rep)-f(lep));
%   count = count + 1;
%  end



end


