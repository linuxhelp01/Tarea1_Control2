close all; clear all; clc;
set(0,'DefaultAxesFontName', 'Times New Roman');
set(0,'DefaultAxesFontSize',12);
set(0,'DefaultLineLineWidth', 1.5);
set(0,'DefaultLineMarkerSize',8);
%% Parametros
global Gdc Gac Lf Rf Cdc Ll Rl Vrms mqo mdo Vsq Vsd w Ipv Vdc Vpv 

tspan = linspace(0,1000e-3,1001);
% Parametros
Gdc = 0.5;
Gac = Gdc;
Lf = 7e-3; % 7 mili-henrrios
Rf = 0.7; %Resistencia (Ohms)
Cdc = 2e-3; % 2 mili-faradios
Ll = 5.7e-3; % 5.7 mili-henrrios
Rl = 5; % Resistenciaa (Ohms)
Vrms = 220; % Voltaje RMS [V]
f = 50; % frecuencia [Hz]
w = 2*pi*f; % Frecuencia angular [Rad]
fps = 0.93; % Factor de potencia
%% Pregunta C 
% Puntos de Operacion 

Vdc = 800;
Vpv = Vdc;
Ipv = 23.35; % Corriente Panel Fotovoltaico
x1o = Vdc; % Punto de operacion del voltaje Vdc
Vsd = sqrt(3)*Vrms;
Vsq = 0;
%% Ecuaciones para obtener los ptos de operacion
syms x2o x3o x4o x5o mdo mqo

ec1 = (Ipv/Cdc) - ((Gdc*mdo)/Cdc)*x2o - ((Gdc*mqo)/Cdc)*x3o ==0;
ec2 = ((Gac/Lf)*mdo*x1o) - ((1/Lf)*Vsd) - ((Rf/Lf)*x2o) + (w*x3o) ==0; 
ec3 = ((Gac/Lf)*mqo*x1o) - ((1/Lf)*Vsq) - ((Rf/Lf)*x3o) - (w*x2o) ==0;
ec4 = -((Rl/Ll)*x4o) + ((1/Ll)*Vsd) + (w*x5o) ==0;
ec5 = -((Rl/Ll)*x5o) + ((1/Ll)*Vsq) - (w*x4o) ==0;
ec6 = -acos(fps)-atan((x5o-x3o)/(x4o-x2o));

ec = [ec1,ec2,ec3,ec4,ec5,ec6];
ing = [x2o x3o x4o x5o mdo mqo];

s = vpasolve(ec,ing);
%% Soluciones
s = vpasolve(ec,ing);
x2o = double(s.x2o(:,1));
x3o = double(s.x3o(:,1));
x4o = double(s.x4o(:,1));
x5o = double(s.x5o(:,1));
mdo = double(s.mdo(:,1));
mqo = double(s.mqo(:,1));
%% Derivada
[t,x] = ode45('call_nolinealPro',tspan,[x1o;x2o;x3o;x4o;x5o]);
%% Graficas
% Entrada
md = mdo - 0.1*mdo*(t>=0.05);
mq = mqo - 0.1*mqo*(t>=0.550);
% Pertubacion
v_sd = Vsd - 0.05*Vsd*(t>=0.3);

% Graficas
figure(1),subplot(511),plot(t,x(:,1),"R",lineWidth=1.5),title('Voltaje del Condensador'), grid on;...
    legend('vdc'),xlabel('[Tiempo (ms)]'),ylabel('[Amplitud (V)]');
figure(1),subplot(512),plot(t,x(:,2),"B",lineWidth=1.5),title('Corriente Ic directa');...
    grid on,legend('Ic^d'),xlabel('[Tiempo (ms)]'),ylabel('[Amplitud (A)]');
figure(1),subplot(513),plot(t,x(:,3),"B",lineWidth=1.5),title('Corriente Ic cuadratura');...
    grid on,legend('Ic^q'),xlabel('[Tiempo (ms)]'),ylabel('[Amplitud (A)]');
figure(1),subplot(514),plot(t,x(:,4),"R",lineWidth=1.5),title('Corriente Il directa');...
    grid on,legend('Il^d'),xlabel('[Tiempo (ms)]'),ylabel('[Amplitud (A)]');
figure(1),subplot(515),plot(t,x(:,5),"R",lineWidth=1.5),title('Corriente Il cuadratura');...
    grid on,legend('Il^q'),xlabel('[Tiempo (ms)]'),ylabel('[Amplitud (A)]');

figure(2),subplot(211),plot(t,x(:,2),t,x(:,3),"R" ,LineWidth=1.5), grid on; ...
    title('Comparación Corriente Ic Directa y Cuadratura');...
    legend('Ic^d','Ic^q'),xlabel('[Tiempo (ms)]'),ylabel('[Amplitud (A)]');
figure(2),subplot(212),plot(t,x(:,4),t,x(:,5),"B" ,LineWidth=1.5), grid on; ...
    title('Comparación Corriente Il Directa y Cuadratura');...
    legend('Il^d','Il^q'),xlabel('[Tiempo (ms)]'),ylabel('[Amplitud (A)]');

figure(3),subplot(211),plot(t,md,t,mq,LineWidth=1.5),title('Entradas moduladoras Md y Mq');...
    grid on, legend('m^d','m^q'),xlabel('[Tiempo (ms)]'),ylabel('[Amplitud]');
figure(3),subplot(212),plot(t,v_sd,t,Vsq,LineWidth=1.5),title('Perturbaciones'),grid on;...
    legend('v^d_s','Vsq'),xlabel('[Tiempo (ms)]'),ylabel('[Amplitud (V)]');
%% Pregunta D)







