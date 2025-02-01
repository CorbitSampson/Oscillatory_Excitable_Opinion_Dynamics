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
% This code generates the data that is plotted in the 1st panel of Fig.9 of
%  C.R. Sampson, J.G. Restrepo, and M.A. Porter, 
% Oscillatory and Excitable Dynamics in an Opinion Model with Group Opinions.
% The data is saved to a .txt file named
%
% figure_9_sim_H.txt.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all
%% Setting constant paramters for hypergraph generation
n = 2500; % number of nodes;
kmean = 20; % mean degree

%% Space allocation
M = 50;
gammavec = linspace(2.5,6,M); % range of gamma values

Q = 75;
rvec = linspace(0,1,Q); % range of correlation coefficient values

amp = zeros(M,Q); % storeage for H in Eq. (28)

NT = 400; % number of time steps
L = 5; % L^2 is number of independent simulations per point
seedvec = linspace(0,1,L);

%% defining constant parameters
m = 8;
mu = 0.25;
fn = @(z) htansig(z, m, mu); % defines sigmoid 
fe = @(z) htansig(z, m, mu); % defines sigmoid 

% defines parameters a,b,c,d from table 1.
a = 1;
b = -0.5;
c = 0.25;
d = 0.25;

%% begin main loops

% loop over gamma values
for j = 1:M
    gamma = gammavec(j); % current value of gamma
    k0 = kmean*((gamma-2)/(gamma-1)); % creates minimum degree based on mean degree and gamma
    
    % loop over correlation coefficient
    for i = 1:Q
        r = rvec(i); % current value of correlation coefficient
    
        % generates hypergraph structure and components
        hyperdegreelist = get_hyperdegree(n, k0, gamma, r); % generates hyperdegree list for current parameters
        HG = hgraph(hyperdegreelist); % generates hypergraph
        A  = adj(HG{3},HG{1}); % generates adjacency matrix for dyadic connections
        M3 = HEIS(HG{1}, HG{4}); % generates incidence matrix for triadic connections
        
        tempamp = zeros(L^2,1); % allocates space for next set of simulations
        
        % loop over independent simulations
        counter = 1;
        for k1 = 1:L
            for k2 = 1:L
                seed1 = seedvec(k1); % draw target fraction of nodes in state 1 from seedvec
                seed2 = seedvec(k2); % draw target fraction of hyperedges in state 1 from seedvec
                [xavg,~,y3avg,~,~] = hypergraph_sim(n,HG,A,M3,fn,fn, a,b,c,d,seed1,seed2, NT); % runs simulation
                tempamp(counter) = max(xavg(100:end)) - min(xavg(100:end)); % computes H from Eq.(28) for current simulation
                counter = counter + 1;
            end
        end
        % end loop over independent simulations
        
    amp(j,i) = mean(tempamp); % averages H from Eq.(28) over the independent simulations
    end
    % end loop over correlation coefficient
end
% end loop over gamma values

writematrix(amp, 'figure_10_sim_H.txt') % saves output as .txt file

% displays results as basic plot
figure()
[X,Y] = meshgrid(rvec, gammavec);
surf(X,Y,amp, 'edgecolor','none')
view(2)
xlabel('mixing')
ylabel('gamma')
cbar = colorbar();
cbar.Label.String = 'wave height';

%% Addition functions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A function which generates the hyperdegree of each node via bivariate
% inverse sampling given the number of nodes (N), minimum degree (kmin),
% gamma, and the correlation coefficient (r)
function degreesamples = get_hyperdegree(N, kmin, gamma, r)

    f1 = @(u) kmin*u.^(1/(1-gamma)); % inverse of marginal CDF 
    ksamples = floor(f1(rand(N,1))); % dyadic degrees from inverse sampling
    qsamples = zeros(N,1); % allocating space for triadic degrees
    x = linspace(kmin, 200, 300);

    for i = 1:N
        if r ~= 1 % condition that dyadic and triadic degrees are not completely correlated
            marginal = Fqgk(x,ksamples(i),r,gamma, kmin); % returns marginary CDF given dyadic degrees
            p = rand*marginal(end);
            [~,I] = unique(marginal);
            qsamples(i) = floor(interp1(marginal(I),x(I),p)); % inverse sampling of triadic degree
            while isnan(qsamples(i)) % ensures that all Nan values are replaced with numeric values
               p = rand*marginal(end);
               qsamples(i) = floor(interp1(marginal(I),x(I),p));
            end
        else % returns equal dyadic and triadic degrees if completely correlated (r = 1)
            qsamples(i) = ksamples(i);
        end
    end
    degreesamples = [ksamples,qsamples];
end


% The condition marginal cumulative distribution function for triadic
% degrees given the dyadic degrees
function out = Fqgk(q,k,alpha,gamma,kmin)
    out = zeros(length(q),1);
    for ii = 1:length(q)
        if q(ii)>= kmin
            out(ii) = (1-(q(ii)/kmin).^(1-gamma))*(1-alpha) + alpha*selection(q(ii),k);
        else
            out(ii) = 0;
        end   
    end
    
    % sub-function, step(q-k)
    function out2 = selection(q,k)
        if q >= k
            out2 = 1;
        else
            out2 = 0;
        end
    end
end
