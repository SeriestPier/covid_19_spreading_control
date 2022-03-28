global X0 N Lvect
    
%% parameters
s_c = 10;                                       % threshold
deltaT = 14;                                    
L_d = 0.1;                                      % lower intensity (Lockdown)
ts = 0;

Ltemp = zeros(1,N);

%% optimal control

U0 = [0.7 0.8 30 ...                            % Initial input
      0.6 0.4 100];
  
lb = [0 0 0 0 0 0];                             % lower bounds
ub = [0.9 1 N-1 0.9 1 N-1];                     % upper bounds

options = optimoptions('fmincon','Display','iter-detailed');

%% optimal control local minima MultiStart

stpoints = RandomStartPointSet('NumStartPoints',50);
problem = createOptimProblem('fmincon','objective',@cost_function, ...
       'x0',U0,'lb',lb,'ub',ub,'nonlcon',@nonlincon,'options',options);
ms = MultiStart('MaxTime',1000,'StartPointsToRun','bounds-ineqs','Display','iter');

%% 

for tt = 18:deltaT:N-1
 
%   [~,XX] = ode45('gatto_model',ts:1:tt,X0);      %old ode45
    
    XX = ode4(@gatto_model,ts,1,tt,X0);
    
    if (mean(diff(XX(tt-deltaT:tt,9)))) >= s_c   
        
       [Uvec,fval,exitflag] = fmincon('cost_function',U0,[],[],[],[],lb,ub,'nonlincon',options);    % optimal control
       
%       [Uvec,fval] = run(ms,problem,stpoints);                                                      % optimal control local minima MultiStart
       
       Ltemp(tt:tt+deltaT) = Utime2par(Uvec,ts:deltaT); 
       
    elseif mean(diff(XX(tt-deltaT:tt,9)))  < s_c
       Ltemp(tt:tt+deltaT) = L_d;      
    end 
    
    Lvect = Ltemp;
    
end  
