%% Mitchell Dominguez - rot_rthh2inertial.m
% Return the rotation matrix iCr such that 
%   v_I = iCr*v_R
% where v_R is a vector in the rhat-thetahat-hhat frame and v_R is 
% that vector rotated into the chosen inertial frame
%
% Outputs:
%   iCr = rotation matrix from rotating to inertial frame
% Inputs:
%   RAAN = longitude of the ascending node
%   INC = inclination
%   TH = angle of periapsis + true anomaly
%   units = 'rad' or 'deg', specifying units that angular COEs are given in

function iCr = rot_rthh2inertial(RAAN,INC,TH,units)
    iCr = rotmataa([0;0;1],RAAN,units)*rotmataa([1;0;0],INC,units)*rotmataa([0;0;1],TH,units);
end
