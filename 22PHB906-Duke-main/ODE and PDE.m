tic
   
global c
c(1) = 0.18; % delta, damping
c(2) = 1; % alpha, stiffness
c(3) = -1; % beta, non linearity factor
c(4) = 0.5; % gamma, amplitude
c(5) = 1.5; % omega, angular frequency

m = 1.0;
nT = 500; 
nP = 25000;
nS = 1;
w_ext = c(5);
T_ext = 2*pi/w_ext; 
tMin = 0;
tMax = T_ext;
t = linspace(tMin,tMax,nT);
h = t(2) - t(1);
x = zeros(nT,1);
v = zeros(nT,1);
x(1) = -1;
v(1) = 1;


figure(1) % plot
   pos = [0.02 0.05 0.42 0.42];
   xlim([-2 2])
   set(gcf,'Units','normalized');
   set(gcf,'Position',pos);
   set(gcf,'color','w');
   title('Poincare Section','fontweight','normal');
   xlabel('$x(m)$','interpreter','latex');
   ylabel('$v(ms^{-1})$','interpreter','latex');
   hold on
   box on
   set(gca,'fontsize',14)
   grid on

for cP = 1:nP 
   for cc = 1 : nT-1
       [k1, k2, k3, k4] = coeff(t(cc),h,x(cc),v(cc));
       x(cc+1) = x(cc) + h*(v(cc) + (k1 + k2 +k3)/6);  
       v(cc+1) = v(cc) + (k1 + 2*k2 + 2*k3 + k4)/6;
   end
   xP = x(cc);  yP = v(cc);
   if cP > nS
       plot(xP,yP,'b.')
       xlim([-2 2])
       ylim([-1.5 1.5])
   end
   t = linspace(tMin,tMax,nT) + cP*T_ext;
   x(1) = x(cc);
   v(1) = v(cc);
end
    
toc

% functions
function [k1,k2,k3,k4] = coeff(t,h,x,v)
  k1 = h * fn(t, x, v);
  k2 = h * fn(t + h/2, x + h * v/2, v + k1/2);
  k3 = h * fn(t + h/2, x + h * v/2 + h * k1/4 ,v + k2/2);
  k4 = h * fn(t + h, x + h * v + h * k2/2, v + k3);  
end

function  y = fn(t,x,v)
   global c
   y = -c(1) * v + c(2) * x + c(3) * x^3 + c(4) * cos(c(5) * t);
end
