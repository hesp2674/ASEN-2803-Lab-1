clear; clc; close all;

t = [0:(pi/500):2*pi];
x = -50*sin(t);
y = 50*cos(t);
z = 2*t;
t2 = t';

h0 = 125;
v = sqrt(2*9.81*(h0-z));
m = 1;
g = 9.81;
theta = 45; %degrees
r = 50;

L = ((-g*tand(theta))+((v).^2)/r)/(sind(theta)*tand(theta)+cosd(theta));
N = g/cosd(theta) + (L*sind(theta))/cosd(theta);

G_l = L/(m*g);
G_n = N/(m*g);

figure(1)
plot3(x,y,G_l, "Color",'magenta','LineWidth',2)
xlabel('X position (m)');
ylabel('Y position (m)');
zlabel('Z position (m)');
grid on;
hold on;

figure(1);
surf([x(:) x(:)], [y(:) y(:)], [G_l(:) G_l(:)], ...
    'FaceColor','none', ...
    'EdgeColor','interp', ...
    'LineWidth', 2);
view(2);
xlabel('X position (m)');
ylabel('Y position (m)');
colorbar;
figure(1);
scatter3(x,y,z,[],G_l)
colormap;
colorbar;

figure(2)
plot3(x,y,G_n, "Color",'magenta','LineWidth',2)
xlabel('X position (m)');
ylabel('Y position (m)');
zlabel("Normal G Force");
grid on;

figure(2);
surf([x(:) x(:)], [y(:) y(:)], [G_n(:) G_n(:)], ...
    'FaceColor','none', ...
    'EdgeColor','interp', ...
    'LineWidth', 2);
view(2);
xlabel('X position (m)');
ylabel('Y position (m)');
colorbar;
figure(2);
scatter3(x,y,z,[],G_n)
xlabel('X position (m)');
ylabel('Y position (m)');
zlabel("Normal G Force");
colormap;
colorbar

theta2 = linspace (-90,270,1000);
R2 = 50;
h = R2*sind(theta2) + R2;
% G Force at different locations
G_top = (2*(h0-2*R2)/(R2)) -1;
G_angle = (2*(h0-R2*sind(theta2)-R2)/(R2))- sind(theta2);
G_bot = (2*h0/R2) +1;
%Velocity
V = sqrt(2*g*(h0-h));
% Loop diagram
x2 = R2*sind(theta2);
y2 = R2*cosd(theta2);
figure();
plot3(x2,y2,G_angle,"Color",'b','LineWidth',2);
xlabel('X position (m)');
ylabel('Y position (m)');
zlabel("G force");
grid on;
figure();
surf([x2(:) x2(:)], [y2(:) y2(:)], [G_angle(:) G_angle(:)], ...
    'FaceColor','none', ...
    'EdgeColor','interp', ...
    'LineWidth', 2);
view(2);
xlabel('X position (m)');
ylabel('Y position (m)');
colorbar;
z2 = R2*sind(theta2);
y2 = R2*cosd(theta2);
x2=zeros(1,1000);
figure();
scatter3(y2,x2,z2,[],G_angle)
colormap;
colorbar;







