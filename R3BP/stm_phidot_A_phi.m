function Zdot = stm_phidot_A_phi(t,Z,mu)
    % unpack variables
    z = Z(1:6);
    phi = reshape(Z(7:end),[6 6]);

    zdot = cr3bp(t,z,mu);
    phidot = cr3bp_A(z(1),z(2),z(3),mu)*phi;

    Zdot = [zdot;reshape(phidot,[36 1])];
end
