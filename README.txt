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
	This repository includes a number of matlab functions which make up the implementation of our stochastic opinon model
	and mean-field maps.

	Additional files labeled as "data generator" generate the data used for the creation of specific 
	figures and save the output as a .txt file. Files labeled as "builders" create the figures which are displayed in a matlab
	figure window. Files which are labeled both as "data generators" and "builders" run nessecary simulations and create the 
	figure in the same file (in this case no data is saved). 

	The matlab file titled runfile.m runs all data generators for figures 3, 4, and 9. 
	However, please note that the run tile for this file is several days.

	The "Data" folder contains all data produced by the "data generator" files to allow figures to be generated without running the code base.
	The "Figures" folder contains all figures for the paper both as matlab .fig files and as .png files. Note that some figures have additional labels
	added post which are not included in the version on the repository at this time.

	Any Questions regarding the code in this repository can be directed to corbit.sampson@colorado.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
