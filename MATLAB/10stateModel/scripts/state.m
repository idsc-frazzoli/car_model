%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sim_params_out] = state(sim_params, car_params)
%global car_params
%inital states 
%sim_params.vx_ini = 60;
%sim_params.vy_ini= 0;
%sim_params.r_ini=0;


sim_params.speed_ini = max(sim_params.vx_ini, 3.6*car_params.Dz1);

% longitudinal and lateral speed in car coordiante frame [m/s]
Ux0 = sim_params.speed_ini/3.6;
Uy0 = 0;

% wheel speeds [rad/s], rear and front
w1L0 = sim_params.speed_ini/3.6/car_params.R;
w1R0 = sim_params.speed_ini/3.6/car_params.R;
w2L0 = sim_params.speed_ini/3.6/car_params.R;
w2R0 = sim_params.speed_ini/3.6/car_params.R;
WF0 = sim_params.speed_ini/3.6/car_params.R;
WR0 = sim_params.speed_ini/3.6/car_params.R;
% yawing rate [rad/s2]
r0 = 0;

% coordiantes of the car [m]
x0 = 0;
y0 = 0;

%heading of the car [deg]
ksi0 = 0;

sim_params.x0= [
     Ux0;
     Uy0;
     r0;
     x0;
     y0;
     ksi0;
% wheel speeds [rad/s], rear and front
     w1L0;
     w1R0;
     w2L0;
     w2R0];

%%%%%%%%%%%%%%%%%%%
 
sim_params.Ts = 0.001;
sim_params.t_total=50;
sim_params.N=sim_params.t_total/sim_params.Ts;
sim_params.t=linspace(0,sim_params.t_total,sim_params.N);

sim_params_out= sim_params;
end