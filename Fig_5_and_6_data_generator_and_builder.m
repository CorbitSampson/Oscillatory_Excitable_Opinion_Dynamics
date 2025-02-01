%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright 2022 - 2025 Corbit R. Sampson
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file is part of the Oscillatory_Excitable_Opinion_Dynamics repository.
%
% Competing_Social_Contagions repository is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
% as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
%
% Competing_Social_Contagions repository is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
% See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along with Oscillatory_Excitable_Opinion_Dynamics. If not, see <https://www.gnu.org/licenses/>. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% preamble
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code generates the data used in Figs.5 and 6 of  C.R. Sampson, J.G. Restrepo, and M.A. Porter, 
% Oscillatory and Excitable Dynamics in an Opinion Model with Group Opinions and
% constructs the figure.
%
% Note: the generation of Fig.5 and 6 is subject to change run to run due to the
% particular instance of the hyperdegree list, hypergraph, and intial
% conditions.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all
%% initalize simulation parameters
NT = 400; % number of time steps


% hypergraph parameters
n = 1000; % number of nodes;
gamma = 4; % gamma
r = 1; % correlation coefficient
kmean = 20; % mean degree
k0 = ((gamma-2)/(gamma-1))*kmean; % creates minimum degree based on mean degree and gamma
h = @(u, gamma, k0) k0*(u).^(1/(1-gamma)); % defines inverse of marginar degree distribution used in inverse sampling


% defines parameters a,b,c,d from table 1.
a = 1;
b = -0.5;
c = 0.25;
d = 0.25;

% sigmoid parameters and functions
m = 8;
mu = 0.25;
fn = @(z) htansig(z, m,mu);
fe = @(z) htansig(z, m,mu);

%% Creating the hypergrpah and hyperdegree distribution
degreelist(:,1) = floor(h(rand(n,1),gamma, k0)); % generates dyadic degree using inverse sampling
degreelist(:,2) = degreelist(:,1); % sets triadic degree equal to dyadic degree since r = 1

[K,Pk] = DPS(degreelist(:,1)); Q = K; % generate list of degrees (K) and corresponding probablity (PK) for the mean-field maps
P1 = diag(Pk); % creates discrete analog of completely correlated hyperdegree
P2 = Pk*Pk'; % creates discrete analog of completely uncorrelated hyperdegree
P = r*P1 + (1-r)*P2; % discrete analog of Eq.(10)

% creates hypergraph
HG = hgraph(degreelist); % generates hypergraph
A  = adj(HG{3},HG{1}); % generates adjacency matrix for dyadic connections
M3 = HEIS(HG{1}, HG{4}); % generates incidence matrix for triadic connections

%% creates initial condition for mean-field map and target fraction of nodes and hyperedges in state one.
seed1 = rand;
seed2 = rand;
seed3 = rand;
initial = [seed1,seed1, seed3];

%% runs simulation of stochastic opinion model and mean-field maps
[xavg,~,y3avg,~,~]  = hypergraph_sim(n,HG,A,M3,fn,fn, a,b,c,d,seed1,seed3, NT); % stochastic opinion model
[xx,~,yy]           = Meanfield_Iteration(@(v) Meanfield_Equations(v, {fn, fe},K,Q,P,a,b,c,d),NT,initial, false); % iterates mean-field maps without pulse to show steady-state solution
[xx_kick,~,yy_kick] = Meanfield_Iteration(@(v) Meanfield_Equations(v, {fn, fe},K,Q,P,a,b,c,d),NT,initial, true); % iterates mean-field maps with pulse at t = 200 for Fig.6


%% Creates figures
figure(1)

hold on
plot(xavg, 'color', 1/255*[228,26,28], 'linewidth', 1.5)
plot(y3avg, 'color', 1/255*[55,126,184], 'linewidth', 1.5)
plot(xx, 'color', 1/255*[228,26,28], 'linewidth', 1.5, 'linestyle', '--')
plot(yy, 'color', 1/255*[55,126,184], 'linewidth', 1.5, 'linestyle', '--')
l1 = legend({'\hspace{1pt} nodes \hspace{2pt}','\hspace{1pt} hyperedges \hspace{2pt}'}, 'interpreter', 'latex');
l1.Position(1) = l1.Position(1)-0.1;
l1.Position(3) = l1.Position(3)+0.1;
set(gca, 'fontsize', 16)
xlabel('time', 'interpreter', 'latex')
ylabel('$V^t,\hspace{1pt} Y^t$',  'interpreter', 'latex')
axis([0, NT, 0, 1])

figure(2)

subplot(2,1,1)
plot(xavg,  'color', 1/255*[228,26,28], 'linewidth', 1.5, 'linestyle', '-')
axis([0, NT, 0, 1.1])
ylabel('$V^t$',  'interpreter', 'latex')
set(gca, 'fontsize', 14)
l2 = legend('\hspace{1pt} simulation (nodes) \hspace{2pt}', 'interpreter', 'latex');
l2.Position(1) = l2.Position(1)-0.05;
l2.Position(3) = l2.Position(3)+0.05;

subplot(2,1,2)
hold on
plot([xx_kick(1:199);xx_kick(199)], 'color', 1/255*[228,26,28], 'linewidth', 1.5, 'linestyle', '--')
plot(200:length(xx_kick),xx_kick(200:end), 'color', 1/255*[228,26,28], 'linewidth', 1.5, 'linestyle', '--')
arrow1 = annotation('arrow', 'linewidth', 1.5);
arrow1.Parent = gca;
arrow1.Position = [200,0.7,0,-0.38];
axis([190, 225, 0, 1.1])
ylabel('$V^t$', 'interpreter', 'latex')
xlabel('time', 'interpreter', 'latex')
set(gca, 'fontsize', 14)
l3 = legend('\hspace{1pt} mean field (nodes) \hspace{2pt}', 'interpreter', 'latex');
l3.Position(1) = l3.Position(1)-0.05;
l3.Position(3) = l3.Position(3)+0.05;

%% additional functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A local version of the Meanfield_Iteration()function which can include a
% single pulse perturbation to the mean-field maps at time t = 200 for
% Fig.6
function [V,U,Y] = Meanfield_Iteration(MFM,T,initial, kick)
    V = zeros(T,1); V(1) = initial(1);
    U = zeros(T,1); U(1) = initial(2);
    Y = zeros(T,1); Y(1) = initial(3);
    old = initial;
    for t = 2:T
        new = MFM(old);
        if kick == true
            if t == 200
                new(1) = new(1) + 0.2;
                new(2) = new(2) + 0.2;
            end
        end
        V(t) = new(1);
        U(t) = new(2);
        Y(t) = new(3);
        old = new;
    end
end