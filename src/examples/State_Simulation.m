function [x, p_signal, time] = State_Simulation(varargin)
% STATE_SIMULATION MPCA-LKF state simulation
% 
% Input parameters (optional):
%   N - Simulation steps (default: 200)
%   tau - Delay (default: 2)
%   min_dwell - Minimum dwell time (default: 12)
%   x0 - Initial conditions (default: [0.5; -0.3])
%   plot_results - Whether to plot results (default: true)
% 
% Output:
%   x - State trajectory
%   p_signal - Switching signal
%   time - Time vector
%
% Author: Da Chen
% Date: 2025-08-04

%% Parameter parsing
p = inputParser;
addParameter(p, 'N', 200, @isnumeric);
addParameter(p, 'tau', 3, @isnumeric);
addParameter(p, 'min_dwell', 12, @isnumeric);
addParameter(p, 'x0', [0.5; -0.3], @isnumeric);
addParameter(p, 'plot_results', true, @islogical);
parse(p, varargin{:});

N = p.Results.N;
tau = p.Results.tau;
min_dwell = p.Results.min_dwell;
x0 = p.Results.x0;
plot_results = p.Results.plot_results;

%% System matrix definition
A(:,:,1) = [0.9597 0; 0 0.9473];
B(:,:,1) = [0.01 0; 0 0.009];
C(:,:,1) = [0 0.011; 0.002 0];

A(:,:,2) = [0.9597 0; 0 0.9473];
B(:,:,2) = [0.02 0; 0 0.02];
C(:,:,2) = [0 0.005; 0.005 0];

%% Activation functions
f1 = @(s) tanh(0.5*s) - 0.1*s;
f2 = @(s) tanh(0.5*s) - 0.1*s;

%% Initialization
x = zeros(2, N+tau);
x(:,1:tau) = repmat(x0, 1, tau);

%% Generate switching signal
p_signal = generate_switching_signal(N, min_dwell);

%% Simulation
for k = tau+1:N+tau-1
    p = p_signal(k - tau);    
    xk = x(:,k);
    fk = [f1(xk(1)); f2(xk(2))];
    fk_tau = [f1(x(1,k-tau)); f2(x(2,k-tau))];
    
    x(:,k+1) = A(:,:,p)*xk + B(:,:,p)*fk + C(:,:,p)*fk_tau;
end

%% Time vector
time = 0:N-1;

%% Plotting
if plot_results
    plot_state_results(x, p_signal, time, tau);
end

end

function p_signal = generate_switching_signal(N, min_dwell)
% Generate switching signal satisfying dwell time constraints
p_signal = [];
current_mode = 1;

while length(p_signal) < N
    dwell = min_dwell + randi([0,5]); 
    p_signal = [p_signal, current_mode*ones(1, dwell)];
    current_mode = 3 - current_mode;  % Switch between 1 and 2
end
p_signal = p_signal(1:N);  % Ensure length = N
end

function plot_state_results(x, p_signal, time, tau)
% Plot state simulation results

% State trajectory plot
figure('Name', 'State Trajectory', 'Position', [100, 100, 800, 600]);
plot(time, x(1,tau+1:end), 'b-', 'LineWidth', 2); 
hold on;
plot(time, x(2,tau+1:end), 'r--', 'LineWidth', 2);
xlabel('$k$', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('States $x_1, x_2$', 'Interpreter', 'latex', 'FontSize', 12);
legend('$x_1$', '$x_2$', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
title('MPCA-LKF State Trajectory', 'FontSize', 14);

% Switching signal plot
figure('Name', 'Switching Signal', 'Position', [200, 200, 800, 400]);
stairs(time, p_signal, 'LineWidth', 2);
xlabel('$k$', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$\sigma(k)$', 'Interpreter', 'latex', 'FontSize', 12);
ylim([0.5 2.5]);
grid on;
title('Switching Signal', 'FontSize', 14);

end 