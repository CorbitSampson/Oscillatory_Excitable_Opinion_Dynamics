%% preamble
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code creates Fig.2 of C.R. Sampson, J.G. Restrepo, and M.A. Porter, 
% Oscillatory and Excitable Dynamics in an Opinion Model with Group Opinions
% using the data in the
%
% following files:
%   figure_2_branchV_1.txt
%   figure_2_branchV_2.txt
%   figure_2_branchV_3.txt
%   figure_2_branchY_1.txt
%   figure_2_branchY_2.txt
%   figure_2_branchY_3.txt
%   SIM_V_figure_2_mF0L10S25.txt
%   SIM_Y_figure_2_mF0L10S25.txt
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all
%% Imports data
branch1V = readmatrix('figure_2_branchV_1.txt');
branch2V = readmatrix('figure_2_branchV_2.txt');
branch3V = readmatrix('figure_2_branchV_3.txt');
branch1Y = readmatrix('figure_2_branchY_1.txt');
branch2Y = readmatrix('figure_2_branchY_2.txt');
branch3Y = readmatrix('figure_2_branchY_3.txt');
SIMV = readmatrix('SIM_V_figure_2_mF0L10S25.txt');
SIMY = readmatrix('SIM_Y_figure_2_mF0L10S25.txt');

% creates range of m values for m for each the mean field results and
% simulation of the stochastic opinion model
V1 = 0:0.25:10; % range of m values for stochastic opinion model
V2 = 0:0.01:10; % range of m values for mean-field maps
L = 10;
%% Begin figures
figure(1)
tt = tiledlayout(2,1);

nexttile
hold on
for j=1:L^2
    pV1 = plot(V2, branch1V,'color', 1/255*[5,113,176], 'linewidth', 2, 'displayname', '\hspace{1pt} mean field (stable) \hspace{2pt}');
    pV2 = plot(V2, branch2V,'color', 1/255*[5,113,176], 'linestyle', '--', 'linewidth',2, 'displayname', '\hspace{1pt} mean field (unstable) \hspace{2pt}');
    pV3 = plot(V2, branch3V,'color', 1/255*[5,113,176], 'linewidth',2);
    pV4 = plot(V1,SIMV(j,:), 'color', 1/255*[202,0,32], 'marker', '.', 'linestyle', 'none', 'markersize', 10, 'displayname', 'simulation  \hspace{2pt}'); 
    ylim([0,1])
end
set(gca, 'fontsize', 18)
ylabel('$V^*$', 'fontsize', 25, 'interpreter', 'latex')
txtstring = '(a)';
text(0.5,0.85,txtstring, 'fontsize',22,'interpreter','latex')
legend([pV4, pV1, pV2], 'location', 'northoutside','orientation', 'horizontal' ,'fontsize', 16,  'interpreter', 'latex')

nexttile
hold on
for j=1:L^2
    pY1 = plot(V2, branch1Y,'color', 1/255*[5,113,176], 'linewidth', 2);
    pY2 = plot(V2, branch2Y,'color', 1/255*[5,113,176], 'linestyle', '--', 'linewidth',2);
    pY3 = plot(V2, branch3Y,'color', 1/255*[5,113,176], 'linewidth',2);
    pY4 = plot(V1,SIMY(j,:),'color', 1/255*[202,0,32], 'marker', '.', 'linestyle', 'none', 'markersize', 10); 
    ylim([0,1])
end
set(gca, 'fontsize', 18)
ylabel('$Y^*$', 'fontsize', 25, 'interpreter', 'latex')
txtstring = '(b)';
text(0.5,0.85,txtstring, 'fontsize',22,'interpreter','latex')
xlabel('$m$', 'fontsize', 25,  'interpreter', 'latex')
tt.TileSpacing = 'compact';
