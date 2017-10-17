%global car_params
%global sim_params
close all
clear all
clear car_params
clear sim_params
X=[];
U=[];

initialize_parameters
sim_params.vx_ini = 0; %km/h
sim_params.vy_ini= 0; %km/h
sim_params.r_ini=0;

sim_params= state(sim_params, car_params);

% u = [delta brake handbrake throttle]'

% 0.2*sin(0.1*sim_params.t)
% 0.1*linspace(1
%% Exp 1
sim_params.vx_ini =5; %km/h
sim_params.vy_ini= 0; %km/h
sim_params.r_ini=0;

sim_params.u(1,:) = 0.2*ones(1,sim_params.N); 
sim_params.u(2,:) = zeros(1,sim_params.N);   
sim_params.u(3,:) = zeros(1,sim_params.N);
sim_params.u(4,:) = linspace(0,0.3, sim_params.N); %

sim_params= state(sim_params, car_params);
X=  [X rollout(sim_params.x0, sim_params.u , sim_params.t, car_params)];
U= [U sim_params.u];
%% Exp 2
if (false)
sim_params.vx_ini = 5; %km/h
sim_params.vy_ini= 0; %km/h
sim_params.r_ini=0;

sim_params.u(1,:) = 0.3*zeros(1,sim_params.N); 
sim_params.u(2,:) = zeros(1,sim_params.N);   
sim_params.u(3,:) = zeros(1,sim_params.N);
sim_params.u(4,:) =  0.5*ones(1,sim_params.N);%linspace(0,0.3, sim_params.N); %0.1*ones(1,sim_params.N); %;%

sim_params= state(sim_params, car_params);
X=  [X rollout(sim_params.x0, sim_params.u , sim_params.t, car_params)];
U= [U sim_params.u];

end

%% Exp 3
if (false)
sim_params.vx_ini = 30; %km/h
sim_params.vy_ini= 0; %km/h
sim_params.r_ini=0;

sim_params.u(1,:) = 0.3*zeros(1,sim_params.N); 
sim_params.u(2,:) = zeros(1,sim_params.N);   
sim_params.u(3,:) = zeros(1,sim_params.N);
sim_params.u(4,:) =  0.5*ones(1,sim_params.N);%linspace(0,0.3, sim_params.N); %0.1*ones(1,sim_params.N); %;%

sim_params= state(sim_params, car_params);
X=  [X  rollout(sim_params.x0, sim_params.u , sim_params.t, car_params)];
U= [U sim_params.u];

end
%% Exp 4
if (false)
sim_params.vx_ini = 5; %km/h
sim_params.vy_ini= 0; %km/h
sim_params.r_ini=0;

sim_params.u(1,:) = 0.5*ones(1,sim_params.N); 
sim_params.u(2,:) = zeros(1,sim_params.N);   
sim_params.u(3,:) = zeros(1,sim_params.N);
sim_params.u(4,:) = linspace(0,0.2, sim_params.N); %0.1*ones(1,sim_params.N); %;%

sim_params= state(sim_params, car_params);
X=  [X  rollout(sim_params.x0, sim_params.u , sim_params.t, car_params)];
U= [U sim_params.u];

end

%%
%circle tests ramping up throtle, with different fixed steering


%%
plot_params.Ts=0.001;
plot_idx = 1:plot_params.Ts/sim_params.Ts:size(X,2);
Ux=X(1,plot_idx);
Uy=X(2,plot_idx);
r=X(3,plot_idx);
ksi=X(4,plot_idx);
x=X(5,plot_idx);
y=X(6,plot_idx);
w1L=X(7,plot_idx);
w1R=X(8,plot_idx);
w2L=X(9,plot_idx);
w2R=X(10,plot_idx);
delta = U(1,:);
brake = U(2,:);
handbrake = U(3,:);
throttle = U(4,:);

time=plot_params.Ts*plot_idx;
visualization
