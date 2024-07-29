%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% seeds initial state of nodes or hyperedge by returning a vector v of 0s
% and 1s notating opinion.
%
% inputs: v (a vector of the opinions of nodes or hyperedges), flag
% (a flag setting the strategy for opinion assignment, only "All" case is
% used), p (probability that the current node or hyperedge is assigned
% opinion 1.
%
% output: w (a vector of opinions of nodes or hyperedges)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function w = seed(v, flag, p)
    switch flag
        case "Single"
            i = randi([1,length(v)],1,1);
            v(i) = 1;
        case "All"
            for i = 1:length(v)
               q = rand;
               if q < p
                   v(i) = 1;
               end
            end
        otherwise
            warning('seed input error, no case for flag = %s', flag)
    end

    w = v;
end