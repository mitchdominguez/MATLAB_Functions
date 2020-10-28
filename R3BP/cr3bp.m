%% Mitchell Dominguez - doming18@purdue.edu - cr3bp.m
% RHS function for the 3-dimensional circuclar restricted 3 body problem
function Sdot = cr3bp(~,S,mu)
    x = S(1); y = S(2); z = S(3); xdot = S(4); ydot = S(5); zdot = S(6);

    d = sqrt((x+mu)^2 + y^2 + z^2);
    r = sqrt((x-1+mu)^2 + y^2 + z^2);
    
    xddot = 2*ydot + x - (1-mu)*(x+mu)/d^3 - mu*(x-1+mu)/r^3;
    yddot = -2*xdot + y -(1-mu)*y/d^3 - mu*y/r^3;
    zddot = -(1-mu)*z/d^3 - mu*z/r^3;

    Sdot = [xdot;ydot;zdot;xddot;yddot;zddot];
end
