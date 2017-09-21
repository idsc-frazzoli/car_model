% test the accuracy of the mex file

addpath(genpath('..'))
params = initialize_parameters_simple('carsim');

N = 10000;
k = N;
for (i=1:N)

x0 = [2*rand(1)-1 2*rand(1)-1 1+rand(1)*4];
u0 = [deg2rad(15*(2*rand(1)-1)) 2000*rand(1)];
x = threeStateModel(x0,u0, params);
xMex = threeStateModelMex(x0, u0);

if (norm(x-xMex,1) > 1e-3)
    k = k - 1;
end

end

fprintf('Testing, %d / %d examples passed \n', k, N);