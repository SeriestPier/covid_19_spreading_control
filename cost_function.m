function CF_val = cost_function(Utry)

global Lvect X0 N gamma_cf PIL_pc phi_maiusc chi_maiusc ita_population k

t = 0:1:N-1;

Lvect = Utime2par(Utry,t);

t0 = 0;                                 % ode4 parameter - simulation starting time
tfinal = N;                             % ode4 parameter - simulation ending time
dt = 1;                                 % ode4 parameter - simulation step time

% [time,Xnolk] = ode45('gatto_model',time,X0);            % old ode45 implementation
XX = ode4(@gatto_model,t0,dt,tfinal,X0);

S = XX(:,1);
E = XX(:,2) + XX(:,3) + XX(:,4);
P = XX(:,5);
I = XX(:,6) + XX(:,7) + XX(:,8) + XX(:,9);
A = XX(:,10) + XX(:,11) + XX(:,12) + XX(:,13);
Q = XX(:,17) + XX(:,18) + XX(:,19);
H = XX(:,14) + XX(:,15) + XX(:,16);
R = XX(:,20);
D = XX(:,21);

% disp('economic_cost')
economic_cost = PIL_pc * (E + P + I + A) + gamma_cf * D;

% disp('wise_cost')
wise_cost = phi_maiusc * (ita_population - S) + chi_maiusc * D;

% k = 0         % only wise cost
% k = 1         % only economic cost

% economic cost function
CF_val = sum((k * (400 * economic_cost)) + ((1 - k) * (wise_cost)));