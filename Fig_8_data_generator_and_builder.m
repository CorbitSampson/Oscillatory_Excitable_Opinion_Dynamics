%% preamble
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code generates the data used in Fig.8 of  C.R. Sampson, J.G. Restrepo, and M.A. Porter, 
% Oscillatory and Excitable Dynamics in an Opinion Model with Group Opinions and
% constructs the figure.
%
% Note: the generation of Fig.8 is subject to change run to run due to the
% particular instance of the hyperdegree list, hypergraph, and intial
% conditions.
%
% dependence: This script uses the jacobianest() from ... by .. avaliable
% on ... .
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all;
%% initialize simulation parameters
NT = 200; % number of time steps
rvec = [1,0.5,0.1]; % list of values used for the correlation coefficient

% hyperdegree distribution parameters
kmean = 20; % mean degree
gamma = 4; % gamma
k0 = kmean*((gamma-2)/(gamma-1)); % minimum degree
z = rand(15000,1); % generate rand samples used to create hyperdegree distribution
h = @(u, gamma, k0) k0*(u).^(1/(1-gamma)); % inverse of the CDF for inverse sampling

% defines parameters a,b,c,d from table 1.
a = 1;
b = -0.5;
c = 0.25;
d = 0.25;

% sigmoid parameters and functions
m = 8;
mu = 0.25;
fn = @(z) htansig(z, m,mu); % defines sigmoid
fe = @(z) htansig(z, m,mu); % defines sigmoid
f = {fn,fe};

%% generate hyperdegree distribution
[K,Pk] = DPS(floor(h(z,gamma, k0))); Q = K; % generate list of degrees (K) and corresponding probablity (PK)
P1 = diag(Pk); % creates discrete analog of completely correlated hyperdegree
P2 = Pk*Pk'; % creates discrete analog of completely uncorrelated hyperdegree


%% main

% begins figure construction
figure(1)
tiledlayout(2,2)
titlebox = {'(a)','(b)','(c)'};

for aa = 1:3
    r = rvec(aa); % current value of correlation coefficient
    P = (r)*P1 + (1-r)*P2; % discrete analog of Eq.(10)

    func = @(v) Meanfield_Equations(v,f,K,Q,P,a,b,c,d) - v; % creates function to be solved for equilibria

    % initial guesses for equilibria
    v0 = [1,1,0.5]'; 
    v1 = [0,0,0]';
    v2 = [0.2,0.2,0.1]';

    % estimates of equilibria
    x0 = fsolve(func,v0);
    x1 = fsolve(func,v1);
    x2 = fsolve(func,v2);

    % creates the jacobian matrix at each equilibria
    J0 = jacobianest( @(v) Meanfield_Equations(v,f,K,Q,P,a,b,c,d),x0);
    J1 = jacobianest( @(v) Meanfield_Equations(v,f,K,Q,P,a,b,c,d),x1);
    J2 = jacobianest( @(v) Meanfield_Equations(v,f,K,Q,P,a,b,c,d),x2);

    % stores eigenvalues of each jacobian
    lambda0 = eig(J0);
    lambda1 = eig(J1);
    lambda2 = eig(J2);
    
    % display eigenvalues and norm
    disp('first equilibrium')
    disp(lambda0')
    disp(norm(lambda0))

    disp('second equilibrium')
    disp(lambda1')
    disp(norm(lambda1))
    
    disp('third equilibrium')
    disp(lambda2')
    disp(norm(lambda2))
    
    % set marker type and color for each equilibria
    % unstable spiral
    marktype0 = "hexagram";
    fillcolor0 = 'none';
    
    % stable node
    marktype1 = 'o';
    fillcolor1 = 'b';
    
    % saddle (unstable)
    marktype2 = 'o';
    fillcolor2 = 'none';

    % iterate mean-field maps to produce orbit
    old = x1;
    V(1) = old(1);
    U(1) = old(2);
    Y(1) = old(3);
    for T = 1:200
        new = Meanfield_Equations(old,f,K,Q,P,a,b,c,d);
        old = new;
        temp = purt(T);
        old(1) = old(1) + temp;
        old(2) = old(2) + temp;
        V(T+1) = old(1);
        U(T+1) = old(2);
        Y(T+1) = old(3);
    end

    % create figure
    ax = nexttile;
    hold on
    p1 = plot3(V,U,Y, 'color', 'k', 'marker', '.', 'linestyle', 'none', 'markersize', 5.8);
    view([1,1,1])
    set(gca, 'fontsize', 12)
    xlabel('$V^t$', 'interpreter', 'latex')
    ylabel('$U^t$', 'interpreter', 'latex')
    zlabel('$Y^t$', 'interpreter', 'latex')
    titlestring = sprintf('%2.1f', r);
    title(['$r= $ ', titlestring], 'interpreter', 'latex')
    ylim([-0.1,1])
    xlim([-0.1,1])
    zlim([-0.1,1])
    p2 = plot3(x0(1),x0(2),x0(3), 'marker', marktype0, 'markerfacecolor', fillcolor0, 'markeredgecolor', 'r', 'linestyle', 'none');
    if aa ~= 3
        p3 = plot3(x1(1),x1(2),x1(3), 'marker', marktype1, 'markerfacecolor', fillcolor1, 'markeredgecolor', 'b', 'linestyle', 'none');
    end
    p4 = plot3(x2(1),x2(2),x2(3), 'marker', marktype2, 'markerfacecolor', fillcolor2, 'markeredgecolor', 'g', 'linestyle', 'none');
    text(0.45,0.25,1.2,titlebox{aa},'fontsize',16)
    view(45,20)

end
axn = nexttile;

area([NaN,NaN], NaN(2,4));
leg = legend(axn,[p1,p3,p4,p2],{'\hspace{1pt} orbit \hspace{2pt}','\hspace{1pt} stable fixed-point \hspace{2pt}','\hspace{1pt} saddle point \hspace{2pt}','\hspace{1pt} unstable spiral \hspace{2pt}'});
leg.Interpreter = 'latex';
leg.FontSize = 16;

axn.Visible = false;

%% additional function

% this function creates a perturbation of 0.25 at a fix input of 70 and is
% used to pertrb the order parameters V and U in the mean-field maps.
function out = purt(in)
    q = rand;
    if q < 0.75
        if in == 70
            out = 0.25;
        else
            out = 0;
        end
    else
        out = 0;
    end   
end


