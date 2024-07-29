%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% create the weighted adjacency matrix for dyadic connections
%
% inputs: E (dyadic edge list), n (number of nodes)
%
% output: A (weighted adjacency matrix)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function A = adj(E,n)
    N = size(E,1);
    A = sparse(n,n);
    for i = 1:N
        j = E(i,1);
        k = E(i,2);
        A(j,k) = A(j,k) + 1;
        A(k,j) = A(k,j) + 1;
    end
end