function Plotting_Tools()
% PLOTTING_TOOLS Plotting tool function collection
% 
% This file contains various plotting tool functions for MPCA-LKF project visualization
%
% Author: Da Chen
% Date: 2025-08-04

end

function plot_state_trajectory(time, x, title_str, varargin)
% PLOT_STATE_TRAJECTORY Plot state trajectory
% 
% Input:
%   time - Time vector
%   x - State matrix (each column is a state)
%   title_str - Figure title
%   varargin - Optional parameters
%     'labels' - State labels
%     'colors' - Color array
%     'linewidth' - Line width

%% Parameter parsing
p = inputParser;
addParameter(p, 'labels', {}, @iscell);
addParameter(p, 'colors', {'b', 'r', 'g', 'm', 'c', 'y'}, @iscell);
addParameter(p, 'linewidth', 2, @isnumeric);
parse(p, varargin{:});

labels = p.Results.labels;
colors = p.Results.colors;
linewidth = p.Results.linewidth;

%% Plotting
figure('Name', title_str, 'Position', [100, 100, 800, 600]);

if isempty(labels)
    labels = cell(1, size(x, 1));
    for i = 1:size(x, 1)
        labels{i} = sprintf('$x_%d$', i);
    end
end

hold on;
for i = 1:size(x, 1)
    color_idx = mod(i-1, length(colors)) + 1;
    plot(time, x(i, :), 'Color', colors{color_idx}, 'LineWidth', linewidth, ...
         'DisplayName', labels{i}, 'Interpreter', 'latex');
end

xlabel('$k$', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('States', 'FontSize', 12);
legend('Interpreter', 'latex', 'FontSize', 10);
grid on;
title(title_str, 'FontSize', 14);

end

function plot_switching_signal(time, signal, title_str, varargin)
% PLOT_SWITCHING_SIGNAL Plot switching signal
% 
% Input:
%   time - Time vector
%   signal - Switching signal
%   title_str - Figure title
%   varargin - Optional parameters
%     'ylim' - Y-axis range
%     'linewidth' - Line width

%% Parameter parsing
p = inputParser;
addParameter(p, 'ylim', [0.5, 2.5], @isnumeric);
addParameter(p, 'linewidth', 2, @isnumeric);
parse(p, varargin{:});

ylim_range = p.Results.ylim;
linewidth = p.Results.linewidth;

%% Plotting
figure('Name', title_str, 'Position', [200, 200, 800, 400]);
stairs(time, signal, 'LineWidth', linewidth);
xlabel('$k$', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$\sigma(k)$', 'Interpreter', 'latex', 'FontSize', 12);
ylim(ylim_range);
grid on;
title(title_str, 'FontSize', 14);

end

function plot_convergence_comparison(time, data, labels, title_str, varargin)
% PLOT_CONVERGENCE_COMPARISON Plot convergence comparison
% 
% Input:
%   time - Time vector
%   data - Data matrix (each row is data for one method)
%   labels - Method labels
%   title_str - Figure title
%   varargin - Optional parameters
%     'colors' - Color array
%     'linestyles' - Line style array
%     'linewidth' - Line width

%% Parameter parsing
p = inputParser;
addParameter(p, 'colors', {'#1B9E77', '#D95F02', '#7570B3', '#E7298A', '#66A61E', '#A6761D'}, @iscell);
addParameter(p, 'linestyles', {'-', '--', '-.', ':', '-', '--'}, @iscell);
addParameter(p, 'linewidth', 2, @isnumeric);
parse(p, varargin{:});

colors = p.Results.colors;
linestyles = p.Results.linestyles;
linewidth = p.Results.linewidth;

%% Plotting
figure('Name', title_str, 'Position', [100, 100, 1000, 600]);
hold on;

for i = 1:size(data, 1)
    color_idx = mod(i-1, length(colors)) + 1;
    style_idx = mod(i-1, length(linestyles)) + 1;
    
    plot(time, data(i, :), 'LineWidth', linewidth, ...
         'DisplayName', labels{i}, ...
         'Color', colors{color_idx}, ...
         'LineStyle', linestyles{style_idx});
end

xlabel('$k$', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$||x(k)||$', 'Interpreter', 'latex', 'FontSize', 12);
legend('Location', 'northeast', 'FontSize', 10);
grid on;
grid minor;
title(title_str, 'FontSize', 14);

end

function save_figure(fig_handle, filename, varargin)
% SAVE_FIGURE Save figure
% 
% Input:
%   fig_handle - Figure handle
%   filename - Filename
%   varargin - Optional parameters
%     'format' - File format ('png', 'pdf', 'eps', 'svg')
%     'dpi' - Resolution
%     'path' - Save path

%% Parameter parsing
p = inputParser;
addParameter(p, 'format', 'png', @ischar);
addParameter(p, 'dpi', 300, @isnumeric);
addParameter(p, 'path', './results/', @ischar);
parse(p, varargin{:});

format = p.Results.format;
dpi = p.Results.dpi;
path = p.Results.path;

%% Create directory
if ~exist(path, 'dir')
    mkdir(path);
end

%% Save figure
full_filename = fullfile(path, [filename, '.', format]);
print(fig_handle, full_filename, ['-d', format], ['-r', num2str(dpi)]);
fprintf('Figure saved to: %s\n', full_filename);

end 