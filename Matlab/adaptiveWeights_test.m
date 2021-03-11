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
            Rn    = findNeighbours(idx, HSI.h, HSI.R, win); %Reconstruction error neighbours
            Cn    = findNeighbours(idx, HSI.h, HSI.C, win); %codelayer neighbours
            wt    = HSI.R(idx)./Rn';% find weights
            dist  = sum((sqrt((Cn - HSI.C(idx, :)).^2)), 2);    
            
            wt((Rn' - mean_r) > 2*std_r) = Pf*wt((Rn' - mean_r) > 2*std_r);
            anomaly_score(idx) = (1/length(dist(dist > 0)))*(wt*dist);% calc anomaly score

        end
    end
end