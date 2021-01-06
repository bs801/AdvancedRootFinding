%%%%%%%%%%%%%%%%%%%
%%% Name: Bohan Song
%%% RUID: 180006793
%%%%%%%%%%%%%%%%%%%
function [g,index,vp] = brent(f,x0,x1,realroot)
%% This function is an implementation of Brent's method
% INPUT value:
%          f - function
%          x0 - left end point
%          x1 - right end point
%          realroot - exact value of root / approximation by fzero
% Output value:
%          g - approximation of the root for the interval [x0,x1]
%          index - numbers of iterations
%          vp - vector of errors 
%% Setup halting condition
tol = 1e-10;  %tolarence
maxnum = 15;  %maximum number of iterations
count = 1;    %keep track of iterations
vp = zeros(maxnum);  % error vector
v = zeros(maxnum) ; % approximation of each step
format long;
%% Execute to find the foot and consecutive error vector

if(f(x0) * f(x1)>= 0)  % f(x0) and f(x1) must have different sign
    fprintf('Error: the root is not bracketed. \n');
else
    if (x0 > x1) % Swap x0 and x1
       temp = x0;
       x0 = x1;
       x1 = temp;
    end
    while ( (f(x0) ~= 0 && f(1) ~= 0) && abs(x1-x0) >= tol)
        x2 = (x0+x1)/2; % midpoint of two end points
        if(f(x0)~=f(x2) && f(x1)~=f(x2))
            s = inversequadratic(f,x0,x2,x1);  % when three function values are not equal which most cases are, we run inverse quadratic mathod. 
            if(x0<s && s<x1) % condition when s is in between x0 and x1
                 %fprintf('Brent method uses inverse quadratic interpolation at this step %g and approximation is %g \n',count,s);
                 if(f(s)==0)
                    break;
                 end
            else  %  root is not [x0,x1]
                if(f(x0)*f(x2)<0) % use bisection method every round to determine which interval root falls in
                    s = secant(f,x0,x2);  % execute secant.m on [x0,x2]
                elseif(f(x1)*f(x2)<0)
                    s = secant(f,x2,x1);  % execute secant.m on [x2,x1]
                end 
                %fprintf('Brent method uses Bisection and Secant method at this step %g and approximation of root is %g \n',count,s);
            end 
        else
            if(f(x0)*f(x2)<0) % use bisection method every round to determine which interval root falls in
                s = secant(f,x0,x2);  % execute secant.m on [x0,x2]
            elseif(f(x1)*f(x2)<0)
                s = secant(f,x2,x1);  % execute secant.m on [x2,x1]
            end
            %fprintf('Brent method uses Bisection and Secant method at this step %g and approximation of root is %g \n',count,s);
        end
         v(count) = s;
         vp(count) = abs(s-realroot);  % store error in a vector
        % if(abs(s-realroot)<tol)  % terminate if estimation reaches an given accuracy
        %     vp = vp(1:count);
        %     break;
        % end
        if(x2 > s)  % swap s and x2 because we always want x0 <=x2<=s<= x1
           temp = x2;
           x2 = s;
           s = temp;
        end
        if (f(x2)*f(s) <= 0 )% x2 will be our next left end point and s will be our next right end point
            x0 = x2;
            x1 = s;
        else
            if(f(x0)*f(x2)<=0) % we want to truncate our interval to a smaller interval [x0,x2] 
                x1 = x2;
            else   % we want to truncate our interval to a smaller interval [s,x1]
                x0 = s;
            end
        end
        if(abs(x0-x1)< tol)
            vp = vp(1:count);
            v = v(1:count);
            break;
        end
        count = count + 1;
        if(count>15)
            break;
        end
    end
end
g = v(end);
index = count;


%fprintf('Brent method:  \n');
%fprintf('     1)The approximation of root uisng Brent method is %g \n',g);
%fprintf('     2)The number of iteration for Brent method is %g \n',index);
%fprintf('     3)The vector vp (difference between approximation and real root) is: [');
%fprintf('%g ', vp);
%fprintf(']\n');
end
