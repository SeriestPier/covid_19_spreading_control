%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Gatto model simulation - main script %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close all
clc

%% 1 - get parameters

global k 

parameters
parameters_r

%% 2 - model simulation (no lockdown case)

tic
% [time,Xnolk] = ode45('gatto_model',time,X0);            % old ode45 implementation
X = ode4(@gatto_model,t0,dt,tfinal,X0);
toc
% print_plot (time,Xnolk);
print_plot (time,X);
r_0_validation

%% 3 - Optimal control (economic-oriented case)

tic
k = 1;
opt_control
% [time,Xnolk] = ode45('gatto_model',time,X0);            % old ode45 implementation
X = ode4(@gatto_model,t0,dt,tfinal,X0);
toc
% Lvect'
% print_plot (time,Xnolk);
print_plot (time,X);

%% 4 - Optimal control ("wise" government case)

tic
k = 0;
opt_control;
% [time,Xnolk] = ode45('gatto_model',time,X0);            % old ode45 implementation
X = ode4(@gatto_model,t0,dt,tfinal,X0);
toc
% print_plot (time,Xnolk);
print_plot (time,X);

%% 5 - Optimal control (convex interpolation of previous cases)

tic
for k = 0:0.2:1
    opt_control
    [time,Xnolk] = ode45('gatto_model',time,X0);
    % X = ode4(@gatto_model,t0,dt,tfinal,X0);
    % Lvect'
    print_plot (time,Xnolk);
end
toc

%% 6 - Cyclic Function
k = 1;
tic
cyclic_control;
%[time,Xnolk] = ode45('gatto_model',time,X0);       % old ode45 implementation
X = ode4(@gatto_model,t0,dt,tfinal,X0);
toc
%print_plot (time,Xnolk);                           % old ode45 implementation
print_plot (time,X);

%% 7 - MPC

tic
X = ode4(@gatto_model,t0,dt,tfinal,X0);
opt_control;
MPC_CL;
X = ode4(@gatto_model,t0,dt,tfinal,X0);
toc

%% 8 - Sensitivity Analysis

open Gatto_distribution.slx