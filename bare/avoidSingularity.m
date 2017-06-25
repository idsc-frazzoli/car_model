function out = avoidSingularity(x) 
% to avoid singularity if the model
% code by edo

global params;

x(1) = deadZone(x(1), -params.Dz1, params.Dz1);
x(2) = deadZone(x(2), -params.Dz1, params.Dz1);
x(3) = deadZone(x(3), -params.Dz2, params.Dz2);


x(7) = deadZone(x(7), -params.Dz1/params.R, params.Dz1/params.R);
x(8) = deadZone(x(8), -params.Dz1/params.R, params.Dz1/params.R);
x(9) = deadZone(x(9), -params.Dz1/params.R, params.Dz1/params.R);
x(10) = deadZone(x(10), -params.Dz1/params.R, params.Dz1/params.R);

out = x;


end

