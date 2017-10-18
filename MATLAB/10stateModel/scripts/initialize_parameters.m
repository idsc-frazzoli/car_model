%%%%%%%%
% initialization of parameters
% these are valid for C-type hatchback that can be found in 
% CarSim libraries

global car_params;

% mass [kg]
car_params.m = 1412;

% yawing moment of inertia [kgm2]
car_params.Iz = 1536.7 + 427.7084; % sprung mass inertia + unsprung mass inertia

% wheel moment of inertia [kgm2]
car_params.Iw = 0.9;

% dimensions for the car

% distance from COG to front end [m]
car_params.frontL = 1.915;

% distance from COG to rear end [m]
car_params.rearL = 2.835;

% width of the vehicle [m]
car_params.width = 1.916;

% front axle distance from COG [m]
car_params.lF = 1.015;

% rear axle distanc from COG [m]
car_params.lR = 1.895;

% lateral distance of wheels from COG [m]
car_params.lw = 1.675/2;

% height of COG [m]
car_params.h = 0.54;

% wheel radius [m]
car_params.R = 0.325;

% pacejka model parameters
% 1 - for frint tires, 2 - rear tires
car_params.B1 = 13.8509; car_params.C1 = 1.367; car_params.D1 = 0.9622;
car_params.B2 = 14.1663; car_params.C2 = 1.3652; car_params.D2 = 0.9744;
% car_params.B = (car_params.B1 + car_params.B2)/2;
% car_params.C = (car_params.C1 + car_params.C2)/2;
% car_params.D = (car_params.D1 + car_params.D2)/2;
% car_params.B1 = 7; car_params.C1 = 1.4; car_params.D1 = 1;
% car_params.B2 = 7; car_params.C2 = 1.4; car_params.D2 = 1;

% maximal steering angle [deg]
car_params.maxDelta = 30*pi/180;

% Nm per Mpa conversion constant [Nm/Mpa] for Front and Rear brakes
car_params.press2torF = 250;
car_params.press2torR = 150;

% max handbrake torque [Nm]
car_params.maxThb = 2000;

% maximal master cylinder presure [MPa]
car_params.maxPress = 13;

% maximal motor torque [Nm], with gears included
car_params.maxTm = 1000;

%rear/total drive ratio; 0 is FWD, 1 is RWD
car_params.gammaM = 0;

% gravitational acceleration [m/s2]
car_params.g = 9.81;

% tire road friction coefficient
car_params.mu = 0.53;

%rolling friction coefficient
car_params.muRoll = 0;

% dynamic friction coefficient N/(m/s)
car_params.b = 5;
car_params.fric = 47;   %coulomb friction

% tolerance below which is speed considered 0
eps = 1e-4;

% dead zone tOLERANCE
car_params.Dz1 = 0.05;
car_params.Dz2 = 1*pi/180;

% sampling time for MPC  [s]
car_params.T = 0.1;


car_params.maxDeltaRate = 50 * pi/180; % rad/s TODO confirm with @jelavice
car_params.maxBrakeRate = 5; % 1/s
car_params.maxHandbrakeRate = 5; % 1/s
car_params.maxThrottleRate = 5; % 1/s

%%%%%%%%%%%%%%%%%%%%%%%%%%%%


