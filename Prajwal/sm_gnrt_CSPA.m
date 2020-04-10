function  [CSPA, start, stop] = sm_gnrt_CSPA(ang_dst, eps, q, m, REF_CAT)           
    %function to generate the candidate star pair array from the measured value
    %of the angular distance
    %% Add paths
    addpath(genpath('.\Prajwal'));

    K_VEC = REF_CAT(:, 5); % Extract K-Vector from Reference catalogue

    %% Calculate constants
    s = sqrt( 1- ang_dst^2 );
    k_bot = floor( (ang_dst*cos(eps) - s*sin(eps) - q) / m ); % Lower value
    k_top = ceil( (ang_dst*cos(eps) + s*sin(eps) - q) / m ); % Upper value

    start = K_VEC(k_bot) + 1; % Lower index
    stop = K_VEC(k_top); % Upper index

    %% Junk Code
    %len = start - stop; % Length of the CSPA
    %len = len + 1; 
    %disp(k_bot);disp(K_VEC(k_bot));
    %disp(k_top);disp(K_VEC(k_top));

    %% Calculate Candidate Star Pair Array
    if (start == stop)
        idx = stop;

        st_ID1 = REF_CAT(idx, 2); % Determine Star-IDs from Reference Catalogue
        st_ID2 = REF_CAT(idx, 3);

        CSPA = [st_ID1, st_ID2]; % Store Star-IDs

    else
        CSPA = [];
        for idx = start:stop

            st_ID1 = REF_CAT(idx, 2); % Determine Star-IDs from Reference Catalogue
            st_ID2 = REF_CAT(idx, 3);

            tmp = [st_ID1, st_ID2];
            CSPA = [CSPA, tmp]; % Store Star-IDs
        end

    end
end