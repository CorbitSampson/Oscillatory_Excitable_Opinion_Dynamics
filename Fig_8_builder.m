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

clear; close all
%% 
Mdata = 50;
gammavec_data = linspace(2.5,6,Mdata); % range of gamma values
Qdata = 75;
rvec_data = linspace(0,1,Qdata); % range of correlation coefficient values
[Xdata,Ydata] = meshgrid(rvec_data, gammavec_data); % creates meshgrid

%% Setting parameters for degree distribution
kmean = 20; % mean degree
Z = rand(2500,1); % generate rand samples used to create hyperdegree distribution
h = @(u, gamma, k0) k0*(u).^(1/(1-gamma)); % defines inverse of marginar degree distribution used in inverse sampling

%% Space allocation
M = 150;
gammavec = linspace(2.5,6,M); % range of gamma values

Q = 150;
rvec = linspace(0,1,Q); % range of correlation coefficient values

val1 = zeros(M,Q); % 
val2 = zeros(M,Q); % 
val3 = zeros(M,Q); %

%% defining constant parameters
m = 8; 
mu = 0.25;
fn = @(z) htansig(z, m,mu); % defines sigmoid 
fe = @(z) htansig(z, m,mu); % defines sigmoid 
f = {fn,fe};

% defines parameters a,b,c,d from table 1.
a = 1;
b = -0.5;
c = 0.25;
d = 0.25;

x0 = [1,1,0.5]';
x1 = [0,0,0]';
x2 = [0.2,0.2,0.1]';

% loop over gamma values
for j = 1:M
    gamma = gammavec(j); % current value of gamma
    k0 = ((gamma-2)/(gamma-1))*kmean; % creates minimum degree based on mean degree and gamma

    [K,Pk] = DPS(floor(h(Z,gamma, k0))); % generate list of degrees (K) and corresponding probablity (PK)
    P1 = diag(Pk); % creates discrete analog of completely correlated hyperdegree
    P2 = Pk*Pk'; % creates discrete analog of completely uncorrelated hyperdegree
    
        % loop over correlation coefficient
    for i = 1:Q
        r = rvec(i); % current value of correlation coefficient
        P = (r)*P1 + (1-r)*P2; % discrete analog of Eq.(10)
        
        func = @(v) Meanfield_Equations(v,f,K,K,P,a,b,c,d) - v; % creates function to be solved for equilibria
        
        
        x0 = fsolve(func,x0);
        x1 = fsolve(func,x1);
        x2 = fsolve(func,x2+0.022*rand(3,1));
        disp(x1)
        disp(x2)
        J0 = jacobianest( @(v) Meanfield_Equations(v,f,K,K,P,a,b,c,d),x0);
        J1 = jacobianest( @(v) Meanfield_Equations(v,f,K,K,P,a,b,c,d),x1);
        lambdas0 = eig(J0);
        lambdas1 = eig(J1);
        largest0 = lambdas0(max(abs(lambdas0)) == abs(lambdas0));
        largest1 = lambdas1(max(abs(lambdas1)) == abs(lambdas1));
        val1(j,i) = abs(largest0(1));
        val2(j,i) = imag(largest0(1));
        val3(j,i) = abs(largest1(1));
    end
end

[X,Y] = meshgrid(rvec, gammavec(1:end-1));

map = [1,1,1; 0,0,0; 33/255,197/255,1; 192/255,0,0];

f1 = figure(1);
han = axes(f1,'visible','off'); 

t = tiledlayout(1,1);
t.TileSpacing = 'compact';
t.Padding = 'compact';

t2 = nexttile;
s2 = surf(X,Y,2*double(diff(val1>1))+ 1*double(diff(val3<0.99)~=0) + 0.5*double(diff(val2==0)), 'edgecolor','none');
colormap(t2,map)
set(gca, 'fontsize',12)
set(gca,'YDir','normal')
xlabel('correlation coefficient ($r$)', 'interpreter','latex', 'fontsize', 16)
axhand = s2.Parent;
axhand.YLim = [2.5,6];
view(2)

ylabel(t,'power-law exponent ($\gamma$)','interpreter', 'latex', 'fontsize', 16)



