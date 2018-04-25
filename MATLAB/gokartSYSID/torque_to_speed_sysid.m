close all; clear;

columns_name = ["time", "torque_speed_control_l",...
    "torque_speed_control_r", "rear_wheel_rate_l",... 
    "rear_wheel_rate_r",    "tangent_speed",...
    "angular_rate",    "angular_rate_proportional_to_steering_angle"];
name1 = "pursuit_20180307T154859.csv" ;
name2 = "gokart_rimo_prbs/20180418T132333_bca165ae_prbs3.csv";
data_raw = csvread(name2);
data_struct = struct();
for i=1:length(columns_name)
    field = convertStringsToChars(columns_name(i));
    data_struct(1).(field) = data_raw(:, i);
end

%% first ignorant approach fft -> etf
t = data_struct(1).time;

Ts = 0.01;
Fs = 1/Ts;

t_resample = (t(1):Ts:t(end))';
N = length(t_resample);
f = Fs*(0:(N/2))/N;
u_raw = (data_struct(1).torque_speed_control_l + ...
        data_struct(1).torque_speed_control_r)/2;
y_raw = (data_struct(1).rear_wheel_rate_l + ...
        data_struct(1).rear_wheel_rate_r)/2;
u = interp1(t, u_raw, t_resample,'spline');
y = interp1(t, y_raw, t_resample,'spline');

U = fft(u);
Y = fft(y);
omega = (2*pi/N)*(0:N-1)';
idx = find(omega > 0 & omega < pi);

figure(1);
subplot(2,1,1)
plot(omega(idx),abs(U(idx)))
title("raw fft U");
subplot(2,1,2)
plot(omega(idx),abs(Y(idx)))
title("raw fft Y");
set(1,'Position',[100, 100, 1000, 1000])
Gest = Y./U; % ETFE estimate

%% Plots
figure(2);

subplot(2,2,1)
loglog(f(1:end-1),abs(Gest(idx)))

subplot(2,2,2)
loglog(f(1:end-1),angle(Gest(idx)))

 subplot(2,2,3)
 semilogx(f(1:end-1),abs(Gest(idx)))
% 
 subplot(2,2,4)
 semilogx(f(1:end-1),angle(Gest(idx)))

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
