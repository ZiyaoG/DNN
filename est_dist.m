function [xhat_dot,sigmahat]= est_dist(x, xhat,u,al,m_nom,a_pred, f2_nom, f0_nom, f1_nom,adapt_gain)
xtilde = xhat-x;

xdes_dot = acc_dynamics(x,u,al,m_nom,f0_nom,f1_nom,f2_nom);

sigmahat = adapt_gain*xtilde; 

xhat_dot = xdes_dot + sigmahat- a_pred*xtilde;

% sigmahat = sigmahat(1);  % matched part
end
