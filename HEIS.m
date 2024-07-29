%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% HyperEdge Inclusion Structure (HEIS)
%
% Generates a matrix M such that M(j,i) = 1 if node i is in hyperedge j.
%
% Inputs: n (number of nodes), E (Collection of hyperedges)
% Outputs: M (Hyperedge Inclusion Structure)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function M = HEIS(n, E)
    N = size(E,1);
    M = sparse(N, n);
    for i = 1:n
       for j = 1:N
          is = ismember(i,E(j,:)); 
          if( is )
             M(j,i) = sum(E(j,:)==i); 
          end
       end
    end
end