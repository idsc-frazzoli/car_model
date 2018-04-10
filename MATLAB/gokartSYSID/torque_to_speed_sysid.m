close all; clear;

columns_name = ["time", "torque_speed_control_sx",...
    "torque_speed_control_rx", "rear_wheel_rate_sx",... 
    "rear_wheel_rate_rx",    "tangent_speed",...
    "angular_rate",    "angular_rate_proportional_to_steering_angle"];
data_raw = csvread("pursuit_20180307T154859.csv");
data_struct = struct();
for i=1:length(columns_name)
    field = convertStringsToChars(columns_name(i));
    data_struct(1).(field) = data_raw(:, i);
end

%% first ignorant approach fft -> etf
t = data_struct(1).time;
N = length(t);
Ts = mean(diff(t));
Fs = 1/Ts;
f = Fs*(0:(N/2))/N;
u = data_struct(1).torque_speed_control_rx;
y = data_struct(1).tangent_speed;

U = fft(u);
Y = fft(y);
omega = (2*pi/N)*(0:N-1)';
idx = find(omega > 0 & omega < pi);

figure(1);
subplot(2,1,1)
loglog(omega(idx),abs(U(idx)))
subplot(2,1,2)
loglog(omega(idx),abs(Y(idx)))
Gest = Y./U; % ETFE estimate

%% Plots
figure(2);

subplot(2,2,1)
loglog(omega(idx),abs(Gest(idx)))

subplot(2,2,2)
semilogx(omega(idx),angle(Gest(idx)))

% subplot(2,2,3)
% semilogy(f,abs(Gest(idx)))
% 
% subplot(2,2,4)
% plot(f,angle(Gest(idx)))

% https://it.mathworks.com/help/ident/ref/etfe.html

%% Controller PI
z = tf('z',Ts);
Ki = 20; % [Nm/rad]
Kp = 20; % [Nm*s/rad]

C_pi = Kp + Ki*1/z;


%% With sysid toolbox
data = iddata(y,u,Ts);
ge = etfe(data);
gs = spa(data);
figure(3);
bode(ge,gs);

%% FFT check
figure(4);
plot(omega(idx), abs(U(idx)));
