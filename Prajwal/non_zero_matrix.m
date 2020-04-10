function nz_mtrx  = non_zero_matrix(mtrx, add_info)
% Returns a sub matrix which has atleast one non-zeros elemnt
% in every row
%Parameters:
% mtrx: The matrix from which non-zero rows will be extracted
% add_info: If true, appends the following columns to thew final non-zero_matrix - count_no, row_no, col_no

sz = size(mtrx);
n_rw = sz(1); n_clm = sz(2); % Number of rows and columns of given matrix

nz_mtrx = [];

rw_info = [];
cnt = 1;
for i_rw = 1:n_rw
    for j_clm = 1:n_clm
        
        elmt = mtrx(i_rw, j_clm); % Element from the matrix
        if ( elmt ~= 0 )
            rw = mtrx(i_rw, :);
            nz_mtrx = [nz_mtrx; rw]; % Append non-zero row
            
            tmp = [cnt,i_rw, j_clm];
            rw_info = [rw_info; tmp];
            cnt = cnt + 1;
            break
        end
    end
end

if add_info == true
    nz_mtrx = [nz_mtrx, rw_info];    
end

end
        
        
        