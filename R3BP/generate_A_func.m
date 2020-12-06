ccc;

syms X Y Xdot Ydot mu
d = sqrt((X+mu)^2 + Y^2);
r = sqrt((X-1+mu)^2 + Y^2);
U = (X^2 + Y^2)/2 + (1-mu)/d + mu/r;
Ux = diff(U,X);
Uy = diff(U,Y);
f = [Xdot;Ydot;Ux + 2*Ydot;Uy - 2*Xdot];
A_func = matlabFunction(jacobian(f,[X;Y;Xdot;Ydot]),'File','cr3bp_2d_A.m');



syms X Y Z Xdot Ydot Zdot mu
d = sqrt((X+mu)^2 + Y^2 + Z^2);
r = sqrt((X-1+mu)^2 + Y^2 + Z^2);
U = (X^2 + Y^2)/2 + (1-mu)/d + mu/r;
Ux = diff(U,X);
Uy = diff(U,Y);
Uz = diff(U,Z);
f = [Xdot;Ydot;Zdot;Ux + 2*Ydot;Uy - 2*Xdot;Uz];
A_func = matlabFunction(jacobian(f,[X;Y;Z;Xdot;Ydot;Zdot]),'File','cr3bp_A.m');
