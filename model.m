% Molecular Computing Model on MATLAB
% Referenced paper http://pubs.acs.org/doi/pdf/10.1021/sb300087n 

% We are doing the synchronous mode only. Modelling asynchronous one is
% very complex

% Perform Moving average

%env = {'A'    'C'    'B'    'D'    'R'    'T'    'X'    'Y'}

clc; clear; close all;

start_t = current_time;
x = [0.3 0.6 0.7 0.9 0.8 0.5 0.4 0.5 0.3 0.2 0.4 0.5 0.1 0.6 0.4 0.2 0.4 0.1 0.2 0.1 0.7 0.6];
num_data = size(x,2);
num_chemicals = 8;
y = zeros(1, num_data);

plot_matrix = [];

for i=1:num_data
    [y(i), env] = movAvg_mc(x(i));
    plot_matrix = [plot_matrix cell2mat(env(2,:))'];
end
end_t = current_time;
display(end_t - start_t);

%Test code
x_fix = [0 x 0];
y_test = zeros(1, num_data);
for i=1:num_data
   y_test(i) = (x_fix(i) + x_fix(i+1))/2; 
end

figure;
hold on;
plot(plot_matrix(8,:));
plot(y_test, 'r--', 'LineWidth', 2);
hold off;
grid on;
xlabel('Test number');
ylabel('Expected Output');
title('Moving average filter using modeled molecular computing');
legend('Modelled Output', 'Expected output');

% hold on
% for i=1:num_chemicals
%     plot(plot_matrix(8,:));
% end
% hold off;
% leg_vals = cell2mat(env(1,:));
% legend(leg_vals(1),leg_vals(2),leg_vals(3),leg_vals(4),leg_vals(5),leg_vals(6),leg_vals(7),leg_vals(8));
