%   Parametros Carta de Smith
%
%   This program plots a simple Smith Chart.  It calls
%   on the functions realcirc, imcirc, and z2gamma.
%
%   Abilio Azevedo, 10/11/2016
%
%   Variables:
%       a       circle radius
%       m,n     x,y center of circle
%       theta   angle (degrees)
%       z       a complex location
%       rvalues values to plot for the real circles
%       xvalues values to plot for the imag circles
%       xpos    x location of text
%       ypos    y location of text
%       rl       parte real da carga
%       xl       parte imaginaria da carga

clc     %clears the command window
clear all;
clearvars;
close all;
%rl=[0.5 0.5 0.5 0.5];
%xl=[.2 2 -2 -.2];
%Impedancia da carga
prompt = strcat('Diga a impedancia da carga (parte real)\nSay the load impedance (real part)\n');
rl(1) = str2num(input(prompt,'s'));
prompt = strcat('Diga a impedancia da carga (parte imaginaria)\nSay the load impedance (imaginary part)\n');
prompt = strcat('Say the load impedance (real part)\n');
xl(1) = str2num(input(prompt,'s'));
prompt = strcat('Diga a distancia em direcao ao gerador (em comprimentos de onda)\nSay the distance towards the generator (in wavelengths)\n');
lambda = str2num(input(prompt,'s'));

figure('Name','Carta de Smith')
%first plot comprimento de onda em direc?o ao gerador
theta=linspace(-pi,pi,180);
a=1.5;
m=0;
n=0;
Re=a*cos(theta)+m;
Im=a*sin(theta)+n;
z=Re+1i*Im;
plot(z,'k')
axis('equal')
axis('off')
hold on
xvalues=[0 0.125 0.25 0.375];
xangles=[pi pi/2 0 -pi/2];
for x=1:4
    xpos=a*cos(xangles(x))+m;
    ypos=a*sin(xangles(x))+n;
    h=text([xpos], [ypos], strcat('->',num2str(xvalues(x))));
    if xpos>.1
        set(h,'VerticalAlignment','top');
        set(h,'HorizontalAlignment','center');
        set(h,'Rotation',90);
    elseif xpos<-.1
        set(h,'VerticalAlignment','bottom');
        set(h,'HorizontalAlignment','center');
        set(h,'Rotation',90);
    else
        if ypos<0
            set(h,'VerticalAlignment','top');
            set(h,'HorizontalAlignment','center');
        else
            set(h,'VerticalAlignment','bottom');
            set(h,'HorizontalAlignment','center');
        end
    end
end


%plot comprimento de onda em direcao a carga
theta=linspace(-pi,pi,180);
a=1.4;
m=0;
n=0;
Re=a*cos(theta)+m;
Im=a*sin(theta)+n;
z=Re+1i*Im;
plot(z,'k')
xvalues=[0 0.375 0.25 0.125];
xangles=[pi pi/2 0 -pi/2];
for x=1:4
    xpos=a*cos(xangles(x))+m;
    ypos=a*sin(xangles(x))+n;
    h=text([xpos], [ypos], strcat('<-',num2str(xvalues(x))));
    if xpos>.1
        set(h,'VerticalAlignment','cap');
        set(h,'HorizontalAlignment','center');
        set(h,'Rotation',90);
    elseif xpos<-.1
        set(h,'VerticalAlignment','bottom');
        set(h,'HorizontalAlignment','center');
        set(h,'Rotation',90);
    else
        if ypos<0
            set(h,'VerticalAlignment','top');
            set(h,'HorizontalAlignment','center');
        else
            set(h,'VerticalAlignment','bottom');
            set(h,'HorizontalAlignment','center');
        end
    end
end

%plot angulo do coeficiente de reflecao 
theta=linspace(-pi,pi,180);
a=1.3;
m=0;
n=0;
Re=a*cos(theta)+m;
Im=a*sin(theta)+n;
z=Re+1i*Im;
plot(z,'k')
xvalues={'+-180' '90' '0' '-90'};
xangles=[pi pi/2 0 -pi/2];
for x=1:4
    xpos=a*cos(xangles(x))+m;
    ypos=a*sin(xangles(x))+n;
    h=text([xpos], [ypos], [xvalues(x)]);
    if xpos>.1
        set(h,'VerticalAlignment','top');
        set(h,'HorizontalAlignment','right');
        set(h,'Rotation',90);
    elseif xpos<-.1
        set(h,'VerticalAlignment','bottom');
        set(h,'HorizontalAlignment','center');
        set(h,'Rotation',90);
    else
        if ypos<0
            set(h,'VerticalAlignment','top');
            set(h,'HorizontalAlignment','center');
        else
            set(h,'VerticalAlignment','bottom');
            set(h,'HorizontalAlignment','center');
        end
    end
end

%plot angulo do coeficiente de transmiss?o
theta=linspace(-pi,pi,180);
a=1.2;
m=0;
n=0;
Re=a*cos(theta)+m;
Im=a*sin(theta)+n;
z=Re+1i*Im;
plot(z,'k')
xvalues=[90 45 0 -45 -90];
xangles=[165/180*pi 88/180*pi 0 -88/180*pi -165/180*pi];
for x=1:5
    xpos=a*cos(xangles(x))+m;
    ypos=a*sin(xangles(x))+n;
    h=text([xpos], [ypos], [num2str(xvalues(x))]);
    if xpos>.1
        set(h,'VerticalAlignment','top');
        set(h,'HorizontalAlignment','right');
        set(h,'Rotation',90);
    elseif xpos<-.1
        set(h,'VerticalAlignment','bottom');
        set(h,'HorizontalAlignment','center');
        set(h,'Rotation',90);
    else
        if ypos<0
            set(h,'VerticalAlignment','top');
            set(h,'HorizontalAlignment','center');
        else
            set(h,'VerticalAlignment','bottom');
            set(h,'HorizontalAlignment','center');
        end
    end
end

%plot real = 0 circle
theta=linspace(-pi,pi,180);
a=1;
m=0;
n=0;
Re=a*cos(theta)+m;
Im=a*sin(theta)+n;
z=Re+1i*Im;
plot(z,'k')


for l=1:length(rl)
    %plot the load circle
    loadcirc(rl(l),xl(l));
    %plot load line
    c=loadline(rl(l),xl(l)); %c
    tetaDegrees=lambda*90/0.125;
    if tetaDegrees<0
        tetaDegrees=tetaDegrees+360;
    elseif tetaDegrees>360
        tetaDegrees=tetaDegrees-360;
    end
    c1=abs(c);
    c2=angle(c)-((tetaDegrees*pi)/180);
    c=c1*cos(c2)+1i*c1*sin(c2);
    loadline2(c)
end

%add the x = 0 line
plot([-1 1],[0,0],'k');

%now add real circles
rvalues=[0.5 1 2 4];
if ismember(rl, rvalues)
    rvalues=[0.5 1 2 4];
else
    rvalues=[0.5 1 2 4 rl];
end
for r=rvalues
    realcirc(r);
    xpos=z2gamma(r);
    h=text(xpos,0,num2str(r));
    set(h,'VerticalAlignment','top','HorizontalAlignment','right');
end

%now add +/-x circles imaginary
xvalues=[0.2 0.5 1 2 3];
if ismember(rl, rvalues)
    xvalues=[0.2 0.5 1 2 3];
else
    xvalues=[0.2 0.5 1 2 3 xl];
end
for x=xvalues
    imcirc(x);
    imcirc(-x);
    xpos=real(z2gamma(1i*x));
    ypos=imag(z2gamma(1i*x));
    h=text([xpos xpos], [ypos -ypos], [' j' num2str(x);'-j' num2str(x)]);
    set(h(1),'VerticalAlignment','bottom');
    set(h(2),'VerticalAlignment','top');
    if xpos==0
        set(h,'HorizontalAlignment','center');
    elseif xpos<0
        set(h,'HorizontalAlignment','right');
end

h=text(-1,0,'0');
set(h,'VerticalAlignment','middle','HorizontalAlignment','right');

end