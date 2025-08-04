function params = Parameter_Setup()
% PARAMETER_SETUP Setup system parameters for MPCA-LKF and MAC-LKF
% 
% Output:
%   params - Structure containing all system parameters
%
% Author: Da Chen
% Date: 2025-08-04

%% System matrix definition
params.A(:,:,1) = diag([0.9597, 0.9473]);
params.B(:,:,1) = diag([0.01, 0.009]);
params.C(:,:,1) = [0 0.011; 0.02 0];  % Corrected to original file value

params.A(:,:,2) = diag([0.9597, 0.9473]);
params.B(:,:,2) = diag([0.02, 0.002]);
params.C(:,:,2) = [0 0.05; 0 0.05];

%% Activation function parameters
params.K1 = diag([-0.1, -0.1]);
params.K2 = diag([0.1, 0.1]);

%% MPCA-LKF piecewise convex combination parameters
params.a111 = 0.4; params.a112 = 0.6;
params.a121 = 0.2; params.a122 = 0.8;
params.a211 = 0.4; params.a212 = 0.6;
params.a221 = 0.2; params.a222 = 0.8;

params.b111 = 0.3; params.b112 = 0.7;
params.b121 = 0.3; params.b122 = 0.7;
params.b211 = 0.3; params.b212 = 0.7;
params.b221 = 0.3; params.b222 = 0.7;

%% MAC-LKF piecewise parameters
params.a11 = 0.4; params.a12 = 0.6;
params.a21 = 0.2; params.a22 = 0.8;
params.b11 = 0.3; params.b12 = 0.7;
params.b21 = 0.3; params.b22 = 0.7;

%% Time delay parameters
params.n = 2;          % System dimension
params.h_2 = 16;       % Maximum delay (MPCA-LKF)
params.h_1 = 1;        % Minimum delay
params.h_12 = params.h_2 - params.h_1;

params.h_k = params.h_1;
params.h_1k = params.h_k - params.h_1 + 1;
params.h_2k = params.h_2 - params.h_k + 1;

%% Stability parameters
params.N_01 = 1;
params.N_02 = 1;
params.alpha_1 = 0.01;     % Exponential decay rate (MPCA-LKF)
params.alpha_2 = 0.01;
params.mu_1 = 1.01;        % Switching parameters
params.mu_2 = 1.01;
params.pho_1 = 0.85;       % Piecewise parameters
params.pho_2 = 0.85;

%% MAC-LKF specific parameters (consistent with original file)
params.alpha_1_mac = 0.001;  % MAC-LKF alpha_1
params.alpha_2_mac = 0.005;  % MAC-LKF alpha_2
params.mu_2_mac = 1.05;      % MAC-LKF mu_2
params.h_2_mac = 8;          % MAC-LKF h_2

%% Simulation parameters
params.tau = 2;            % Delay
params.N = 200;            % Simulation steps
params.min_dwell = 12;     % Minimum dwell time

%% Activation functions
params.f1 = @(s) tanh(0.5*s) - 0.1*s;
params.f2 = @(s) tanh(0.5*s) - 0.1*s;

%% Initial conditions
params.x0 = [0.5; -0.3];

end 