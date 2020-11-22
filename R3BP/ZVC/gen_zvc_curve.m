function soln = gen_zvc_curve(init_pt, mu, C, max_iter, tol)

    % Define stopping point and tolerance for each NR computation
    %max_iter = 1e2;
    %tol = 1e-12;

    % Initialize loop index variable
    i = 1;

    % Initialize variable to store each zvc point
    %   Each iteration will add a new row to pts
    pts(i,:) = init_pt; % will be an mx2 matrix, with m being the number of zvc points

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Define maximum number of points allowed to be tested (prevents infinite loops)
    i_max = 1e6;

    % Define minimum acceptable (absolute) value of a derivative where it will be used
    % in the NR iteration. If the derivative is too close to zero, then NR algorithm
    % will blow up
    min_deriv = 0.1;

    % Define step size to pick next point
    step = 0.001;

    % Initialize variable that will determine when to break the loop
    %   Since there is no do-while loop, cont is initialized to true
    cont = true;


    n = [];

    % Iterate while:
    %   - we haven't reached i_max
    %   - we haven't re-crossed the x-axis (after the first point)
    %   - we haven't returned to the starting point
    while cont
        % Calculate derivative at pt i
        dfdx = d_zvc_d_x(pts(i,1),pts(i,2),mu,C);
        dfdy = d_zvc_d_y(pts(i,1),pts(i,2),mu,C);

        % Calculate which direction steps should be made in
        % Other than the first point, the step should be
        % made such that the dx or dy is the same sign
        % as the delta x or y from the previous two points
        if i == 1
            dx = -1*step; 
            dy = 1*step;
        else
            dx = pts(i,1)-pts(i-1,1);
            dy = pts(i,2)-pts(i-1,2);
        end

        % Use the derivative that has the largest absolute value
        %   This avoids using a zero-valued derivative and blowing
        %   up the NR iteration scheme
        %
        % Determine whether to step in the x or y direction to find
        % the next point based on which derivative to use
        %
        % Next, use NR to calculate the new point
        if max(abs([dfdx,dfdy])) == abs(dfdy)
            % We are using the dfdy derivative, therefore
            % we are going to make a step in the x direction
            % In other words, we are trying to find a y value
            % corresponding to the new x value
            %disp('We are using dfdy')
            new_x = pts(i,1) + dx;
            new_y = pts(i,2);

            % Use Newton-Raphson iteration to find new y
            [pts(i+1,:), n(i), info(i)] = zvc_NR(new_x,new_y,'y',mu,C,max_iter,tol);
        else
            % We are using the dfdx derivative, therefore
            % we are going to make a step in the y direction
            % In other words, we are trying to find an x value
            % corresponding to the new y value
            %disp('We are using dfdx')
            new_x = pts(i,1);
            new_y = pts(i,2) + dy;

            % Use Newton-Raphson iteration to find new x
            [pts(i+1,:), n(i), info(i)] = zvc_NR(new_x,new_y,'x',mu,C,max_iter,tol);
        end

        % Verify that we did indeed get a proper solution
        % If we've still exceeded the maximum number of iterations, throw an error
        if n(i) == max_iter-1

            figure;
            plot(pts(:,1),pts(:,2))
            axis equal
            grid on

            figure;
            plot(n)

            error('Maximum number of iterations exceed')
        end

        % Stopping conditions
        if i>i_max || (i>5 && norm(pts(i+1,:)-pts(1,:))<step)
            cont = false;
        end

        i = i+1;
    end

    soln.pts = pts;
    soln.n = n;
    soln.info = info;
end
