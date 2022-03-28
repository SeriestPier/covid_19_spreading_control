syms beta_A beta_P beta_I beta_P1 beta_P2

% linear equations system
eqns = [beta_A/beta_P == 0.033, beta_I/beta_A == 1.03, beta_P1/beta_P == 0.82, beta_P2/beta_P1 == 0.66, beta_P / delta_P + sigma * (beta_I/(eta + alpha_I + gamma_I)) + (1 - sigma) * beta_A/gamma_A == 3.6];

% vector of linear system results
beta_all = solve(eqns,[beta_A beta_P beta_I beta_P1 beta_P2]);

beta_P = double(beta_all.beta_P);                  % transmission rate of post-latent people
beta_I = double(beta_all.beta_I);                  % transmission rate of people with severe symptoms
beta_A = double(beta_all.beta_A);                  % transmission rate of people with no/mild symptoms
