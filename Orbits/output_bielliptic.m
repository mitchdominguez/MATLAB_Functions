%% Mitchell Dominguez - output_bielliptic.m
% Output data from bielliptic transfer

function [dv, dv_tot, total_tof_hrs, alpha, beta, f] = output_bielliptic(orbit1, orbit2, man, tof, mu, f)

    % Unpack orbit data
    a_1 = orbit1.SMA;
    a_2 = orbit2.SMA;

    e_1 = orbit1.ECC;
    e_2 = orbit2.ECC;

    i_1 = orbit1.INC;
    i_2 = orbit2.INC;

    dv = [norm(man{1}.dv), norm(man{2}.dv), norm(man{3}.dv)];
    dv_tot = sum(dv);
    total_tof = sum(tof);;
    total_tof_hrs = total_tof/3600;
    alpha = [man{1}.alpha, man{2}.alpha, man{3}.alpha] ;
    beta = [man{1}.beta, man{2}.beta, man{3}.beta] ;

    carts.p1 = rv2coe(man{1}.r,man{1}.v_p,mu);
    carts.p2 = rv2coe(man{2}.r,man{2}.v_p,mu);

    if nargin == 5
        f = figure;
    end

    % Initial orbit
    [iCp, r, f, orbit1_plot_objs] = plot_conic_3D(1:360, a_1, e_1, 0, 0, i_1, 'deg', 'r',f);
    % Final orbit
    [iCp, r, f, orbit2_plot_objs] = plot_conic_3D(1:360, a_2, e_2, 0, 0, i_2, 'deg', 'b',f);
    % Transfer orbit 1
    [iCp, r, f, t1_plot_objs] = plot_conic_3D(0:180, carts.p1.SMA, carts.p1.ECC, 0, 0, carts.p1.INC, 'deg', 'r--',f);
    % Transfer orbit 2
    [iCp, r, f, t2_plot_objs] = plot_conic_3D(180:360, carts.p2.SMA, carts.p2.ECC, 0, 0, carts.p2.INC, 'deg', 'b--',f);

    xlabel('$$\hat{x}$$ [km]')
    ylabel('$$\hat{y}$$ [km]')
    zlabel('$$\hat{z}$$ [km]')
    legend([orbit1_plot_objs.orbit, orbit2_plot_objs.orbit, t1_plot_objs.orbit, t2_plot_objs.orbit], 'Initial Orbit', 'Final Orbit', 'Transfer Orbit 1', 'Transfer Orbit 2')
end
