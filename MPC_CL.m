
function MPC_CL ()

global X0 Lvect N Lfinal t0 dt tfinal time

ND = 18; %first days without lockdown

%time = 0:1:ND-1;
XM = ode4(@gatto_model,t0,dt,ND,X0);
XR = ode4(@gatto_model_real,t0,dt,ND,X0);

Lvect = zeros(1,ND);

X0R = XR(ND,:);                             %new initial condition
X0M = XM(ND,:);                             %new initial condition;

XX_real = XR(1:ND,:);                       %Evolution matrix
XX_model = XM(1:ND,:);                      %Evolution matrix
Lfinal = zeros(1,ND);

%CL MPC
Nc = N-ND;                                  %Days with control
PT = 50;                                    %Prediction time
time = 0:1:PT-1;
deltaT = 15;                                %Useful prediction
MaxdeltaI = 0.0025;                         %constraint on I

U0 = [0.7 0.8 30 ...                        % Initial input
      0.8 0.4 100]; 
  
lb = [0 0 0 0 0 0];                         % lower bounds
ub = [0.9 1 N 0.9 1 N];                     % upper bounds

DDD = zeros(4,1);

for jj = 0:deltaT:Nc-1
    %model-real matching (EKF)
    DDD = XR(end,:) - XM(end,:);
    
    %Observable States
    X0M(1) = X0M(1) + DDD(1);           %S
    X0M(9) = X0M(9) + DDD(9);           %I
    X0M(16) = X0M(16) + DDD(16);        %H
    X0M(21) = X0M(21) + DDD(21);        %D
  
    
    %j-esima ottimizzazione singola
    X0 = X0M;
    
    options = optimoptions('fmincon','Display','iter-detailed');
    [Uvec,fval,exitflag] = fmincon('cost_function',U0,[],[],[],[],lb,ub,[],options);
    
    %evolution reality and model
    Lvect = Utime2par(Uvec, 1:deltaT+1);
    XR = ode4(@gatto_model_real,t0,dt,deltaT,X0);
    XM = ode4(@gatto_model,t0,dt,deltaT,X0);
    
    X0R = XR(end,:)'; %new inital cond
    X0M = XM(end,:)';
    
    XX_real = [XX_real; XR(1:end,:)];
    XX_model = [XX_model; XM(1:end,:)];
    Lfinal = [Lfinal Lvect(1:end-1)'];
    Lvect = Lfinal;
end

time = 0:1:N-1;

XX_real(N+1:end, :) = [];  
XX_model(N+1:end, :) = []; % deletes your matrix end(last) row
print_plot(time,XX_real);
print_plot(time,XX_model);


