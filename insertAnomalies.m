function [M3D, an_map] = insertAnomalies(M3D, optsHSI, gb)
    [h, w, b] = size(M3D);
    load('groundTruth_Cuprite_nEnd12.mat','-mat', 'M');
    M      = M(gb, :);
    an_map = zeros(h, w);
    
    for i = (1: optsHSI.N_an)
        h_i   = randi(h - optsHSI.maxAnomalySize);
        w_i   = randi(w - optsHSI.maxAnomalySize);
        sig_i = randi([1 12]);
        
        an_size = randi([1 optsHSI.maxAnomalySize]);
        M_an    = zeros(an_size, an_size, b);
        for j = 1: an_size
            for k = 1:an_size
                M_an(j, k, :) = M(:, sig_i);
            end
        end
        
        M3D(h_i:(h_i + an_size - 1), w_i:(w_i + an_size - 1), :) = M_an;
        an_map(h_i:(h_i + an_size - 1), w_i:(w_i + an_size - 1)) = 1;
    end
end