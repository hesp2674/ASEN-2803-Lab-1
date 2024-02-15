clc;
clear ;
close all;

%% LOOP 

%Variables
h0 = 125;
theta = linspace (-90,270,1000);
R = 50;
g = 9.81;
h = R*sind(theta) + R;

% G Force at different locations
G_top = (2*(h0-2*R)/(R)) -1;
G_angle = (2*(h0-R*sind(theta)-R)/(R))- sind(theta);
G_bot = (2*h0/R) +1;

%Velocity
V = sqrt(2*g*(h0-h));


% Loop diagram
x = R*sind(theta);
y = R*cosd(theta);

figure();
plot3(x,y,G_angle,"Color",'b','LineWidth',2);
xlabel('X position (m)');
ylabel('Y position (m)');
zlabel("G force");
grid on;


figure();
surf([x(:) x(:)], [y(:) y(:)], [G_angle(:) G_angle(:)], ...
    'FaceColor','none', ...
    'EdgeColor','interp', ...
    'LineWidth', 2);
view(2);
xlabel('X position (m)');
ylabel('Y position (m)');
colorbar;


z = R*sind(theta);
y = R*cosd(theta);
x=zeros(1,1000);
figure();
scatter3(x,y,z,[],G_angle)
colormap;
colorbar;
