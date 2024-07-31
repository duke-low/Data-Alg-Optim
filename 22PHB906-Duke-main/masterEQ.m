sz = [[1 0]; [0 -1]];
omega = 2;
H = omega/2 * sz;
gamma = 0.2;
L(:,:,1) = sz;
rho0 = ones(2)/2;
t = 0:0.1:15;

rho = masterEQ(rho0,H,L,gamma,t);

% plot
WRe = real(squeeze(rho(1,2,:)));
WIm = imag(squeeze(rho(1,2,:)));
plot(t,WRe,'LineWidth',2)
hold on
ylim([-0.5 0.5])
plot(t,WIm,'LineWidth',2)
xlabel('$t$','Interpreter','latex');
ylabel('$\rho_{+-}(t)$','Interpreter','latex');
lgd = legend('$\mathcal{R}[\rho_{+-}(t)]$','$\mathcal{I}[\rho_{+-}(t)]$','Interpreter','latex' ,'NumColumns',1);
lgd.FontSize=20;
lgd.Location='northeast';
tcks = gca;
tcks.TickLabelInterpreter = 'latex';
tcks.FontSize=15;
ti.FontSize=15;
box on
grid on

% function
function rho = masterEQ(rho0,H,L,gamma,t)
    dim = length(L(:,1,1));
    N = length(gamma);
    T = zeros(dim^2);
    for i = 1:dim^2
        F_i = zeros(dim);
        F_i(i) = 1;
        for j = 1:dim^2
            F_j = zeros(dim);
            F_j(j) = 1;
            dissipator = zeros(dim);
            for k = 1:N
                dissipator = dissipator + gamma(k) * (L(:,:,k) * F_j * L(:,:,k)' - 1/2 * (L(:,:,k)' * L(:,:,k) * F_j + F_j * L(:,:,k)' * L(:,:,k)));
            end
            unitary = -1.i * (H * F_j - F_j * H);
            
            T(i,j) = trace(F_i' * (dissipator + unitary));
        end
    end
    dMat = reshape(rho0,[ ],1);
    t_span = t;
    sol = ode45(@(t,p) ME(p,T),t_span,dMat);
    rho = reshape(deval(sol,t),dim,dim,[ ]);
    
    function dp = ME(p,L)
        dp = L * p;
    end
end
