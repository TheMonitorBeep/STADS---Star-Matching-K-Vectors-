%% Add paths
addpath(genpath('.\Prajwal'));

%% Read Catalogues
GD_CAT = readmatrix('.\Prajwal\Catalogues\Guide_Catalogue.csv'); % Read - Guide catalogue
PP_CAT = readmatrix('.\Prajwal\Catalogues\PreProcessed_Catalogue.csv'); % Read - Preprocessed catalogue (which contains the star pairs)

c_ANG_DST = PP_CAT(:,4); % Extract 'Angular distance' from Preprocessed catalogue

%% Construct K-Vector
[K_VEC,~,~] = sm_gnrt_K_VEC( c_ANG_DST, 1 );

%% Create Reference Catalogue
REF_CAT = [PP_CAT, K_VEC]; % Append K-Vector column to Reference catalogue 
writematrix(REF_CAT, '.\Prajwal\Catalogues\Reference_Catalogue.csv');
