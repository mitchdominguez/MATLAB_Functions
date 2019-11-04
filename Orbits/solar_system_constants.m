%% Mitchell Dominguez - solar_system_constants.m
% Converting table of solar system constants to .mat file
% Units:
%   Axial Rotational Period-------------Rev/Day
%   Mean Equatorial Radius--------------km
%   Gravitational Parameter-------------km3/s2
%   Semi-major Axis of Orbit------------km
%   Orbital Period----------------------s
%   Inclination of Orbit to Ecliptic----deg

%% Sun
sun.ax_rot_period   = 0.0394011;
sun.R               = 695990.00;
sun.mu              = 132712440017.9900;

%% Moon
moon.ax_rot_period  = 0.0366004;
moon.R              = 1738.10;
moon.mu             = 4902.8011;
moon.a              = 384400.000; % About Earth
moon.P              = 2360592; % Orbit period 
moon.e              = 0.0549000;
moon.i              = 5.14500;

%% Mercury
mercury.ax_rot_period  = 0.0170514;
mercury.R              = 2439.70;
mercury.mu             = 22032.0800;
mercury.a              = 57909226.542;
mercury.P              = 7600561.226;
mercury.e              = 0.205636;
mercury.i              = 7.004979;

%% Venus
venus.ax_rot_period  = 0.0041149; % RETROGRADE
venus.R              = 6051.90;
venus.mu             = 324858.5988;
venus.a              = 108209474.537;
venus.P              = 19414287.29;
venus.e              = 0.006776720;
venus.i              = 3.394676;

%% Earth
earth.ax_rot_period  = 1.0027395;
earth.R              = 6378.136;
earth.mu             = 398600.4415;
earth.a              = 149597870.700;
earth.P              = 31558148.63;
earth.e              = 0.01671022;
earth.i              = 0.00005;

%% Mars
mars.ax_rot_period  = 0.9747000;
mars.R              = 3397.00;
mars.mu             = 42828.3143;
mars.a              = 227943822.428;
mars.P              = 59356149.69;
mars.e              = 0.0933941000;
mars.i              = 1.849691;

%% Jupiter
jupiter.ax_rot_period  = 2.4181573;
jupiter.R              = 71492.00;
jupiter.mu             = 126712767.8578;
jupiter.a              = 778340816.693;
jupiter.P              = 374344561.8;
jupiter.e              = 0.0483862400;
jupiter.i              = 1.304397;

%% Saturn
saturn.ax_rot_period  = 2.2522053;
saturn.R              = 60268.00;
saturn.mu             = 37940626.0611;
saturn.a              = 1426666414.180;
saturn.P              = 929277960.1;
saturn.e              = 0.05386179;
saturn.i              = 2.485992;

%% Uranus
uranus.ax_rot_period  = 1.3921114; % retrograde
uranus.R              = 25559.00;
uranus.mu             = 5794549.00707190;
uranus.a              = 2870658170.656;
uranus.P              = 2652691782;
uranus.e              = 0.047257440;
uranus.i              = 0.77264;

%% Neptune
neptune.ax_rot_period  = 1.4897579;
neptune.R              = 25269.00;
neptune.mu             = 6836534.0639;
neptune.a              = 4498396417.0095;
neptune.P              = 5203546650;
neptune.e              = 0.008590480;
neptune.i              = 1.770043;

%% Pluto
pluto.ax_rot_period  = 0.1565620;
pluto.R              = 1162.00;
pluto.mu             = 981.6009;
pluto.a              = 5906440596.5288;
pluto.P              = 7829117488;
pluto.e              = 0.248827300;
pluto.i              = 17.140012;
