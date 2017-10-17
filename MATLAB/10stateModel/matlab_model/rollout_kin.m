function [ x] = rollout_kin( x0, u, times, carParams)%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%Ux = 
%Ux is the integral of Fx forces / mass

%r= Ux * tan(delta) /(lr+lf)
%Uy = r*lr --> 

% x = 
%
%

Ux=X(1,plot_idx);
Uy=X(2,plot_idx);
r=X(3,plot_idx);
ksi=X(4,plot_idx);
x=X(5,plot_idx);
y=X(6,plot_idx);
w1L=X(7,plot_idx);
w1R=X(8,plot_idx);
w2L=X(9,plot_idx);
w2R=X(10,plot_idx);

end

