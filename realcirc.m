function [h]=realcirc(r)
%REALCIRC(r) draws  circle of constant real with normalized r;
phi=1:1:360;
theta=phi*pi/180;
a=1/(1+r);
m=r/(r+1);
n=0;
Re=a*cos(theta)+m;
Im=a*sin(theta)+n;
z=Re+i*Im;
h=plot(z,'k');
axis('equal')
axis('off')