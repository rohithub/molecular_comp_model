function [y, input_env] = movAvg_td_mc(input_env, k_fast, k_slow)

    % Chemical Indexes: Do Not change this 
    A_ind = 1;
    B_ind = 3;
    C_ind = 2;
    D_ind = 4;
    R_ind = 5;
    T_ind = 6;
    X_ind = 7;
    Y_ind = 8;

    k_ratio = k_fast/k_slow; %Determines when the two phases work
    curr_count = 0;
    
    if(cell2mat(input_env(2,X_ind)) ~= 0) %Only proceed if the concetration of X is not zero
        % Start the reactions and update the environment
        
        if(cell2mat(input_env(2,X_ind))~=0)
            %     B + X --kslow--> A + C + B
            reactants = [B_ind X_ind];
            input_env = react(reactants, k_slow, input_env);
        end
        
        if(cell2mat(input_env(2,A_ind))~=0)
            %     2A --kfast--> D'
            reactants = [A_ind A_ind];
            input_env = react(reactants, k_fast, input_env);
        end
        
        if(cell2mat(input_env(2,C_ind))~=0)
            %     2C --kfast--> Y
            reactants = [C_ind C_ind];
            input_env = react(reactants, k_fast, input_env);
        end
        
        if(cell2mat(input_env(2,T_ind))~=0)
            %     R + D' --kslow--> D + R
            reactants = [R_ind T_ind];
            input_env = react(reactants, k_slow, input_env);
        end
        
        if(cell2mat(input_env(2,D_ind))~=0)
            %     B + D --kslow--> Y + B
            reactants = [B_ind D_ind];
            input_env = react(reactants, k_slow, input_env);
        end
        
        % Return output
        y = input_env{2, Y_ind};
    end
end
