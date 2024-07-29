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
        while (length(Rindex) ~= length(unique(Rindex)))
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
        while (length(Rindex) ~= length(unique(Rindex)))
            Rindex = randi([1,LT],3,1);
            tempE = [T(Rindex(1)),T(Rindex(2)), T(Rindex(3))];
        end
        Et(k,:) = tempE; T(Rindex) = [];
        Nt = Nt - 1;
    end

    E{1} = Es;
    E{2} = Et;
end