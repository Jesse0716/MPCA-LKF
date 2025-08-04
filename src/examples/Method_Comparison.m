function [results] = Method_Comparison(varargin)
% METHOD_COMPARISON MAC-LKF and MPCA-LKF method comparison
% 
% Input parameters (optional):
%   plot_results - Whether to plot results (default: true)
% 
% Output:
%   results - Comparison result structure

%% Parameter parsing
p = inputParser;
addParameter(p, 'plot_results', true, @islogical);
parse(p, varargin{:});

plot_results = p.Results.plot_results;

%% Setup parameters
params = Parameter_Setup();

%% Test MAC-LKF method
fprintf('Testing MAC-LKF method...\n');
try
    result_mac = MAC_LKF_Solver(params);
    mac_feasible = result_mac.feasible;
    fprintf('  MAC-LKF status: %s\n', result_mac.status);
catch ME
    fprintf('  MAC-LKF failed: %s\n', ME.message);
    mac_feasible = false;
end

%% Test MPCA-LKF method
fprintf('Testing MPCA-LKF method...\n');
try
    result_mpca = MPCA_LKF_Solver(params);
    mpca_feasible = result_mpca.feasible;
    fprintf('  MPCA-LKF status: %s\n', result_mpca.status);
catch ME
    fprintf('  MPCA-LKF failed: %s\n', ME.message);
    mpca_feasible = false;
end

%% Compare results
fprintf('\n=== Method Comparison Results ===\n');
fprintf('MAC-LKF feasibility: %s\n', mat2str(mac_feasible));
fprintf('MPCA-LKF feasibility: %s\n', mat2str(mpca_feasible));

if mpca_feasible && ~mac_feasible
    fprintf('Conclusion: MPCA-LKF method is superior\n');
elseif mac_feasible && ~mpca_feasible
    fprintf('Conclusion: MAC-LKF method is superior\n');
elseif mac_feasible && mpca_feasible
    fprintf('Conclusion: Both methods are feasible\n');
else
    fprintf('Conclusion: Parameters need adjustment\n');
end

%% Save results
results = struct();
results.mac_feasible = mac_feasible;
results.mpca_feasible = mpca_feasible;
results.timestamp = datetime('now');

%% Plotting
if plot_results
    plot_comparison_results(mac_feasible, mpca_feasible);
end

end

function plot_comparison_results(mac_feasible, mpca_feasible)
% Plot comparison results
figure('Name', 'Method Comparison Results', 'Position', [100, 100, 800, 600]);

methods = {'MAC-LKF', 'MPCA-LKF'};
feasibility = [mac_feasible, mpca_feasible];

bar(1:2, feasibility, 'FaceColor', 'flat');
colormap([0.8 0.2 0.2; 0.2 0.8 0.2]);

set(gca, 'XTickLabel', methods);
ylabel('Feasibility');
title('MAC-LKF vs MPCA-LKF Feasibility Comparison');
ylim([0, 1.2]);

for i = 1:2
    if feasibility(i)
        text(i, 1.1, 'Feasible', 'HorizontalAlignment', 'center', 'FontWeight', 'bold');
    else
        text(i, 0.1, 'Infeasible', 'HorizontalAlignment', 'center', 'FontWeight', 'bold');
    end
end

grid on;

end 