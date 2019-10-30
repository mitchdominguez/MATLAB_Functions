% Mitchell Dominguez
% Solve Kepler's Time Equation for hyperbolic orbits 
% using the Newton-Raphson Method
function [H_final,err] = kepler_time_NR_hyperbola(N,e,max_iter,tol)
% N = mean anomaly
% e = eccentricity
% max_iter = max number of iterations
% tol = convergence criteria

%H(1) = 1.2;
H(1) = N;

% Use Newton-Raphson to calculate E
for i = 1:(max_iter-1)
    H(i+1) = H(i) - (e*sinh(H(i)) - H(i) - N)/(e*cosh(H(i)) - 1);
    
    err(i) = abs(H(i+1)-H(i));
    if (err(i) < tol)
        break;
    end
    
end

H_final = H(end);

end
