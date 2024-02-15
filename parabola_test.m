clc;
clear ;
close all;

%% LOOP 

%Initial Values
h0 = 125;
base = 85;
g = 9.81;
theta0 = 70;
x0 = 5; %Initial x position
y_plane = 0;

%Calculatev Values
v0 = sqrt(2*g*(h0-base));
xf = x0 + (v0^2*sind(2*theta0))/g; %Uses rng eq to find where it's level

% Parabola diagram
x = linspace(x0, xf, 1000); %Interval
z = ((x-x0).*tand(theta0) - ((g.*((x-x0).^2))/(2*v0^2*(cosd(theta0))^2)))+base; %Solves for z

dzdx = tand(theta0) - (g.*(x-x0))/(v0^2*(cosd(theta0)^2));
d2zdx2 = -g/(v0^2*cosd(theta0)^2);

rho = ((1+(dzdx.^2)).^(3/2))./abs(d2zdx2);
theta = atand(dzdx);
v = sqrt(2*g.*(h0-z));
G_force = cosd(theta)-((v.^2)./(g.*rho));


%Plot
plot(x,z)
xlabel('X position (m)');
ylabel('Z position (m)');
grid on;

hold on;

%G-plot
y=zeros(1,1000) + y_plane;
figure();
scatter3(x,y,z,[],G_force)
colormap;
colorbar;