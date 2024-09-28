function dxdt=call_nolinealPro(t,x) %% no Lineal Promedio

global Gdc Gac Rf Lf Rl Ll Cdc Vrms

%entrada
md = md0 + 0.4*md0*(t>=0)

%% perturbacion (red electrica)
ipv = ipv0*(t>=0)
%%

xt = [x(2),x(3),x(4)]

dxdt = [ipv/Cdc - (Gdc/Cdc)*(xt).'*m;...
        ]; %Espacio de estados