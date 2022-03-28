% validation of theoretical value of R_0

t = 0:1:N-1;   

[~,XX] = ode45('gatto_model',t,X0);

I = XX(:,6) + XX(:,7) + XX(:,8) + XX(:,9);

I(10);                      
(I(13) + I(14))/2;                        % output value is approximately three times I(10)

I(20);
(I(23) + I(24))/2;                        % output value is approximately three times I(20)                     

E = XX(:,2) + XX(:,3) + XX(:,4);

E(10);
(E(13) + E(14))/2;                        % output value is approximately three times E(10)

E(20);
(E(23) + E(24))/2;                        % output value is approximately three times I(20)     