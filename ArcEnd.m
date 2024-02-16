function [x_vals, y, z_vals, position, v, G_force] = ArcEnd(x_end, z_end, theta_end, y_plane, radius)

    %Constants
    g = 9.81;
    h0 = 125;
    
    circd = @(radius,deg_ang)  [radius*cosd(deg_ang);  radius*sind(deg_ang)];       % Circle Function For Angles In Degrees
    
    N = 500;
    theta0 = -90;
    theta_end_corr = theta_end - 90;% Number Of Points In Complete Circle
    angle = linspace(theta0, theta_end_corr, N);                                   % Angle Defining Arc Segment (deg)
                                                    % Arc Radius
    xz = circd(radius,angle);
    x_vals = xz(1,:) - xz(1,N) + x_end;
    z_vals = xz(2,:) - xz(2,N) + z_end;
    
    theta = angle-90;
    v = sqrt(2*g.*(h0-z_vals));
    G_force = ((v.^2)./(g.*radius))-cosd(theta);
    
    len_curve = sum(vecnorm(diff( [x_vals(:),z_vals(:)] ),2,2));
    position = linspace(0, len_curve, N);
    
    
    y = zeros(1,length(z_vals)) + y_plane;

    