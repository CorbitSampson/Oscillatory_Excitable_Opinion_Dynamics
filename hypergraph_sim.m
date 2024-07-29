%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% A function that runs a simulation of the stochastic opinion model from
% eqs.(1) and (2) till the bailtime is reached.
%
% inputs: n (number of nodes), HG (the hypergraph structure created via the 
%         HGCFM3 function), A (the adjacency of the dyadic connections),   
%         M3 (the incidence matrix of the triadic connections), fn (sigmoid
%         function for node opinion changes), fe (sigmoid function for the
%         hyperedge opinion changes), weight1 (parameter a from table 1),
%         weight2 (parameter b from table 1), weight3 (parameter c from
%         table 1), weight4 (parameter d from table 1), seed1 (target
%         fraction of nodes with opinion 1 at time zero), seed2 (target
%         fraction of hyperedges with opinion 1 at time zero), bailtime
%         (the number of timesteps the simulation runs)
%         
% outputs: Vavg (the order parameter V at each time step), etanodes (array
%           of node opinons at each time step), y3avg (the order parameter Y at each
%           time step), eta3edges (array of hyperedge opinons at each time step), T
%           (last time step)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Vavg, etanodes, y3avg, eta3edges ,T] = hypergraph_sim(n,HG,A,M3,fn,fe, weight1, weight2, weight3, weight4, seed1, seed2, bailtime)
%% parameters
    % interaction parameters
    a = weight1;
    b = weight2;
    c = weight3;
    d = weight4;
    
    % construct hypergraph and sim related quantities
    N3 = size(HG{4},1);
    Nagents = N3 + n;
    initialsize = 50;
    E2List = HG{3};
    E3List = HG{4};

    % initialize storage and seed initial conditions
    etanodes = zeros(initialsize,n);
    eta3edges = zeros(initialsize,N3);
    Vavg = zeros(1,initialsize);
    y3avg = zeros(1,initialsize);

    % set initial conditions
    etanodes(1,:)  = seed(etanodes(1,:) , 'All', seed1); Vavg(1) =  mean(etanodes(1,:)); % sets initial opinion of each node
    eta3edges(1,:) = seed(eta3edges(1,:), 'All', seed2); y3avg(1) = mean(eta3edges(1,:)); % sets the initial opinon of each hyperedge
    
    %% Simulation
    T = 1; % set initial time
    while (T < bailtime)
        % Iterate through every node and make update
        T = T + 1; % increment time step by 1
        xbar = A*etanodes(T-1,:)'./mean(sum(A,2));
        y3bar = M3'*eta3edges(T-1,:)'./mean(sum(M3)');
        for j = 1:n
            q = rand;
            p = fn(a*xbar(j) + b*y3bar(j));

            if q < p
                etanodes(T,j) = 1;
            else
                etanodes(T,j) = 0;
            end
        end
        
        % Iterate through every 3-edge and make update
        xinc = M3*etanodes(T-1,:)'./mean(sum(M3,2));
        for k = 1:N3
            q = rand;
            
            p = fe(c*xinc(k) + d*eta3edges(T-1,k));
            if q < p
               eta3edges(T,k) = 1; 
            else
               eta3edges(T,k) = 0; 
            end   
        end
        % compute order parameters at time T
        Vavg(T)  = sum(etanodes(T,:)'.*(A*ones(n,1)))/(mean(A*ones(n,1))*n); % computes the order parameter V^T
        y3avg(T) = mean(eta3edges(T,:)); % computes the order parameter Y^T
    end
end