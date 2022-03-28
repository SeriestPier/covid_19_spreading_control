%%%%%%%%%%%%%%%% Opt-Control %%%%%%%%%%%%%
global N time Lvect


U0 = [0.6 0.8 30 ...                            % Initial input
      0.6 0.4 100]; 
  
lb = [0 0 0 0 0 0];                             % lower bounds
ub = [0.9 1 N-1 0.9 1 N-1];                     % upper bounds

options = optimoptions('fmincon','Display','iter-detailed');

[Uvec,fval,exitflag] = fmincon('cost_function',U0,[],[],[],[],lb,ub,'nonlincon',options);

%% local minima MultiStart

 %stpoints = RandomStartPointSet('NumStartPoints',50);
 %problem = createOptimProblem('fmincon','objective',@cost_function, ...
 %      'x0',U0,'lb',lb,'ub',ub,'nonlcon',@nonlincon,'options',options);
 %ms = MultiStart('MaxTime',1000,'StartPointsToRun','bounds-ineqs','Display','iter');
 %[Uvec,fval] = run(ms,problem,stpoints);
 

%% local minima GlobalSearch

% rng default % For reproducibility
% problem = createOptimProblem('fmincon','objective',@cost_function_par,...
%     'x0',U0,'lb',lb,'ub',ub,'nonlcon',@nonlincon,'options',options);
% gs = GlobalSearch('Display','iter','NumTrialPoints',1000,'NumStageOnePoints',200,'StartPointsToRun','bounds-ineqs');
% [Uvec,fval] = run(gs,problem);



% evolution 
Lvect = Utime2par(Uvec, time);