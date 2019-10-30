function Xi = quat_ximat(q)
q4 = q(4);
q123 = q(1:3);

Xi = [q4*eye(3)+crs(q123);-q123.'];
end