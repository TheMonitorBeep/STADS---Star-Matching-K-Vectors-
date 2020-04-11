%% Add paths
addpath(genpath('.\Prajwal'));
clc
%% Read Catalogues
GD_CAT = readmatrix('.\Prajwal\Catalogues\Guide_Catalogue.csv'); % Read - Guide catalogue
REF_CAT = readmatrix('.\Prajwal\Catalogues\Reference_Catalogue.csv'); % Read - Reference catalogue (which contains the star pairs)

c_ANG_DST = REF_CAT(:,4); % Extract 'Angular distance' from Reference catalogue
K_VEC = REF_CAT(:,5); % Extract K-Vector from Reference catalogue

%% Input from Feature Extraction
TRUE_STAR_ID = [18686; 19013; 18386; 17947]; 

TRUE = [429632, 18686, 19013, 0.999719952559425;
        429538,	18686, 18386, 0.999707430257071;
        358735, 17947, 18686, 0.990165287308108;
        423077, 19013, 18386, 0.998859985155972;
        337399, 17947, 19013, 0.987236809197251;
        378234, 17947, 18386, 0.992827250569396;]; % Test Case
    
c_img_ang_dst = TRUE(:, 4); % set of input angular distances ( cos(theta) )

%% Add error to image angular distances
c_err = randn(6,1) * 1.0e-6; % Generate error 
c_img_ang_dst = c_img_ang_dst + c_err; % Add error to angular distances

%% Initialize variables
E = 2.22*1.0e-16; % Precision of the machine

sz = size(REF_CAT); % Size of REF_CAT
n_rw_RC = sz(1); % Number of star pairs (Number of rows - Reference catalogue)

sz = size(GD_CAT); % Size of GD_CAT
n_rw_GC = sz(1); % Number of guide stars (Number of rows - Guide catalogue)

eps = 0.0001; % Epsilon value
M = ( max(c_ANG_DST) - min(c_ANG_DST) + 2*E ) / ( n_rw_RC - 1 );
Q = min(c_ANG_DST) - E - M ;

%% Generate Star Identification Matrix
SIM = zeros(n_rw_GC, 6);

for j_clm = 1:6
    ang_dst = c_img_ang_dst(j_clm); % Angular distance of (j-th) pair
    %% Generate Candidate Star Pair Array
    [CSPA, ~] = sm_gnrt_CSPA(ang_dst, eps, Q, M, REF_CAT);   % Determine candidate star pair array
    
    %% Update (j-th) column of SIM for stars found in CSPA
    
    for idx = 1:length(CSPA)
        st_id = CSPA(idx); % Possible Star ID
        
        [r,c] = find(GD_CAT == st_id); % Index of st_id in Guide catalogue
        %SIM(r, j_clm) = SIM(r, j_clm) + 1; % Increment  value
        SIM(r, j_clm) = 1; % Updating value
    end
end
disp('SIM - Done');

%% Check
% Coarse Check
COND = [1, 1, 1 ,0, 0, 0;
        1, 0, 0, 1, 1, 0;
        0, 1, 0, 1, 0, 1;
        0, 0, 1, 0, 1, 1]; % Check conditions

check_cond = zeros(4,1); % (i-th) element holds the number of matched rows of SIM with the (i-th) condition
act_st_idx =  zeros(4,1); %(i-th) element holds the row number of SIM which matches the (i-th) condition

for j_rw = 1:4
    cond_i = COND(j_rw, :); % (j-th) condition
    cnt = 0; % Counter variable
    
    for i_rw = 1:n_rw_GC
        rw = SIM(i_rw, :); % (i-th) row
        if cond_i == rw % Check row with condition
            act_st_idx(j_rw) = i_rw; % Store row number when condition matches
            cnt = cnt + 1; % Update counter 
        end
    end
    check_cond(j_rw) = cnt; % Store counter value
end

% Ideall all elements should be 1 - indicating that only 1 row of SIM has
% been matched. (n) in (i-th) column implies (n) rows matched the (i-th)
% condition
disp(transpose(check_cond)); 


% Fine Check
act_st_id = zeros(4,1); % (i-th) element holds the Star ID to which the (i-th) condition has been matched to
st_id_bool = zeros(4,1); % (i-th) element holds the bool value of whether the actual (i-th) star ID == expected (i-th) star ID 

for i_rw = 1:4    
    if check_cond(i_rw) == 1 % If only one row of SIM has matched with the (i-th) condition
        
        st_idx = act_st_idx(i_rw); % Extract the corresponding row number of SIM which has matched
        act_st_id(i_rw) = GD_CAT(st_idx, 2); % Find the corresponding Star ID from the GD_CAT using the row number
        
        if act_st_id(i_rw) == TRUE_STAR_ID(i_rw) % Checking if actual Star ID is equal to expected Star ID
            st_id_bool(i_rw) = true; % Set true value 
        end
    end
end

% First row corresponds to the expected Star IDs
% Second row corresponds to the actual Star IDs
% Third row corresponds to the bool value of whether each of the actual and
% expected Star IDs match
disp([TRUE_STAR_ID.'; act_st_id.'; st_id_bool.']);