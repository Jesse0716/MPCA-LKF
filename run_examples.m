%% MPCA-LKF Project Demo Script
% 
% This script demonstrates all main features of the MPCA-LKF project
%
% Author: Da Chen
% Date: 2025-08-04

clear; clc; close all;

fprintf('=== MPCA-LKF Project Demo ===\n\n');

%% 1. Run Discrete-Time Linear Switched System Simulation
fprintf('1. Running discrete-time linear switched system simulation...\n');
try
    [x, rrho1, instant] = Example_2_Simulation('final', 100, 'times', 10);
    fprintf('   - Simulation completed\n');
catch ME
    fprintf('   - Simulation failed: %s\n', ME.message);
end

%% 2. Run MPCA-LKF State Simulation
fprintf('\n2. Running MPCA-LKF state simulation...\n');
try
    [x_state, p_signal, time] = State_Simulation('N', 200, 'tau', 2);
    fprintf('   - State simulation completed\n');
catch ME
    fprintf('   - State simulation failed: %s\n', ME.message);
end

%% 3. Run Convergence Comparison
fprintf('\n3. Running convergence comparison...\n');
try
    Convergence_Comparison('k_max', 200, 'x0', 1);
    fprintf('   - Convergence comparison completed\n');
catch ME
    fprintf('   - Convergence comparison failed: %s\n', ME.message);
end

%% 4. Test MAC-LKF Solver
fprintf('\n4. Testing MAC-LKF solver...\n');
try
    % Setup parameters
    params = Parameter_Setup();
    
    % Run MAC-LKF solver
    result_mac = MAC_LKF_Solver(params);
    
    % Display results
    fprintf('   Solver status: %s\n', result_mac.status);
    fprintf('   Solver message: %s\n', result_mac.message);
    fprintf('   Feasibility: %s\n', mat2str(result_mac.feasible));
    fprintf('   - MAC-LKF solver test completed\n');
catch ME
    fprintf('   - MAC-LKF solver test failed: %s\n', ME.message);
end

%% 5. Test MPCA-LKF Solver
fprintf('\n5. Testing MPCA-LKF solver...\n');
try
    % Setup parameters
    params = Parameter_Setup();
    
    % Run MPCA-LKF solver
    result_mpca = MPCA_LKF_Solver(params);
    
    % Display results
    fprintf('   Solver status: %s\n', result_mpca.status);
    fprintf('   Solver message: %s\n', result_mpca.message);
    fprintf('   Feasibility: %s\n', mat2str(result_mpca.feasible));
    fprintf('   - MPCA-LKF solver test completed\n');
catch ME
    fprintf('   - MPCA-LKF solver test failed: %s\n', ME.message);
end

%% 6. Compare Two Methods
fprintf('\n6. Method comparison...\n');
if exist('result_mac', 'var') && exist('result_mpca', 'var')
    fprintf('   MAC-LKF feasibility: %s\n', mat2str(result_mac.feasible));
    fprintf('   MPCA-LKF feasibility: %s\n', mat2str(result_mpca.feasible));
    
    if result_mac.feasible && result_mpca.feasible
        fprintf('   - Both methods are feasible\n');
    elseif result_mpca.feasible && ~result_mac.feasible
        fprintf('   - MPCA-LKF method is superior\n');
    elseif result_mac.feasible && ~result_mpca.feasible
        fprintf('   - MAC-LKF method is superior\n');
    else
        fprintf('   - Both methods are infeasible\n');
    end
else
    fprintf('   - Cannot compare, solver tests failed\n');
end

%% 7. Display Project Information
fprintf('\n=== Project Information ===\n');
fprintf('Project name: MPCA-LKF (Multiple Piecewise Convex and Asymmetric Lyapunov-Krasovskii Functional)\n');
fprintf('Key features:\n');
fprintf('  - Piecewise convex Lyapunov function\n');
fprintf('  - Asymmetric matrix structure\n');
fprintf('  - Free weight matrices\n');
fprintf('  - Improved estimation accuracy\n');
fprintf('  - Reduced conservatism\n');
fprintf('  - Support for both MAC-LKF and MPCA-LKF methods\n');

fprintf('\n=== Demo Completed ===\n');
fprintf('All figures have been generated, please check the figure windows.\n');
fprintf('To save results, please use MATLAB save command.\n');