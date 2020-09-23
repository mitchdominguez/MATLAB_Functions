% Mitchell Dominguez - Cornell University - 02/15/2018
% Solve Kepler's Time Equation using the Newton-Raphson Method
%
% Outputs:
%   E_final = calculated eccentric anomaly [rad]
%   err = error from NR iteration
%   n = number of iterations
% Inputs:
%   M = mean anomaly [rad]
%   e = eccentricity
%   max_iter = maximum number of iterations allowed
%   tol = convergence criteria
function [E_final,err,n] = kepler_time_NR(M,e,max_iter,tol)

% Calculate E0
E(1) = M;
%if (M/(1-e) < sqrt(6*(1-e)/e))
    %E(1) = M/(1-e);
%else
    %E(1) = (6*M/e)^(1/3);
%end

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
n = i;

end
