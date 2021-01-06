%%%%%%%%%%%%%%%%%%%
%%% Name: Bohan Song
%%% RUID: 180006793
%%%%%%%%%%%%%%%%%%%
%% This file will execute brent.m and ridder.m to show approximation of root, eroor plot and estimation of order of convergence in three examples
%% Example 1
f = @(x) sin(1/x); % Function
x0 = 0.2; % left end point
x1 = 0.4; % right end point
approx2 = fzero(f,x1);  % approximate zero using fzero
[p1,i1,vp1] = brent(f,x0,x1,approx2); % approximate zero using Brent's method
[p2,i2,vp2] = ridder(f,x0,x1,approx2); % approximate zero using Ridder's method

z=1;
p=1;
while z<size(vp1) % make sure there is no zero in error vector vp1
      if (vp1(z)==0)
           vp1 = vp1(1:z);
           break;
      end
      z = z+1;
end
while p<size(vp2) % make sure there is no zero in error vector in vp2
      if (vp2(p)==0)
           vp2 = vp2(1:p-1);
           break;
      end
      p=p+1;
end
%fprintf('vp1 is: [');
%fprintf('%g ', vp1);
%fprintf(']\n');
%fprintf('vp2 is: [');
%fprintf('%g ', vp2);
%fprintf(']\n');
s1 = log(vp1(3:end)./vp1(2:end-1))./log(vp1(2:end-1)./vp1(1:end-2)); %Estimation of order of Brent's method
s2 = log(vp2(3:end)./vp2(2:end-1))./log(vp2(2:end-1)./vp2(1:end-2)); %Estimation of order of Ridder's method
fprintf('Example 1 f(x) = sin(1/x): \n')
fprintf('  a. Brent Method: \n')
fprintf('      The approximation of root using Brent method after %g iterations is %g. \n',i1,p1);
fprintf('      The approximate order of convergence of Brent method is %g. \n',s1(end-2));
%fprintf('The s1 vector for Brent method is: [');
%fprintf('%g ', s1);
%fprintf(']\n');
fprintf('  b. Ridder Method: \n')
fprintf('      The approximation of root using Ridder method after %g iterations is %g. \n',i2,p2);
fprintf('      The approximattion of order of convergence of Ridder method is %g. \n',s2(end-1));
%fprintf('The estimated order of convergence for Ridder method is: [');
%fprintf('%g ', s2);
%fprintf(']\n');
fprintf('  c. Matlab fzero: \n');
fprintf('      The approximation of root using Matlab buitin functionis %g. \n',approx2);

x1 = linspace(eps,vp1(1));
y1 = 5*vp1(1).*x1;
x2 = linspace(eps,vp2(1));
y2 = 10*vp2(1)*x2.^2;
f1 = figure;
loglog(vp1(1:end-1),vp1(2:end),'*-',vp2(1:end-1),vp2(2:end),'*-',x1,y1,'--',x2,y2,'--','LineWidth',2);
xlabel('$e_n$','Interpreter','latex','FontSize',14)
ylabel('$e_{n+1}$','Interpreter','latex','FontSize',14)
title('Example 1 Error Plots')
legend('Brent Method','Ridder method','order 1','order 2','Location','northwest')
axis([0,0.069255971877225,0,0.016666641284991]);
grid on
grid minor
%% Example 2
f = @(x) 1/(sin(x)) -x; % Function
x0 = 1/2; % Left end point
x1 = 2;   % Right end point
approx2 = fzero(f,x1); % approximate zero using fzero
[p1,i1,vp1] = brent(f,x0,x1,approx2);  % approximate zero using Brent's method
[p2,i2,vp2] = ridder(f,x0,x1,approx2); % approximate zero using Ridder's method

z=1;
p=1;
while z<size(vp1) % make sure there is no zero in error vector vp1
      if (vp1(z)==0)
          vp1 = vp1(1:z-1);
           break;
      end
      z = z+1;
end
while p<size(vp2) % make sure there is no zero in error vector in vp2
      if (vp2(p)==0)
          vp2 = vp2(1:p-1);
           break;
      end
      p=p+1;
end
%fprintf('vp1 is: [');
%fprintf('%g ', vp1);
%fprintf(']\n');
%fprintf('vp2 is: [');
%fprintf('%g ', vp2);
%fprintf(']\n');

s1 = log(vp1(3:end)./vp1(2:end-1))./log(vp1(2:end-1)./vp1(1:end-2)); %Estimation of order of Brent's method
s2 = log(vp2(3:end)./vp2(2:end-1))./log(vp2(2:end-1)./vp2(1:end-2)); %Estimation of order of Ridder's method
fprintf('Example 2 f(x) = 1/sinx - x: \n')
fprintf('  a. Brent Method: \n')
fprintf('      The approximation of root using Brent method after %g iterations is %g. \n',i1,p1);
fprintf('      The approximation of order of convergence of Brent method is %g. \n',s1(end-1));
%fprintf('The vector s1 for Brent method is: [');
%fprintf('%g ', s1);
%fprintf(']\n');
fprintf('  b. Ridder Method: \n')
fprintf('      The approximation of root using Ridder method after %g iterations is %g. \n',i2,p2);
fprintf('      The approximation order of convergence of Ridder method is %g. \n',s2(2));
%fprintf('The vector s2 for Ridder's method is: [');
%fprintf('%g ', s2);
%fprintf(']\n');
fprintf('  c. Matlab fzero: \n');
fprintf('      The approximation of root using Matlab buitin functionis %g. \n',approx2);

x1 = linspace(eps,vp1(1));
y1 = 5*vp1(1).*x1;
x2 = linspace(eps,vp2(1));
y2 = 10*vp2(1)*x2.^2;
f2 = figure;
loglog(vp1(1:end-1),vp1(2:end),'*-',vp2(1:end-1),vp2(2:end),'*-',x1,y1,'--',x2,y2,'--','LineWidth',2);
xlabel('$e_n$','Interpreter','latex','FontSize',14)
ylabel('$e_{n+1}$','Interpreter','latex','FontSize',14)
title('Example 2 Error Plots')
legend('Brent Method','Ridder method','order 1','order 2','Location','northwest')
axis([7.0702e-11,0.048250050507692,2.530902989964061e-26,83728.95957253505]);
grid on
grid minor

%% Plot both figures from Exampl 1 and Example 2

figure(f1); % Figure of example 1
figure(f2); % Figure of example 2


