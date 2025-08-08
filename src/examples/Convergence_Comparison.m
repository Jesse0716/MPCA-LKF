function Convergence_Comparison(varargin)
% CONVERGENCE_COMPARISON Convergence comparison
% 
% Input parameters (optional):
%   k_max - Maximum time steps (default: 200)
%   x0 - Initial value (default: 1)
%   plot_results - Whether to plot results (default: true)
% 
% Output:
%   No return value, directly displays figure
%
% Author: Da Chen
% Date: 2025-08-04

%% Parameter parsing
p = inputParser;
addParameter(p, 'k_max', 200, @isnumeric);
addParameter(p, 'x0', 1, @isnumeric);
addParameter(p, 'plot_results', true, @islogical);
parse(p, varargin{:});

k_max = p.Results.k_max;
x0 = p.Results.x0;
plot_results = p.Results.plot_results;

%% Convergence rates λ
lambda_vals = [0.087, 0.074, 0.072, 0.060, 0.057, 0.054];
labels = {
    'MPAC-LKF (\lambda = 0.087)', 
    'MAC-LKF (\lambda = 0.074)', 
    'LKF in [39] (\lambda = 0.072)', 
    'LKF in [40] (\lambda = 0.060)', 
    'LKF in [41] (\lambda = 0.057)',
    'LKF in [42] (\lambda = 0.054)'
};

%% Define colors and line styles
colors = {'#1B9E77', '#D95F02', '#7570B3', '#E7298A', '#66A61E', '#A6761D'};
linestyles = {'-', '--', '-.', ':', '-', '--'};

%% Time setup
k = 0:k_max;

%% Plotting
if plot_results
    plot_convergence_comparison(k, x0, lambda_vals, labels, colors, linestyles);
end

end

function plot_convergence_comparison(k, x0, lambda_vals, labels, colors, linestyles)
% Plot convergence comparison

figure('Name', 'Convergence Comparison', 'Position', [100, 100, 1000, 600]); 
hold on;

for i = 1:length(lambda_vals)
    xk = x0 * exp(-lambda_vals(i) * k);
    plot(k, xk, 'LineWidth', 2, ...
        'DisplayName', labels{i}, ...
        'Color', colors{i}, ...
        'LineStyle', linestyles{i});
end

xlabel('$k$', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$||x(k)||$', 'Interpreter', 'latex', 'FontSize', 12);
legend('Location', 'northeast', 'FontSize', 10);
grid on;
xlim([0, max(k)]);
ylim([0, 1.05]);
title('Convergence Comparison of Different Methods', 'FontSize', 14);

% Add minor grid
grid minor;

end 