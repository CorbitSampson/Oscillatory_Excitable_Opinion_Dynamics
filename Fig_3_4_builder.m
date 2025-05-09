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
% This code creates Fig.3 of  C.R. Sampson, J.G. Restrepo, and M.A. Porter, 
% Oscillatory and Excitable Dynamics in an Opinion Model with Group Opinions
% using the data in the following files:
%
%    ab_param_sweep_param.txt
%    ab_param_sweep_MF_c01_d01_mu5.txt
%    ab_param_sweep_MF_c01_d09_mu5.txt
%    ab_param_sweep_MF_c09_d09_mu5.txt
%    ab_param_sweep_SIM_c01_d01_mu5.txt
%    ab_param_sweep_SIM_c01_d09_mu5.txt
%    ab_param_sweep_SIM_c09_d09_mu5.txt
%    ab_param_sweep_MF_c01_d01_mu25.txt
%    ab_param_sweep_MF_c01_d09_mu25.txt
%    ab_param_sweep_MF_c09_d09_mu25.txt
%    ab_param_sweep_SIM_c01_d01_mu25.txt
%    ab_param_sweep_SIM_c01_d09_mu25.txt
%    ab_param_sweep_SIM_c09_d09_mu25.txt
%    m_param_sweep_param.txt
%    m_param_sweep_MF_a02_b02_c08_d08_mu5.txt
%    m_param_sweep_MF_a05_b05_c05_d05_mu5.txt
%    m_param_sweep_MF_a08_b08_c02_d02_mu5.txt
%    m_param_sweep_SIM_a02_b02_c08_d08_mu5.txt
%    m_param_sweep_SIM_a05_b05_c05_d05_mu5.txt
%    m_param_sweep_SIM_a08_b08_c02_d02_mu5.txt
%    m_param_sweep_MF_a02_b02_c08_d08_mu25.txt
%    m_param_sweep_MF_a05_b05_c05_d05_mu25.txt
%    m_param_sweep_MF_a08_b08_c02_d02_mu25.txt
%    m_param_sweep_SIM_a02_b02_c08_d08_mu25.txt
%    m_param_sweep_SIM_a05_b05_c05_d05_mu25.txt
%    m_param_sweep_SIM_a08_b08_c02_d02_mu25.txt
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all;

%% import data

% importing data for Fig.3
ab_independent = readmatrix('ab_param_sweep_param.txt');

ab_sweep_c01_d01_MF_mu5 = readmatrix('ab_param_sweep_MF_c01_d01_mu5.txt');
ab_sweep_c01_d09_MF_mu5 = readmatrix('ab_param_sweep_MF_c01_d09_mu5.txt');
ab_sweep_c09_d09_MF_mu5 = readmatrix('ab_param_sweep_MF_c09_d09_mu5.txt');

ab_sweep_c01_d01_SIM_mu5 = readmatrix('ab_param_sweep_SIM_c01_d01_mu5.txt');
ab_sweep_c01_d09_SIM_mu5 = readmatrix('ab_param_sweep_SIM_c01_d09_mu5.txt');
ab_sweep_c09_d09_SIM_mu5 = readmatrix('ab_param_sweep_SIM_c09_d09_mu5.txt');

ab_sweep_c01_d01_MF_mu25 = readmatrix('ab_param_sweep_MF_c01_d01_mu25.txt');
ab_sweep_c01_d09_MF_mu25 = readmatrix('ab_param_sweep_MF_c01_d09_mu25.txt');
ab_sweep_c09_d09_MF_mu25 = readmatrix('ab_param_sweep_MF_c09_d09_mu25.txt');

ab_sweep_c01_d01_SIM_mu25 = readmatrix('ab_param_sweep_SIM_c01_d01_mu25.txt');
ab_sweep_c01_d09_SIM_mu25 = readmatrix('ab_param_sweep_SIM_c01_d09_mu25.txt');
ab_sweep_c09_d09_SIM_mu25 = readmatrix('ab_param_sweep_SIM_c09_d09_mu25.txt');

% importing data for Fig.4
m_independent = readmatrix('m_param_sweep_param.txt');
m_independent2 = readmatrix('m_param_sweep_param.txt');

m_sweep_a02_b02_c08_d08_MF_mu5 = readmatrix('m_param_sweep_MF_a02_b02_c08_d08_mu5.txt');
m_sweep_a05_b05_c05_d05_MF_mu5 = readmatrix('m_param_sweep_MF_a05_b05_c05_d05_mu5.txt');
m_sweep_a08_b08_c02_d02_MF_mu5 = readmatrix('m_param_sweep_MF_a08_b08_c02_d02_mu5.txt');

m_sweep_a02_b02_c08_d08_SIM_mu5 = readmatrix('m_param_sweep_SIM_a02_b02_c08_d08_mu5.txt');
m_sweep_a05_b05_c05_d05_SIM_mu5 = readmatrix('m_param_sweep_SIM_a05_b05_c05_d05_mu5.txt');
m_sweep_a08_b08_c02_d02_SIM_mu5 = readmatrix('m_param_sweep_SIM_a08_b08_c02_d02_mu5.txt');

m_sweep_a02_b02_c08_d08_MF_mu25 = readmatrix('m_param_sweep_MF_a02_b02_c08_d08_mu25.txt');
m_sweep_a05_b05_c05_d05_MF_mu25 = readmatrix('m_param_sweep_MF_a05_b05_c05_d05_mu25.txt');
m_sweep_a08_b08_c02_d02_MF_mu25 = readmatrix('m_param_sweep_MF_a08_b08_c02_d02_mu25.txt');

m_sweep_a02_b02_c08_d08_SIM_mu25 = readmatrix('m_param_sweep_SIM_a02_b02_c08_d08_mu25.txt');
m_sweep_a05_b05_c05_d05_SIM_mu25 = readmatrix('m_param_sweep_SIM_a05_b05_c05_d05_mu25.txt');
m_sweep_a08_b08_c02_d02_SIM_mu25 = readmatrix('m_param_sweep_SIM_a08_b08_c02_d02_mu25.txt');


%% creating Fig.3
colors = {[178,24,43]/255,[33,102,172]/255,[244,165,130]/255};
markers = {'o','*','square','+', 'diamond'};

figure(1)
tiledlayout(2,1)

nexttile
set(gca, 'fontsize', 18)
hold on
plot(ab_independent,ab_sweep_c01_d01_MF_mu5, 'color', colors{1}, 'linewidth', 1.5)
plot(ab_independent,ab_sweep_c01_d09_MF_mu5, 'color', colors{2}, 'linewidth', 1.5)
plot(ab_independent,ab_sweep_c09_d09_MF_mu5, 'color', colors{3}, 'linewidth', 1.5)

plot(ab_independent,ab_sweep_c01_d01_SIM_mu5, 'color', colors{1}, 'linestyle','none', 'marker', markers{1}, 'linewidth', 1.5)
plot(ab_independent,ab_sweep_c01_d09_SIM_mu5, 'color', colors{2}, 'linestyle','none', 'marker', markers{2}, 'linewidth', 1.5)
plot(ab_independent,ab_sweep_c09_d09_SIM_mu5, 'color', colors{3}, 'linestyle','none', 'marker', markers{3}, 'linewidth', 1.5)

xlabel('$a=b$','fontsize', 20,'interpreter', 'latex')
ylabel('$D(V^*,Y^*)$','fontsize', 20, 'interpreter', 'latex')
txtstring = '(a)';
text(0.13,0.85,txtstring, 'fontsize',22,'interpreter','latex')

p1 = plot(NaN,NaN,'color', colors{1},'marker', markers{1}, 'linewidth', 1.5);
p2 = plot(NaN,NaN,'color', colors{2},'marker', markers{2}, 'linewidth', 1.5);
p3 = plot(NaN,NaN,'color', colors{3},'marker', markers{3}, 'linewidth', 1.5);

l1 = legend([p1,p2,p3],{'\hspace{1pt} $c=d=0.1$ \hspace{2pt}','\hspace{1pt} $c=0.1, \hspace{1pt} d=0.9$ \hspace{2pt}', '\hspace{1pt} $c=d=0.9$ \hspace{2pt}'},'numcolumns',3,'location','northoutside','fontsize', 14 ,'interpreter','latex');
l1.ItemTokenSize(2) = 10;
legend('boxoff')

nexttile
set(gca, 'fontsize', 18)
hold on
plot(ab_independent,ab_sweep_c01_d01_MF_mu25, 'color', colors{1}, 'linewidth', 1.5)
plot(ab_independent,ab_sweep_c01_d09_MF_mu25, 'color', colors{2}, 'linewidth', 1.5)
plot(ab_independent,ab_sweep_c09_d09_MF_mu25, 'color', colors{3}, 'linewidth', 1.5)

plot(ab_independent,ab_sweep_c01_d01_SIM_mu25, 'color', colors{1}, 'linestyle','none', 'marker', markers{1}, 'linewidth', 1.5)
plot(ab_independent,ab_sweep_c01_d09_SIM_mu25, 'color', colors{2}, 'linestyle','none', 'marker', markers{2}, 'linewidth', 1.5)
plot(ab_independent,ab_sweep_c09_d09_SIM_mu25, 'color', colors{3}, 'linestyle','none', 'marker', markers{3}, 'linewidth', 1.5)

xlabel('$a=b$','fontsize', 20,'interpreter', 'latex')
ylabel('$D(V^*,Y^*)$','fontsize', 20, 'interpreter', 'latex')
txtstring = '(b)';
text(0.13,0.85,txtstring, 'fontsize',22,'interpreter','latex')

%% Creating Fig.4
figure(2)
tiledlayout(2,1)

nexttile
set(gca, 'fontsize', 18)
hold on 
plot(m_independent, m_sweep_a02_b02_c08_d08_MF_mu5, 'color', colors{1}, 'linewidth', 1.5)
plot(m_independent2, m_sweep_a05_b05_c05_d05_MF_mu5, 'color', colors{2}, 'linewidth', 1.5)
plot(m_independent, m_sweep_a08_b08_c02_d02_MF_mu5, 'color', colors{3}, 'linewidth', 1.5)

plot(m_independent, m_sweep_a02_b02_c08_d08_SIM_mu5, 'color', colors{1}, 'linestyle','none', 'marker', markers{1}, 'linewidth', 1.5)
plot(m_independent2, m_sweep_a05_b05_c05_d05_SIM_mu5, 'color', colors{2}, 'linestyle','none', 'marker', markers{2}, 'linewidth', 1.5)
plot(m_independent, m_sweep_a08_b08_c02_d02_SIM_mu5, 'color', colors{3}, 'linestyle','none', 'marker', markers{3}, 'linewidth', 1.5)

p1 = plot(NaN,NaN,'color',colors{1},'marker',markers{1},'linewidth',1.5);
p2 = plot(NaN,NaN,'color',colors{2},'marker',markers{2},'linewidth',1.5);
p3 = plot(NaN,NaN,'color',colors{3},'marker',markers{3},'linewidth',1.5);
xlabel('$m$','fontsize', 20, 'interpreter', 'latex')
ylabel('$D(V^*,Y^*)$','fontsize', 20, 'interpreter', 'latex')
ylim([0,0.6])
txtstring = '(a)';
text(0.1,0.55,txtstring, 'fontsize',22,'interpreter','latex')
l2 = legend([p1,p2,p3], {['\hspace{1pt} $a=b=0.2$ \hspace{2pt}' newline '\hspace{1pt} $c=d=0.8$ \hspace{2pt}'],['\hspace{1pt} $a=b=0.5$ \hspace{2pt}' newline '\hspace{1pt} $c=d=0.5$ \hspace{2pt}'],['\hspace{1pt} $a=b=0.8$ \hspace{2pt}' newline '\hspace{1pt} $c=d=0.2$ \hspace{2pt}']},'numcolumns',3,'location','northoutside','fontsize', 14, 'interpreter','latex');
legend('boxoff')

nexttile
set(gca, 'fontsize', 18)

hold on
plot(m_independent, m_sweep_a02_b02_c08_d08_MF_mu25, 'color', colors{1}, 'linewidth', 1.5)
plot(m_independent2, m_sweep_a05_b05_c05_d05_MF_mu25, 'color', colors{2}, 'linewidth', 1.5)
plot(m_independent, m_sweep_a08_b08_c02_d02_MF_mu25, 'color', colors{3}, 'linewidth', 1.5)

plot(m_independent, m_sweep_a02_b02_c08_d08_SIM_mu25, 'color', colors{1}, 'linestyle','none', 'marker', markers{1}, 'linewidth', 1.5)
plot(m_independent2, m_sweep_a05_b05_c05_d05_SIM_mu25, 'color', colors{2}, 'linestyle','none', 'marker', markers{2}, 'linewidth', 1.5)
plot(m_independent, m_sweep_a08_b08_c02_d02_SIM_mu25, 'color', colors{3}, 'linestyle','none', 'marker', markers{3}, 'linewidth', 1.5)

xlabel('$m$','fontsize', 20, 'interpreter', 'latex')
ylabel('$D(V^*,Y^*)$','fontsize', 20, 'interpreter', 'latex')
ylim([0,0.6])
txtstring = '(b)';
text(0.1,0.55,txtstring, 'fontsize',22,'interpreter','latex')