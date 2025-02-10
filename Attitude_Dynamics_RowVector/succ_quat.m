%% Mitchell Dominguez - doming18@purdue.edu - succ_quat.m
% Successive rotations using quaternions
%   Rot 1: A->P
%   Rot 2: P->B
%
% INPUTS:
%   eps_ap = quaternion for rotation 1, scalar part as 4th element, in a or p frame
%   eps_pb = quaternion for rotation 2, scalar part as 4th element, in p or b frame
%
% OUTPUTS:
%   eps_ab = quaternion reprenting overall rotation, scalar part as 4th element
%               expressed in the a or b frame

function eps_ab = succ_quat(eps_ap, eps_pb)
    eps_ap_vec = eps_ap(1:3);
    eps_ap_4 = eps_ap(4);

    eps_pb_vec = eps_pb(1:3);
    eps_pb_4 = eps_pb(4);

    eps_ab_vec = eps_ap_vec*eps_pb_4 + eps_pb_vec*eps_ap_4 ...
        + cross(eps_pb_vec,eps_ap_vec);

    eps_ab_4 = eps_ap_4*eps_pb_4 - dot(eps_ap_vec,eps_pb_vec);


    % Expressed in P frame! 
    eps_ab_P = [eps_ab_vec, eps_ab_4];  

    % Return eps_ab in A or B frame
    % pCa = quat2dcm(eps_ap)';
    % eps_ab = [ eps_ab_vec*pCa, eps_ab_4]

    pCb = quat2dcm(eps_pb);
    eps_ab = [ eps_ab_vec*pCb, eps_ab_4];
    
%     return

     %CORRECT MATRIX VERSION BELOW
%     A = [eps_ap(4), -eps_ap(3), eps_ap(2), eps_ap(1);
%         eps_ap(3), eps_ap(4), -eps_ap(1), eps_ap(2);
%         -eps_ap(2), eps_ap(1), eps_ap(4), eps_ap(3);
%         -eps_ap(1), -eps_ap(2), -eps_ap(3), eps_ap(4)];
% 
%     eps_ab = A*eps_pb';

end
