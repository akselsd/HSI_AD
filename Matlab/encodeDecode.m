function HSI = encodeDecode(DBN, HSI)
    
    HSI.C = zeros(HSI.N_pix, DBN.N_hid);
    HSI.Y = zeros(HSI.N_pix, HSI.N_band);
    HSI.R = zeros(HSI.N_pix, 1);
    
    if (numel(DBN.dbn.rbm) == 2)
        for i = 1:HSI.N_pix
            HSI.C(i, :)  = sigmoid( HSI.M_2D(i, :) * DBN.dbn.rbm{1}.W + DBN.dbn.rbm{1}.b );
            HSI.Y(i, :)  = sigmoid( HSI.C(i, :) * DBN.dbn.rbm{2}.W + DBN.dbn.rbm{2}.b );
            HSI.R(i)     = sqrt(sum((HSI.M_2D(i, :) - HSI.Y(i, :)).^2));
        end
        
    else
        tmp = zeros(HSI.N_pix, 10);
        for i = 1:HSI.N_pix
            tmp(i, :)    = sigmoid( HSI.M_2D(i, :) * DBN.dbn.rbm{1}.W + DBN.dbn.rbm{1}.b );
            HSI.C(i, :)  = sigmoid( tmp(i, :) * DBN.dbn.rbm{2}.W + DBN.dbn.rbm{2}.b );
            tmp(i, :)    = sigmoid( HSI.C(i, :) * DBN.dbn.rbm{3}.W + DBN.dbn.rbm{3}.b );
            HSI.Y(i, :)  = sigmoid( tmp(i, :) * DBN.dbn.rbm{4}.W + DBN.dbn.rbm{4}.b );
            HSI.R(i)     = sqrt(sum((HSI.M_2D(i, :) - HSI.Y(i, :)).^2));
        end
end