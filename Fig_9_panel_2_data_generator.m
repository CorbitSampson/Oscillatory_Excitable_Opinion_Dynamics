%% preamble
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code generates the data that is plotted in the 3nd panel of Fig.9 of
%  C.R. Sampson, J.G. Restrepo, and M.A. Porter, 
% Oscillatory and Excitable Dynamics in an Opinion Model with Group Opinions. 
% The data is saved to a .txt file named
%
% figure_9_mf_H_stochastic.txt.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all
%% Setting parameters for degree distribution
kmean = 20; % mean degree
Z = rand(2500,1); % generate rand samples used to create hyperdegree distribution
h = @(u, gamma, k0) k0*(u).^(1/(1-gamma)); % defines inverse of marginar degree distribution used in inverse sampling

%% Space allocation
M = 50;
gammavec = linspace(2.5,6,M); % range of gamma values

Q = 75;
rvec = linspace(0,1,Q); % range of correlation coefficient values

amp = zeros(M,Q); % storeage for H in Eq. (28)

NT = 400; % number of time steps
V = zeros(1,NT); % allocating space for order parameter V
U = zeros(1,NT); % allocating space for order parameter U
Y = zeros(1,NT); % allocating space for order parameter Y

L = 3; % L^2 is number of independent simulations per point
seedvec = linspace(0,1,L);

%% defining constant parameters
m = 8; 
mu = 0.25;
fn = @(z) htansig(z, m,mu); % defines sigmoid 
fe = @(z) htansig(z, m,mu); % defines sigmoid 
f = {fn,fe};

% defines parameters a,b,c,d from table 1.
a = 1;
b = -0.5;
c = 0.25;
d = 0.25;

%% begin main loops

% loop over gamma values
for j = 1:M
    gamma = gammavec(j); % current value of gamma
    k0 = ((gamma-2)/(gamma-1))*kmean; % creates minimum degree based on mean degree and gamma

    [K,Pk] = DPS(floor(h(Z,gamma, k0))); % generate list of degrees (K) and corresponding probablity (PK)
    P1 = diag(Pk); % creates discrete analog of completely correlated hyperdegree
    P2 = Pk*Pk'; % creates discrete analog of completely uncorrelated hyperdegree
    
    % loop over correlation coefficient
    for i = 1:Q
        r = rvec(i); % current value of correlation coefficient
        P = (r)*P1 + (1-r)*P2; % discrete analog of Eq.(10)

        tempamp = zeros(L^2,1); % allocates space for next set of simulations
        counter = 1;
        % loop over independent simulations
        for k1 = 1:L
            for k2 = 1:L
                for k3 = 1:L
                    initial = [seedvec(k1),seedvec(k2),seedvec(k3)]; % draws initial conditions from seedvec for each order parameter.
                    V(1) = initial(1); % set initial condition V^0
                    U(1) = initial(2); % set initial condition U^0
                    Y(1) = initial(3); % set initial condition Y^0
                    old = initial;
                    % begin single simulation (loop over timesteps)
                    for T = 1:NT
                        new = Meanfield_Equations(old,f,K,K,P,a,b,c,d); % steps mean-field maps forward 1 step
                        old = new; % stores values for next step
                        temp = rand*0.036; % creates stochastic terms in Eqs.(29)
                        old(1) = old(1) + temp; % adds stochastic term to current value of V
                        old(2) = old(2) + temp; % adds stochastic term to current value of U
                        V(T+1) = new(1); % stores new value of V
                        U(T+1) = new(2); % stores new value of U (not used)
                        Y(T+1) = new(3); % stores new value of Y (not used)
                    end
                    % end loop over timesteps
                    tempamp(counter) =  max(V(end-350:end)) - min(V(end-350:end)); % computes H from Eq.(28) for current simulation
                    counter = counter + 1;
                end
            end
        end
        % end loop over independent simulations

        amp(j,i) = mean(tempamp); % averages H from Eq.(28) over the independent simulations
    end
    % end loop over correlation coefficient
end
% end loop over gamma values

writematrix(amp1, 'figure_9_mf_H_stochastic.txt') % saves output as .txt file

% displays results as basic plot
figure()
[X,Y] = meshgrid(rvec, gammavec);
surf(X,Y,amp, 'edgecolor','none')
view(2)
xlabel('alpha')
ylabel('gamma')
cbar = colorbar();
cbar.Label.String = 'Double Amplitude';