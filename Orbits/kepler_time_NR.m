% Mitchell Dominguez - Cornell University - 02/15/2018
% Solve Kepler's Time Equation using the Newton-Raphson Method
function [E_final,err] = kepler_time_NR(M,e,max_iter,tol)
% M = mean anomaly
% e = eccentricity
% max_iter = max number of iterations
% tol = convergence criteria

% E = zeros(1,n);

% Calculate E0
if (M/(1-e) < sqrt(6*(1-e)/e))
    E(1) = M/(1-e);
else
    E(1) = (6*M/e)^(1/3);
end

% Use Newton-Raphson to calculate E
for i = 1:(max_iter-1)
    E(i+1) = E(i) - (E(i) - e*sin(E(i)) - M)/(1-e*cos(E(i)));
    
    err(i) = abs(E(i+1)-E(i));
    if (err(i) < tol)
%         fprintf(['At i = %d, the Newton-Raphson method converged '...
%             'for M = %f and e = %f \n'],i,M,e);
        break;
    end
    
end

E_final = E(end);

end
