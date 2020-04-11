function  [CSPA, INDEX] = sm_gnrt_CSPA(ang_dst, eps, Q, M, REF_CAT)           
    % Generates the candidate star pair array from the measured value
    % of the angular distance
    %Parameters:
    %-----------
    % ang_dist: double
    %     The angular distance calculated between two stars
    % eps: double
    %     The value of epsilon to be used to find the range
    % Q: double
    %     Slope of Z-Vector line
    % M: double
    %     Coefficient of Z-Vector line
    % REF_CAT: matrix
    %     The Reference catalogue, with the following properties: Star_ID1,
    %     Star_ID2 at columns (2,3) and the K-vector at column (5)
    %     respectively    
    % Returns: 
    % --------
    % CSPA: (N,2) - matrix
    %     The possible Star ID matches for given angular distance
    % INDEX: (1,2) - matrix
    %     The start and stop indices of possible matches generated for given angular distance
    
    K_VEC = REF_CAT(:, 5); % Extract K-Vector from Reference catalogue

    %% Calculate constants
    s = sqrt( 1- ang_dst^2 );
    k_bot = floor( (ang_dst*cos(eps) - s*sin(eps) - Q) / M ); % Lower value
    k_top = ceil( (ang_dst*cos(eps) + s*sin(eps) - Q) / M ); % Upper value

    start = K_VEC(k_bot) + 1; % Lower index
    stop = K_VEC(k_top); % Upper index
    INDEX = [start, stop]; % Generate INDEX
    
    %% Calculate Candidate Star Pair Array
    if (start == stop)
        idx = stop; % Assign index value

        st_ID1 = REF_CAT(idx, 2); % Determine Star-IDs from Reference Catalogue
        st_ID2 = REF_CAT(idx, 3);

        CSPA = [st_ID1, st_ID2]; % Store Star-IDs

    else
        CSPA = [];
        for idx = start:stop % Iterate over index value

            st_ID1 = REF_CAT(idx, 2); % Determine Star-IDs from Reference Catalogue
            st_ID2 = REF_CAT(idx, 3);

            tmp = [st_ID1, st_ID2];
            CSPA = [CSPA, tmp]; % Store Star-IDs
        end

    end
end