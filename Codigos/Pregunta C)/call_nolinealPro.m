function dxdt= call_nolinealPro(t,x)

global Gdc Gac Lf Rf Cdc Ll Rl  mqo mdo Vsq Vsd w Ipv  

%% Entradas
md = mdo - 0.1*mdo*(t>=0.05);
mq = mqo - 0.1*mqo*(t>=0.550);
%% Perturbacion (red electrica)
v_sd = Vsd - 0.05*Vsd*(t>=0.3);
%% Dx/Dt
dxdt = [(Ipv/Cdc) - ((Gdc*md)/Cdc)*x(2) - ((Gdc*mq)/Cdc)*x(3);...
    ((Gac/Lf)*md*x(1)) - ((1/Lf)*v_sd) - ((Rf/Lf)*x(2)) + (w*x(3));...
    ((Gac/Lf)*mq*x(1)) - ((1/Lf)*Vsq) - ((Rf/Lf)*x(3)) - (w*x(2));...
    -((Rl/Ll)*x(4)) + ((1/Ll)*v_sd) + (w*x(5));...
    -((Rl/Ll)*x(5)) + ((1/Ll)*Vsq) - (w*x(4))];
end