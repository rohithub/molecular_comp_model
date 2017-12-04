% Molecular Computing Model on MATLAB
% Referenced paper http://pubs.acs.org/doi/pdf/10.1021/sb300087n 

% We are doing the synchronous mode only. Modelling asynchronous one is
% very complex

% Perform Moving average

%env = {'A'    'C'    'B'    'D'    'R'    'T'    'X'    'Y'}

clc; clear; close all;

num_data = 10;
num_chemicals = 8;
y = zeros(1, num_data);
x = [0.5 0.1 0.6 0.4 0.2 0.4 0.5 0.1 0.3 0.6];
plot_matrix = [];

for i=1:num_data
    [y(i), env] = movAvg_mc(x(i));
    plot_matrix = [plot_matrix cell2mat(env(2,:))'];
end

figure;
hold on
for i=1:num_chemicals
    plot(plot_matrix(i,:));
end
hold off;
leg_vals = cell2mat(env(1,:));
legend(leg_vals(1),leg_vals(2),leg_vals(3),leg_vals(4),leg_vals(5),leg_vals(6),leg_vals(7),leg_vals(8));
% figure;
% plot(x, y);