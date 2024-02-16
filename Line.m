function [x, y, z, position, v, G_force] = Line(x0, z0, xf, zf, y)
    g = 9.81;
    h0 = 125;

    N = 500;
    
    x = linspace(x0, xf, N);
    z = linspace(z0, zf, N);
    y = zeros(1,N) + y;
    
    len_curve = sum(vecnorm(diff( [x(:),z(:)] ),2,2));
    position = linspace(0, len_curve, N);
    
    theta = atand((zf-z0)/(xf-x0));
    
    G_force = zeros(1,N) + (g*sind(theta));
    
    v = sqrt(2*g*(h0-z));


