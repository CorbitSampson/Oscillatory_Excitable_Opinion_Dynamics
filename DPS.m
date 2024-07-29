%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% A function that creates the list of unique degrees from a random sample of
% degrees and the normalized probability of each degree. Used for the
% implementation of the mean-field maps in Eqs.(22).
%
% inputs: vect (the degree list for a collection of nodes)
%
% outputs: K (list of unique degrees that occured in vect), Pk (the
% normalized probability of each degree that occurs in vect).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [K,Pk] = DPS(vect)
    K = unique(vect);
    L = length(K);
    Pk = zeros(L,1);
    S = length(vect);
    for i = 1:L
       Pk(i) = sum(vect==K(i))/S; 
    end
end