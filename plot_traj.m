%% plot the result
close all;
print_file = 1;     % whether to save the fig and print it to pdf. 
line_wd = 1.5;      %
plot_rst_w_obs = 1; % whether to plot the results with obstacles
w_max = 1;          % amplitude of disturbance
if plot_rst_w_obs == 0
    ccm_sim_data = 'sim_ccm_lam_0.8_w_dist_1.mat';
    deccm_sim_data = 'sim_deccm_lam_1.4_w_dist_1.mat';
%     rccm_pos_sim_data = 'sim_rccm_pos_lam_1.2_w_dist_1.mat';
    ccm_nomTraj_data = 'nomTraj.mat';
%     rccm_nomTraj_data = 'nomTraj.mat';
%     rccm_pos_nomTraj_data = 'nomTraj.mat';
elseif plot_rst_w_obs == 1
    ccm_sim_data = 'sim_ccm_lam_0.8_w_dist_1_w_obs.mat';
%     deccm_sim_data = 'sim_deccm_lam_1.4_w_dist_1_w_obs.mat';
%     rccm_pos_sim_data = 'sim_rccm_pos_lam_1.2_w_dist_1_w_obs.mat';
    ccm_nomTraj_data = 'nomTraj_w_obs_no_learning.mat';
%     rccm_nomTraj_data = 'nomTraj_w_obs_rccm_1.4_wmax_1_plim_0.33pi.mat';
%     rccm_pos_nomTraj_data = 'nomTraj_w_obs_rccm_1.2_wmax_1_plim_0.33pi_pos.mat';
end

% load data

% CCM
load(ccm_sim_data);
times_ccm = times;
xTraj_ccm = xTraj;
uTraj_ccm = uTraj;
energyTraj_ccm = energyTraj;
controller_ccm = controller;
controller_ccm.tube_x = controller_ccm.tube_gain_x*w_max;
controller_ccm.tube_z = controller_ccm.tube_gain_z*w_max;
load(ccm_nomTraj_data);
nomTrajSoln = soln; 
simuLen = length(times);
xnomTraj_ccm = zeros(n,simuLen);
unomTraj_ccm = zeros(nu,simuLen);
for t =1:simuLen
    xnomTraj_ccm(:,t) = nomTrajSoln.interp.state(times(t));
    unomTraj_ccm(:,t) = nomTrajSoln.interp.control(times(t));
end
times_ccm = times;


if sim_config.include_obs == 1
    fig_name_com = '_w_obs';
    obs = sim_config.trajGen_config.obs;
else
    fig_name_com = '';
end

% RCCM
% load(deccm_sim_data);
% times_rccm = times;
% xTraj_rccm = xTraj;
% uTraj_rccm = uTraj;
% energyTraj_rccm = energyTraj;
% % tube_gain_rccm = tube_gain;
% % tube_rccm = tube_gain*w_max*artificial_gain; 
% controller_rccm = controller;
% controller_rccm.tube_xz = controller_rccm.tube_gain_xz*w_max;
% controller_rccm.tube_x = controller_rccm.tube_xz;
% controller_rccm.tube_z = controller_rccm.tube_xz; 
% load(rccm_nomTraj_data);
% nomTrajSoln = soln; 
% simuLen = length(times);
% xnomTraj_rccm = zeros(n,simuLen);
% unomTraj_rccm = zeros(nu,simuLen);
% for t =1:simuLen
%     xnomTraj_rccm(:,t) = nomTrajSoln.interp.state(times(t));
%     unomTraj_rccm(:,t) = nomTrajSoln.interp.control(times(t));
% end
% times_rccm = times;

% RCCM (pos)
% load(rccm_pos_sim_data);
% times_rccm_pos = times;
% xTraj_rccm_pos = xTraj;
% uTraj_rccm_pos = uTraj;
% energyTraj_rccm_pos = energyTraj;
% % tube_gain_rccm_pos = tube_gain;
% % tube_rccm_pos = tube_gain*w_max*artificial_gain;
% controller_rccm_pos = controller;
% controller_rccm_pos.tube_xz = controller_rccm_pos.tube_gain_xz*w_max;
% controller_rccm_pos.tube_x = controller_rccm_pos.tube_xz;
% controller_rccm_pos.tube_z = controller_rccm_pos.tube_xz;
% load(rccm_pos_nomTraj_data);
% nomTrajSoln = soln; 
% simuLen = length(times);
% xnomTraj_rccm_pos = zeros(n,simuLen);
% unomTraj_rccm_pos = zeros(nu,simuLen);
% for t =1:simuLen
%     xnomTraj_rccm_pos(:,t) = nomTrajSoln.interp.state(times(t));
%     unomTraj_rccm_pos(:,t) = nomTrajSoln.interp.control(times(t));
% end
% times_rccm_pos = times;
% n = plant.n; nu = plant.nu;

%% ----------- Plot the trajectory -----------------
% nominal trajectory
close all;
load('nomTraj.mat');
xF = trajGen_config.xF;
x0 = trajGen_config.x0;
x_nom_fcn = soln.interp.state;
u_nom_fcn = soln.interp.control;
simuLen = length(times);
xnomTraj = zeros(n,simuLen);
unomTraj = zeros(nu,simuLen);
for t =1:simuLen
    xnomTraj(:,t) = x_nom_fcn(times(t));
    unomTraj(:,t) = u_nom_fcn(times(t));
end

% color testing
color = {'k','b',[0 0.5 0],'r',[0.8 0.9 0.9741],[0.8 0.98 0.9],[1 0.8 0.8]};
% figure;hold on;
% plot(times',xnomTraj(1,:),'color',color{5},'Linewidth',5);
% plot(times',xnomTraj(1,:)+0.5,'color',color{6},'Linewidth',5);
% plot(times',xnomTraj(1,:)-0.5,'color',color{7},'Linewidth',5);
 
linestyle = {':','--','-.','-'};
% close all;
figId = 1;
figId = figId+1;
figure(figId); clf;
subplot(3,1,1); hold on;
plot(times,xnomTraj(1,:),'k:');
plot(times_ccm,xTraj_ccm(1,:),'b-.');
plot(times_rccm,xTraj_rccm(1,:),'g--');
plot(times_rccm_pos,xTraj_rccm_pos(1,:),'r-');
xlabel('Time (s)')
ylabel('p_x (m)')
legend('Nominal','CCM','RCCM','RCCM-P');

subplot(3,1,2); hold on;
plot(times,xnomTraj(2,:),'k:');
plot(times_ccm,xTraj_ccm(2,:),'b-.');
plot(times_rccm,xTraj_rccm(2,:),'g--');
plot(times_rccm_pos,xTraj_rccm_pos(2,:),'r-');
xlabel('Time (s)')
ylabel('p_z (m)')
legend('Nominal','CCM','RCCM','RCCM-P');

subplot(3,1,3); hold on;
plot(times,xnomTraj(3,:)*180/pi,':');
plot(times_ccm,xTraj_ccm(3,:)*180/pi,'-.');
plot(times_rccm,xTraj_rccm(3,:)*180/pi,'--');
plot(times_rccm_pos,xTraj_rccm_pos(3,:)*180/pi,'-');
xlabel('Time (s)')
ylabel('\phi (deg)')
legend('Nominal','CCM','RCCM','RCCM-P');

figId = figId+1;
figure(figId); clf;
subplot(3,1,1);hold on;
plot(times,unomTraj(1,:),'k:');
plot(times_ccm,uTraj_ccm(1,:),'b-.');
plot(times_rccm,uTraj_rccm(1,:),'g--');
plot(times_rccm_pos,uTraj_rccm_pos(1,:),'r-');
xlabel('Time (s)');
ylabel('u (N)')
legend('Nominal','CCM','RCCM','RCCM-P');

subplot(3,1,2);hold on;
plot(times,unomTraj(2,:),'k:');
plot(times_ccm,uTraj_ccm(2,:),'b-.');
plot(times_rccm,uTraj_rccm(2,:),'g--');
plot(times_rccm_pos,uTraj_rccm_pos(2,:),'r-');
xlabel('Time (s)');
ylabel('u (N)')
legend('Nominal','CCM','RCCM','RCCM-P');
% plot(times,distTraj);
% xlabel('Time (s)');
% ylabel('$\|x-x^\star\|/\|x_0-x^\star_0\|$','interpreter','latex');

subplot(3,1,3);hold on;
plot(times_ccm, energyTraj_ccm);
plot(times_rccm, energyTraj_rccm);
plot(times_rccm_pos, energyTraj_rccm_pos);
xlabel('Time (s)');
ylabel('Riemann energy')
legend('CCM','RCCM','RCCM-P');

figId = figId + 1;
figure(figId);clf;
subplot(3,1,1);hold on;
plot(times,xnomTraj(4,:),'k:');
plot(times_ccm,xTraj_ccm(4,:),'b-.');
plot(times_rccm,xTraj_rccm(4,:),'g--');
plot(times_rccm_pos,xTraj_rccm_pos(4,:),'r-');
xlabel('Time (s)')
ylabel('v_x (m/s)')
legend('Nom.', 'CCM','RCCM','RCCM-P');

subplot(3,1,2);hold on;
plot(times,xnomTraj(5,:),'k:');
plot(times_ccm,xTraj_ccm(5,:),'b-.');
plot(times_rccm,xTraj_rccm(5,:),'g--');
plot(times_rccm_pos,xTraj_rccm_pos(5,:),'r-');
xlabel('Time (s)')
ylabel('v_x (m/s)')
legend('Nom.', 'CCM','RCCM','RCCM-P');

subplot(3,1,3);hold on;
plot(times,xnomTraj(6,:),'k:');
plot(times_ccm,xTraj_ccm(6,:),'b-.');
plot(times_rccm,xTraj_rccm(6,:),'g--');
plot(times_rccm_pos,xTraj_rccm_pos(6,:),'r-');
xlabel('Time (s)')
ylabel('v_x (m/s)')
legend('Nom.', 'CCM','RCCM','RCCM-P');



%% show the trajectories in X-Z plane
figId = figId + 1;
figure(figId);clf;
hold on;
% CCM tube
scale = 20;
Len = length(times_ccm);
for i=1:Len/scale
    center = [xnomTraj_ccm(1,i*scale-1),xnomTraj_ccm(2,i*scale-1)];
    h2_tube = ellipse(controller_ccm.tube_x, controller_ccm.tube_z,0,center(1),center(2),color{5},[],1);
end
% RCCM tube
Len = length(times_rccm);
for i=1:Len/scale
    center = [xnomTraj_rccm(1,i*scale-1),xnomTraj_rccm(2,i*scale-1)];
   h3_tube= ellipse(controller_rccm.tube_xz,controller_rccm.tube_xz,0,center(1),center(2),color{6},[],1);
end

% RCCM-pos tube
Len = length(times_rccm_pos);
for i=1:Len/scale
    center = [xnomTraj_rccm_pos(1,i*scale-1),xnomTraj_rccm_pos(2,i*scale-1)];
    h4_tube = ellipse(controller_rccm_pos.tube_xz,controller_rccm_pos.tube_xz,0,center(1),center(2),color{7},[],1);
end
h2 = plot(xTraj_ccm(1,:),xTraj_ccm(2,:),[color{2} linestyle{4}],'Linewidth',line_wd);

h4 = plot(xTraj_rccm_pos(1,:),xTraj_rccm_pos(2,:),[color{4} linestyle{4}],'Linewidth',line_wd);

% nominal trajectories
if sim_config.include_obs == 0
    h1 = plot(xnomTraj(1,:),xnomTraj(2,:),[color{1} linestyle{1}],'Linewidth',line_wd);
    h3 = plot(xTraj_rccm(1,:),xTraj_rccm(2,:),linestyle{3},'color',color{3},'Linewidth',line_wd);
    scatter(xnomTraj(1,1),xnomTraj(1,1), [color{1} 'o']);
    scatter(xnomTraj(1,end),xnomTraj(1,end),[color{1} '*']);
    
    scatter(xTraj_ccm(1,end),xTraj_ccm(2,end),[color{2} '*'])
    scatter(xTraj_rccm(1,end),xTraj_rccm(2,end),'*','MarkerEdgeColor',color{3});
    scatter(xTraj_rccm_pos(1,end),xTraj_rccm_pos(2,end),[color{4} '*']);
else
    h3 = plot(xTraj_rccm(1,:),xTraj_rccm(2,:),'-','color',color{3},'Linewidth',line_wd);
    h1 = plot(xnomTraj_ccm(1,:),xnomTraj_ccm(2,:),'k--','Linewidth',line_wd);
    scatter(xnomTraj_ccm(1,1),xnomTraj_ccm(1,1), 'ko');
    scatter(xnomTraj_ccm(1,end),xnomTraj_ccm(1,end),'k*');
    
    plot(xnomTraj_rccm(1,:),xnomTraj_rccm(2,:),'k--','Linewidth',line_wd);
    
    plot(xnomTraj_rccm_pos(1,:),xnomTraj_rccm_pos(2,:),'k--','Linewidth',line_wd);
end

if sim_config.include_obs == 0
    arrow = annotation('arrow',[0.15 0.25],[0.6 0.6],'Linewidth',2);
    txt_wind = text(-4.5,7.8,'Wind','Fontsize',13,'color','r');
    xlabel('$p_x$ (m)','interpreter','latex');
    ylabel('$p_z$ (m)','interpreter','latex')
else
    visualize_obs(obs); 
    arrow = annotation('arrow',[0.15 0.25],[0.55 0.55],'Linewidth',2);
    txt_wind = text(-3.6,5.9,'Wind','Fontsize',13,'color','r');
    xlabel('$p_x$ (m)','interpreter','latex');
    ylabel('$p_z$ (m)','interpreter','latex')
end

if sim_config.include_obs == 0
    legend([h1,h2,h3,h4,h2_tube,h3_tube,h4_tube],{'Nominal', 'CCM','RCCM','RCCM-P', 'Tube: CCM','Tube: RCCM','Tube: RCCM-P'},'Location','Southeast');
else
    legend([h1,h2,h3,h4,h2_tube,h3_tube,h4_tube],{'Nominal','CCM','RCCM','RCCM-P'},'Location','northwest');
end
goodplot([6 5]);
fig_name = ['traj' fig_name_com];

if print_file == 1
    savefig([fig_name '.fig']);
    print([fig_name '.pdf'], '-painters', '-dpdf', '-r150');
end

legend off
if sim_config.include_obs == 0
    ylim([6 12]);
    xlim([6 12]);
    
    text(6.2,9.8,'Wind','Fontsize',13,'color','r');
    goodplot([6 3]);
else
    ylim([3 8]);
    xlim([0 15]);
    txt_wind.Position =[0.5 6.5];
    arrow.Y = [0.58 0.58];
    goodplot([6 2.8]);
end
fig_name = [fig_name '_zoomin'];
if print_file == 1
    savefig([fig_name '.fig']);
    print([fig_name '.pdf'], '-painters', '-dpdf', '-r150');
end

