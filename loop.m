clc;
clear ;
close all;

%% LOOP 

%Variables
h0 = 125;
N = 750;
theta = linspace (0,360,N);
R = 30;
g = 9.81;
x0 = 0;
y0 = 0;
z0 = 60;


%Eq of Circle
x = (R*cosd(theta)) + x0;
z = (R*sind(theta) + R) + z0;
y = zeros(1,length(x)) + y0;

% G Force at different locations\
v = sqrt(2*g*(h0-z));

G_top = (2*(h0-2*R)/(R)) -1;
G_bot = (2*h0/R) +1;
G_force = ((v.^2)./(g.*R))-sind(theta);

len_curve = sum(vecnorm(diff( [x(:),z(:)] ),2,2));
position_vec = linspace(0, len_curve, N);

%% PLOTTING

subplot(3,1,1)
plot(position_vec, G_force)
grid on;
ylim([-1 6])
xlabel('Position (m)');
ylabel('G-Force Up/Dowm (Gs)');

subplot(3,1,2)
lat_gs = zeros(length(position_vec));
plot(position_vec, lat_gs)
grid on;
ylim([-3 3])
xlabel('Position (m)');
ylabel('G-Force Lateral (Gs)');

subplot(3,1,3)
lat_gs = zeros(length(position_vec),1);
plot(position_vec, lat_gs)
grid on;
ylim([-4 5])
xlabel('Position (m)');
ylabel('G-Force Forward/Back (Gs)');

%G-Force Plot
figure();
scatter3(x,y,z,[],G_force)
colormap;
cb = colorbar();
ylabel(cb,'G-Force')
ylabel('Y Positon')
xlabel('X Position')
zlabel('Z Position')

%Velocity Plot
figure();
scatter3(x,y,z,[],v)
colormap;
cb = colorbar();
ylabel(cb,'Velocity')
ylabel('Y Positon')
xlabel('X Position')
zlabel('Z Position')