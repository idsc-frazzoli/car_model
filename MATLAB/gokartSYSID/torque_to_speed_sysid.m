close all; clear;

columns_name = ["time", "torque_speed_control_sx",...
    "torque_speed_control_rx", "rear_wheel_rate_sx",... 
    "rear_wheel_rate_rx",    "tangent_speed",...
    "angular_rate",    "angular_rate_proportional_to_steering_angle"];
data_raw = csvread("pursuit_20180307T154859.csv");
data = struct();
for i=1:length(columns_name)
    field = convertStringsToChars(columns_name(i));
    data(1).(field) = data_raw(:, i);
end

%% first ignorant approach fft -> etf
N = length(data_raw);
Ts = mean(diff(data(1).time));
Fs = 1/Ts;
f = Fs*(0:(N/2))/N;

U = fft(data(1).torque_speed_control_rx);
Y = fft(data(1).tangent_speed);
omega = (2*pi/N)*(0:N-1)';
idx = find(omega > 0 & omega < pi);
loglog(omega(idx),abs(U(idx)))
loglog(omega(idx),abs(Y(idx)))
Gest = Y./U; % ETFE estimate

%% Plots
figure(1);

subplot(2,2,1)
loglog(omega(idx),abs(Gest(idx)))

subplot(2,2,2)
semilogx(omega(idx),angle(Gest(idx)))

% subplot(2,2,3)
% semilogy(f,abs(Gest(idx)))
% 
% subplot(2,2,4)
% plot(f,angle(Gest(idx)))
