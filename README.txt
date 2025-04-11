%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	This repository contains all code used for the generation of data and figures of in
 		C.R. Sampson, J.G. Restrepo, and M.A. Porter, Oscillatory and Excitable Dynamics in an Opinion Model with Group Opinions.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	Dependences and Acknowledgments:
  	    Fig_8_generator_and_figure.m depends on the jacobianest.m file for numerical 
 	    computation of the Jacobian matrix by John D'Errico. This file is available through MathWorks file Exchange at
 	    https://www.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation.

  	Citation: John D'Errico (2024). Adaptive Robust Numerical Differentiation 
                  (https://www.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation), 
                  MATLAB Central File Exchange. Retrieved July 29, 2024. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	This repository includes a number of matlab functions that make up the implementation of our stochastic opinon model
	and mean-field maps. These functions have additional documentation that explains the intended input and corresponding output.

	Additional files labeled with "data_generator" in the file name generate the data used for the creation of specific 
	figures and save the output as a .txt file. Files labeled with "builder" in the file name create the figures from the corresponding data. 
	Files that are labeled both with "data generator" and "builder" run nessecary simulations and create the 
	figure in the same file (in this case no data is saved). 

	The matlab file titled runfile.m runs all data generators for figures 3, 4, and 10. 
	However, please note that the run file for this file is several days.

	The "Data" folder contains all data produced by the "data generator" files to allow figures to be generated without running the code base.
	The "Figures" folder contains all figures for the paper both as matlab .fig files and .png files or .svg files as were used in the corresponding paper. 
	Note that some figures have additional labels added in post, which are not included in the .fig file versions in this repository.

	Any questions regarding the code in this repository can be directed to corbit.sampson@colorado.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
