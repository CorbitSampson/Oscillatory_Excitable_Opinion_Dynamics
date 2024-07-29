%% preamble
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code generates the data that is plotted in Fig. 2 of C.R. Sampson, J.G. Restrepo, and M.A. Porter, 
% Oscillatory and Excitable Dynamics in an Opinion Model with Group Opinions
% and labelled as simulation. The data is saved as the .txt files named
%
%     SIM_V_figure_2_mF0L10S25.txt
%     SIM_Y_figure_2_mF0L10S25.txt
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all;
%% initalize simulation parameters
NT = 400;

% hypergraph parameters
n = 700; % number of nodes
kmean = 20; % mean degree
gamma = 4; % gamma 
% r = 1 (not used directly)
k0 = kmean*((gamma-2)/(gamma-1)); % creates minimum degree based on mean degree and gamma
h = @(u, gamma, k0) k0*(u).^(1/(1-gamma)); % defines inverse of marginar degree distribution used in inverse sampling

% defines parameters a,b,c,d from table 1.
a = 0.5;
b = 0.5;
c = 0.5;
d = 0.5; 
 
% sigmoid parameters and functions
mu = 0.5;
mvec = 0:0.25:10; % parameter range for m

%% Creating the hypergrpah and hyperdegree distribution
degreelist(:,1) = floor(h(rand(n,1),gamma, k0)); % generates dyadic degree using inverse sampling
degreelist(:,2) = degreelist(:,1); % sets triadic degree equal to dyadic degree since r = 1

% creates hypergraph
HG = hgraph(degreelist); % generates hypergraph
A  = adj(HG{3},HG{1}); % generates adjacency matrix for dyadic connections
M3 = HEIS(HG{1}, HG{4}); % generates incidence matrix for triadic connections

%% Space allocation
L = 10; % L^2 is the number of independent simulations
seedvec = linspace(0,1,L); % range of target fraction for opinion initialization.
SimV = zeros(L^2,length(mvec)); % allocating space to store the steady-state V^* for each simulation
SimY = SimV; % allocating space to store the steady-state Y^* for each simulation

% begin loop of m values
for i = 1:length(mvec) 
    m = mvec(i); % current value of m
    fn = @(z) htansig(z,m,mu); % defines sigmoid
    fe = @(z) htansig(z,m,mu); % defines sigmoid
    
    % begin loop over independent simulations
    counter = 1;
    for j = 1:L
        for q = 1:L
            seed1 = seedvec(j); % target fraction of nodes in state 1
            seed2 = seedvec(q); % target fraction of triangles in state 1

            [vavg,~,y3avg,~,~] = hypergraph_sim(n,HG,A,M3,fn,fn, a,b,c,d,seed1,seed2, NT); % run stochastic opinion model

            SimV(counter,i) = vavg(end); % store steady state V^* for current simulation 
            SimY(counter,i) = y3avg(end); % store steady state Y^* for current simulation 
            counter = counter + 1;
        end
    end
    % end loop over independent simulations
end
% end loop of m values

%% create filename and save data
var1 = 'm';
step = '25';

filename3 = ['SIM_V_figure_2_',var1,'F',num2str(mvec(1)),'L',num2str(mvec(end)),'S',step,'.txt'];
filename4 = ['SIM_Y_figure_2_',var1,'F',num2str(mvec(1)),'L',num2str(mvec(end)),'S',step,'.txt'];
                         
writematrix(SimV , filename3)
writematrix(SimY , filename4)