%% Mitchell Dominguez - calc_3D_alpha_beta.m

function [alpha, beta] = calc_3D_alpha_beta(r,v,dv)
    % Calculate alpha, beta
    [C,V,N] = vnc_basis(r,v);
    dv_cvn = [dot(dv,C), dot(dv,V), dot(dv,N)]; % delta v in the CVN frame
    dv_cv = [dv_cvn(1),dv_cvn(2),0]; % delta v component in the C-V plane
    alpha = atan2d(dv_cvn(1),dv_cvn(2));
    beta = acosd(dot(dv_cvn,dv_cv)/(norm(dv_cvn)*norm(dv_cv)));
end
