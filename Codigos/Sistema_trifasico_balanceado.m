clear all
close all
clc

t = 0:100e-6:0.25;

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

%% Variables abc
% Señales abc balanceadas y separadas por un desface de 120° = 2*pi/3 rad
VL_a = Ag.*A1.*sin(wt - Ph - Ph1);
VL_b = Ag.*A2.*sin(wt - 2*pi/3 - Ph - Ph2);
VL_c = Ag.*A3.*sin(wt + 2*pi/3 - Ph - Ph3);

Vabc = [VL_a;VL_b;VL_c];

% Graficar cada fase individualmente
figure(1)
subplot(311),plot(t, Vabc(1, :), 'r', t, Vabc(2, :), 'g', t, Vabc(3, :), 'b');
xlabel('Tiempo (s)');
ylabel('Voltaje (V)');
title('Voltajes trifásicos');
legend({'Fase A', 'Fase B', 'Fase C'}); % Etiquetas de las fases
grid on;  % Añadir cuadrícula


%% Matriz de transformacion Clark
T_Clark = sqrt(2/3)*[1, -1/2, -1/2;...
               0, sqrt(3)/2, -sqrt(3)/2;...
               1/sqrt(2), 1/sqrt(2), 1/sqrt(2)];

V_clark = T_Clark*Vabc;

% Graficar cada fase individualmente
figure(1)
subplot(312),plot(t, V_clark(1, :), 'r', t, V_clark(2, :), 'g', t, V_clark(3, :), 'b');
xlabel('Tiempo (s)');
ylabel('Voltaje (V)');
title('Transformada aplha-beta-cero');
legend({'\alpha', '\beta', '0'}); % Etiquetas de las fases
grid on;  % Añadir cuadrícula


%% Transformada de Park

for i = 1:length(t)
    % Matriz de transformación de Park en el tiempo t(i)
    T_Park = sqrt(2/3)*[sin(wt(i)), sin(wt(i)-2*pi/3), sin(wt(i)+2*pi/3); ...
                        cos(wt(i)), cos(wt(i)-2*pi/3), cos(wt(i)+2*pi/3); ...
                        1/sqrt(2), 1/sqrt(2), 1/sqrt(2)];
                    
    V_Park(:, i) = T_Park * Vabc(:, i);
end


figure(1)
subplot(313),plot(t, V_Park(1, :), 'r', t, V_Park(2, :), 'g', t, V_Park(3, :), 'b');
xlabel('Tiempo (s)');
ylabel('Voltaje (V)');
title('Transformada dq0');
legend({'Directa', 'Cuadratura', 'Cero'}); % Etiquetas de las fases
grid on;  % Añadir cuadrícula


%% Inversas de las transformadas
for i = 1:length(t)
    % Matriz de transformación de Park en el tiempo t(i)
    T_Park = sqrt(2/3)*[sin(wt(i)), sin(wt(i)-2*pi/3), sin(wt(i)+2*pi/3); ...
                        cos(wt(i)), cos(wt(i)-2*pi/3), cos(wt(i)+2*pi/3); ...
                        1/sqrt(2), 1/sqrt(2), 1/sqrt(2)];
                    
    V_Park(:, i) = T_Park * Vabc(:, i);
end

T_Park_inv = T_Park(:, i)^-1;


