function out_env = react(input_chem, rate_const, env)
% The first input is a list with details on chemical used and their
% concentration. The size if 2xN, where N is the number of chemicals
% 'B' and 'R' are special chemicals used for clock generation
% 'D' and 'T' are special chemicals for delay operations
% Output is similary a chemical with given concetration
% Rate constant is the time for reaction to complete (in unit time)
% env cpontains the current state of all the chemicals in the environment

% Chemical Indexes: Do Not change this 
A_ind = 1;
B_ind = 3;
C_ind = 2;
D_ind = 4;
R_ind = 5;
T_ind = 6;
X_ind = 7;
Y_ind = 8;

num_inp_chem = size(input_chem, 2);
spl_clock_chem = 0;
spl_clock_chem_index = 0;
num_spl_clock_chem = 0;
spl_delay_chem = 0;
spl_delay_chem_index = 0;
num_spl_delay_chem = 0;
out_env = env;

if(num_inp_chem > 2)
   error('ERROR: We don''t support more than two chemical reactions yet'); 
end

for i=1:num_inp_chem
   if (input_chem(i) == B_ind) || (input_chem(i) == R_ind) 
       spl_clock_chem = 1;
       spl_clock_chem_index = i;
       num_spl_clock_chem = num_spl_clock_chem + 1;
   end
   
   if (input_chem(i) == D_ind) || (input_chem(i) == T_ind) 
       spl_delay_chem = 1;
       spl_delay_chem_index = i;
       num_spl_delay_chem = num_spl_delay_chem + 1;
   end
end

if(num_spl_clock_chem > 1)
   error('ERROR: More than one clock (B/R) chemical in a reaction is not allowed '); 
end
if(num_spl_delay_chem > 1)
   error('ERROR: More than one delay (D/T) chemical in a reaction is not allowed '); 
end

start_time = current_time;

%Perform actual chemical reactions
if (spl_clock_chem == 1)
    if(input_chem(spl_clock_chem_index) == B_ind)
        if(spl_delay_chem == 1) % this is a B + D -> Y + B reaction
            if(spl_clock_chem_index == 1)
                out_env{2, B_ind} = env{2,input_chem(1)};
                out_env{2, Y_ind} = out_env{2, Y_ind} + env{2,input_chem(2)}; %Accumulate Y
                out_env{2, input_chem(2)} = 0; %Input D becomes 0
            else
                out_env{2, B_ind} = env{2,input_chem(2)};
                out_env{2, Y_ind} = out_env{2, Y_ind} + env{2,input_chem(1)}; %Accumulate Y
                out_env{2, input_chem(1)} = 0; %Input D becomes 0
            end
        else % This is B + X -> B + A + C reaction
            if(spl_clock_chem_index == 1)
                out_env{2, B_ind} = env{2,input_chem(1)};
                out_env{2, A_ind} = env{2,input_chem(2)};
                out_env{2, C_ind} = env{2,input_chem(2)};
                out_env{2, input_chem(2)} = 0; %Input X becomes 0
            else
                out_env{2, B_ind} = env{2,input_chem(2)};
                out_env{2, A_ind} = env{2,input_chem(1)};
                out_env{2, C_ind} = env{2,input_chem(1)};
                out_env{2, input_chem(1)} = 0; %Input X becomes 0
            end
        end
    else
        if(input_chem(spl_clock_chem_index) == R_ind) % This is R + T -> R + D reaction
            if(spl_clock_chem_index == 1)
                out_env{2, R_ind} = env{2,input_chem(1)};
                out_env{2, D_ind} = env{2,input_chem(2)};
                out_env{2, input_chem(2)} = 0; %Input T becomes 0
            else
                out_env{2, R_ind} = env{2,input_chem(2)};
                out_env{2, D_ind} = env{2,input_chem(1)};
                out_env{2, input_chem(1)} = 0; %Input T becomes 0
            end
        else
             error('ERROR: Wrong chemicals for S2');
        end
    end
else
 % This is the actual reaction for non-special chemicals
    if((input_chem(1) == A_ind) && (input_chem(2) == A_ind))
            out_env{2, T_ind} = env{2,input_chem(1)}/2;
            out_env{2, input_chem(1)} = 0; %Input A becomes 0
    else
        if((input_chem(1) == C_ind) && (input_chem(2) == C_ind))
            out_env{2, Y_ind} = out_env{2, Y_ind} + env{2,input_chem(1)}/2; %Accumulate Y
            out_env{2, input_chem(1)} = 0; %Input C becomes 0
        else
            error('ERROR: Wrong input for reactions (A/C)');
        end
    end
end
%Wait for 'rate_const' time before outputting value
end_time = current_time;
while((end_time - start_time) < rate_const)
    end_time = current_time;
end
end