%% Mitchell Dominguez - doming18@purdue.edu - periodic_xfixed.m
% mu, ICs, target, tf, 

function soln = periodic_xfixed(mu, z_ic, tmax, ode_opts, max_iter, tol)
    % Include events function in ode options
    ode_opts = odeset(ode_opts,'Events',@xz_plane_crossing);

    % Initialize the targeter 
    Z0{1} = [z_ic(:,1);reshape(eye(6),[36 1])]; % Initial conditions (including STM)

    i = 1; % iteration counter
    cont = true; % Variable that evaluates whether another iteration should be made

    while 1
        % Integrate to t2 to get both the state and the STM at that time
        [T{i},Z{i}] = ode113(@stm_phidot_A_phi,[0,tmax],Z0{i},ode_opts,mu);
        phi_tf = reshape(Z{i}(end,7:end),[6 6]);
        tf(i) = T{i}(end); % New tf is the time when the sim is stopped --> crosses x axis
        phi_aug_tf{i} = [phi_tf, cr3bp(tf(i),Z{i}(end,1:6)', mu)];

        % Compute the dxdot_f  --> it should be zero for a perpendicular crossing
        err(:,i) = -Z{i}(end,[4 6])'; % [xdot_final,zdot_final] is the error

        % Evaluate stopping conditions
        if norm(err(:,i))<tol || i+1>max_iter
            cont = false;
            iters = i;
            break;
        end

        % [x y z xdot ydot zdot]
        % [1 2 3  4    5    6  ]
        % Compute the delta v -- dv = inv(phi_rv)*err
        phi_23 = phi_aug_tf{i}(2,3); % dy/dz0
        phi_25 = phi_aug_tf{i}(2,5); % dy/dydot0
        phi_43 = phi_aug_tf{i}(4,3); % dxdot/dz0
        phi_45 = phi_aug_tf{i}(4,5); % dxdot/dydot0
        phi_63 = phi_aug_tf{i}(6,3); % dzdot/dz0
        phi_65 = phi_aug_tf{i}(6,5); % dzdot/dydot0
        xddot = phi_aug_tf{i}(4,7); % x double dot 
        zddot = phi_aug_tf{i}(6,7); % z double dot 
        ydot = phi_aug_tf{i}(2,7); % y dot
        mat = [phi_43, phi_45;phi_63, phi_65] - (1/ydot)*[xddot;zddot]*[phi_23, phi_25];
        dz0ydot0(:,i) = mat\err(:,i);

        % Compute the new initial conditions and t_final - v_i+1 = v_i + dv_i
        z_ic(:,i+1) = z_ic(:,i) + [0;0;dz0ydot0(1,i);0;dz0ydot0(2,i);0]; % Updated initial state
        Z0{i+1} = [z_ic(:,i+1);reshape(eye(6),[36 1])]; % Updated initial conditions

        i = i+1;
    end

    dv_net = Z0{iters}(4:6)-Z0{1}(4:6);
    dtf_net = tf(end)-tf(1);

    % Set up options for integrating without an events function
    ode_opts = odeset(ode_opts,'Events',[]);

    % Package solution struct
    soln.dv_net = dv_net;
    soln.dtf_net = dtf_net;
    soln.dz0ydot0 = dz0ydot0;
    soln.Z0 = Z0;
    soln.Z = Z;
    soln.err = err;
    soln.T = T;
    soln.iters = iters;
    soln.phi_aug_tf = phi_aug_tf;
    soln.z_ic = z_ic;
    soln.tf = tf;
    soln.P = tf(end)*2;
    soln.z_0_per = Z0{end}(1:6);
    [soln.t, soln.z] = ode113(@cr3bp,[0,soln.P],soln.z_0_per,ode_opts,mu);

    % Calculate monodromy matrix
    S = [zeros(3), eye(3);-eye(3),zeros(3)];
    Om = [0 1 0;-1 0 0;0 0 0];
    V = [eye(3), zeros(3);-Om, eye(3)];
    G = diag([1;-1;1;-1;1;-1]);
    phi_half_P = soln.phi_aug_tf{end}(1:6,1:6);
    mat1 = [zeros(3), -eye(3);eye(3), -2*Om];
    mat2 = [-2*Om, eye(3);-eye(3), zeros(3)];

    soln.M = G*mat1*phi_half_P'*mat2*G*phi_half_P; % Monodromy matrix
    [soln.V,D] = eig(soln.M);
    soln.lam = diag(D); % Eigenvalues of the monodromy matrix
end

% Events function
function [value, isterminal, direction] = xz_plane_crossing(t,z,mu)
    y = z(2); % Unpack y value
    value = y; % Detect when y = 0 
    isterminal = 1; % Stop the simulation when y=0
    direction = 0;
end
