function [torques] = motorTorques(u)
% code by edo

global params;


throttleCmd = u(4);

reqTorque = params.maxTm * throttleCmd;

Tm1L = (1-params.gammaM) * reqTorque;
Tm1R = Tm1L;
Tm2L = params.gammaM * reqTorque;
Tm2R = Tm2L;

torques = [Tm1L; Tm1R; Tm2L; Tm2R];

end

