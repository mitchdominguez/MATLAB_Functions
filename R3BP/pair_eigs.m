%% Mitchell Dominguez - doming18@purdue.edu - pair_eigs.m
% Organize eigenvalues of the monodromy matrix into pairs, 
% with the singular eigenvalues in indices 5 and 6


function lam = pair_eigs(lam)
    % Find unit eigenvalues, which will be indices 5 and 6
    [~,ind5] = min(abs(lam-1));
    lam5 = lam(ind5)
    tlam0 = lam([1:ind5-1,ind5+1:end]);
    [~,ind6] = min(abs(tlam0-1));
    lam6 = tlam0(ind6)

    % Find first reciprocal pair 
    tlam = lam(lam~=lam5 & lam~=lam6);
    lam1 = tlam(1)
    [~,ind2] = min(abs(tlam-1/lam1));
    lam2 = tlam(ind2)

    % Find second reciprocal pair
    lam34 = tlam(tlam~=lam1 & tlam~=lam2);
    lam3 = lam34(1)
    lam4 = lam34(2)

    lam = [lam1;lam2;lam3;lam4;lam5;lam6];
end

