function Zdot = stm_phidot_A_phi(t,Z,mu)
    % unpack variables
    z = Z(1:4);
    phi = reshape(Z(5:20),[4 4]);

    zdot = cr3bp_2d(t,z,mu);
    phidot = cr3bp_2d_A(z(1),z(2))*phi;

    Zdot = [zdot;reshape(phidot,[16 1])];
end
