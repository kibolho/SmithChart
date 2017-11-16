function [c]=loadline(r,x)
%c = ponto de encontro entre r e x
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
angle2=zeros(360);
Re2=zeros(360);
Im2=zeros(360);
z2=zeros(360);
d=zeros(360,360);
for t=1:1:360
    angle2(t)=t*pi/180;
    Re2(t)=a2*cos(angle2(t))+m2;
    Im2(t)=a2*sin(angle2(t))+n2;
    z2(t)=Re2(t)+1i*Im2(t);
    if abs(z2(t)) <= 1
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
z=[0 c 1.1*c 1.5*c 1.7*c 1.9*c 2*c 2.2*c 2.4*c 2.5*c 2.7*c 2.9*c 3*c 3.3*c 3.6*c 3.9*c 4.2*c 4.5*c 4.8*c 5.1*c 5.4*c 5.7*c 6*c];
for j=1:23
    if abs(z(j))>1.7
        z(j)=0;
    end
end
plot(z,'r')


%plot comprimento de onda em direc?o ao gerador
whos angle
clear angle
teta=angle(c);
teta=wrapTo2Pi(teta);
tetaDegrees=teta*180/pi;
m=0;
n=0;
a=1.7;
xpos=a*cos(teta)+m;
ypos=a*sin(teta)+n;
if tetaDegrees<0
    tetaDegrees=tetaDegrees+360;
end
tetaDegreesMap=map(tetaDegrees,0,360,540,180);
if tetaDegreesMap>360
    tetaDegreesMap=tetaDegreesMap-360;
end
lambda=tetaDegreesMap*0.125/90;     
h=text(xpos, ypos, num2str(lambda));
if ypos<0
    set(h,'VerticalAlignment','top');
    set(h,'HorizontalAlignment','center');
else
    set(h,'VerticalAlignment','bottom');
    set(h,'HorizontalAlignment','center');
end

%plot comprimento de onda em direcao a carga
a=1.55;
xpos=a*cos(teta)+m;
ypos=a*sin(teta)+n;
tetaDegreesMap=map(tetaDegrees,0,360,180,540);
if tetaDegreesMap>360
    tetaDegreesMap=tetaDegreesMap-360;
end
lambda=tetaDegreesMap*0.125/90;
%lambda=map(lambda,0,.5,.5,0)      
h=text(xpos, ypos, num2str(lambda));
if ypos<0
    set(h,'VerticalAlignment','top');
    set(h,'HorizontalAlignment','center');
else
    set(h,'VerticalAlignment','bottom');
    set(h,'HorizontalAlignment','center');
end

%plot angulo do coeficiente de reflecao 
a=1.4;
xpos=a*cos(teta)+m;
ypos=a*sin(teta)+n;
%lambda=map(lambda,0,.5,.5,0)      
h=text(xpos, ypos, num2str(tetaDegrees));
if ypos<0
    set(h,'VerticalAlignment','top');
    set(h,'HorizontalAlignment','center');
else
    set(h,'VerticalAlignment','bottom');
    set(h,'HorizontalAlignment','center');
end

%plot angulo do coeficiente de transmiss?o
a=1.2;
xpos=a*cos(teta)+m;
ypos=a*sin(teta)+n;
x=tetaDegrees;
if x<=180
tetaDegreesMap=((49704514655*x^5)/73786976294838206464 - (8019064309*x^4)/36028797018963968 + (31922261529*x^3)/1125899906842624 - (28241392431*x^2)/17592186044416 + (599073244209*x)/1099511627776 + 3186465329/274877906944);
else
x=map(x,180,360,180,0);
tetaDegreesMap=((49704514655*x^5)/73786976294838206464 - (8019064309*x^4)/36028797018963968 + (31922261529*x^3)/1125899906842624 - (28241392431*x^2)/17592186044416 + (599073244209*x)/1099511627776 + 3186465329/274877906944);
tetaDegreesMap=-tetaDegreesMap;
end   
h=text(xpos, ypos, num2str(tetaDegreesMap));
if ypos<0
    set(h,'VerticalAlignment','top');
    set(h,'HorizontalAlignment','center');
else
    set(h,'VerticalAlignment','bottom');
    set(h,'HorizontalAlignment','center');
end

% VSWR ou Voltage Standing Wave Ratio ? uma taxa da amplitude m?xima de
% tens?o sobre a amplitude m?nima de tens?o (onda estacion?ria)
a=1.8;
xpos=a*cos(teta)+m;
ypos=a*sin(teta)+n;
VSWR=1/abs(c);
h=text(xpos, ypos,strcat('Carga - VSWR ',num2str(VSWR)));
set(h,'Color','red');
if ypos<0
    set(h,'VerticalAlignment','top');
    set(h,'HorizontalAlignment','center');
else
    set(h,'VerticalAlignment','bottom');
    set(h,'HorizontalAlignment','center');
end
