function [x_vals, y, z_vals, position, v, G_force] = ArcStart(x_start, z_start, theta_start, y_plane, radius)

    %Constants
    g = 9.81;
    h0 = 125;
     
    
    
    circd = @(radius,deg_ang)  [radius*cosd(deg_ang);  radius*sind(deg_ang)];       % Circle Function For Angles In Degrees
    
    N = 500;
    thetaf = -90;
    theta_start_corr = theta_start - 90;% Number Of Points In Complete Circle
    angle = linspace(theta_start_corr, thetaf, N);                                   % Angle Defining Arc Segment (deg)
                                                    % Arc Radius
    xz = circd(radius,angle);
    x_vals = xz(1,:) + x_start;
    z_vals = xz(2,:) + z_start + radius;
    
    theta = angle-90;
    v = sqrt(2*g.*(h0-z_vals));
    G_force = ((v.^2)./(g.*radius))-cosd(theta);
    

    len_curve = sum(vecnorm(diff( [x_vals(:),z_vals(:)] ),2,2));
    position = linspace(0, len_curve, N);
    
    
    y = zeros(1,length(z_vals)) + y_plane;

    