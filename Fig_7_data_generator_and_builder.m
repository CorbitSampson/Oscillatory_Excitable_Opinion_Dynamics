%% preamble
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code generates the data used in Fig.7 of  C.R. Sampson, J.G. Restrepo, and M.A. Porter, 
% Oscillatory and Excitable Dynamics in an Opinion Model with Group Opinions and
% constructs the figure.
%
% Note: the generation of Fig.7 is subject to change run to run due to the
% particular instance of the hyperdegree list, hypergraph, and intial
% conditions.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all
%% initalize simulation parameters
NT = 200; % number of time steps

% hypergraph parameters
n = 2500; % number of nodes;
gamma = 3.8; % gamma
r = 0.15; % correlation coefficient
kmean = 20; % mean degree
k0 = kmean*((gamma-2)/(gamma-1)); % creates minimum degree based on mean degree and gamma

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

%% Creating the hypergrpah and hyperdegree distribution
degreelist = get_hyperdegree(n, k0, gamma, r); % generates hyperdegree list 

[K,Pk] = DPS(degreelist(:,1)); Q = K;% generate list of degrees (K) and corresponding probablity (PK) for the mean-field maps
P1 = diag(Pk); % creates discrete analog of completely correlated hyperdegree
P2 = Pk*Pk'; % creates discrete analog of completely uncorrelated hyperdegree
P = r*P1 + (1-r)*P2; % discrete analog of Eq.(10)

% creates hypergraph
HG = hgraph(degreelist); % generates hypergraph
A  = adj(HG{3},HG{1}); % generates adjacency matrix for dyadic connections
M3 = HEIS(HG{1}, HG{4}); % generates incidence matrix for triadic connections

%% creates initial condition for mean-field map and target fraction of nodes and hyperedges in state one.
seed1 = 0.5; 
seed2 = 0.5;
seed3 = 0.5;
initial = [seed1, seed1, seed3];

%% runs simulation of stochastic opinion model and mean-field maps
[xavg,~,y3avg,~,~] = hypergraph_sim(n,HG,A,M3,fn,fn, a,b,c,d,seed1,seed3, NT); % stochastic opinion model
[xx,~,yy] = Meanfield_Iteration(@(v) Meanfield_Equations(v, {fn, fe},K,Q,P,a,b,c,d),NT,initial); % iterates mean-field maps


%% Creates figure
figure(1)
   subplot(2,1,1);
   hold on
   plot(xavg,  'color', 1/255*[5,113,176], 'linewidth',1.5)
   plot(y3avg, 'color',  1/255*[202,0,32], 'linewidth',1.5)
   l1 = legend({'\hspace{1pt} nodes \hspace{2pt}',' \hspace{1pt} hyperedges'}, 'location', 'southeast', 'interpreter', 'latex', 'orientation', 'horizontal');
   l1.Position(1) = l1.Position(1) - 0.135;
   l1.Position(2) = l1.Position(2) + 0.045;
   l1.Position(3) = l1.Position(3) + 0.15;
   ylabel('$V^t$,\hspace{2pt} $Y^t$', 'interpreter', 'latex')
   xlabel('time','interpreter', 'latex')
   ylim([0,1])
   hold off
   title({'simulation'}, 'interpreter', 'latex')
   set(gca, 'fontsize', 16)

   subplot(2,1,2);
   hold on
   plot(xx, 'color', 1/255*[5,113,176], 'linewidth',1.5)
   plot(yy, 'color', 1/255*[202,0,32], 'linewidth',1.5)
   l2 = legend({'\hspace{1pt} nodes \hspace{2pt}',' \hspace{1pt} hyperedges'}, 'location', 'southeast','interpreter', 'latex',  'orientation', 'horizontal');
   l2.Position(1) = l2.Position(1) - 0.135;
   l2.Position(2) = l2.Position(2) + 0.045;
   l2.Position(3) = l2.Position(3) + 0.15;
   ylabel('$V^t$,\hspace{2pt} $Y^t$','interpreter', 'latex')
   ylim([0,1])
   hold off
   title({'';'mean field'},'interpreter', 'latex')
   xlabel('time','interpreter', 'latex')
   set(gca, 'fontsize', 16)


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