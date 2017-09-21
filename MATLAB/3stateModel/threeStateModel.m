function [dx] = threeStateModel(x0,u0, params)

% this is obsolete and no longer maintained
% you are encouraged to use mex version instead

beta = x0(1);
r = x0(2);
Ux = x0(3);

delta = u0(1);
FxR = u0(2);


FyF = Fy_F(beta, r, Ux, delta, params);
FyR = Fy_R(beta, r, Ux, FxR, params);

dbeta = (FyF + FyR) / (params.m * Ux) - r;
dr = (params.a * FyF - params.b * FyR) / params.Iz;
dUx = (FxR - FyF * sin(delta)) / params.m + r * Ux * beta;


dx = [dbeta, dr, dUx]';

end
