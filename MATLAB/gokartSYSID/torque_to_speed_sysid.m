close all; clear;

columns_name = ["time", "torque_speed_control_sx",...
    "torque_speed_control_rx", "rear_wheel_rate_sx",... 
    "rear_wheel_rate_rx",    "tangent_speed",...
    "angular_rate",    "angular_rate_proportional_to_steering_angle"];
data_raw = csvread("pursuit_20180307T154859.csv");
data = struct();
for i=1:size(columns_name,2)
    field = convertStringsToChars(columns_name(i));
    data(1).(field) = data_raw(:, i);
end