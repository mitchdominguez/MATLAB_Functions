function norm_vec = norm3(vec)
col1 = vec(:,1);
col2 = vec(:,2);
col3 = vec(:,3);
norm_vec = sqrt(col1.^2 + col2.^2 + col3.^2);
