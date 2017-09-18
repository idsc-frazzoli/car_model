function [x0,u0] = anonymous

params = ctype_hatchback;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%inital states 

speed = 30 + 3.6*params.Dz1; % km/h

% longitudinal and lateral speed in car coordiante frame [m/s]
state0.Ux0  = speed/3.6;
state0.Uy0  = 2;

% wheel speeds [rad/s], rear and front
state0.w1L0 = speed/3.6/params.R;
state0.w1R0 = speed/3.6/params.R;
state0.w2L0 = speed/3.6/params.R;
state0.w2R0 = speed/3.6/params.R;
% yawing rate [rad/s2]
state0.r0   = 0;

% coordiantes of the car [m]
state0.x0   = -50;
state0.y0   = -75;

%heading of the car [rad] TODO jan changed the comment to [rad]
state0.ksi0 = 1;


% [Ux Uy r Ksi x y w1L w1R w2L w2R]'
x0=[
state0.Ux0 %Ux velocity longitudinal
state0.Uy0 %Uy velocity lateral
state0.r0  %r = x(3);
state0.ksi0 %Ksi % x(4)
state0.x0 %x % x(5)
state0.y0 %y % x(6)
state0.w1L0 %w1L = x(7);
state0.w1R0 %w1R = x(8);
state0.w2L0 %w2L = x(9);
state0.w2R0 %w2R = x(10);
];

u0=zeros(4,1);

