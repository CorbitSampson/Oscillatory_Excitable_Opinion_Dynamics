%% preamble
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code creates Fig.9 of  C.R. Sampson, J.G. Restrepo, and M.A. Porter, 
% Oscillatory and Excitable Dynamics in an Opinion Model with Group Opinions using the data in the
% following files:
%
%   figure_9_mf_H.txt
%   figure_9_mf_H_stochastic.txt
%   figure_9_sim_H.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all
%% Imports data
MF_data = readmatrix('figure_9_mf_H.txt');
MF_data_pulse = readmatrix('figure_9_mf_H_stochastic.txt');
sim_data = readmatrix('figure_9_sim_H.txt');

%% Creating meshgrid
M = 50;
gammavec = linspace(2.5,6,M); % range of gamma values

Q = 75;
rvec = linspace(0,1,Q); % range of correlation coefficient values

[X,Y] = meshgrid(rvec, gammavec); % creates meshgrid

%% Begin figures
f1 = figure(1);
colormap(parula)
t = tiledlayout(3,1);
t.TileSpacing = 'compact';
t.Padding = 'compact';

nexttile()
s1 = imagesc(rvec, gammavec, sim_data);
axhand = s1.Parent;
axhand.YLim = [2.5,6];
set(gca, 'fontsize', 12)
set(gca,'YDir','normal')
c = colorbar('northoutside');
c.Label.String = '$\mathcal{H}(V^t, [100,400])$';
c.Label.Interpreter = 'latex';
set(c,'fontsize',12);
set(c.Label,'fontsize',14)
view(2)

nexttile
s2 = imagesc(rvec, gammavec, MF_data_pulse);
set(gca, 'fontsize',12)
set(gca,'YDir','normal')
ylabel('power-law exponent ($\gamma$)','interpreter', 'latex', 'fontsize', 14)
axhand = s2.Parent;
axhand.YLim = [2.5,6];
view(2)

nexttile
s3 = imagesc(rvec, gammavec, MF_data);
set(gca, 'fontsize',12)
set(gca,'YDir','normal')
axhand = s3.Parent;
axhand.YLim = [2.5,6];
xlabel('correlation coefficient ($r$)', 'interpreter','latex', 'fontsize', 14)
view(2)