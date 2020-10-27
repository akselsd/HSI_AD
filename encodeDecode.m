function [C, R, Y] = encodeDecode(DBN, X, N_hid, N_pix, N_band)
    
    C = zeros(N_pix, N_hid);
    Y = zeros(N_pix, N_band);
    R = zeros(N_pix, 1);
    
    for i = 1:N_pix
        C(i, :)  = sigmoid( X(i, :) * DBN.rbm{1}.W + DBN.rbm{1}.b );
        Y(i, :)  = sigmoid( C(i, :) * DBN.rbm{2}.W + DBN.rbm{2}.b );
        R(i)     = sqrt(sum((X(i, :) - Y(i, :)).^2));
    end
    
end