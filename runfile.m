%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright 2022 - 2025 Corbit R. Sampson
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file is part of the Oscillatory_Excitable_Opinion_Dynamics repository.
%
% Competing_Social_Contagions repository is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
% as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
%
% Competing_Social_Contagions repository is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
% See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along with Oscillatory_Excitable_Opinion_Dynamics. If not, see <https://www.gnu.org/licenses/>. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% preamble
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This file is sectioned off to run the data generator codes for figures
% 2,3,4, and 9. The sections can be run one at a time using the "run
% section" command in matlab.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Section for Fig.2

disp('begin running fig.2 data generators')

run('Fig_2_mean_field_data_generator'); disp('finished 1/2')
run('Fig_2_stochastic_model_data_generator'); disp('finished 2/2')

%% Section for Fig.3

disp('begin running fig.3 data generators')

run('Fig_3_data_generator_c01_d01_mu25'); disp('finished 1/6')
run('Fig_3_data_generator_c01_d01_mu50'); disp('finished 2/6')
run('Fig_3_data_generator_c01_d09_mu25'); disp('finished 3/6')
run('Fig_3_data_generator_c01_d09_mu50'); disp('finished 4/6')
run('Fig_3_data_generator_c09_d09_mu25'); disp('finished 5/6')
run('Fig_3_data_generator_c09_d09_mu50'); disp('finished 6/6')

%% Section for Fig.4

disp('begin running fig.4 data generators')

run('Fig_4_data_generator_ab02_cd08_mu25'); disp('finished 1/6')
run('Fig_4_data_generator_ab02_cd08_mu50'); disp('finished 2/6')
run('Fig_4_data_generator_ab05_cd05_mu25'); disp('finished 3/6')
run('Fig_4_data_generator_ab05_cd05_mu50'); disp('finished 4/6')
run('Fig_4_data_generator_ab08_cd02_mu25'); disp('finished 5/6')
run('Fig_4_data_generator_ab08_cd02_mu50'); disp('finished 6/6')

%% Section for Fig.9

disp('begin running fig.9 data generators')

run('Fig_9_panel_1_data_generator'); disp('finished 1/3')
run('Fig_9_panel_2_data_generator'); disp('finished 2/3')
run('Fig_9_panel_3_data_generator'); disp('finished 3/3')