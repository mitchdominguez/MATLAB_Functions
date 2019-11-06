%% Mitchell Dominguez - output_hohmann.m
% Output data from Hohmann transfer

function [dv, dv_tot, total_tof_hrs, alpha, beta, f, plot_objs] = output_hohmann(orbit1, orbit2, man, tof, mu, f)

    % Unpack orbit data
    a_1 = orbit1.SMA;
    a_2 = orbit2.SMA;

    e_1 = orbit1.ECC;
    e_2 = orbit2.ECC;

    i_1 = orbit1.INC;
    i_2 = orbit2.INC;

    dv = [norm(man{1}.dv), norm(man{2}.dv)];
    dv_tot = sum(dv);
    total_tof = sum(tof);;
    total_tof_hrs = total_tof/3600;
    alpha = [man{1}.alpha, man{2}.alpha] ;
    beta = [man{1}.beta, man{2}.beta] ;

    carts.p1 = rv2coe(man{1}.r,man{1}.v_p,mu);
    carts.p2 = rv2coe(man{2}.r,man{2}.v_p,mu);

    if nargin == 5
        f = figure;
    end

    %% Initial orbit
    %[iCp, r, f, orbit1_plot_objs] = plot_conic_3D(0:360, a_1, e_1, 0, 0, i_1, 'deg', 'r',f);
    %% Final orbit
    %[iCp, r, f, orbit2_plot_objs] = plot_conic_3D(0:360, a_2, e_2, 0, 0, i_2, 'deg', 'b',f);
    % Transfer orbit
    [iCp, r, f, t1_plot_objs] = plot_conic_3D(0:180, carts.p1.SMA, carts.p1.ECC, 0, 0, carts.p1.INC, 'deg', 'k-',f);

    %xlabel('$$\hat{x}$$ [km]')
    %ylabel('$$\hat{y}$$ [km]')
    %zlabel('$$\hat{z}$$ [km]')
    %legend([orbit1_plot_objs.orbit, orbit2_plot_objs.orbit, t1_plot_objs.orbit], 'Initial Orbit', 'Final Orbit', 'Transfer Orbit')
    %plot_objs.orbit1 = orbit1_plot_objs;
    %plot_objs.orbit2 = orbit2_plot_objs;
    plot_objs.transfer = t1_plot_objs;
end
