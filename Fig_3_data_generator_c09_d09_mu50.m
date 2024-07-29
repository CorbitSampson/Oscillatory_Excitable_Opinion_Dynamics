%% preamble
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code generates the data that is plotted in Fig.3 for c=d=0.9 and
% mu=0.5 for the mean-field maps and stochastic opinion model. The data is
% saved as the .txt files named
%
%    ab_param_sweep_MF_c09_d09_mu5.txt
%    ab_param_sweep_SIM_c09_d09_mu5.txt
%    ab_param_sweep_param.txt
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all;
%% initalize simulation parameters
NT = 500; % number of time steps

% hypergraph parameters
n = 2000; % number of nodes;
gamma = 4; % gamma
kmean = 20; % mean degree
k0 = ((gamma-2)/(gamma-1))*kmean; % creates minimum degree based on mean degree and gamma
h = @(u, gamma, k0) k0*(u).^(1/(1-gamma)); % defines inverse of marginar degree distribution used in inverse sampling

% defines parameters a,b,c,d from table 1.
ab_vec = 0:0.05:1; % range of values of a and b
c = 0.9;
d = 0.9;

% sigmoid parameters and functions
m = 4;
mu = 0.50;
fn = @(z) htansig(z, m,mu); % defines sigmoid
fe = @(z) htansig(z, m,mu); % defines sigmoid

%% Creating the hypergrpah and hyperdegree distribution

degreelist(:,1) = floor(h(rand(n,1),gamma, k0)); % generates dyadic degree using inverse sampling
degreelist(:,2) = degreelist(:,1); % sets triadic degree equal to dyadic degree since r = 1

[K,Pk] = DPS(degreelist(:,1)); % generate list of degrees (K) and corresponding probablity (PK) for the mean-field maps

% creating hypergraph
HG = hgraph(degreelist); % generates hypergraph
A  = adj(HG{3},HG{1}); % generates adjacency matrix for dyadic connections
M3 = HEIS(HG{1}, HG{4}); % generates incidence matrix for triadic connections

%% Space allocation

diff_meanfield = zeros(length(ab_vec),1); % allocating space for data for mean field
diff_sim = diff_meanfield; % allocating space for data for stochastic opinion model

L = 4; % L^2 is number of independent simulations per point
seedvec = linspace(0,1,L);

% begin loop for parameters a and b.
for i = 1:length(diff_meanfield)
    
    a = ab_vec(i); % current value of a
    b = a; % current value of b

    yY = @(v,a,b,c,d) YYMF(fe,v,a,b,c,d); % creates inline equation of G(V) in Eqs. (26)
    vV = @(v,a,b,c,d) VVMF(fn, fe, @YYMF ,Pk,K,v,a,b,c,d); % creates inline solvable version of Eq.(24)

    % begin loop over independent simulations
    xeq_sim = zeros(1,L^2); % allocate space for each independent simulation
    yeq_sim = zeros(1,L^2); % allocate space for each independent simulation
    counter = 1;
    for j = 1:L
        for q = 1:L
            seed1 = seedvec(j); % draw target fraction of nodes in state 1
            seed2 = seedvec(q); % draw target fraction of triangles in state 1
            [xavg,~,y3avg,~,~] = hypergraph_sim(n,HG,A,M3,fn,fn, a,b,c,d,seed1,seed2, NT);

            xeq_sim(counter) = mean(xavg(400:end)); % store average value of the last 100 time steps
            yeq_sim(counter) = mean(y3avg(400:end)); % store average value of the last 100 time steps
            counter = counter + 1;
        end
    end
    % end loop over independent simulations
    tempX = mean(xeq_sim); % compute average over L independent simulations
    tempY = mean(yeq_sim); % compute average over L independent simulations
    diff_sim(i) = abs(tempX-tempY); % compute discordance using Eq.(27) for stochastic opinion model


    xeq_meanfield = fzero(@(v) vV(v,a,b,c,d)- v, 1); % find fixed point by solving Eq.(24) using root finder for mean field 
    yeq_meanfield = yY(xeq_meanfield,a,b,c,d); % find corresponding Y value using G(V) from Eqs.(26)

    diff_meanfield(i) = abs(xeq_meanfield-yeq_meanfield); % compute discordance using Eq.(27) for mean-field maps
end
% end loop over ranage of a and b values.


%% Save data
writematrix(ab_vec, 'ab_param_sweep_param.txt')
writematrix(diff_meanfield, 'ab_param_sweep_MF_c09_d09_mu5.txt')
writematrix(diff_sim, 'ab_param_sweep_SIM_c09_d09_mu5.txt')


%% Additional functions
% implementation of G(V) from Eqs.(26) 
function output = YYMF(f,v,a,b,c,d)
    output = f(c*v)./(1 + f(c*v) - f(c*v + d));
end

% implementation of F(V) from Eqs.(26)
function output = VVMF(fn, fe, YYMF ,P,K,v,a,b,c,d)
    km = sum(K.*P); 
    xx = zeros(length(K),length(v));
    for j = 1:length(K)
        xx(j,:) = fn( (K(j)/km)*(a*v + b*YYMF(fe,v,a,b,c,d))); 
    end  
    output = sum(K.*P.*xx)/km;
end