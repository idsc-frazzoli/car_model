function par =  initialize_parameters_simple(modelName)


par = [];

if strcmpi('hindiyeh', modelName)
    
    par =  initialize_parameters_Hindiyeh();
    return;
end


if strcmpi ('carsim', modelName)
   
    par = initialize_parameters_carSim();
    return;
end

error('Unknown model name');

end



function par = initialize_parameters_Hindiyeh()

%parameters for the car from Hindiyeh's thesis


par.m = 1724; % kg
par.I = 1300; % kgm^2
par.a = 1.35; % m distance to front axle
par.b = 1.15; % m distance to rear axle
par.CaF = 120000; % N/rad
par.CaR = 175000; % N/rad
par.muF = 0.55;
par.muR = 0.53;
par.g = 9.81; %m/s^2

% pacejka model parameters
par.B = 20.5667;    %optimization result
par.C = 1.1753;
par.D = 0.5560;

par.usePacejka = false;

end

function par = initialize_parameters_carSim()

%parameters for the car from Edo's master thesis
%this is a C type hatchback in CarSim



% mass [kg]
par.m = 1412;

% yawing moment of inertia [kgm2]
par.Iz = 1536.7 + 427.7084; % sprung mass inertia + unsprung mass inertia


% front axle distance from COG [m]
par.a = 1.015;

% rear axle distanc from COG [m]
par.b = 1.895;



% pacejka model parameters
% 1 - for frint tires, 2 - rear tires
par.B1 = 13.8509; par.C1 = 1.367; par.D1 = 0.9622;
par.B2 = 14.1663; par.C2 = 1.3652; par.D2 = 0.9744;
par.B = (par.B1 + par.B2)/2;
par.C = (par.C1 + par.C2)/2;
par.D = (par.D1 + par.D2)/2;


% gravitational acceleration [m/s2]
par.g = 9.81;

% tire road friction coefficient
par.mu = 0.85;

par.CaF = NaN; % do not use these params for now
par.CaR = NaN; % do not use these params for now

par.muF = 0.55;
par.muR = 0.53;

par.usePacejka = true;


end
