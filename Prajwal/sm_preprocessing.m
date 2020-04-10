%% Add paths
addpath(genpath('.\Prajwal'));

%% Read Catalogues
GD_CAT = readmatrix('.\Prajwal\Catalogues\Guide_Catalogue.csv'); % Read - Guide catalogue
PP_CAT = readmatrix('.\Prajwal\Catalogues\PreProcessed_Catalogue.csv'); % Read - Reference catalogue (which contains the star pairs)

c_ANG_DST = PP_CAT(:,4); % Extract 'Angular distance' from Reference catalogue

%% Initialize variables
u = 2.22*1.0e-16; % Precision of the machine 

sz = size(PP_CAT); % Size of REF_CAT
n_rw_RC = sz(1); % Number of star pairs (Number of rows - Reference catalogue)

c_z = zeros(n_rw_RC, 1);
K_VEC = zeros(n_rw_RC, 1);

%% Calculate constants
m = ( max(c_ANG_DST) - min(c_ANG_DST) + 2*u ) / ( n_rw_RC - 1 );
q = min(c_ANG_DST) - u - m ;

%% Construct K-Vector
for i_rw = 1:n_rw_RC             
    c_z(i_rw) = m*i_rw + q;
    K_VEC(i_rw) = i_rw - 1;
    
    if c_z(i_rw) > c_ANG_DST(i_rw)
        K_VEC(i_rw) = K_VEC(i_rw) + 1;
    end
    
end

%% Create Reference Catalogue
REF_CAT = [PP_CAT, K_VEC]; % Append K-Vector column to Reference catalogue 
writematrix(REF_CAT, '.\Prajwal\Catalogues\Reference_Catalogue.csv');
