%% Mitchell Dominguez - doming18@purdue.edu 
% Common unit conversions
% Usage:
%   The naming convention for the variables is always <unit1>2<unit2>
%   where unit1 is the original unit and unit2 is the desired unit. 
%   For example, the variable m2km is 1e-3, since you multiply a variable
%   of units by 1e-3 to achieve a unit conversion to km. 

%% LENGTH
m2km = 1e-3; 
km2m = 1e3;
au2km = 149597870700*m2km;
km2au = 1/au2km;

%% TIME
min2sec = 60;
sec2min = 1/min2sec;

hr2min = 60;
min2hr = 1/hr2min;

day2hr = 24;
hr2day = 1/day2hr;

sec2hr = sec2min*min2hr;
hr2sec = hr2min*min2sec;

sec2day = sec2hr*hr2day;
day2sec = day2hr*hr2sec;

min2day = min2hr*hr2day;
day2min = day2hr*hr2min;

%% MASS
