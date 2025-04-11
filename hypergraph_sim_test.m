clear; %close all
%% initalize simulation parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hypergraph parameters
T = 200; % Sim time
n = 2000; % number of nodes;
D = 2;   % Starting with edges and triangles
k = 30;   % Uniform node degree
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% interaction parameters
a = 1;
b = -0.5;
c = 0.5;
d = 0.5;
m1 = 8;
mu1 = 0.25;
m2 = 6;
mu2 = 0.25;
fn = @(z) htansig(z, m1,mu1);
fe = @(z) htansig(z, m1,mu1);
%fn = @(z) z;
%fe = @(z) z;
seed1 = 0.5;
seed2 = 0.5;

gamma = 4;%2.8;%gamma = 2.54455;
k0 = 20*((gamma-2)/(gamma-1));
h = @(u, gamma, k0) k0*(u).^(1/(1-gamma));

alpha = 0;
degreelist(:,1) = floor(h(rand(n,1),gamma, k0));
degreelist(:,2) = degreelist(:,1);
[K,Pk] = DPS(degreelist(:,1));
Q = K;
P1 = Pk*Pk';
P2 = diag(Pk);
P = (1-alpha)*P2 + alpha*P1;

HG = hgraph([degreelist(:,1),degreelist(:,2)]);
G = graph(HG{3}(:,1), HG{3}(:,2));
A  = adj(HG{3},HG{1});
M3 = HEIS(HG{1}, HG{4});
B = M3'*M3;
disp( (sum(sum(A>1)) + sum(sum(B>1)) )/ (size(HG{4},1) + size(HG{3},1)))
%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = 1;
xavg = cell(M,1);
y3avg = xavg;
%xx = xavg;
%yy = xavg;
tic
for i = 1:M
    seed1 = rand;
    seed2 = rand;
    seed3 = rand;
    initial = [seed1,seed1, seed3];
   [xavg{i},~,y3avg{i},~,~] = hypergraph_sim(n,HG,A,M3,fn,fn, a,b,c,d,seed1,seed3, T);
   [xx(i,:),~,yy(i,:)] = Meanfield_Iteration(@(v) Meanfield_Equations(v, {fn, fe},K,Q,P,a,b,c,d),T,initial);
end
toc
%% Plotting
figure(2)
s = sprintf('%12.3f, %12.3f, %12.3f, %12.3f, %12.3f, %12.3f',a,b,c,d,m1,mu1);
%title(s)
hold on 
tiledlayout(2,1)

nexttile
hold on
for l = 1:M
    %nexttile
    hold on
    title('\alpha = 1', 'fontsize', 20)
    ylabel('average state', 'fontsize', 16)
    plot(xavg{1}, 'b')
    plot(y3avg{l}, 'r')
    legend('nodes', 'hyperedges')
    ylim([-1,1])
    %plot(xx(l,:), 'r')
    %{
    plot(1:199,xx(1,1:199),'--k')
    plot(199:200,xx(1,199:200),'b')
    plot(200:203,xx(1,200:203),'m')
    plot(203:207,xx(1,203:207),'g')
    plot(207:217,xx(1,207:217),'r')
    plot(217:length(xx(1,:)),xx(1,217:end),'k')
    %}
    %plot(y3avg{l}, 'b')
    plot(xx(l,:), 'b')
    plot(yy(l,:), 'r')
    %{
    plot(1:199,yy(1,1:199),'--k')
    plot(199:200,yy(1,199:200),'b')
    plot(200:203,yy(1,200:203),'m')
    plot(203:207,yy(1,203:207),'g')
    plot(207:217,yy(1,207:217),'r')
    plot(217:length(yy(1,:)),yy(1,217:end),'k')
    %}
    %plot(y3avg{l}, 'r')
    %plot(extra2{2} + extra2{3} + extra2{4} - extra1, 'k')
   % plot(cons, 'k')
   ylim([0,1])
end
ylim([0,1])
xlabel('time', 'fontsize', 16)
ylabel('average state', 'fontsize', 16)
%legend('phase 1', 'phase 2', 'phase 3', 'phase 4', 'phase 5', 'phase 6')
legend('nodes', 'hyperedges')
%plot(xx', 'k--')
%ylabel('Avg Value on Node')
%ylim([0,1])
%xlabel('Time')
%legend('Node (Sim)','Nodes(thy)') %Fix legends
%hold off
%{
nexttile
hold on

for l = 1:M
    plot(y3avg{l}, 'r')
end

%plot(yy', 'k--')
ylabel('Avg Value on Edge')
xlabel('Time')
ylim([0,1])
%legend('Edges (Sim)','Edges (thy)')
hold off
%}
%{
figure(7)
hold on
for l = 1:M
    plot(xavg{l},y3avg{l}, 'k')
end
%}


%{
figure(7)
plot(extra1)
%}

%{
figure(3)
tiledlayout(4,1)

nexttile
plot(extra2{1})
ylim([0,1])

nexttile
plot(extra2{2})
ylim([0,1])

nexttile
plot(extra2{3})
ylim([0,1])

nexttile
plot(extra2{4})
ylim([0,1])

checkosc(xavg{1,1});
%}

%{
for i = 1:M
   temppol(i) = mean(xavg{i}(50:end)); 
end
checkpolarization(temppol)
%}

%{
nexttile
hold on
plot(xavg' - y3avg')
plot(xx' - yy', 'r--')
ylabel('Avg Value on diff')
xlabel('Time')
ylim([-1,1])
%legend('Edges (Sim)','Edges (thy)')
hold off
%}

function vect = swamps(vect, K)
for i = 1:K
    ind = randi(length(vect), 2,1);
    vect(ind) = vect(flip(ind));
end

end
%}