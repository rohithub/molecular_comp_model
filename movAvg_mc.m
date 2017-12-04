function [y, env] = movAvg_mc(x)

    % Chemical Indexes: Do Not change this 
    A_ind = 1;
    B_ind = 3;
    C_ind = 2;
    D_ind = 4;
    R_ind = 5;
    T_ind = 6;
    X_ind = 7;
    Y_ind = 8;

    % Initial concentrations. Keep each value less than 1 and positive
    A_conc = 0;
    C_conc = 0;
    D_conc = 0;
    T_conc = 0;
    B_conc = 0.5;
    R_conc = 0.5;
    X_conc = x;
    Y_conc = 0;

    % Rate constants. Only the fastest and slowest dictates the overall system
    k_slow = 1;
    k_fast = 0.5;

    % Create the initial molecule environment
    env = {'A'    'C'    'B'    'D'    'R'    'T'    'X'    'Y'; ...
            A_conc C_conc B_conc D_conc R_conc T_conc X_conc Y_conc};
 
    % Start the reactions and update the environment
    %     B + X --kslow--> A + C + B
    reactants = [B_ind X_ind];
    env = react(reactants, k_slow, env);
    
    %     2A --kfast--> D'
    reactants = [A_ind A_ind];
    env = react(reactants, k_fast, env);

    %     2C --kfast--> Y
    reactants = [C_ind C_ind];
    env = react(reactants, k_fast, env);
    
    %     R + D' --kslow--> D + R
    reactants = [R_ind T_ind];
    env = react(reactants, k_slow, env);
    
    %     B + D --kslow--> Y + B
    reactants = [B_ind D_ind];
    env = react(reactants, k_slow, env);
    
    % Return output
    y = env{2, Y_ind};
end
