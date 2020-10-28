%% Mitchell Dominguez - doming18@purdue.edu - zvc_NR.m
function [final_pt,n,info] = zvc_NR(x,y,var2find,mu,C,max_iter,tol)

    if strcmp(var2find,'x')
        % Iterate to find an x value

        % Initial guess for x
        x(1) = x;

        % Use Newton-Raphson to calculate x
        for i = 1:(max_iter-1)
            f(i) = zvc_func(x(i),y,mu,C);
            fp(i) = d_zvc_d_x(x(i),y,mu,C);
            %fpp(i) = d2_zvc_d_y2(x(i),y,mu,C); % For Halley's

            if abs(fp)<1e-8
                error("Stationary point reached")
            end
            x(i+1) = x(i) - f(i)/fp(i); % Newton's Method
            %x(i+1) = x(i) - 2*f(i)*fp(i)/(2*fp(i)^2 - f(i)*fpp(i)); % Halley's Method

            err(i) = abs(x(i+1)-x(i));
            if (err(i) < tol)
                break;
            end
        end
    elseif strcmp(var2find,'y')
        % Iterate to find a y value

        % Initial guess for y
        y(1) = y;

        % Use Newton-Raphson to calculate y
        for i = 1:(max_iter-1)
            f(i) = zvc_func(x,y(i),mu,C);
            fp(i) = d_zvc_d_y(x,y(i),mu,C);
            %fpp(i) = d2_zvc_d_y2(x,y(i),mu,C); % For Halley's

            if abs(fp)<1e-8
                error("Stationary point reached")
            end
            y(i+1) = y(i) - f(i)/fp(i); % Newton's Method
            %y(i+1) = y(i) - 2*f(i)*fp(i)/(2*fp(i)^2 - f(i)*fpp(i)); % Halley's Method

            err(i) = abs(y(i+1)-y(i));
            if (err(i) < tol)
                break;
            end

        end

    else
        error('zvc_NR requires either ''x'' or ''y''')
    end

    x_final = x(end);
    y_final = y(end);
    final_pt = [x_final,y_final];
    n = i;
    info.y = y;
    info.f = f;
    info.fp = fp;
end



