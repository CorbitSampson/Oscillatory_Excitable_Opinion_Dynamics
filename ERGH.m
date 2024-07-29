%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% !!INCLUDED BUT NOT IN USE!!
%
% Erdos-Renyi Graph Hyperedge (ERGH)
%
% Generates a collection of N hyperedges, each containing m nodes, from a
% collection of n nodes.
%
% Inputs: n (number of nodes), N (number of hyperedges), m (size of...
%            hyperedges)
% Outputs: E collection of hyperedges
%
% Note: that currently it is possible for a hyperedge to be in E twice, but
% this is unlikely sinze nCm will typically be very very large.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function E = ERGH(n, N, m)
    E = zeros(N,m);
    vE = nchoosek(1:n, m);
    nCm = size(vE,1);
    for i = 1:N
       q = randi(nCm);
       E(i,:) = vE(q,:);
    end
end