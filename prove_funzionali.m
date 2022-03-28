clc

global Lvect X0 N xi_cf alpha_cf gamma_cf PIL_pc phi_maiusc chi_maiusc ita_population

t = 0:1:N-1;   

[~,XX] = ode45('gatto_model',t,X0);

S = XX(:,1);
E = XX(:,2) + XX(:,3) + XX(:,4);
P = XX(:,5);
I = XX(:,6) + XX(:,7) + XX(:,8) + XX(:,9);
A = XX(:,10) + XX(:,11) + XX(:,12) + XX(:,13);
Q = XX(:,17) + XX(:,18) + XX(:,19);
H = XX(:,14) + XX(:,15) + XX(:,16);
D = XX(:,21);

%disp('perdita da lockdown')
PIL_pc * (S + E + P + I + A + Q);                    % e+12

%disp('perdita terapie intensive')
alpha_cf * xi_cf * H;                                % e+08

%disp('perdite per morti')                           % e+10
gamma_cf * D;

economic_cost = PIL_pc * (S + E + P + I + A + Q) + alpha_cf * xi_cf * H + gamma_cf * D;

disp('costo economico complessivo')
economic_cost                                       % e+12

disp('costo sociale delle infezioni')
phi_maiusc * (ita_population - S)                   % e+10 va aumentato di 2

disp('costo sociale delle morti')
chi_maiusc * D                                      % e+09 va aumentato di 3

wise_cost = phi_maiusc * (ita_population - S) + economic_cost + chi_maiusc * D;