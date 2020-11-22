%% Mitchell Dominguez - doming18@purdue.edu - collinear_lagrange.m
% Find the collinear Lagrange points given a mu

function [L1_results,L2_results,L3_results] = collinear_lagrange(mu,max_iter,tol)
    L1_results = NR_L1(mu,max_iter,tol);
    L2_results = NR_L2(mu,max_iter,tol);
    L3_results = NR_L3(mu,max_iter,tol);

    % Calculate gamma values (as defined in AAE632 lecture notes)
    L1_results(end+1) = L1_results(1) - (1-mu); % gamma 1
    L2_results(end+1) = L2_results(1) - (1-mu); % gamma 2
    L3_results(end+1) = L3_results(1) + mu; % gamma 3
end

function res = NR_L1(mu,max_iter,tol)
    % Initial guess for x
    x(1) = 1;
   
    % Use Newton-Raphson to calculate x
    for i = 1:(max_iter-1)
        f = (1-mu)/(x(i)+mu)^2 - mu/(x(i)-1+mu)^2 - x(i);
        fp = -2*(1-mu)/(x(i)+mu)^3 + 2*mu/(x(i)-1+mu)^3 -1;
        x(i+1) = x(i) - f/fp;

        err(i) = abs(x(i+1)-x(i));
        if (err(i) < tol)
            break;
        end
    end

    x_final = x(end);
    err_final = err(end);
    n = i;
    res = [x_final,err_final,n];
end

function res = NR_L2(mu,max_iter,tol)
    % Initial guess for x
    x(1) = 1;
   
    % Use Newton-Raphson to calculate x
    for i = 1:(max_iter-1)
        f = (1-mu)/(x(i)+mu)^2 + mu/(x(i)-1+mu)^2 - x(i);
        fp = -2*(1-mu)/(x(i)+mu)^3 - 2*mu/(x(i)-1+mu)^3 -1;
        x(i+1) = x(i) - f/fp;

        err(i) = abs(x(i+1)-x(i));
        if (err(i) < tol)
            break;
        end
    end

    x_final = x(end);
    err_final = err(end);
    n = i;
    res = [x_final,err_final,n];
end

function res = NR_L3(mu,max_iter,tol)
    % Initial guess for x
    x(1) = -1;
   
    % Use Newton-Raphson to calculate x
    for i = 1:(max_iter-1)
        f = -(1-mu)/(x(i)+mu)^2 - mu/(x(i)-1+mu)^2 - x(i);
        fp = 2*(1-mu)/(x(i)+mu)^3 + 2*mu/(x(i)-1+mu)^3 -1;
        x(i+1) = x(i) - f/fp;

        err(i) = abs(x(i+1)-x(i));
        if (err(i) < tol)
            break;
        end
    end

    x_final = x(end);
    err_final = err(end);
    n = i;
    res = [x_final,err_final,n];
end
