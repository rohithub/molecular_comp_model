function output_chem = react(input_chem, rate_const)
% The first input is a list with details on chemical used and their
% concentration. The size if 2xN, where N is the number of chemicals
% 'B' and 'R' are special chemicals used for clock generation
% 'D' and 'T' are special chemicals for delay operations
% Output is similary a chemical with given concetration
% Rate constant is the time for reaction to complete (in unit time)

start_time = current_time;
num_inp_chem = size(input_chem, 2);
spl_clock_chem = 0;
spl_clock_chem_index = 0;
num_spl_clock_chem = 0;
spl_delay_chem = 0;
spl_delay_chem_index = 0;
num_spl_delay_chem = 0;
three_chem_data = {':' ':' ':'; 0 0 0};
two_chem_data = {':' ':'; 0 0};
one_chem_data = {':'; 0};
output_chem = one_chem_data;
if(num_inp_chem > 2)
   error('ERROR: We don''t support more than two chemical reactions yet'); 
end

for i=1:num_inp_chem
   if (input_chem{1,i} == 'B') || (input_chem{1,i} == 'R') 
       spl_clock_chem = 1;
       spl_clock_chem_index = i;
       num_spl_clock_chem = num_spl_clock_chem + 1;
   end
   
   if (input_chem{1,i} == 'D') || (input_chem{1,i} == 'T') 
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

%Perform actual chemical reactions
if (spl_clock_chem == 1)
    if(input_chem{1,spl_clock_chem_index} == 'B')
        if(spl_delay_chem == 1) % this is a B + D -> Y + B reaction
            output_chem = two_chem_data;
            output_chem{1,1} = 'B';
            output_chem{1,2} = 'Y';
            if(spl_clock_chem_index == 1)
                output_chem{2,1} = input_chem{2,1};
                output_chem{2,2} = input_chem{2,2};
            else
                output_chem{2,1} = input_chem{2,2};
                output_chem{2,2} = input_chem{2,1};
            end
        else % This is B + X -> B + A + C reaction
            output_chem = three_chem_data;
            output_chem{1,1} = 'B';
            output_chem{1,2} = 'A';
            output_chem{1,3} = 'C';
            if(spl_clock_chem_index == 1)
                output_chem{2,1} = input_chem{2,1};
                output_chem{2,2} = input_chem{2,2};
                output_chem{2,3} = input_chem{2,2};
            else
                output_chem{2,1} = input_chem{2,2};
                output_chem{2,2} = input_chem{2,1};
                output_chem{2,3} = input_chem{2,1};
            end
        end
    else
        if(input_chem{1,spl_clock_chem_index} == 'R')
            output_chem = two_chem_data;
            output_chem{1,1} = 'R';
            output_chem{1,2} = 'D';
            if(spl_clock_chem_index == 1)
                output_chem{2,1} = input_chem{2,1};
                output_chem{2,2} = input_chem{2,2};
            else
                output_chem{2,1} = input_chem{2,2};
                output_chem{2,2} = input_chem{2,1};
            end
        else
             error('ERROR: Wrong chemicals for S2');
        end
    end
else
    if (spl_delay_chem == 1)
        if(spl_clock_chem == 1) %This is a R + T -> D + R reaction
            if(input_chem{1,spl_clock_chem_index} == 'R')
                output_chem = two_chem_data;
                output_chem{1,1} = 'R';
                output_chem{1,2} = 'D';
                if(spl_clock_chem_index == 1)
                    output_chem{2,1} = input_chem{2,1};
                    output_chem{2,2} = input_chem{2,2};
                else
                    output_chem{2,1} = input_chem{2,2};
                    output_chem{2,2} = input_chem{2,1};
                end
            else
                 error('ERROR: Wrong chemicals for S2');
            end
        else    %Wrong chemicals for stage S2
            error('ERROR: Wrong chemicals for S2');
        end
    else % This is the actual reaction for non-special chemicals
        if((input_chem{1,1} == 'A') && (input_chem{1,2} == 'A'))
                output_chem = one_chem_data;
                output_chem{1,1} = 'T';
                output_chem{2,1} = input_chem{2,1};
        else
            if((input_chem{1,1} == 'C') && (input_chem{1,2} == 'C'))
                output_chem = one_chem_data;
                output_chem{1,1} = 'Y';
                output_chem{2,1} = input_chem{2,1};
            else
                error('ERROR: Wrong input for reactions (A/C)');
            end
        end
    end
end
%Wait for 'rate_const' time before outputting value
end_time = current_time;
while((end_time - start_time) < rate_const)
    end_time = current_time;
end
end