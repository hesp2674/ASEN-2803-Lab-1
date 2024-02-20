clear; close all; clc;

%Constants
g = 9.81;
h0 = 125;

%Inputs
x_start = 28;
z_start = 63;
theta_start = 0;
radius = 20;   


circd = @(radius,deg_ang)  [radius*cosd(deg_ang);  radius*sind(deg_ang)];       % Circle Function For Angles In Degrees

N = 250;
thetaf = 0;
theta_start_corr = theta_start - 90;% Number Of Points In Complete Circle
angle = linspace(theta_start_corr, thetaf, N);                                   % Angle Defining Arc Segment (deg)
                                                % Arc Radius
xz = circd(radius,angle);
x_vals = xz(1,:) + x_start;
z_vals = xz(2,:) + z_start + radius;

theta = angle-90;
v = sqrt(2*g.*(h0-z_vals));
G_force = ((v.^2)./(g.*radius))-sind(theta);


y = zeros(length(z_vals),1);

len_curve = sum(vecnorm(diff( [x_vals(:),z_vals(:)] ),2,2));

% figure();
scatter3(x_vals,y,z_vals,[],G_force)
colormap;
cb = colorbar();
ylabel(cb,'G-Force')
ylabel('Y Positon')
xlabel('X Position')
zlabel('Z Position')



figure()
plot(x_vals, z_vals)
