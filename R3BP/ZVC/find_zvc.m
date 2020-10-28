%% Mitchell Dominguez - doming18@purdue.edu - find_zvc.m
% Find the Zero Velocity Curve for a given system
function soln = find_zvc(mu, C)

    % Calculate Lagrange Point Jacobi Constants
    %   This will help with determining how many x-axis crossings there are
    [L1,L2,L3] = collinear_lagrange(mu,1e2,1e-12);
    r_L1 = [L1(1);0];
    r_L2 = [L2(1);0];
    r_L3 = [L3(1);0];
    r_L4 = [0.48785;0.866025];

    C_L1 = jacobi_2d(r_L1',zeros(1,2),mu);
    C_L2 = jacobi_2d(r_L2',zeros(1,2),mu);
    C_L3 = jacobi_2d(r_L3',zeros(1,2),mu);
    C_L45 = jacobi_2d(r_L4',zeros(1,2),mu);

    % Determine number of solutions to expect
    if C > C_L1
        n = 6; % enclosed regions around primaries
    elseif abs(C-C_L1)<1e-8 % C == C_L1
        n = 5; % Intersection at L1
    elseif C > C_L2
        n = 4; % Gateway at L1
    elseif abs(C-C_L2)<1e-8 % C == C_L2
        n = 3; % Intersection at L2
    elseif C > C_L3
        n = 2; % Escape route at L2
    elseif abs(C-C_L3)<1e-8 % C == C_L3
        n = 1; % Intersection at L3
    else
        n = 0; % No x-axis crossings
    end

    syms x y;

    f = vpa(x^2 + y^2 + 2*(1-mu)/((x+mu)^2 + y^2)^(1/2) ...
        + 2*mu/((x-1+mu)^2 + y^2)^(1/2) - C);

    x_y0 = sort(double(solve(subs(f,y,0)==0,x,'real',true))); % x axis crossings


    switch n
        case 2
            soln = gen_zvc_curve([x_y0(end),0],mu,C);
        case 4
            outer = gen_zvc_curve([x_y0(end),0],mu,C); % Solve outer loop
            inner = gen_zvc_curve([x_y0(end-1),0],mu,C); % Solve inner loop
            soln.outer = outer;
            soln.inner = inner;
        case 6
            outer = gen_zvc_curve([x_y0(end),0],mu,C); % Solve outer loop
            m2 = gen_zvc_curve([x_y0(end-1),0],mu,C); % Solve m2 loop
            m1 = gen_zvc_curve([x_y0(end-3),0],mu,C); % Solve m1 loop
            soln.outer = outer;
            soln.m2 = m2;
            soln.m1 = m1;
    end
end
