clear;
close all;

% 00_1010

% load('sim_deccm_lam_0.8_w_dist_1_100_010_w_obs.mat')
% load('sim_deccm_lam_0.8_w_dist_1_withnn__00_1010_w_obs.mat')
% load('sim_deccm_lam_0.8_w_dist_1_with_true_nn__00_1010_w_obs.mat')

% load('sim_deccm_lam_0.8_w_dist_1_60_7.510_w_obs.mat')
% load('sim_deccm_lam_0.8_w_dist_1_withnn__60_7.510_w_obs.mat')
load('sim_deccm_lam_0.8_w_dist_1_with_true_nn__60_7.510_w_obs.mat')

dt = sim_config.step_size;
u_size = size(uTraj);
cost = 0.0;
for i = 1:u_size(2)
    u_t = uTraj(:,i);
    cost_t = u_t(1)^2+u_t(2)^2;
    cost = cost + cost_t*dt;
end
disp(cost)
%% results
y = [136.8553 136.8553; 138.0294 132.8969; 132.7243 130.1325];
h = bar(y);
ylim([125 140])
name = {'No Learning';'Imperfect Learning';'Perfect Learning'};
set(gca,'xticklabel',name)
ylabel('Cost')
set(h, {'DisplayName'}, {'Task 1','Task 2'}')
% Legend will show names for each color
legend() 
goodplot([6 5])
print('Comparing Cost.pdf', '-painters', '-dpdf', '-r150');
