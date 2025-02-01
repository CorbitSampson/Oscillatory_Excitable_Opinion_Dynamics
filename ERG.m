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