% plots

close all
clc

translucency = 0.1;
axis equal
grid on
hold on
xLimDown = -75;
xLimUp = 75;
yLimDown = xLimDown;
yLimUp = xLimUp;
N = max(size(x));
for i=1:100:N;
    draw_car(x(i),y(i),ksi(i),car_params.frontL, car_params.rearL, car_params.width,1,translucency);
    xlim([xLimDown xLimUp])
    ylim([yLimDown yLimUp])   
end
h1 = draw_car( x(end),y(end),ksi(end),car_params.frontL, car_params.rearL, car_params.width,1,translucency);


%%

figure(1)
subplot(5,1,1)
plot(time, w1L)
hold on
grid on
ylabel('w1L [rad/s]')

subplot(5,1,2)
plot(time, w1R)
hold on
grid on
ylabel('w1R [rad/s]')

subplot(5,1,3)
plot(time, w2L)
hold on
grid on
ylabel('w2L [rad/s]')

subplot(5,1,4)
plot(time, w2R)
hold on
grid on
ylabel('w2R [rad/s]')




%%
figure(2)
subplot(5,1,1)
plot(time,Ux)
hold on
grid on
ylabel('U_x [m/s]')

subplot(5,1,2)
plot(time,Uy)
hold on
grid on
ylabel('U_y [m/s]')

subplot(5,1,3)
plot(time, atan2(Uy, Ux)*180/pi)
hold on
grid on
ylabel('slip angle [deg]')

subplot(5,1,4)
plot(time,r*180/pi)
hold on
grid on
ylabel('r [deg/s]')

subplot(5,1,5)
plot(time,ksi*180/pi)
hold on
grid on
ylabel('heading [deg]')
%plot(time, y, 'g');

figure(3)
scatter3(Ux, Uy,r);
xlabel('Ux [m/s]')
ylabel('Uy [m/s]')
zlabel('r [deg/s]')

figure(4)
scatter3(Uy,r, delta);
xlabel('Uy [m/s]')
ylabel('r [rad/s]')
zlabel('delta [rad]')

%%

% plot forces (tire forces)
% 
% figure
% subplot(4,1,1)
% plot(time, fy1L)
% hold on
% grid on
% ylabel('f1L [N]')
% 
% subplot(4,1,2)
% plot(time, fy1R)
% hold on
% grid on
% ylabel('f1R [N]')
% 
% subplot(4,1,3)
% plot(time, fy2L)
% hold on
% grid on
% ylabel('f2L [N]')
% 
% subplot(4,1,4)
% plot(time, fy2R)
% grid on
% ylabel('f2R [N]')
