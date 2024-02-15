clc;
clear ;
close all;

%% LOOP 

%Variables
h0 = 45.8716;
%h0 = 60;
g = 9.81;
v0 = sqrt(2*g*h0);
theta0 = 70;



% Parabola diagram
x = linspace(0, 60, 1000);  %correct
z = x.*tand(theta0) - ((9.81.*(x.^2))/(2*v0^2*(cosd(theta0))^2));  %Correct

dzdx = tand(theta0) - (9.81.*x)/(v0^2*(cosd(theta0)^2));
d2zdx2 = -9.81/(v0^2*cosd(theta0)^2);

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
y=zeros(1,1000);
figure();
scatter3(x,y,z,[],G_force)
colormap;
colorbar;