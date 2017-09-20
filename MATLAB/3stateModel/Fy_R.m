function FyR = Fy_R(beta, r, Ux, FxR, par)


aR = a_R(beta, r, Ux, par.b);
FzR = Fz_R(par.m, par.g, par.a, par.b);

if par.usePacejka
    FyR = F_yPaj([par.B, par.C, par.D]', aR, FxR, FzR, par.muR);
else
    FyR = F_y(aR, FxR , FzR, par.muR, par.CaR);
end

end
