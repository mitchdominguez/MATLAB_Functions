%% Mitchell Dominguez - doming18@purdue.edu - lyap_targeter.m
% mu, ICs, target, tf, 

function soln = lyap_targeter(mu, z_ic, tmax, ode_opts, max_iter, tol)
    % Include events function in ode options
    ode_opts = odeset(ode_opts,'Events',@x_axis_crossing);

    % Initialize the targeter 
    Z0{1} = [z_ic(:,1);reshape(eye(4),[16 1])]; % Initial conditions (including STM)

    i = 1; % iteration counter
    cont = true; % Variable that evaluates whether another iteration should be made

    while 1
        % Integrate to t2 to get both the state and the STM at that time
        [T{i},Z{i}] = ode113(@stm_phidot_A_phi_2d,[0,tmax],Z0{i},ode_opts,mu);
        phi_tf = reshape(Z{i}(end,5:20),[4 4]);
        tf(i) = T{i}(end); % New tf is the time when the sim is stopped --> crosses x axis
        phi_aug_tf{i} = [phi_tf, cr3bp_2d(tf(i),Z{i}(end,1:4)', mu)];

        % Compute the dxdot_f  --> it should be zero for a perpendicular crossing
        err(i) = -Z{i}(end,3); % xdot_final is the error

        % Evaluate stopping conditions
        if norm(err(i))<tol || i+1>max_iter
            cont = false;
            iters = i;
            break;
        end

        % Compute the delta v -- dv = inv(phi_rv)*err
        phi_34 = phi_aug_tf{i}(3,4); % dxdot/dydot_0
        phi_24 = phi_aug_tf{i}(2,4); % dy/dydot_0
        xddot = phi_aug_tf{i}(3,5); % x double dot 
        ydot = phi_aug_tf{i}(2,5); % y dot
        dydot_0(i) = err(i)/(phi_34 - phi_24*xddot/ydot);

        % Compute the new initial conditions and t_final - v_i+1 = v_i + dv_i
        z_ic(:,i+1) = z_ic(:,i) + [0;0;0;dydot_0(i)]; % Updated initial state
        Z0{i+1} = [z_ic(:,i+1);reshape(eye(4),[16 1])]; % Updated initial conditions

        i = i+1;
    end

    dv_net = Z0{iters}(3:4)-Z0{1}(3:4);
    dtf_net = tf(end)-tf(1);

    % Set up options for integrating without an events function
    ode_opts = odeset(ode_opts,'Events',[]);

    % Package solution struct
    soln.dv_net = dv_net;
    soln.dtf_net = dtf_net;
    soln.dydot_0 = dydot_0;
    soln.Z0 = Z0;
    soln.Z = Z;
    soln.err = err;
    soln.T = T;
    soln.iters = iters;
    soln.phi_aug_tf = phi_aug_tf;
    soln.z_ic = z_ic;
    soln.tf = tf;
    soln.P = tf(end)*2;
    soln.z_0_per = Z0{end}(1:4);
    [soln.t, soln.z] = ode113(@cr3bp_2d,[0,soln.P],soln.z_0_per,ode_opts,mu);
end

% Events function
function [value, isterminal, direction] = x_axis_crossing(t,z,mu)
    y = z(2); % Unpack y value
    value = y; % Detect when y = 0 
    isterminal = 1; % Stop the simulation when y=0
    direction = 0;
end
