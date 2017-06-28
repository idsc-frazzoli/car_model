function [ x] = statespacemodel( x0, u, times)
% code by edo
% forward integrates the car model in time
% params: -x0[in] - initial state
%         -u [in] - vector of inputs, dimension is p x N where p id num
%            inputs and N is the number of samples
%         -times [in] - vector of times to integrate (over dimension N)
%         -params [global] - structure contatinig all the parameters of the
%            car
%         -x [out] - trajectory dimensin is n x N where n id the number of 
%            states and N is the number od samples   
%
%  CALLER OF THIS FUNCTION MUST CLEAR THE PERSISTENT VARIABLES WITHIN 
%   THE FUNCTION BETWEEN TWO CALLS (command: clear rollout)

global params;
global h;

if (size(u, 2) ~= length(times))
    error('time and input vecotr are not the right dimensions');
end

N = length(times);

h = times(2) - times(1);
for i =2:N
    if times(i) > times(i-1)
        if abs( times(i) - times(i-1) - h) > 1e-5
            error('Times are not equidistant');
        end
    else
        error('Times are not monotonically increasing');
    end
end


x = zeros(size(x0,1),N);
x(:,1) = x0;

for i=2:N
      
    x(:,i) = euler(@f, x(:,i-1), u(:,i), h);
    %x(:,i) = rungeKutta(@f, x(:,i-1), u(:,i), h);
              
end

end

function next = euler(f, current, input,h)  %this is implemented properly

global params;
persistent xInt;
if isempty(xInt)
    xInt = current;
end

next = limitIntegrators(xInt + h * f(current, input));
xInt = next;
next = avoidSingularity(next);

end

function next = rungeKutta(f, current, input, h)    % not sure whether this is properly implemented

global params;
persistent xInt;
if isempty(xInt)
    xInt = current;
end


k1 = f(current, input);

x = current + h/2*k1;
x = avoidSingularity(x);
k2 = f(x, input);

x = current + h/2*k2;
x = avoidSingularity(x);
k3 = f(x, input);

x = current + h*k3;
x = avoidSingularity(x);
k4 = f(x, input);

next = limitIntegrators(xInt + (1/6)*(k1+2*k2+2*k3+k4)*h);
xInt = next;
next = avoidSingularity(next);

end




function [dX] = f(x, u) %evaluates the derivative of the car dynamics


% params is a structure others are vectors
% state vector [Ux Uy r Ksi x y w1L w1R w2L w2R]'
% input vector [delta brake handbrake throttle]'

global params;
persistent uPrev;

if isempty(uPrev)
    uPrev = u;
end

% x(1) = deadZone(x(1), -params.Dz1, params.Dz1);
% x(2) = deadZone(x(2), -params.Dz1, params.Dz1);
% x(3) = deadZone(x(3), -params.Dz2, params.Dz2);
%
%
% x(7) = deadZone(x(7), -params.Dz1/params.R, params.Dz1/params.R);
% x(8) = deadZone(x(8), -params.Dz1/params.R, params.Dz1/params.R);
% x(9) = deadZone(x(9), -params.Dz1/params.R, params.Dz1/params.R);
% x(10) = deadZone(x(10), -params.Dz1/params.R, params.Dz1/params.R);

u(1) =rateLimiter(u(1), uPrev(1), params.maxDeltaRate);
u(2) =rateLimiter(u(2), uPrev(2), params.maxBrakeRate);
u(3) =rateLimiter(u(3), uPrev(3), params.maxHandbrakeRate);
u(4) =rateLimiter(u(4), uPrev(4), params.maxThrottleRate);

[ FORCES, forces] = tires(x,u);
[brakeTorques] = brakes(x, u, forces);
[torques] = motorTorques(u);

rollFric = params.m*params.g*params.muRoll;
du = 1/params.m*(deadZone(sum(FORCES(1:4)) + params.m*x(3)*x(2), -rollFric, rollFric)  - coulombFriction(x(1)));
% TODO ask about 0*fric
dv = 1/params.m*(deadZone(sum(FORCES(5:8)) - params.m*x(1)*x(3), -rollFric, rollFric) -  0*coulombFriction(x(2)));
dr = 1/params.Iz * (params.lF*(sum(FORCES(5:6))) - params.lR*(sum(FORCES(7:8))) + params.lw * (FORCES(2) + FORCES(4) - FORCES(1) - FORCES(3)));
dKsi = x(3);
dx = x(1) * cos(x(4)) - x(2) * sin(x(4));
dy = x(1) * sin(x(4)) + x(2) * cos(x(4));
dw1L = 1/params.Iw * (torques(1) + brakeTorques(1) - forces(1)*params.R);
dw1R = 1/params.Iw * (torques(2) + brakeTorques(2) - forces(2)*params.R);
dw2L = 1/params.Iw * (torques(3) + brakeTorques(3) - forces(3)*params.R);
dw2R = 1/params.Iw * (torques(4) + brakeTorques(4) - forces(4)*params.R);

dX = [du dv dr dKsi dx dy dw1L dw1R dw2L dw2R]';

uPrev = u;
end



