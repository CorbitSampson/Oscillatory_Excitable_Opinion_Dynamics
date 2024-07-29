%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% !!INCLUDED BUT NOT IN USE!!
%
% Erdos-Renyi Graph (ERG)
%
% Generates the adjacency matrix for a Erdos-Renyi G(n,p) model random
% graph.
%
% Inputs:  n (number of nodes), p (probability of connection
% Outputs: A (adjacency matrix of Erdos-Renyi G(n,p) graph.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function A = ERG(n,p)
    A = sparse(n,n);
    for i = 1:n
        for j = i+1:n
            q = rand;
            if q < p
                A(i,j) = 1;
                A(j,i) = 1;
            end
        end
    end
end