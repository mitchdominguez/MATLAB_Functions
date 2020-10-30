%% Mitchell Dominguez - doming18@purdue.edu - pos_targeter_tfixed.m
% mu, ICs, target, tf, 

function soln = pos_targeter_tfixed(mu, targ, z_ic, tf, ode_opts, max_iter, tol)
    % Initialize the targeter 
    Z0{1} = [z_ic(:,1);reshape(eye(4),[16 1])]; % Initial conditions (including STM)

    i = 1; % iteration counter
    cont = true; % Variable that evaluates whether another iteration should be made

    while 1
        % Integrate to t2 to get both the state and the STM at that time
        [T{i},Z{i}] = ode113(@stm_phidot_A_phi_2d,[0,tf],Z0{i},ode_opts,mu);
        phi_tf{i} = reshape(Z{i}(end,5:20),[4 4]);

        % Compute the error -- err = r_target-r_err
        err(:,i) = targ-Z{i}(end,1:2)';
        norm(err);

        % Evaluate stopping conditions
        if norm(err(:,i))<tol || i+1>max_iter
            cont = false;
            iters = i;
            break;
        end

        % Compute the delta v -- dv = inv(phi_rv)*err
        phi_rv{i} = phi_tf{i}(1:2,3:4); % Top right block of the STM matrix
        dv(:,i) = phi_rv{i}\err(:,i);

        % Compute the new initial conditions - v_i+1 = v_i + dv_i
        z_ic(:,i+1) = z_ic(:,i) + [0;0;dv(:,i)]; % Updated initial state
        Z0{i+1} = [z_ic(:,i+1);reshape(eye(4),[16 1])]; % Updated initial conditions

        i = i+1;
    end

    dv_net = Z0{iters}(3:4)-Z0{1}(3:4);

    % Package solution struct
    soln.dv_net = dv_net;
    soln.dv = dv;
    soln.Z0 = Z0;
    soln.Z = Z;
    soln.err = err;
    soln.T = T;
    soln.iters = iters;
    soln.phi_tf = phi_tf;
end


















