%% Mitchell Dominguez - doming18@purdue.edu - test_succ.m
% Test successive rotations code
ccc; format compact;
define_xyz;

% aCp = axang2dcm([1;3;7],23,'deg');
% pCb = axang2dcm([4,2,0],69,'deg');
for i = 1:100
    aCp = axang2dcm(rand(3,1)-0.5, rand(1)*360, 'deg');
    pCb = axang2dcm([4,2,0],69,'deg');
    aCb = aCp*pCb;

    eps_ap = dcm2quat(aCp); % In the A frame or P frame
    eps_pb = dcm2quat(pCb); % In the P frame or B frame

    %eps_pb(1:3) = eps_pb(1:3)*aCp';
    %eps_pb(1:3) = eps_pb(1:3)*aCb';
    %eps_ap(1:3) = eps_ap(1:3)*aCb;

    %lam = eps_pb(1:3)/sqrt(1-eps_pb(4)^2)

    %th_1 = 2*asind(eps_pb(1:3)/lam(1))
    %th_2 = 2*acosd(eps_pb(4))

    eps_ab = succ_quat(eps_ap,eps_pb);

    aCb_from_quat = quat2dcm(eps_ab);
    
%     norm(aCb_from_quat-aCb)
%     norm(aCb_from_quat-aCb) > 1e-14
    assert(norm(aCb_from_quat-aCb)<1e-10, ...
        sprintf('Error in successive rotations equal to %d!',norm(aCb_from_quat-aCb)))
end

%z = [-0.27; -0.42; 0; 0.3; -1.028; 0];
%Z0 = [z;reshape(eye(6),[36 1])];
%t = [0 1];
%mu = 0.01215;

%ode_opts = odeset('AbsTol',1e-18,'RelTol',1e-13); % ODE options
%[T,Z] = ode113(@stm_phidot_A_phi,t,Z0,ode_opts,mu);

%phi_end = reshape(Z(end,7:end),[6 6])
