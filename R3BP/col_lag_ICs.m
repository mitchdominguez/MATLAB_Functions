%% Mitchell Dominguez - doming18@purdue.edu col_lag_ICs.m
% Function to calculate the initial velocities for orbiting a collinear
% Lagrange point, given the initial positions relative to the Lagrange point
% and the position of the Lagrange point (specifying Lagrange point), in 2D

function IC = col_lag_ICs(mu,xi_0,eta_0, r_L)
    % % Solve for U_xx, U_yy at L_1
    %syms x y mu % Declare symbolic variables so I don't make silly algebra mistakes
    % %r_L1 = [0.836918;0]; % ndim position of L1 in the EM system
    %d = sqrt((x+mu)^2 + y^2);
    %r = sqrt((x-1+mu)^2 + y^2);
    %U = (x^2 + y^2)/2 + (1-mu)/d + mu/r;
    %U_xx = diff(diff(U,x),x)
    %U_yy = diff(diff(U,y),y)
    %U_xy = diff(diff(U,x),y)
    %U_yx = U_xy

    %ddU = matlabFunction([U_xx, U_xy;U_yx, U_yy],'File','cr3bp_2d_ddU.m')

    r_0 = r_L + [xi_0;eta_0];
    U_derivs = cr3bp_2d_ddU(mu,r_L(1),r_L(2));
    U_xx = U_derivs(1,1);
    U_yy = U_derivs(2,2);

    % Solve for beta_1, beta_2
    beta_1 = 2 - ((U_xx+U_yy)/2);
    beta_2 = sqrt(-U_xx*U_yy);

    % Solve for s, beta_3
    s = sqrt(beta_1 + sqrt(beta_1^2 + beta_2^2));
    beta_3 = (s^2 + U_xx)/(2*s);

    % Position is r_L1 + [xi_0,eta_0]
    % Velocity is [xi_0_dot, eta_0_dot]

    xi_0_dot = eta_0*s/beta_3;
    eta_0_dot = -beta_3*xi_0*s;
    v_0 = [xi_0_dot;eta_0_dot];

    IC = [r_0;v_0];
end
