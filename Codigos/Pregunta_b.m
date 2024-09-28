close all
clc
%% Parametros

% Parametros tarea

t = 0:100e-6:0.25; %tiempo de simulacion

Gdc = 0.5;
Gac = Gdc;

Lf = 7*10^-3; % 7 mili-henrrios
Rf = 0.7; %Resistencia (Ohms)
Cdc = 2*10^-2; % 2 mili-faradios
Ll = 5.7; % 5.7 muli-henrrios
Rl = 5; % Resistenciaa (Ohms)


%parametros de perturbacion

%Amplitud de señales
Ag = 220*sqrt(3)*(t>=0); %Amplitud de volaje de linea
% A1, A2 y A3 indican la proporcion de la amplitud que tiene cada fase
A1 = 1;
A2 = 1;
A3 = 1;

%Desface
FP = 1; %Factor de potencia
Ph = acos(FP);
%Ph1, Ph2 y Ph3 indican el desface de cada fase (No considera el desface
%natural de un sistema trifasico)
Ph1 = 0;
Ph2 = 0;
Ph3 = 0;

%Frecuencia de trabajo
f = 50; %Hz
w0 = 2*pi*f; %velocidad angular
wt = w0*t; 

% Caracteristicas de cada linea de la fuente trifasica 
VL_a = Ag.*A1.*sin(wt - Ph - Ph1);
VL_b = Ag.*A2.*sin(wt - 2*pi/3 - Ph - Ph2);
VL_c = Ag.*A3.*sin(wt + 2*pi/3 - Ph - Ph3);

%% Entradas
% Controlable
syms a b c
Mabc = [a b c];

% Perturbacion
% Señales abc balanceadas y separadas por un desface de 120° = 2*pi/3 rad
VSabc = [VL_a;VL_b;VL_c];





%% Ecuaciones del sistema






