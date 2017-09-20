function [torques] = motorTorques(u)
% code by edo

global params;


throttleCmd = u(4);

% TODO check if sum of tmXY ==  throttleCmd
% if so, divive by 2 could be appropriate

reqTorque = params.maxTm * throttleCmd;

Tm1L = (1-params.gammaM) * reqTorque;
Tm1R = Tm1L;
Tm2L = params.gammaM * reqTorque;
Tm2R = Tm2L;

torques = [Tm1L; Tm1R; Tm2L; Tm2R];

end

