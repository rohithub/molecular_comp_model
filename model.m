% Molecular Computing Model on MATLAB
% Referenced paper http://pubs.acs.org/doi/pdf/10.1021/sb300087n 
% We are doing the synchronous mode only.
% Perform Moving average
%env = {'A'    'C'    'B'    'D'    'R'    'T'    'X'    'Y'}

clc; clear; close all;
% User Options
show_plot = 1;
use_bottom_up_approach = 0;

% System execution starts after this
start_t = current_time;
% Rate constants. Only the fastest and slowest dictates the overall system
k_slow = 1;
k_fast = 0.5;

% Initial concentrations. Keep each value less than 1 and positive
A_conc = 0;
C_conc = 0;
D_conc = 0;
T_conc = 0;
B_conc = 0.5;
R_conc = 0.5;
X_conc = 0;
Y_conc = 0;

%Define the input
input_x = [0.3 0.6 0.7 0.9 0.8 0.5 0.4 0.5 0.3 0.2 0.4 0.5 0.1 0.6 0.4 0.2 0.4 0.1 0.2 0.1 0.7 0.6];
%input_x = [0.3 0.6 0.7 0.9 0.8 0.6 0.3 0.2];

num_data = size(input_x,2);
num_chemicals = 8;
y = zeros(1, num_data);
plot_matrix = [];

if(use_bottom_up_approach == 1)
    % Use the Bottom Up approach to react the chemicals. In this model, the
    % reactions have to be explicitly controlled for the computing to
    % happen
    for i=1:num_data
        [y(i), env] = movAvg_bu_mc(input_x(i));
        plot_matrix = [plot_matrix cell2mat(env(2,:))'];
    end
else
    % Use the top down approach. In this model, only the concentration of
    % the chemicals are given as input and the system implicitly manages
    % the reactions    
    for i=1:num_data
        % Reset the chemical concentrations
        A_conc = 0;
        C_conc = 0;
        D_conc = 0;
        T_conc = 0;
        B_conc = 0.5;
        R_conc = 0.5;
        X_conc = input_x(i);
        Y_conc = 0;

        % Create the initial molecule environment
        env = {'A'    'C'    'B'    'D'    'R'    'T'    'X'    'Y'; ...
                A_conc C_conc B_conc D_conc R_conc T_conc X_conc Y_conc};

        [y(i), env] = movAvg_td_mc(env, k_fast, k_slow);
        plot_matrix = [plot_matrix cell2mat(env(2,:))'];
    end
end

end_t = current_time;
display(end_t - start_t);

%Test code: Generate ground truth
x_fix = [0 input_x 0];
y_test = zeros(1, num_data);
for i=1:num_data
   y_test(i) = (x_fix(i) + x_fix(i+1))/2; 
end

%Plot graphs
if(show_plot==1)
    figure;
    hold on;
    if(use_bottom_up_approach == 1)
        plot(plot_matrix(8,:), 'b--');
    else
        plot(plot_matrix(8,:), 'k--')
    end
    plot(y_test(2:end), 'r', 'LineWidth', 2);
   
    hold off;
    grid on;
    xlabel('Test number', 'LineWidth', 2);
    ylabel('Output', 'LineWidth', 2);
    if(use_bottom_up_approach == 1)
        title('Moving average filter using Bottom-up Model', 'LineWidth', 2);
    else
        title('Moving average filter using Top-down Model', 'LineWidth', 2);
    end
    legend('Modelled Output', 'Expected output');
end
