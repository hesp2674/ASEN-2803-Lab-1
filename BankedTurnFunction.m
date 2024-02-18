function [x, y, z, position, v, G_n, G_l] = BankedTurnFunction(xf)

    t = [0:(pi/500):2*pi];
    x = (-50*sin(t)) + xf;
    y = (50*cos(t)) - 50;
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
    
    %Calculating Gs
    G_l = L/(m*g);
    G_n = N/(m*g);
    
    
    %Calculating Velocity
    % theta2 = linspace (-90,270,1000);
    % R2 = 50;
    % h = R2*sind(theta2) + R2;
    % V = sqrt(2*g*(h0-h));
    

    %Creating Position Vector
    len_curve = sum(vecnorm(diff( [x(:), z(:), y(:)] ),2,2));
    position = linspace(0, len_curve, 1001);