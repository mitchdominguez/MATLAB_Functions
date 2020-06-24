function oe = convert_oe_struct(oe)
    % Convert between using caps orbital elements and lowercase abbreviations
    if ~isfield(oe,'SMA') && isfield(oe,'a')
        oe.SMA = oe.a;
    end
    if ~isfield(oe,'ECC') && isfield(oe,'e')
        oe.ECC = oe.e;
    end
    if ~isfield(oe,'TA') && isfield(oe,'thstar')
        oe.TA = oe.thstar;
    end
    if ~isfield(oe,'AOP') && isfield(oe,'omega')
        oe.AOP = oe.omega;
    end
    if ~isfield(oe,'RAAN') && isfield(oe,'Omega')
        oe.RAAN = oe.Omega;
    end
    if ~isfield(oe,'INC') && isfield(oe,'i')
        oe.INC = oe.i;
    end

    % Assume 3D orbital elements are zero if they are not given
    if ~isfield(oe,'AOP')
        oe.AOP = 0;
    end
    if ~isfield(oe,'RAAN')
        oe.RAAN = 0;
    end
    if ~isfield(oe,'INC')
        oe.INC = 0;
    end

end
