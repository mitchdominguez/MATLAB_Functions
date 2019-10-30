%% Mitchell Dominguez - common_value.m
% Pick the common value between two vectors
% Equality assessed within a tolerance

function angle = common_angle(v1,v2,tol)
    angle = 'no common value';
    for i=1:length(v1)
        for j = 1:length(v2)
            %fprintf('%d <|> %d\n\n',v1(i), v2(j))
            if abs(v1(i) - v2(j)) < tol
                angle = v1(i);
                return;
            end
        end
    end
    if angle == 'no common value'
        disp(angle)
    end
end
