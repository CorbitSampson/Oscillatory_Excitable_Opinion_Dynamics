%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% graphgen
%
% generates the graph structure given a  hyperdegree list
%
% Inputs: degreelist (n by D matrix where each column is the degree list
% for hyperedges of size d = 1:D.
%
% Outputs: G (cell object which contains the number of nodes, original
% degree list, the edge lists for the created network, the incidence
% matricies, the projection matricies, and a directory locating these.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function G = hgraph(degreelist)
    n = size(degreelist,1);
    D = size(degreelist,2);

    G = cell(2 + D,1);
    E = HGCFM3( degreelist );
    G{1} = n; G{2} = degreelist;
    for i = 1:D
       G{2+i} = E{i};
    end
end