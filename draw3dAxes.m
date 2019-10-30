%% Mitchell Dominguez 2018
% Draw 3D Coordinate Axes (axis equal and hold on)
% INPUTS:
%   orig:       Location of origin
%   A:          Orientation of axes (DCM)
%   axlength:   how long each plotted axis should appear in base units (m)
%   scale:      unit scaling (1 for m, but 1000 to plot in mm, for example)
function draw3dAxes(orig,A,axlength,scale,linewidth)
x = [1;0;0];
y = [0;1;0];
z = [0;0;1];

xt_c = axlength*A*x;
yt_c = axlength*A*y;
zt_c = axlength*A*z;

orig = orig*scale;
xt_c = xt_c*scale;
yt_c = yt_c*scale;
zt_c = zt_c*scale;

if nargin == 5
    linewidth = linewidth;
else
    linewidth = 3;
end

hold on
axis equal
plot3(orig(1),orig(2),orig(3),'k.','markers',30)
plot3([orig(1) orig(1)+xt_c(1)],[orig(2) orig(2)+xt_c(2)],[orig(3) orig(3)+xt_c(3)],'r','LineWidth',linewidth)
plot3([orig(1) orig(1)+yt_c(1)],[orig(2) orig(2)+yt_c(2)],[orig(3) orig(3)+yt_c(3)],'g','LineWidth',linewidth)
plot3([orig(1) orig(1)+zt_c(1)],[orig(2) orig(2)+zt_c(2)],[orig(3) orig(3)+zt_c(3)],'b','LineWidth',linewidth)

end
