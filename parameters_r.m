%%%%%%%%%%%%%%%%%%%%%% model parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global Lvect xi_cf alpha_cf gamma_cf phi_maiusc chi_maiusc ... 
       ita_population PIL_pc PIL_pc_daily Lvect N time alpha_I_r ... 
       alpha_H_r beta_A beta_I beta_P gamma_A_r gamma_I_r ...
       gamma_H_r gamma_Q_r E_coeff_gen_r delta_E_r delta_P_r ...
       eta_r zeta sigma X0 I_coeff_r I_coeff_gen_r A_coeff_gen_r H_coeff_r ... 
       H_coeff_gen_r Q_coeff_gen_r theta
   
rng ('shuffle')

N = 150;                                % number of simulated days

time = 0:1:N-1;                         % time vector

Lvect = zeros(1,N);                     % lockdown intensity vector (initialization to no-lockdown case)
                
alpha_I_r = 1. / (unifrnd(0,100));      % fatality rate of people with severe symptoms
alpha_H_r = alpha_I_r;                      % fatality rate of hospitalized people

%%% beta parameters are calculated in a different script, launched below in
%%% this file

% beta_P;                               % transmission rate of post-latent people           
% beta_I;                               % transmission rate of people with severe symptoms   
% beta_A;                               % transmission rate of people with no/mild symptoms  

gamma_I_r =  1. / (unifrnd(0,100));     % recovery rate of people with severe symptoms
gamma_A_r = 2 * gamma_I_r;                  % recovery rate of people with no/mild symptoms
gamma_H_r = gamma_I_r;                      % recovery rate of hospitalized people
gamma_Q_r = gamma_I_r;                      % recovery rate of quarantined (home-isolated) people            

delta_E_r = 1. / (normrnd(4,0.4));
                    
delta_P_r = 1. / (normrnd(1,0.1));      % post-latency rate
                      
eta_r = 1. / (normrnd(4,0.4));          % removal rate of people with severe symptoms from the community
    
zeta = 0.4;                             % fraction of severe infections being isolated at home

sigma = 0.25;                           % fraction of infections with severe symptoms

theta = 0.95;                           % lockdown effectiveness

%%%%%%%%%%% coefficients for ode-cascade implementation %%%%%%%%%%%%%%%%%%

E_coeff_gen_r = delta_E_r * 3;              % coefficient for ode-cascade implementation

I_coeff_r = eta_r + gamma_I_r + alpha_I_r;      % coefficient for ode-cascade implementation
I_coeff_gen_r = I_coeff_r * 4;              % coefficient for ode-cascade implementation

A_coeff_gen_r = gamma_A_r * 4;              % coefficient for ode-cascade implementation

H_coeff_r = gamma_H_r + alpha_H_r;            % coefficient for ode-cascade implementation
H_coeff_gen_r = H_coeff_r * 4;              % coefficient for ode-cascade implementation

Q_coeff_gen_r = gamma_Q_r * 3;              % coefficient for ode-cascade implementation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp_start = 10;                         % starting number of exposed individuals

ita_population = 59641488;              % italian population at 01/01/2020 (source: demo.istat.it)

PIL_2019 = 1787664000000;               % PIL 2019 (source: https://www.istat.it/it/files/2020/03/Pil-Indebitamento-Ap.pdf)

PIL_2019 = 1787664000000;               % PIL 2019 (source: https://www.istat.it/it/files/2020/03/Pil-Indebitamento-Ap.pdf)

PIL_pc = PIL_2019 / ita_population;     % PIL pro-capite 2019

PIL_pc_daily = PIL_pc / 365;            % Daily PIL pro-capite 2019

xi_cf = 10.8348/100;                    % intensive care percentage of covid hospitalized

alpha_cf = 1279;                        % daily cost of a sigle intensive care slot

gamma_cf = 10577;                       % economic cost of a death individual

phi_maiusc = 100000;                    % social weight of susceptible individuals get infected

chi_maiusc = 1000000;                   % social weight of dead individuals

% beta parameters calculation script
beta_equations;

% R_0                                   % Ross number (starting reproduction ratio)
r_0_calculation                         % R_0 theoretical calculation script

% initial conditions
S_0 = ita_population;
E_1_0 = exp_start;
E_2_0 = 0;
E_3_0 = 0;
P_0 = 0;
I_1_0 = 0;
I_2_0 = 0;
I_3_0 = 0;
I_4_0 = 0;
A_1_0 = 0;
A_2_0 = 0;
A_3_0 = 0;
A_4_0 = 0;
H_1_0 = 0;
H_2_0 = 0;
H_3_0 = 0;
Q_1_0 = 0;
Q_2_0 = 0;
Q_3_0 = 0;
Rem_0 = 0;            % starting number of removed individuals (DIFFERENT FROM R_0 = Ross number)
D_0 = 0;

% initial conditions vector
X0 = [S_0,E_1_0,E_2_0,E_3_0,P_0,I_1_0,I_2_0,I_3_0,I_4_0,A_1_0,A_2_0,A_3_0,A_4_0,H_1_0,H_2_0,H_3_0,Q_1_0,Q_2_0,Q_3_0,Rem_0,D_0];
