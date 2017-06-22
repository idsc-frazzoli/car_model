function visualization_ext(x,u,ext)

%[Ux Uy r Ksi x y w1L w1R w2L w2R]'

Ux  =x( 1,:);
Uy  =x( 2,:);
r   =x( 3,:);
Ksi =x( 4,:);
px  =x( 5,:);
py  =x( 6,:);
w1L =x( 7,:);
w1R =x( 8,:);
w2L =x( 9,:);
w2R =x(10,:);

u_delta   =u(1,:);
u_throttle=u(4,:);

times = ext(1,:);

%%%%%%%%%%%%%%%%%%%%%
figure(1)
hold all
plot(px,py)
dx=cos(Ksi);
dy=sin(Ksi);
dsx=cos(Ksi+u_delta);
dsy=sin(Ksi+u_delta);
for k=1:20:length(times)
  ox = [px(k) px(k)+dx(k)];
  oy = [py(k) py(k)+dy(k)];
  plot(ox, oy,'k')

  ox = [px(k) px(k)+dsx(k)];
  oy = [py(k) py(k)+dsy(k)];
  plot(ox, oy,'g')
end
axis equal

%%%%%%%%%%%%%%%%%%%%%
figure(2)
subplot(2,1,1); 
hold all
plot(times, w1L,'b');
plot(times, w1R,'r:');  
legend('w1L','w1R')

subplot(2,1,2); 
hold all
plot(times, w2L,'b');
plot(times, w2R,'r:');  
legend('w2L','w2R')

%%%%%%%%%%%%%%%%%%%%%
figure(3)
subplot(3,1,1)
hold all
plot(times, Ux,'b')
plot(times, Uy,'r')
legend('Ux','Uy')
subplot(3,1,2)
hold all
plot(times, Ksi * 180 / pi,'b')


%%%%%%%%%%%%%%%%%%%%%
figure(4)
subplot(2,1,1)
plot(times, u_delta,'b')
legend('u_delta')

subplot(2,1,2)
plot(times, u_throttle,'b')
legend('u_throttle')

