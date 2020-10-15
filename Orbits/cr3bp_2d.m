%% Mitchell Dominguez - doming18@purdue.edu - cr3bp_2d.m
% RHS function for the 2-dimensional cicruclar restricted 3 body problem
function zdot = cr3bp_2d(~,z,mu)
    x = z(1); y = z(2); xdot = z(3); ydot = z(4);

    d = sqrt((x+mu)^2 + y^2);
    r = sqrt((x-1+mu)^2 + y^2);
    
    xddot = 2*ydot + x - (1-mu)*(x+mu)/d^3 - mu*(x-1+mu)/r^3;
    yddot = -2*xdot + y -(1-mu)*y/d^3 - mu*y/r^3;

    zdot = [xdot;ydot;xddot;yddot];
end
