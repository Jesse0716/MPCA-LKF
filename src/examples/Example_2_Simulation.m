function [x, rrho1, instant] = Example_2_Simulation(varargin)
% EXAMPLE_2_SIMULATION Discrete-time linear switched system simulation
% 
% Input parameters (optional):
%   final - Simulation length (default: 100)
%   times - Number of switches (default: 10)
%   x0 - Initial conditions (default: [0.5; 0.8])
%   plot_results - Whether to plot results (default: true)
% 
% Output:
%   x - State trajectory
%   rrho1 - Switching signal
%   instant - Switching instants
%
% Author: Da Chen
% Date: 2025-08-04

%% Parameter parsing
p = inputParser;
addParameter(p, 'final', 100, @isnumeric);
addParameter(p, 'times', 10, @isnumeric);
addParameter(p, 'x0', [0.5; 0.8], @isnumeric);
addParameter(p, 'plot_results', true, @islogical);
parse(p, varargin{:});

final = p.Results.final;
times = p.Results.times;
x0 = p.Results.x0;
plot_results = p.Results.plot_results;

%% System matrix definition
A1 = [0.98  0.346
      0.8   0.45]; 

A2 = [0.3    0.2
      0.7    0.57];

%% Generate switching instants
instant = [1 sort(randi([2 final-1], 1, times)) final];

%% Initialization
x = zeros(2, final+1);
x(:,1) = x0;

%% Simulation
for i = 1:times+1
    for k = instant(i):instant(i+1)-1
        if mod(i,2) == 0
            x(:,k+1) = A1 * x(:,k);
        else
            x(:,k+1) = A2 * x(:,k); 
        end
    end
    
    if mod(i,2) == 0
        rrho1(instant(i):instant(i+1)-1) = 1;
    else
        rrho1(instant(i):instant(i+1)-1) = 2;
    end
end

%% Plotting
if plot_results
    plot_results_example2(x, rrho1, final);
end

end

function plot_results_example2(x, rrho1, final)
% Plot results

% State trajectory plot
figure('Name', 'State Trajectory', 'Position', [100, 100, 800, 600]);
plot(0:final, x(1,1:final+1), 'b-', 'LineWidth', 2); 
hold on;
plot(0:final, x(2,1:final+1), 'r--', 'LineWidth', 2);
xlabel('$k$', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$\textbf{x}(k)$', 'Interpreter', 'latex', 'FontSize', 12);
legend('$x_1(k)$', '$x_2(k)$', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
title('Discrete-time Linear Switched System State Trajectory', 'FontSize', 14);

% Switching signal plot
figure('Name', 'Switching Signal', 'Position', [200, 200, 800, 400]);
stairs(0:1:max(size(rrho1))-1, rrho1, 'LineWidth', 2);
xlabel('$k$', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$\sigma(k)$', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
title('Switching Signal', 'FontSize', 14);
ylim([0.5, 2.5]);

end 