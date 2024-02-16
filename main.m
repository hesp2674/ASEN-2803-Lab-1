clear; close all; clc;

%Constants
h0 = 125;
g = 9.81;

%% Line 0
[x_line_0, y_line_0, z_line_0, position_line_0, v_line_0, G_force_line_0] = Line(-214.7058, 125, -184.853, 95.14732, 0);


%% ARC 1
[x_arc_1, y_arc_1, z_arc_1, position_arc_1, v_arc_1, G_force_arc_1] = ArcStart(-100, 60, -45, 0, 120);


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


%% ARC 2
[x_arc_2, y_arc_2, z_arc_2, position_arc_2, v_arc_2, G_force_arc_2] = ArcEnd(-81.883, 57.6148, -15, 0, -70);

%% Line 1
[x_line_1, y_line_1, z_line_1, position_line_1, v_line_1, G_force_line_1] = Line(-81.883, 57.6148, -68.3957, 54.0435, 0);

%% Arc 3
[x_arc_3, y_arc_3, z_arc_3, position_arc_3, v_arc_3, G_force_arc_3] = ArcStart(-58.0429, 52.6805, -15, 0, 40);

%% Line 2
[x_line_2, y_line_2, z_line_2, position_line_2, v_line_2, G_force_line_2] = Line(-58.0429, 52.6805, -22.1892, 52.6785, 0);


%% ARC 4
[x_arc_4, y_arc_4, z_arc_4, position_arc_4, v_arc_4, G_force_arc_4] = ArcEnd(5, 70, 65, 0, 30);


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
x = [x_line_0, x_arc_1, x_loop, x_arc_2, x_line_1, x_arc_3, x_line_2, x_arc_4, x_parabola];
z = [z_line_0, z_arc_1, z_loop, z_arc_2, z_line_1, z_arc_3, z_line_2, z_arc_4, z_parabola];
y = [y_line_0, y_arc_1, y_loop, y_arc_2, y_line_1, y_arc_3, y_line_2, y_arc_4, y_parabola];

v = [v_line_0, v_arc_1, v_loop, v_arc_2, v_line_1, v_arc_3, v_line_2, v_arc_4, v_parabola];
G_force = [G_force_line_0, G_force_arc_1, G_force_loop, G_force_arc_2, G_force_line_1, G_force_arc_3, G_force_line_2, G_force_arc_4, G_force_parabola];


%% Arc 5

[x_arc_5, y_arc_5, z_arc_5, position_arc_5, v_arc_5, G_force_arc_5] = ArcEnd(x(length(x)), z(length(z)), -65, 0, 30);

%c Concatonating data
x = [x, x_arc_5];
z = [z, z_arc_5];
y = [y, y_arc_5];

v = [v, v_arc_5];
G_force = [G_force, G_force_arc_5];


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
% figure();
% scatter3(x,y,z,[],v)
% colormap;
% cb = colorbar();
% ylabel(cb,'Velocity')
% ylabel('Y Positon')
% xlabel('X Position')
% zlabel('Z Position')