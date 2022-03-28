% Gatto model simulation

function [ Xdot ] = gatto_model(t, X)

    % global parameters call
    global Lvect alpha_I alpha_H beta_A beta_I beta_P gamma_A gamma_I gamma_H E_coeff_gen delta_P eta zeta sigma I_coeff_gen A_coeff_gen H_coeff_gen Q_coeff_gen theta

    L = Lvect(fix(t)+1);               % lockdown rounded intensity vector
    LK = 1 - theta * L;                % lockdown effective portion
    % LK = 1 - L;
    
    % individuals-related state variables
    
    S = X(1);             % --> susceptible
    
    E_1 = X(2);           % --> exposed (first generation)
    E_2 = X(3);           % --> exposed (second generation)
    E_3 = X(4);           % --> exposed (third generation)
    
    P = X(5);             % --> presymptomatic 
    
    I_1 = X(6);           % --> infectious with severe symptoms (first generation)
    I_2 = X(7);           % --> infectious with severe symptoms (second generation)
    I_3 = X(8);           % --> infectious with severe symptoms (third generation)
    I_4 = X(9);           % --> infectious with severe symptoms (fourth generation)
    
    A_1 = X(10);          % --> infectious with no/mild symptoms (first generation)
    A_2 = X(11);          % --> infectious with no/mild symptoms (second generation)
    A_3 = X(12);          % --> infectious with no/mild symptoms (third generation)
    A_4 = X(13);          % --> infectious with no/mild symptoms (fourth generation)
    
    H_1 = X(14);          % --> hospitalized (first generation)
    H_2 = X(15);          % --> hospitalized (second generation)
    H_3 = X(16);          % --> hospitalized (third generation)
    
    Q_1 = X(17);          % --> quarantined (first generation)
    Q_2 = X(18);          % --> quarantined (second generation)
    Q_3 = X(19);          % --> quarantined (third generation)
    
    R = X(20);            % --> recovered
    
    D = X(21);            % --> dead
    
    
    Xdot = zeros(21,1);     % state variables initialization vector


    
    
    % coefficient in Gatto model
    lambda = (beta_P * P + beta_I * (I_1 + I_2 + I_3 + I_4) + beta_A * (A_1 + A_2 + A_3 + A_4)) / (S + E_1 + E_2 + E_3 + P + I_1 + I_2 + I_3 + I_4 + A_1 + A_2 + A_3 + A_4 + R);
    

    % ode system definition
         
    Xdot(1) = - lambda * S * LK;                                                                % S_dot
    
    Xdot(2) = lambda * S * LK - E_coeff_gen * E_1 * LK;                                         % E_1_dot
    Xdot(3) = E_coeff_gen * E_1 * LK - E_coeff_gen * E_2 * LK;                                  % E_2_dot
    Xdot(4) = E_coeff_gen * E_2 * LK - E_coeff_gen * E_3 * LK;                                  % E_3_dot
    
    Xdot(5) = E_coeff_gen * E_3 * LK - delta_P * P * LK;                                        % P_dot
    
    Xdot(6) = sigma * delta_P * P * LK - I_coeff_gen * I_1 * LK;                                % I_1_dot
    Xdot(7) = I_coeff_gen * I_1 * LK - I_coeff_gen * I_2 * LK;                                  % I_2_dot
    Xdot(8) = I_coeff_gen * I_2 * LK - I_coeff_gen * I_3 * LK;                                  % I_3_dot
    Xdot(9) = I_coeff_gen * I_3 * LK - I_coeff_gen * I_4;                                       % I_4_dot
    
    Xdot(10) = (1 - sigma) * delta_P * P * LK - A_coeff_gen * A_1 * LK;                         % A_1_dot
    Xdot(11) = A_coeff_gen * A_1 * LK - A_coeff_gen * A_2 * LK;                                 % A_2_dot
    Xdot(12) = A_coeff_gen * A_2 * LK - A_coeff_gen * A_3 * LK;                                 % A_3_dot
    Xdot(13) = A_coeff_gen * A_3 * LK - A_coeff_gen * A_4;                                      % A_4_dot
    
    Xdot(14) = (1 - zeta) * (eta * 4) * I_4 - H_coeff_gen * H_1;                                % H_1_dot
    Xdot(15) = H_coeff_gen * H_1 - H_coeff_gen * H_2;                                           % H_2_dot
    Xdot(16) = H_coeff_gen * H_2 - H_coeff_gen * H_3;                                           % H_3_dot
    
    Xdot(17) = zeta * (eta * 4) * I_4 * LK - Q_coeff_gen * Q_1;                                 % Q_1_dot
    Xdot(18) = Q_coeff_gen * Q_1 - Q_coeff_gen * Q_2;                                           % Q_2_dot
    Xdot(19) = Q_coeff_gen * Q_2 - Q_coeff_gen * Q_3;                                           % Q_3_dot
    
    Xdot(20) = (gamma_I * 4) * I_4 + (gamma_A * 4) * A_4 + (gamma_H * 3) * H_3;                 % R_dot
    
    Xdot(21) = (alpha_I * 4) * I_4 + (alpha_H * 3) * H_3;                                       % D_dot
    
end