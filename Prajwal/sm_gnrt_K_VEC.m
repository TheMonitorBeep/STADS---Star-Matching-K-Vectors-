function [K_VEC, I_VEC, Z_VEC] = sm_gnrt_K_VEC (y_vec, is_sorted)
    % Generates the K-Vector for a given array
    % Paramaters:
    % -----------
    % y_vec: column vector
    %     The vector for which k-vector has to be generated
    % is_sorted : boolean
    %     If true - implies the array is sorted
    % Returns:
    % --------
    % K_VEC: column vector
    %     The K-vector of the given array
    % I_VEC: column vector
    %     The integer vector associated with sorting
    % Z_VEC: column vector
    %     The z(x) vector corresponding to the given array     
    
    N = length(y_vec); 
    
    %% Create S & I vectors
    if ( is_sorted == false )
        [S_VEC, I_VEC] = sort(y_vec);
    elseif ( is_sorted == true )
        S_VEC = y_vec;
        I_VEC = transpose( 1:N );
    end
   
    %% Calculate constants
    y_min = S_VEC(1); y_max = S_VEC(N); % Store min & max values
    E = 2.22*10e-16; % Machine precision
    
    M = (y_max - y_min + 2*E)/(N-1); % Calculate slope of Z-Vector line
    Q = y_min - M - E; % Calculate coefficient of Z-Vector line
    
    %% Initialize K-vector
    K_VEC = zeros(N, 1); % Column vector    
    K_VEC(1) = 0; K_VEC(N) = N; % Set boundary values of K-Vector
    
    %% Generate Z-Vector
    Z_VEC = transpose( 1:N ); % Initialize Z-Vector
    Z_VEC = M*Z_VEC + Q; % Calculate Z-Vector
    
    %% Generate K-Vector
    start = 1;
    for i_rw = 2 : N-1
        for j_rw = start:N-1
            
            % Set up conditions
            cond1 = S_VEC(j_rw) <= Z_VEC(i_rw);
            cond2 = Z_VEC(i_rw) > S_VEC(j_rw + 1);
            if ( (cond1 == 1) && (cond2 == 0) )
                K_VEC(i_rw) = j_rw;
                start = j_rw;
                break
            end
        end
    end
end