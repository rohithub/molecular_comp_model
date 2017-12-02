% Molecular Computing Model on MATLAB
% Referenced paper http://pubs.acs.org/doi/pdf/10.1021/sb300087n 

% We are doing the synchronous mode only. Modelling asynchronous one is
% very complex

%Perform Moving average

clc; clear; close all;

num_data = 10;
y = zeros(1, num_data);
x = 0.1:0.1:1;

for i=1:num_data
    y(i) = movAvg_mc(x(i));
end

plot(x, y);