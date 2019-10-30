function [kep] = cart2kep(cart_ph, mu)    

% converts cartesian states to Keplerian

%mu = 42828.3719012840;

r_ph = cart_ph(1:3);
r_mag = norm(r_ph);
v_ph = cart_ph(4:6);
v_mag = norm(v_ph);

h = cross(r_ph,v_ph);
h_mag = norm(h);

E = v_mag^2/2 - mu/r_mag;

kep(1) = -mu/(2*E);                                                                        %a
kep(2) = (1 - h_mag^2/(kep(1)*mu))^(1/2);                                                  %e
kep(3) = acos(h(3)/h_mag);                                                                     %inc (rad)
kep(4) = atan2(h(1), -h(2));                                                                   %lan (rad)
kep(5) = atan2((cart_ph(3)/sin(kep(3))),((cart_ph(1)*cos(kep(4))) + cart_ph(2)*sin(kep(4))));  %arla (rad)

end
