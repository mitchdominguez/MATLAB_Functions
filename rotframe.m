%% Mitchell Dominguez 2018
% Find the rotation matrix bCi given the orthonormal basis vectors for the
% B frame and I frame, respectively
function bCi = rotframe(xb,yb,zb,xi,yi,zi)
bCi = [dot(xi,xb),dot(xi,yb),dot(xi,zb);
       dot(yi,xb),dot(yi,yb),dot(yi,zb);
       dot(zi,xb),dot(zi,yb),dot(zi,zb)];
end