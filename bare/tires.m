function [ FORCES, forces] = tires(x,u)
% code by edo
%#codegen

global params;

eps = 1e-4;

Ux = x(1);
Uy = x(2);
r = x(3);
w1L = x(7);
w1R = x(8);
w2L = x(9);
w2R = x(10);

delta = u(1);


Ux1L = (Ux - r*params.lw)*cos(delta) + (Uy + r*params.lF)*sin(delta);
Uy1L = -(Ux - r*params.lw)*sin(delta) + (Uy + r*params.lF)*cos(delta);

Ux1R = (Ux + r*params.lw)*cos(delta) + (Uy + r*params.lF)*sin(delta);
Uy1R = -(Ux + r*params.lw)*sin(delta) + (Uy + r*params.lF)*cos(delta);

Ux2L = Ux - r*params.lw;
Uy2L = Uy - r*params.lR;

Ux2R = Ux + r*params.lw;
Uy2R = Uy - r*params.lR;


Sx1L = robustDiv2(Ux1L - params.R*w1L, params.R*w1L, eps);
Sy1L = (1+Sx1L) * robustDiv2(Uy1L, Ux1L, eps);

Sx1R = robustDiv2(Ux1R - params.R*w1R, params.R*w1R, eps);
Sy1R = (1+Sx1R) * robustDiv2(Uy1R, Ux1R, eps);

Sx2L = robustDiv2(Ux2L - params.R*w2L, params.R*w2L, eps);
Sy2L = (1+Sx2L) * robustDiv2(Uy2L, Ux2L, eps);

% TODO @jelavice check: change from  Ux1R  to  Ux2R
Sx2R = robustDiv2(Ux2R - params.R*w2R, params.R*w2R, eps);
Sy2R = (1+Sx2R) * robustDiv2(Uy2R, Ux2R, eps);

%S1L = sqrt( (Sx1L)^2 + (Sy1L)^2 );
%S1R = sqrt( (Sx1R)^2 + (Sy1R)^2 );
%S2L = sqrt( (Sx2L)^2 + (Sy2L)^2 );
%S2R = sqrt( (Sx2R)^2 + (Sy2R)^2 );

S1L = hypot(Sx1L, Sy1L);
S1R = hypot(Sx1R, Sy1R);
S2L = hypot(Sx2L, Sy2L);
S2R = hypot(Sx2R, Sy2R);


mu1L = pacejka(params.B1, params.C1, params.D1, S1L); % params.D1*sin(params.C1*atan(params.B1*S1L));
mu1R = pacejka(params.B1, params.C1, params.D1, S1R); % params.D1*sin(params.C1*atan(params.B1*S1R));
mu2L = pacejka(params.B2, params.C2, params.D2, S2L); % params.D2*sin(params.C2*atan(params.B2*S2L));
mu2R = pacejka(params.B2, params.C2, params.D2, S2R); % params.D2*sin(params.C2*atan(params.B2*S2R));

mux1L = - mu1L * robustDiv(Sx1L,S1L,eps);
muy1L = - mu1L * robustDiv(Sy1L,S1L,eps);

mux1R = - mu1R * robustDiv(Sx1R,S1R,eps);
muy1R = - mu1R * robustDiv(Sy1R,S1R,eps);

mux2L = - mu2L * robustDiv(Sx2L,S2L,eps);
muy2L = - mu2L * robustDiv(Sy2L,S2L,eps);

mux2R = - mu2R * robustDiv(Sx2R,S2R,eps);
muy2R = - mu2R * robustDiv(Sy2R,S2R,eps);



C1 = -params.mu*mux1L*params.h*sin(delta);
C2 = -params.mu*muy1L*params.h*cos(delta);
C3 = -params.mu*mux1R*params.h*sin(delta);
C4 = -params.mu*muy1R*params.h*cos(delta);
C5 = -params.mu*muy2L*params.h;
C6 = -params.mu*muy2R*params.h;
%
K1 = params.mu*mux1L*params.h*cos(delta);
K2 = params.mu*muy1L*params.h*sin(delta);
K3 = params.mu*mux1R*params.h*cos(delta);
K4 = params.mu*muy1R*params.h*sin(delta);
K5 = params.mu*mux2L*params.h;
K6 = params.mu*mux2R*params.h;
%
A = -params.lw - C1 - C2;
B = params.lw - C3 - C4;
C = -params.lw - C5;
D = params.lw - C6;
E = K1 - K2 - params.lF;
F = K3 - K4 - params.lF;
G = K5 + params.lR;
H = K6 + params.lR;

den = 2*(A*F - E*B - A*G + E*C + B*H - D*F - C*H + D*G);

Fz1L =   params.m*params.g*(B*G - C*F + B*H - D*F - C*H + D*G)/den;
Fz1R = - params.m*params.g*(A*G - E*C + A*H - E*D + C*H - D*G)/den;
Fz2L =   params.m*params.g*(A*F - E*B + A*H - E*D + B*H - D*F)/den;
Fz2R =   params.m*params.g*(A*F - E*B - A*G + E*C - B*G + C*F)/den;


fx1L = params.mu*Fz1L*mux1L;
fy1L = params.mu*Fz1L*muy1L;

fx1R = params.mu*Fz1R*mux1R;
fy1R = params.mu*Fz1R*muy1R;

fx2L = params.mu*Fz2L*mux2L;
fy2L = params.mu*Fz2L*muy2L;

fx2R = params.mu*Fz2R*mux2R;
fy2R = params.mu*Fz2R*muy2R;


% now change coordinate system

Fx1L = fx1L*cos(delta) - fy1L*sin(delta);
Fy1L = fx1L*sin(delta) + fy1L*cos(delta);

Fx1R = fx1R*cos(delta) - fy1R*sin(delta);
Fy1R = fx1R*sin(delta) + fy1R*cos(delta);

Fx2L = fx2L;
Fy2L = fy2L;

Fx2R = fx2R;
Fy2R = fy2R;

%this is in the car coordinate frame
FORCES = [Fx1L, Fx1R, Fx2L, Fx2R, Fy1L, Fy1R, Fy2L, Fy2R, Fz1L, Fz1R, Fz2L, Fz2R];
FORCES = FORCES(:);
%this are in the tire coordinate frame
forces = [fx1L, fx1R, fx2L, fx2R, fy1L, fy1R, fy2L, fy2R];
forces = forces(:);


end

