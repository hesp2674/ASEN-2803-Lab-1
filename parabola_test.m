clc;
clear ;
close all;

%% PARABOLA

%Initial Values
h0 = 125;
base = 70;
g = 9.81;
theta0 = 65;
x0 = 5; %Initial x position
y_plane = 0;

%Calculatev Values
v0 = sqrt(2*g*(h0-base));
xf = x0 + (v0^2*sind(2*theta0))/g; %Uses rng eq to find where it's level
y=zeros(1,1000) + y_plane; %Calculates the y values

% Parabola diagram
x = linspace(x0, xf, 1000); %Interval
z = ((x-x0).*tand(theta0) - ((g.*((x-x0).^2))/(2*v0^2*(cosd(theta0))^2)))+base; %Solves for z

dzdx = tand(theta0) - (g.*(x-x0))/(v0^2*(cosd(theta0)^2));
d2zdx2 = -g/(v0^2*cosd(theta0)^2);

rho = ((1+(dzdx.^2)).^(3/2))./abs(d2zdx2);
theta = atand(dzdx);
v = sqrt(2*g.*(h0-z));
G_force = cosd(theta)-((v.^2)./(g.*rho));


parabola_length = sum(vecnorm(diff( [x(:),z(:)] ),2,2));
position_vec = linspace(0,parabola_length,1000);

%% Plots
%Plot
% plot(x,z)
% xlabel('X position (m)');
% ylabel('Z position (m)');
% grid on;

subplot(3,1,1)
plot(position_vec, G_force)
grid on;
ylim([-1 6])
xlabel('Position (m)');
ylabel('G-Force Normal (Gs)');

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
ylabel('G-Force Tangential (Gs)');


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

