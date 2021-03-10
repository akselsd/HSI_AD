function anomaly_score = adaptiveWeights_test(HSI, DBN, win)

    N_n           = (win + 2)^2 - win^2; % Nr of neighbours
    mean_r        = mean(HSI.R);
    std_r         = std(HSI.R);
    wt            = zeros(1, N_n); 
    Pf            = 0;                %penalty factor (Recommended set to 0)
    outer_sq      = (ceil(win/2) + 1);
    anomaly_score = zeros(1, HSI.N_pix);

    for col = outer_sq:HSI.w-outer_sq
        for row = outer_sq : (HSI.h-outer_sq)

            idx   = (col - 1)*HSI.h + row;
            r_put = HSI.R(idx);
            Rn    = findNeighbours(idx, HSI.h, HSI.R, win); %Reconstruction error neighbours
            Cn    = findNeighbours(idx, HSI.h, HSI.C, win); %codelayer neighbours

            % find weights
            wt   = r_put./Rn';
            dist = sum((sqrt((Cn - HSI.C(idx, :)).^2)), 2);
            
            
            wt((Rn' - mean_r) > 1*std_r) = Pf*wt((Rn' - mean_r) > 1*std_r);
            
            % calc anomaly score
            anomaly_score(idx) = (1/length(dist(dist > 0)))*(wt*dist);

        end
    end
end