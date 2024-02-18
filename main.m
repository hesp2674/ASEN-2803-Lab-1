clear; close all; clc;

%Constants
h0 = 125;
g = 9.81;

%% Line 0
[x_line_0, y_line_0, z_line_0, p_line_0, v_line_0, G_force_line_0] = Line(-214.7058, 125, -184.853, 95.14732, 0);


%% ARC 1
[x_arc_1, y_arc_1, z_arc_1, p_arc_1, v_arc_1, G_force_arc_1] = ArcStart(-100, 60, -45, 0, 120);


%% LOOP 

%Variables for loop
N = 1000;
theta = linspace (-90,270,N);
R = 30;
g = 9.81;
x0 = -100;
y0 = 0;
z0 = 60;


%Eq of Circle
x_loop = (R*cosd(theta)) + x0;

%x_temp = x_loop(1, 3*length(x_loop)/4+1:length(x_loop));
%x_loop = [x_temp, x_loop(1, 1:3*length(x_loop)/4)];

z_loop = (R*sind(theta) + R) + z0;

%z_temp = z_loop(1, 3*length(z_loop)/4+1:length(z_loop));
%z_loop = [z_temp, z_loop(1, 1:3*length(z_loop)/4)];

y_loop = zeros(1,length(x_loop)) + y0;

% G Force at different locations
v_loop = sqrt(2*g*(h0-z_loop));

G_top_loop = (2*(h0-2*R)/(R)) -1;
G_bot_loop = (2*h0/R) +1;
G_force_loop = ((v_loop.^2)./(g.*R))-sind(theta);

len_curve = sum(vecnorm(diff( [x_loop(:),z_loop(:)] ),2,2));
p_vec_loop = linspace(0, len_curve, N);


%% ARC 2
[x_arc_2, y_arc_2, z_arc_2, p_arc_2, v_arc_2, G_force_arc_2] = ArcEnd(-81.883, 57.6148, -15, 0, -70);

%% Line 1
[x_line_1, y_line_1, z_line_1, p_line_1, v_line_1, G_force_line_1] = Line(-81.883, 57.6148, -68.3957, 54.0435, 0);

%% Arc 3
[x_arc_3, y_arc_3, z_arc_3, p_arc_3, v_arc_3, G_force_arc_3] = ArcStart(-58.0429, 52.6805, -15, 0, 40);

%% Line 2
[x_line_2, y_line_2, z_line_2, p_line_2, v_line_2, G_force_line_2] = Line(-58.0429, 52.6805, -22.1892, 52.6785, 0);


%% ARC 4
[x_arc_4, y_arc_4, z_arc_4, p_arc_4, v_arc_4, G_force_arc_4] = ArcEnd(5, 70, 65, 0, 30);


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
p_parabola = linspace(0,parabola_length,1000);

% Concatonating data
x = [x_line_0, x_arc_1, x_loop, x_arc_2, x_line_1, x_arc_3, x_line_2, x_arc_4, x_parabola];
z = [z_line_0, z_arc_1, z_loop, z_arc_2, z_line_1, z_arc_3, z_line_2, z_arc_4, z_parabola];
y = [y_line_0, y_arc_1, y_loop, y_arc_2, y_line_1, y_arc_3, y_line_2, y_arc_4, y_parabola];

G_force = [G_force_line_0, G_force_arc_1, G_force_loop, G_force_arc_2, G_force_line_1, G_force_arc_3, G_force_line_2, G_force_arc_4, G_force_parabola];
G_l = zeros(1, length(G_force));
G_tan = zeros(1, length(G_force));

v = [v_line_0, v_arc_1, v_loop, v_arc_2, v_line_1, v_arc_3, v_line_2, v_arc_4, v_parabola];
p_vec = p_line_0;
p_vec = [p_vec, p_arc_1 + p_vec(length(p_vec))];
p_vec = [p_vec, p_vec_loop + p_vec(length(p_vec))];
p_vec = [p_vec, p_arc_2 + p_vec(length(p_vec))];
p_vec = [p_vec, p_line_1 + p_vec(length(p_vec))];
p_vec = [p_vec, p_arc_3 + p_vec(length(p_vec))];
p_vec = [p_vec, p_line_2 + p_vec(length(p_vec))];
p_vec = [p_vec, p_arc_4 + p_vec(length(p_vec))];
p_vec = [p_vec, p_parabola + p_vec(length(p_vec))];


%% Line 3
[x_line_3, y_line_3, z_line_3, p_line_3, v_line_3, G_force_line_3] = Line(x(length(x)), z(length(z)), 102.6376, 41.4325, 0);

x = [x, x_line_3];
z = [z, z_line_3];
y = [y, y_line_3];


G_force = [G_force, G_force_line_3];
G_l = [G_l, zeros(1, length(G_force_line_3))];
G_tan = [G_tan, zeros(1, length(G_force_line_3))];

v = [v, v_line_3];
p_vec = [p_vec, p_line_3 + p_vec(length(p_vec))];


%% Arc 5
[x_arc_5, y_arc_5, z_arc_5, p_arc_5, v_arc_5, G_force_arc_5] = ArcEnd(x(length(x)), z(length(z)), -65, 0, 50);

%c Concatonating data
x = [x, flip(x_arc_5, 2)];
z = [z, flip(z_arc_5, 2)];
y = [y, flip(y_arc_5, 2)];


G_force = [G_force, flip(G_force_arc_5, 2)];
G_l = [G_l, zeros(1, length(G_force_arc_5))];
G_tan = [G_tan, zeros(1, length(G_force_arc_5))];

v = [v, flip(v_arc_5, 2)];
p_vec = [p_vec, p_arc_5 + p_vec(length(p_vec))];


%% Banked Turn
[x_bank, y_bank, z_bank, p_bank, v_bank, G_bank_n, G_bank_l] = BankedTurnFunction(x(length(x)));

x = [x, flip(x_bank, 2)];
z = [z, flip(z_bank, 2)];
y = [y, flip(y_bank, 2)];


G_force = [G_force, flip(G_bank_n, 2)];
G_l = [G_l, flip(G_bank_l, 2)];
G_tan = [G_tan, zeros(1, length(G_bank_n))];

v = [v, flip(v_bank, 2)];
p_vec = [p_vec, p_bank + p_vec(length(p_vec))];


%% Braking Section
N_brake = 1000;
brake_g = 2.5;
brake_len = h0/brake_g;

x_brake = linspace(x(length(x)), brake_len+x(length(x)), N_brake);
y_brake = zeros(1, N_brake);
z_brake = zeros(1, N_brake);

v_brake = sqrt(2*g*h0 - 2*brake_g*g.*(x_brake-x(length(x))));

G_force_brake = ones(1, N_brake);
G_force_brake_tan = brake_g*ones(1, N_brake);

len_curve = sum(vecnorm(diff( [x_brake(:),z_brake(:)] ),2,2));
p_brake = linspace(0, len_curve, N_brake);

x = [x, x_brake];
z = [z, z_brake];
y = [y, y_brake];

G_force = [G_force, G_force_brake];
G_l = [G_l, zeros(1, N)];
G_tan = [G_tan, G_force_brake_tan];



v = [v, v_brake];
p_vec = [p_vec, p_brake + p_vec(length(p_vec))];

%% Plotting

%G-Force Plot
figure();
scatter3(x,y,z,5,G_force)
colormap('hsv');
cb = colorbar();
ylabel(cb,'G-Force')
ylabel('Y Positon')
xlabel('X Position')
zlabel('Z Position')

%Velocity Plot
figure();
scatter3(x,y,z,5,v)
colormap('jet');
cb = colorbar();
ylabel(cb,'Velocity')
ylabel('Y Positon')
xlabel('X Position')
zlabel('Z Position')


figure();
subplot(3,1,1)
plot(p_vec, G_force)
xlabel('Position')
ylabel('Normal G Force')

subplot(3,1,2)
plot(p_vec, G_l)
xlabel('Position')
ylabel('Lateral G Force')

subplot(3,1,3)
plot(p_vec, G_tan)
xlabel('Position')
ylabel('Tangential G Force')




% subplot(3,1,2)
% plot(p_vec, G_l)
% xlabel('Position')
% ylabel('Z')
% 
% subplot(3,1,3)
% plot(x, z)
% xlabel('X')
% ylabel('Z')