function [brakeTorques] = brakes(x, u, tireForces)
% code by edo

global params;

brakeCmd = u(2);
handbrakeCmd = u(3);

Tb1L = 0;
Tb1R = 0;
Tb2L = 0;
Tb2R = 0;

fx1L = tireForces(1);
fx1R = tireForces(2);
fx2L = tireForces(3);
fx2R = tireForces(4);

w1L = x(7);
w1R = x(8);
w2L = x(9);
w2R = x(10);

masterPress = params.maxPress * brakeCmd;
pressF = masterPress;

%valve proportioning
if masterPress <= 1.5
    pressR = masterPress;
else
    pressR = 0.3 * masterPress + 1.05;
end

if masterPress > 0
    
    if w1L ~= 0
        Tb1L = - pressF * params.press2torF*sign(w1L);
    else
        Tb1L = fx1L * params.R;
    end
    
    if w1R ~= 0
        Tb1R = - pressF * params.press2torF*sign(w1R);
    else
        Tb1R = fx1R * params.R;
    end
    
    if w2L ~= 0
        Tb2L = Tb2L - pressR * params.press2torR*sign(w2L);
    else
        Tb2L = fx2L * params.R;
    end
    
    if w2R ~= 0
        Tb2R = Tb2R - pressR * params.press2torR*sign(w2R);
    else
        Tb2R = fx2R * params.R;
    end
end

if handbrakeCmd > 0
    
    if w2L ~= 0
        Tb2L = Tb2L - handbrakeCmd * params.maxThb*sign(w2L);
    else
% TODO check with edo if this is a mistake: missing "Tb2L - "
        Tb2L = fx2L * params.R;
    end
    
    if w2R ~= 0
        Tb2R = Tb2R - handbrakeCmd * params.maxThb*sign(w2R);
    else
% TODO check with edo if this is a mistake: missing "Tb2R - "
        Tb2R = fx2R * params.R;
    end
end

brakeTorques = [Tb1L, Tb1R, Tb2L, Tb2R];
brakeTorques = brakeTorques(:);


end

