%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Mean-field maps.
%
% This is an implementation of the mean-field maps in Eqs.(22) taking one
% step forward in time.
%
% inputs: vold (previous state of system), f (a cell of the sigmoid
% functions for nodes and hyperedges), K (list of dyadic degrees in
% sample), Q (list of triadic degrees in sample), a (node-to-node
% interaction parameter), b hyperedge-to-node interaction parameter), c
% (node-to-hyperedge interaction parameter), d (hyperedge-to-self
% interaction parameter)
%
% outputs: vnew (the new state of the system)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function vnew = Meanfield_Equations(vold,f,K,Q,P,a,b,c,d)
    Pk = sum(P,2);
    Pq = sum(P',2);
    km = sum(K.*Pk);
    qm = sum(Q.*Pq);
    arg1 = f{1}((a/km)*K*vold(1) + (b/qm)*Q'*vold(3));
    
    V = sum(sum(K*ones(1,length(Q)).*P.*arg1))/(km);
    U = sum(sum(Q*ones(1,length(K)).*P'.*arg1'))/(qm);
    Y = (vold(3)*f{2}(c*vold(2) + d) + (1-vold(3))*f{2}(c*vold(2)));
    vnew = [V,U,Y]';
end