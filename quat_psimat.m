function Psi = quat_psimat(q)
q4 = q(4);
q123 = q(1:3);

Psi = [q4*eye(3)-crs(q123);-q123.'];
end
