%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% A function that interates the mean-field maps in Eqs.(22)
%
% inputs: MFM (the implementation of the mean-field maps in Eqs.(22)), T
% (the number of time steps to take), initial (initial state of the system)
%
% outputs: V (vector of the order parameter V^T at each time step), U
% (vector of the order parameter U^T at each time step), Y (vector of order
% parameter Y^T at each time step)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [V,U,Y] = Meanfield_Iteration(MFM,T,initial)
    V = zeros(T,1); V(1) = initial(1);
    U = zeros(T,1); U(1) = initial(2);
    Y = zeros(T,1); Y(1) = initial(3);
    old = initial;
    for t = 2:T
        new = MFM(old);
        V(t) = new(1);
        U(t) = new(2);
        Y(t) = new(3);
        old = new;
    end
end