function simple
% provides params and init state to rollout function
close all
global params

clear statespacemodel

params = ctype_hatchback;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%inital states 
x0=x0_demo1

times = linspace(0,10,1000);

u_delta    =sin(times/2)*params.maxDeltaRate; % TODO the factor of rate is unrelated!
u_throttle =exp(-(times-5).^2);

u=zeros(4,length(times));
u(1,:)=u_delta;
u(4,:)=u_throttle;




x=statespacemodel( x0, u, times);

ext=[
times
];

visualization_ext(x, u, ext)

