clear; close all; clc;

%Constants
g = 9.81;
h0 = 125;

%Inputs
x_end = 70;
z_end = 80;
theta_end = 70;
radius = 80;   




circd = @(radius,deg_ang)  [radius*cosd(deg_ang);  radius*sind(deg_ang)];       % Circle Function For Angles In Degrees

N = 250;
theta0 = -90;
theta_end_corr = theta_end - 90;% Number Of Points In Complete Circle
angle = linspace(theta0, theta_end_corr, N);                                   % Angle Defining Arc Segment (deg)
                                                % Arc Radius
xz = circd(radius,angle);
x_vals = xz(1,:) - xz(1,N) + x_end;
z_vals = xz(2,:) - xz(2,N) + z_end;

theta = angle-90;
v = sqrt(2*g.*(h0-z_vals));
G_force = ((v.^2)./(g.*radius))-sind(theta);


y = zeros(length(z_vals),1);

% figure();
% scatter3(x_vals,y,z_vals,[],G_force)
% colormap;
% cb = colorbar();
% ylabel(cb,'G-Force')
% ylabel('Y Positon')
% xlabel('X Position')
% zlabel('Z Position')



figure()
plot(x_vals, z_vals)
