%% Mitchell Dominguez - doming18@purdue.edu - axang2dcm.m
% Convert Euler axis, Euler angle to the DCM aCb (for row vectors)
% INPUTS:
%   lam: axis of rotation (may or may not be a unit vector) [1x3]
%   th: angle of rotation [1x1]
%   unit: 'deg' or 'rad'
% OUTPUTS:
%   aCb: DCM [3x3]

function aCb = axang2dcm(lam,th,unit)
    lam = lam/norm(lam); % normalize axis
    %v = lam(:);
    %if strcmp(unit,'deg')
        %aCb = (cosd(th)*eye(3) + (1-cosd(th))*(v*v.') - sind(th)*crs(v)).';
    %else
        %aCb = (cos(th)*eye(3) + (1-cos(th))*(v*v.') - sin(th)*crs(v)).';
    %end

    %aCb
    lam1 = lam(1); lam2 = lam(2); lam3 = lam(3);

    if strcmp(unit,'deg')
        aCb(1,1) = cosd(th) + lam1*lam1*(1-cosd(th));
        aCb(1,2) = -lam3*sind(th) + lam1*lam2*(1-cosd(th));
        aCb(1,3) = lam2*sind(th) + lam1*lam3*(1-cosd(th));
        aCb(2,1) = lam3*sind(th) + lam2*lam1*(1-cosd(th));
        aCb(2,2) = cosd(th) + lam2*lam2*(1-cosd(th));
        aCb(2,3) = -lam1*sind(th) + lam2*lam3*(1-cosd(th));
        aCb(3,1) = -lam2*sind(th) + lam3*lam1*(1-cosd(th));
        aCb(3,2) = lam1*sind(th) + lam3*lam2*(1-cosd(th));
        aCb(3,3) = cosd(th) + lam3*lam3*(1-cosd(th));
    else
        aCb(1,1) = cos(th) + lam1*lam1*(1-cos(th));
        aCb(1,2) = -lam3*sin(th) + lam1*lam2*(1-cos(th));
        aCb(1,3) = lam2*sin(th) + lam1*lam3*(1-cos(th));
        aCb(2,1) = lam3*sin(th) + lam2*lam1*(1-cos(th));
        aCb(2,2) = cos(th) + lam2*lam2*(1-cos(th));
        aCb(2,3) = -lam1*sin(th) + lam2*lam3*(1-cos(th));
        aCb(3,1) = -lam2*sin(th) + lam3*lam1*(1-cos(th));
        aCb(3,2) = lam1*sin(th) + lam3*lam2*(1-cos(th));
        aCb(3,3) = cos(th) + lam3*lam3*(1-cos(th));
    end

    %assert(norm(aCb) == 1,'Error: matrix does not have unit norm')
end
