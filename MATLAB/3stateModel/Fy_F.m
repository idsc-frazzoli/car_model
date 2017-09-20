function FyF = Fy_F(beta, r, Ux, delta, par)


aF = a_F(beta, r, Ux, delta, par.a);
FzF = Fz_F(par.m, par.g, par.a, par.b);
FxF = 0;

if par.usePacejka
    FyF = F_yPaj([par.B, par.C, par.D]', aF, FxF, FzF, par.muF);
else
    FyF = F_y(aF, FxF, FzF, par.muF, par.CaF);
end

end