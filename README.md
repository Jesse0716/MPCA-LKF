# MPCA-LKF: Multiple Piecewise Convex and Asymmetric Lyapunov-Krasovskii Functional

## 📖 Project Introduction

This project implements the Multiple Piecewise Convex and Asymmetric Lyapunov-Krasovskii Functional (MPCA-LKF) method for studying exponential stability of discrete-time switched neural networks (DSNNs) under mode-dependent average dwell time (MDADT) switching.

## ✨ Key Features

- 🧮 **MPCA-LKF Method**: Introduces linear time-varying convex combinations on piecewise switching intervals
- 🔄 **MAC-LKF Method**: Multiple piecewise convex Lyapunov-Krasovskii functional method
- ⚖️ **Asymmetric Matrix Structure**: Eliminates traditional symmetry and positive definiteness constraints
- 🎯 **Free Weight Matrices**: Avoids non-convex terms caused by forward differences
- 📈 **Improved Estimation Accuracy**: Enhances tightness of Lyapunov difference estimation through piecewise convexity

## 📁 Project Structure

```
MPCA-LKF/
├── README.md                    # Project documentation
├── INSTALL.md                   # Installation guide
├── LICENSE                      # MIT License
├── run_examples.m              # Main execution script
├── src/                         # Source code directory
│   ├── core/                    # Core algorithm implementation
│   │   ├── MPCA_LKF_Solver.m   # MPCA-LKF solver
│   │   ├── MAC_LKF_Solver.m    # MAC-LKF solver
│   │   └── System_Definition.m  # System definition
│   ├── examples/                # Example code
│   │   ├── Example_2_Simulation.m  # Discrete-time linear switched system simulation
│   │   ├── State_Simulation.m      # State simulation
│   │   ├── Convergence_Comparison.m # Convergence comparison
│   │   └── Method_Comparison.m     # Method comparison
│   └── utils/                   # Utility functions
│       ├── Plotting_Tools.m     # Plotting tools
│       └── Parameter_Setup.m    # Parameter setup
├── data/                        # Data files
└── results/                     # Result outputs
```

## 📋 Installation Requirements

- MATLAB R2018b or higher
- YALMIP toolbox
- PENLAB solver (or other LMI solvers)

## 🚀 Quick Start

### 1️⃣ Run Basic Examples

```matlab
% Run discrete-time switched system simulation
run('src/examples/Example_2_Simulation.m');

% Run state simulation
run('src/examples/State_Simulation.m');

% Run convergence comparison
run('src/examples/Convergence_Comparison.m');
```

### 2️⃣ Use Solvers

```matlab
% Create system parameters
params = Parameter_Setup();

% Run MAC-LKF solver
result_mac = MAC_LKF_Solver(params);

% Run MPCA-LKF solver
result_mpca = MPCA_LKF_Solver(params);

% Compare two methods
results = Method_Comparison();
```

### 3️⃣ Run Complete Demo

```matlab
% Run all examples and comparisons
run_examples;
```

## 🧠 Core Algorithms

### MPCA-LKF Method

The main innovations of this method include:

1. **Piecewise Convex Lyapunov Function**: Introduces linear time-varying convex combinations on switching intervals
2. **Asymmetric Matrix Structure**: Eliminates traditional symmetry and positive definiteness constraints
3. **Free Weight Matrices**: Avoids non-convex terms caused by forward differences
4. **Improved Estimation Accuracy**: Enhances tightness of Lyapunov difference estimation through piecewise convexity

### MAC-LKF Method

MAC-LKF is the predecessor method of MPCA-LKF, featuring:

1. **Multiple Piecewise Convex Structure**: Constructs convex combinations on multiple intervals
2. **Traditional Symmetric Constraints**: Maintains matrix symmetry
3. **Basic Stability Analysis**: Provides fundamental stability criteria

### Stability Criteria

Based on MPCA-LKF, the following exponential stability criteria are established:

- New exponential stability criteria in linear matrix inequality (LMI) form
- Explicitly considers switching modes and state-dependent behavior
- Two corollaries handle slow switching to stable modes and fast switching to unstable modes

## 📊 Performance Comparison

Compared to existing methods, MPCA-LKF method has:

- 📉 **Reduced Conservatism**: Reduces conservatism through asymmetric matrix structure
- ⏱️ **Improved Delay Bounds**: Obtains better admissible delay bounds
- 📈 **Enhanced Estimation Accuracy**: Improves estimation accuracy through piecewise convexity
- ✅ **Better Feasibility**: Better feasibility compared to MAC-LKF

## ⚖️ Method Comparison

The project provides comparison functionality for two methods:

```matlab
% Compare MAC-LKF and MPCA-LKF methods
results = Method_Comparison('plot_results', true);

% View comparison results
disp(results);
```

## 🔧 Code Refactoring Summary

### Major Improvements

1. 🔧 **Code Standardization**: Functionization, parameterization, modularization
2. 🎯 **Usability Enhancement**: Unified interface, error handling, comprehensive documentation
3. 🏗️ **Maintainability Improvement**: Clear directory structure, version control
4. 🚀 **Functionality Extension**: Plotting tools, parameter management, result saving

## 🔧 Solver Encapsulation

### Overview

Successfully standardized encapsulation of two YALMIP solver files:

1. **YALMIP_MACLKF.m** → **MAC_LKF_Solver.m**
2. **YALMIP_MPACLKF.m** → **MPCA_LKF_Solver.m**

### Encapsulation Improvements

#### 1. Code Standardization
- **Functionization**: Convert scripts to functions
- **Parameterization**: Use structures to pass parameters
- **Modularization**: Separate core functionality and auxiliary functions

#### 2. Unified Interface
- Both solvers use the same input/output interface
- Unified error handling and result format
- Consistent parameter setup method

#### 3. Enhanced Functionality
- Added method comparison functionality
- Provided visualization of comparison results
- Support for batch testing and result saving

### Key Features

#### MAC-LKF Solver
- Multiple piecewise convex Lyapunov function
- Traditional symmetric constraints
- Basic stability analysis

#### MPCA-LKF Solver
- Piecewise convex Lyapunov function
- Asymmetric matrix structure
- Improved estimation accuracy

#### Comparison Functionality
- Feasibility comparison
- Visualization results
- Performance analysis

### Technical Advantages

1. 🧹 **Code Maintainability**: Clear function structure and comments
2. 🎯 **Usability**: Unified interface and parameter setup
3. 🔌 **Extensibility**: Modular design for easy extension
4. ⚖️ **Comparability**: Built-in method comparison functionality

## 📥 Installation Guide

### System Requirements

#### Required Software
- **MATLAB**: R2018b or higher
- **YALMIP**: Latest version (recommended 2021.06.21 or higher)
- **Solver**: PENLAB or other LMI solvers

#### Recommended Configuration
- **Operating System**: Windows 10/11, macOS 10.15+, Ubuntu 18.04+
- **Memory**: 8GB or higher
- **Storage**: At least 1GB available space

### Installation Steps

#### 1️⃣ Install MATLAB
1. Download and install MATLAB from MathWorks official website
2. Ensure the following toolboxes are installed:
   - Control System Toolbox
   - Optimization Toolbox
   - Statistics and Machine Learning Toolbox

#### 2️⃣ Install YALMIP
1. Visit [YALMIP official website](https://yalmip.github.io/)
2. Download the latest version of YALMIP
3. Extract to MATLAB path, for example: `C:\MATLAB\YALMIP`
4. Run in MATLAB:
   ```matlab
   addpath(genpath('C:\MATLAB\YALMIP'))
   yalmip('version')
   ```

#### 3️⃣ Install Solver
Recommended to use PENLAB solver:

1. Visit [PENLAB official website](http://web.mat.bham.ac.uk/S.Zlobec/PENLAB/)
2. Download the version suitable for your system
3. Follow the official documentation for installation
4. Test in MATLAB:
   ```matlab
   yalmip('solver')
   ```

#### 4️⃣ Configure Project
1. Clone or download this project
2. Add project path in MATLAB:
   ```matlab
   addpath(genpath('path/to/MPCA-LKF'))
   ```

### Verify Installation

Run the following commands to verify installation:

```matlab
% Check YALMIP
yalmip('version')

% Check available solvers
yalmip('solver')

% Run tests
run_examples
```

### Common Issues

#### Q: YALMIP installation failed
**A**: Ensure MATLAB version compatibility and check path settings.

#### Q: Solver not available
**A**: Check if the solver is correctly installed and ensure it's in MATLAB path.

#### Q: Insufficient memory
**A**: For large problems, it's recommended to increase MATLAB memory limit or use more efficient solvers.

## 🛠️ Technology Stack

- MATLAB
- YALMIP
- PENLAB
- Git
- Markdown

## 🔮 Future Improvements

1. 🔧 Complete LMI constraint construction
2. 🛠️ Add more solver options
3. 📊 Enhance visualization functionality
4. ⚡ Add performance benchmarking

## 📄 License

This project is licensed under the MIT License. See LICENSE file for details.