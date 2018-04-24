close all; clear;

name = "20180419T150253_7373f83e.csv";
name2 = "20180419T150253_7373f83e_joy.csv";
name3 = "anomalies_yannik_20180423T181849_633cc6e6.csv";
columns_name = ["time", "torque_speed_control_l",...
    "torque_speed_control_r", "rear_wheel_rate_l",... 
    "rear_wheel_rate_r",    "tangent_speed",...
    "angular_rate",    "angular_rate_proportional_to_steering_angle",...
    "joystick_head_avg","pure_pursuit_speed" ];
data_raw = csvread(name3);
data_struct = struct();
for i=1:length(columns_name)
    field = convertStringsToChars(columns_name(i));
    data_struct(1).(field) = data_raw(:, i);
end
t = data_struct(1).time;

%%

figure(1);
%subplot(2,1,1)
plot(t, data_struct(1).torque_speed_control_r, 'b');
hold on;
plot(t, data_struct(1).rear_wheel_rate_r*20, 'g');
grid on
%plot(t, data_struct(1).joystick_head_avg*1000, 'r');
plot(t, data_struct(1).pure_pursuit_speed*1000, 'k');

legend("torque speed control", "rear wheel rate",...
    "pure pursuit speed")
% %"joystick head avg"
    
title("torque speed control")
%subplot(2,1,2)
%plot(t, data_struct(1).rear_wheel_rate_r);
%title("rear wheel rate")


