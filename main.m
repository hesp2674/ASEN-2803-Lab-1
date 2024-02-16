clear; close all; clc;

%Constants
h0 = 125;
g = 9.81;


%% LOOP 

%Variables for loop
N = 1000;
theta = linspace (0,360,N);
R = 30;
g = 9.81;
x0 = -100;
y0 = 0;
z0 = 60;


%Eq of Circle
x_loop = (R*cosd(theta)) + x0;
z_loop = (R*sind(theta) + R) + z0;
y_loop = zeros(1,length(x_loop)) + y0;

% G Force at different locations
v_loop = sqrt(2*g*(h0-z_loop));

G_top_loop = (2*(h0-2*R)/(R)) -1;
G_bot_loop = (2*h0/R) +1;
G_force_loop = ((v_loop.^2)./(g.*R))-sind(theta);

len_curve = sum(vecnorm(diff( [x_loop(:),z_loop(:)] ),2,2));
position_vec_loop = linspace(0, len_curve, N);


%% ARC 0
[x_arc_0, y_arc_0, z_arc_0, position_arc_0, v_arc_0, G_force_arc_0] = ArcEnd(-100+13.681, 60-2.4123, -20, 0, -40);

%% Line 0
[x_line_0, y_line_0, z_line_0, position_line_0, v_line_0, G_force_line_0] = Line(-86.319, 57.5877, -79.465, 55.0928, 0);

%% Arc 1
[x_arc_1, y_arc_1, z_arc_1, position_arc_1, v_arc_1, G_force_arc_1] = ArcStart(-65.7842, 52.6805, -20, 0, 40);

%% Line 1
[x_line_1, y_line_1, z_line_1, position_line_1, v_line_1, G_force_line_1] = Line(-65.7842, 52.6805, -22.1892, 52.6785, 0);


%% ARC 2
[x_arc_2, y_arc_2, z_arc_2, position_arc_2, v_arc_2, G_force_arc_2] = ArcEnd(5, 70, 65, 0, 30);


%% PARABOLA

%Initial Values
base = 70;
theta0 = 65;
x0 = 5; %Initial x position
y_plane = 0;

%Calculatev Values
v0 = sqrt(2*g*(h0-base));
xf = x0 + (v0^2*sind(2*theta0))/g; %Uses rng eq to find where it's level
y_parabola=zeros(1,1000) + y_plane; %Calculates the y values

% Parabola diagram
x_parabola = linspace(x0, xf, 1000); %Interval
z_parabola = ((x_parabola-x0).*tand(theta0) - ((g.*((x_parabola-x0).^2))/(2*v0^2*(cosd(theta0))^2)))+base; %Solves for z

dzdx = tand(theta0) - (g.*(x_parabola-x0))/(v0^2*(cosd(theta0)^2));
d2zdx2 = -g/(v0^2*cosd(theta0)^2);

rho = ((1+(dzdx.^2)).^(3/2))./abs(d2zdx2);
theta = atand(dzdx);
v_parabola = sqrt(2*g.*(h0-z_parabola));
G_force_parabola = cosd(theta)-((v_parabola.^2)./(g.*rho));


parabola_length = sum(vecnorm(diff( [x_parabola(:),z_parabola(:)] ),2,2));
position_vec_parabola = linspace(0,parabola_length,1000);

% Concatonating data
x = [x_loop, x_arc_0, x_line_0, x_arc_1, x_line_1, x_arc_2, x_parabola];
z = [z_loop, z_arc_0, z_line_0, z_arc_1, z_line_1, z_arc_2, z_parabola];
y = [y_loop, y_arc_0, y_line_0, y_arc_1, y_line_1, y_arc_2, y_parabola];

v = [v_loop, v_arc_0, v_line_0, v_arc_1, v_line_1, v_arc_2, v_parabola];
G_force = [G_force_loop, G_force_arc_0, G_force_line_0, G_force_arc_1, G_force_line_1, G_force_arc_2, G_force_parabola];


%% Arc 3

[x_arc_3, y_arc_3, z_arc_3, position_arc_3, v_arc_3, G_force_arc_3] = ArcEnd(x(length(x)), z(length(z)), -65, 0, 30);

%c Concatonating data
x = [x, x_arc_3];
z = [z, z_arc_3];
y = [y, y_arc_3];

v = [v, v_arc_3];
G_force = [G_force, G_force_arc_3];


%% Plotting

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