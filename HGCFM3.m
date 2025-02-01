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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% HyperGraph ConFiguration Model 3 (HGCFM3)
%
% Inputs: s (degrees of nodes, edges), t (degrees of nodes, 3-edges).
%
% Outputs: E (cell that contains the edges list for edges and the edge list for 3-edges).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function E = HGCFM3(degreelist)

    D = size(degreelist, 2);
    E = cell(D);

    s = degreelist(:,1);
    t = degreelist(:,2);
    n = length(s);
    NsStart = floor(sum(s)/2); Ns = NsStart;
    NtStart = floor(sum(t)/3); Nt = NtStart;
    v = 1:n;
    S = repelem(v, s);
    T = repelem(v, t);

    Es = zeros(NsStart, 2); 
    for k = 1:NsStart
        LS = length(S);
        Rindex = randi([1,LS], 2,1);
        tempE = [S(Rindex(1)),S(Rindex(2))];
        while (length(Rindex) ~= length(unique(Rindex))) %|| (length(tempE) ~= length(unique(tempE)))
            Rindex = randi([1,LS],2,1);
            tempE = [S(Rindex(1)),S(Rindex(2))];
        end
        Es(k,:) = tempE; S(Rindex) = [];
        Ns = Ns - 1;
    end

    Et = zeros(NtStart, 3);
    for k = 1:NtStart
        LT = length(T);
        Rindex = randi([1,LT], 3,1);
        tempE = [T(Rindex(1)),T(Rindex(2)), T(Rindex(3))];
        while (length(Rindex) ~= length(unique(Rindex))) %|| (length(tempE) ~= length(unique(tempE)))
            Rindex = randi([1,LT],3,1);
            tempE = [T(Rindex(1)),T(Rindex(2)), T(Rindex(3))];
        end
        Et(k,:) = tempE; T(Rindex) = [];
        Nt = Nt - 1;
    end
    
    indexlist = [];
    for i = 1:NsStart
        tempE = Es(i,:);
        if (length(tempE) ~= length(unique(tempE)))
            indexlist(end+1) = i;
        end
    end
    disp(length(indexlist)/length(Es(:,1)))
    Es(indexlist,:) = [];
    E{1} = Es;
    
    indexlist = [];
    for i = 1:NtStart
        tempE = Et(i,:);
        if (length(tempE) ~= length(unique(tempE)))
           indexlist(end+1) = i; 
        end
    end
    disp(length(indexlist)/length(Et(:,1)))
    Et(indexlist,:) = [];
    E{2} = Et;
end