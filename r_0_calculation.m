% theoretical calculation of R_0 (appendix. pag 9/18)

% transmission matrix
T = [ 0 beta_P beta_I beta_A
      0 0 0 0
      0 0 0 0
      0 0 0 0
    ];

% transition matrix
sigma_maiusc = [ -delta_E 0 0 0
                 delta_E -delta_P 0 0
                 0 sigma*delta_P -(eta+alpha_I+gamma_I) 0
                 0 (1-sigma)*delta_P 0 -gamma_A
               ];
          
% next_generation matrix (NGM)
K_L = -T*inv(sigma_maiusc);

R_0 = K_L(1,1);