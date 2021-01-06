%%%%%%%%%%%%%%%%%%%
%%% Name: Bohan Song
%%% RUID: 180006793
%%% Final Project
%%%%%%%%%%%%%%%%%%%
function [g,i,vp ] = ridder(f,x0,x1,realroot)
%% This function is an implementation of Ridder's method
% INPUT value:
%          f - function
%          x0 - left end point
%          x1 - right end point
% Output value:
%          g - approximation of the root for the interval [x0,x1]
%          i - numbers of iterations
%          vp - vector of errorrs 
%% Check conditions for Ridder's method
if(x0>x1)    % if right end point is less than left en point, then reverse the bound.
    c = x0;
    x0 = x1;
    x1 = c;
end

if(f(x0)>0 && f(x1) > 0)   %Ridder method requires f(x0) and f(x1) to have different sign
   fpritnf('Alert: Invalid Input Interval For Root Approximation');    
end
if(f(x0) == 0 ) % left endpoint cannot be true root
   fprintf('x0 is a root');
elseif(f(x1) == 0)  % right endpoint cannot be true root
   fprintf('x1 is a root');
end
%% First we need to find a h(x) such that  
%     h(x) = f(x) e^cx 
%     where h(x2) = (h(x0)+h(x1))/2  and c is a constant, x2 = (x0+x1)/2
x2 = (x0+x1)/2; % midpoint of x0 and x1

if(f(x0)>0)
   c = log( (f(x2)-sqrt(f(x2).^2 - f(x0)*f(x1)))/ (f(x1)*(x2-x0))); 
else
   c = log( (f(x2)-(-1)*sqrt(f(x2).^2 - f(x0)*f(x1)))/ (f(x1)*(x2-x0))); 
end

% fprintf('h(x) is the function: f(x)*e^(%g *x) \n',c);

%% Now we need to iteratively find the next point until it reaches a given accuracy or maximum iteration
tol = 1e-10; % tolerance
N = 15;      % Maximum number of iteration
count = 1;   % count numbers of iteration
vp = zeros(1,N);% store error estimation
v = zeros(1,N); %store approximation of root
format long;
while (abs(x1-x0)>=tol && count<=N)    
    x2 = (x0+x1)/2; % compute midpoint for interval of next iteration
    if( f(x0) > 0 )   % using false position method to find end point of next iteration 
         x3 = x2 + (x2-x0)*f(x2)/sqrt(f(x2)^2-f(x0)*f(x1)); 
     else
         x3 = x2 + (x2-x0)*(-1)*f(x2)/sqrt(f(x2)^2-f(x0)*f(x1)); 
    end
     %if(f(x3)==0)   % condition when x3 is the true root
     %    vp(count) = abs(x3-realroot);
     %    vp = vp(1:count);
     %    break;
     %end
     if(f(x2)*f(x3)<0) % This is a well-behaved situation because midpoint can shorten the interval by a lot
        if(x2 < x3)
            x0 = x2;
            x1 = x3;
        else
            x0 = x3;
            x1 = x2;
        end
     elseif(f(x3)*f(x0) < 0) % Th is a not well-behaved situation because midpoint does not help determine next interval
        if(x0 < x3)  % use x0 for one of the endpoint
            x1 = x3;
        else
            x1 = x0;
            x0 = x3;
        end
     elseif(f(x3)*f(x1) < 0) % Th is a not well-behaved situation because midpoint does not help determine next interval
         if(x1 < x3)    % use x1 for one of the endpoint
            x0 = x1;
            x1 = x3;
        else
            x0 = x3;
        end
     end
     v(count) = x3;
     vp(count) = abs(x3-realroot); % store error in a vector
     %if(abs(x3-realroot)<tol) % terminate if reach given accuracy
     %   vp = vp(1:count);
     %   break;
     %end
     %fprintf('The approximation of root for ridder method is %g at step %g \n',x3,count);
     if(abs(x1-x0)<tol) % terminate if reach given accuracy
        vp = vp(1:count);
        v = v(1:count);
        break;
     end
    count = count+1; % count numbers of iterations 
end
g = v(end); %Approximation of the root
i = count;
%fprintf('Ridder method apply false position method on a exponential function : h(x)=f(x)*e^(%g *x)  \n',c);
%fprintf('     1)The approximation of root uisng Ridder method is %g \n',g);
%fprintf('     2)The number of iteration for Ridder method is %g \n',i);
%fprintf('     3)The vector vp is: [');
%fprintf('%g ', vp);
%fprintf(']\n');

end






