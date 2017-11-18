% Molecular Computing Model on MATLAB
% Referenced paper http://pubs.acs.org/doi/pdf/10.1021/sb300087n 

% We are doing the synchronous mode only. Modelling asynchronous one is
% very complex

%Perform Moving average

% Set of Molecular reactions
% % S1
%     B + X --kslow--> A + C + B
%     2A --kfast--> D'
%     2C --kfast--> Y
%     B + D --kslow--> Y +B
%  S2
%     R + D' --kslow--> D + R

