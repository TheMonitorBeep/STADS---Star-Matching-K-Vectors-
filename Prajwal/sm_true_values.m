%% Add paths
addpath(genpath('.\Prajwal'));

%% Read Catalogues
REF_CAT = readmatrix('.\Catalogues\Reference_Catalogue.csv'); % Read - Reference catalogue (which contains the star pairs)
c_ANG_DST = REF_CAT(:,4); % Extract 'Angular distance' from Reference catalogue

%% True Values
TRUE_STAR_ID = [18686; 19013; 18386; 17947];

TRUE = [429632, 18686, 19013, 0.999719952559425;
        429538,	18686, 18386, 0.999707430257071;
        358735, 17947, 18686, 0.990165287308108;
        423077, 19013, 18386, 0.998859985155972;
        337399, 17947, 19013, 0.987236809197251;
        378234, 17947, 18386, 0.992827250569396;];    

%% Search
check = [];
for i = 1:6
    ang_dist = TRUE(i,4);
    [r, c] = find( REF_CAT == ang_dist );
    st_id1 = REF_CAT(r, 2); 
    st_id2 = REF_CAT(r, 3);
    
    tmp = [r, st_id1, st_id2, ang_dist];
%     cond = (tmp == TRUE);
%     
%     if cond
%         disp('True');
%     end
    check = [check; tmp];    
end
%%%%%%%%%%%% If all elements of check are 1 = elements in TRUE are valid
disp(check == TRUE); 

%% Check sm_gnrt_CSPA
E = 2.22*1.0e-16; % Precision of the machine

sz = size(REF_CAT); % Size of REF_CAT
n_rw_RC = sz(1); % Number of star pairs (Number of rows - Reference catalogue)

c_img_ang_dst = TRUE(:, 4);
eps = 0; % Epsilon value
M = ( max(c_ANG_DST) - min(c_ANG_DST) + 2*E ) / ( n_rw_RC - 1 );
Q = min(c_ANG_DST) - E - M ;

check1 = zeros(1,6);
for i = 1:6
    [~, INDEX] = sm_gnrt_CSPA(c_img_ang_dst(i), eps, Q, M, REF_CAT);
    id = TRUE(i, 1);
    start = INDEX(1); stop = INDEX(2);
    if (start<=id) && (id<=stop) % Check if the True Star ID lies between the range predicted by CSPA
        check1(i) = 1;
    end
end
%%%%%%%%%%%% (i-th) element = 1, implies (i-th) TRUE star ID exists in the
%%%%%%%%%%%% range predicted by sm_gnrt_CSPA
disp(check1);

%% Miscellaneous Code

cos_t = c_img_ang_dst(1);
x_val = (cos_t - Q)/M;
k_val = int64(x_val);
[CSPA, INDEX] = sm_gnrt_CSPA(cos_t, 0, Q, M, REF_CAT);