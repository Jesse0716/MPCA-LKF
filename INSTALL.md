# MPCA-LKF Installation Guide

## System Requirements

### Required Software
- **MATLAB**: R2018b or higher
- **YALMIP**: Latest version (recommended 2021.06.21 or higher)
- **Solver**: PENLAB or other LMI solvers

### Recommended Configuration
- **Operating System**: Windows 10/11, macOS 10.15+, Ubuntu 18.04+
- **Memory**: 8GB or higher
- **Storage**: At least 1GB available space

## Installation Steps

### 1. Install MATLAB
1. Download and install MATLAB from MathWorks official website
2. Ensure the following toolboxes are installed:
   - Control System Toolbox
   - Optimization Toolbox
   - Statistics and Machine Learning Toolbox

### 2. Install YALMIP
1. Visit [YALMIP official website](https://yalmip.github.io/)
2. Download the latest version of YALMIP
3. Extract to MATLAB path, for example: `C:\MATLAB\YALMIP`
4. Run in MATLAB:
   ```matlab
   addpath(genpath('C:\MATLAB\YALMIP'))
   yalmip('version')
   ```

### 3. Install Solver
Recommended to use PENLAB solver:

1. Visit [PENLAB official website](http://web.mat.bham.ac.uk/S.Zlobec/PENLAB/)
2. Download the version suitable for your system
3. Follow the official documentation for installation
4. Test in MATLAB:
   ```matlab
   yalmip('solver')
   ```

### 4. Configure Project
1. Clone or download this project
2. Add project path in MATLAB:
   ```matlab
   addpath(genpath('path/to/MPCA-LKF'))
   ```

## Verify Installation

Run the following commands to verify installation:

```matlab
% Check YALMIP
yalmip('version')

% Check available solvers
yalmip('solver')

% Run tests
run_examples
```

## Common Issues

### Q: YALMIP installation failed
**A**: Ensure MATLAB version compatibility and check path settings.

### Q: Solver not available
**A**: Check if the solver is correctly installed and ensure it's in MATLAB path.

### Q: Insufficient memory
**A**: For large problems, it's recommended to increase MATLAB memory limit or use more efficient solvers.

## Technical Support

If you encounter installation issues, please:
1. Check system requirements
2. Review error messages
3. Report issues in GitHub Issues

## Updates

Regularly check for updates of the following components:
- YALMIP
- Solvers
- MATLAB toolboxes

## Date

2025-08-04 