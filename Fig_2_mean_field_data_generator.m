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

%% preamble
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code generates the data that is plotted in Fig. 2 of  C.R. Sampson, J.G. Restrepo, and M.A. Porter, 
% Oscillatory and Excitable Dynamics in an Opinion Model with Group Opinions
% and labelled as mean-field. The data is saved as the .txt files named
%
%    figure_2_branchV_1.txt
%    figure_2_branchV_2.txt
%    figure_2_branchV_3.txt
%    figure_2_branchY_1.txt
%    figure_2_branchY_2.txt
%    figure_2_branchY_3.txt
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all;
%% Setting parameters for degree distribution
n = 500; % number of samples in inverse sampling
kmean = 20; % mean degree
gamma = 4; % gamma
r = 1; % correlation coefficient
k0 = kmean*((gamma-2)/(gamma-1)); % creates minimum degree based on mean degree and gamma
h = @(u, gamma, k0) k0*(u).^(1/(1-gamma)); % defines inverse of marginar degree distribution used in inverse sampling
 
% defines parameters a,b,c,d from table 1.
a = 0.5; 
b = 0.5; 
c = 0.5; 
d = 0.5;

% sigmoid parameters and functions
mu = 0.5;
params = 0:0.01:10; % range of m values



degreelist = floor(h(rand(n,1),gamma, k0)); % generates dyadic degree using inverse sampling
[K,Pk] = DPS(degreelist); Q = K; % generate list of degrees (K) and corresponding probablity (PK) for the mean-field maps
P1 = diag(Pk); % creates discrete analog of completely correlated hyperdegree
P2 = Pk*Pk'; % creates discrete analog of completely uncorrelated hyperdegree
P = r*P1 + (1-r)*P2; % discrete analog of Eq.(10)


%% main
M = 1000; % number grid points in multi-root solver

% begin loop over m
for i = 1:length(params)
   m = params(i); % current value of m
   fn = @(z) htansig(z,m,mu);
   fe = @(z) htansig(z,m,mu);
   f = {fn,fe};
    
   g1 = @(v,a,b,c,d) YYMF(fe,v,a,b,c,d); % creates inline equation of G(V) in Eqs. (26)
   g2 = @(v) VVMF(fn,fe, @YYMF, Pk,K,v,a,b,c,d) - v; % creates inline solvable version of Eq.(24)
   % begin multi-root root finding.
   x0 = 1/M;
   y0 = g2(x0);
   z = [];
   for j = 2:(M-1)
        x1 = x0;
        y1 = y0;
        x0 = j*(1/M);
        y0 = g2(x0);
        if (y1*y0 <= 0)
            z = [z,fsolve(g2, (x0*y1 - x1*y0)/(y1- y0))]; 
        end
        if (j == M-1 )
            func_zeros_V(i, 1:length(z)) = z;
            func_zeros_Y(i,1:length(z)) = g1(z,a,b,c,d);
        end
   end
   % end multi-root root finding    
end
% end loop over m values

% sorts resultings into 3 branches for order parameter V
branch1V = zeros(length(func_zeros_V(:,1)),1);
branch2V = zeros(length(func_zeros_V(:,1)),1);
branch3V = zeros(length(func_zeros_V(:,1)),1);
for j = 1:length(func_zeros_V(:,1))
   temp = func_zeros_V(j,:);
   branch1V(j) =  max(temp); temp(temp==max(temp)) = [];
   branch3V(j) =  min(temp); temp(temp==min(temp)) = [];
   if branch3V(j) == 0
       branch3V(j) = NaN;
   end
   if isempty(temp)
       branch2V(j) = NaN;
   else
      branch2V(j) =  temp;
   end
end

% sorts resultings into 3 branches for order parameter Y
branch1Y = zeros(length(func_zeros_Y(:,1)),1);
branch2Y = zeros(length(func_zeros_Y(:,1)),1);
branch3Y = zeros(length(func_zeros_Y(:,1)),1);
for j = 1:length(func_zeros_Y(:,1))
   temp = func_zeros_V(j,:);
   branch1Y(j) =  max(temp); temp(temp==max(temp)) = [];
   branch3Y(j) =  min(temp); temp(temp==min(temp)) = [];
   if branch3Y(j) == 0
       branch3Y(j) = NaN;
   end
   if isempty(temp)
       branch2Y(j) = NaN;
   else
      branch2Y(j) =  temp;
   end
end

% save results as .txt file
writematrix(branch1V, 'figure_2_branchV_1.txt')
writematrix(branch2V, 'figure_2_branchV_2.txt')
writematrix(branch3V, 'figure_2_branchV_3.txt')

writematrix(branch1Y, 'figure_2_branchY_1.txt')
writematrix(branch2Y, 'figure_2_branchY_2.txt')
writematrix(branch3Y, 'figure_2_branchY_3.txt')


%% Additional functions
% implementation of G(V) from Eqs.(26) 
function output = YYMF(f,v,a,b,c,d)
    output = f(c*v)./(1 + f(c*v) - f(c*v + d));
end

% implementation of F(V) from Eqs.(26)
function output = VVMF(fn, fe, YYMF ,P,K,v,a,b,c,d)
    km = sum(K.*P); 
    xx = zeros(length(K),length(v));
    for j = 1:length(K)
        xx(j,:) = fn( (K(j)/km)*(a*v + b*YYMF(fe,v,a,b,c,d))); 
    end  
    output = sum(K.*P.*xx)/km;
end