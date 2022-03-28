function Y = ode4(odefun,t0,dt,tfinal,y0)

neq = length(y0);
Y = zeros(neq,tfinal);
F = zeros(neq,4);
i=1;

tfinal_cycle = tfinal - 1;

Y(:,1) = y0;
for t = t0 : dt : tfinal_cycle - dt
  i = i+1;
  yi = Y(:,i-1);
  F(:,1) = feval(odefun,t,yi);
  F(:,2) = feval(odefun,t+0.5*dt,yi+0.5*dt*F(:,1));
  F(:,3) = feval(odefun,t+0.5*dt,yi+0.5*dt*F(:,2));
  F(:,4) = feval(odefun,t,yi+dt*F(:,3));
  Y(:,i) = yi + (dt/6)*(F(:,1) + 2*F(:,2) + 2*F(:,3) + F(:,4));
end
Y = Y.';