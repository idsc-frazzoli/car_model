function FyPaj = F_yPaj(x, slip, Fx, Fz, mu)

B = x(1);
C = x(2);
D = x(3);

global YALMIP


if (isempty(YALMIP) || YALMIP == false)

    %this is creating problems in YALMIP
    if (mu*Fz < Fx)
        eps = 0;
    else
        eps = sqrt((mu * Fz)^2 - Fx^2)/ (mu*Fz);
    end
    
    FyPaj = -  eps * Fz * mu * D * sin( C * atan( B * slip ) ) ;
    
else
    
    %reformulation for YALMIP
    eps = ((mu * Fz)^2 - Fx^2)^0.5 / (mu*Fz);
    FyPaj = - eps * D * sin( C * atan( B * slip ) );
      
end

end