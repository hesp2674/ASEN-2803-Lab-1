clc;
clear ;
close all;

[x, y, z, position_arc_0, v, G_force, theta, angle] = ArcEnd(-150, 120, -90, 0, -5);

figure();
scatter3(x,y,z,[],G_force)
colormap;
cb = colorbar();
ylabel(cb,'G-Force')
ylabel('Y Positon')
xlabel('X Position')
zlabel('Z Position')