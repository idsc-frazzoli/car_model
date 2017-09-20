function Fy = F_y(slip, Fx, Fz, mu, Ca)



eps = sqrt((mu * Fz)^2 - Fx^2)/ (mu*Fz);

slipCr= atan(3*eps*mu*Fz / Ca);

if (abs(slip) <= slipCr)
    Fy = -Ca* tan(slip) + ...
          Ca^2/(3*eps*mu*Fz) * abs(tan(slip)) *  tan(slip) - ...
          Ca^3/27/(eps*mu*Fz)^2 * tan(slip)^3;
else
    Fy = -eps*mu*Fz*sign(slip);
end




end