function []=loadcirc(r,x)
c=1; %raio do circulo de carga
%REALCIRC(r) draws  circle of constant real with normalized r;
phi=1:1:360;
theta1=phi*pi/180;
a1=1/(1+r);
m1=r/(r+1);
n1=0;
Re1=a1*cos(theta1)+m1;
Im1=a1*sin(theta1)+n1;
z1=Re1+1i*Im1;
tamZreal = size(z1);
tamZreal=tamZreal(2); %coluna
%h=plot(z1,'k');
%IMCIRC(x) draws a circle of constant imag with normalized x;
a2=abs(1/x);
m2=1;
n2=1/x;
k=1;
minimumBefore=1;
for t=1:1:360
    angle(t)=t*pi/180;
    Re2(t)=a2*cos(angle(t))+m2;
    Im2(t)=a2*sin(angle(t))+n2;
    z2(t)=Re2(t)+1i*Im2(t);
    if abs(z2(t)) <= 1
        z3(k)=z2(t);
        for j=1:tamZreal
            X = [real(z2(t)),imag(z2(t));real(z1(j)),imag(z1(j))];
            d(t,j) = pdist(X,'euclidean');
        end
        k=k+1;
        [minimum,index] = min(d(t,:));
        if minimum<minimumBefore
            if real(z1(index))<0.75
                c=z1(index);
            end
        end
        minimumBefore=minimum;
    end
end
%h=plot(z3,'k');
%axis('equal')
%axis('off')
%plot load circ
theta2=linspace(-pi,pi,180);
a3=abs(c);
m3=0;
n3=0;
Re3=a3*cos(theta2)+m3;
Im3=a3*sin(theta2)+n3;
z4=Re3+i*Im3;
plot(z4,'r')
