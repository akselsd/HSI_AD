function anomaly_score = adaptiveWeights(HSI, DBN, win)

    N_n           = (win + 2)^2 - win^2; % Nr of neighbours
    wt            = zeros(1, N_n); 
    Pf            = 0;                %penalty factor (Recommended set to 0)
    outer_sq      = (ceil(win/2) + 1);
    anomaly_score = zeros(1, HSI.N_pix);

    for col = outer_sq:HSI.w-outer_sq
        for row = outer_sq : (HSI.h-outer_sq)

            idx = (col - 1)*HSI.h + row;
            Rn  = findNeighbours(idx, HSI.h, HSI.R, win); %Reconstruction error neighbours
            Cn  = findNeighbours(idx, HSI.h, HSI.C, win); %codelayer neighbours

            % find weights
            wt  = 1./Rn';
            wt(abs(Rn' - mean(Rn)) > 4*std(Rn)) = Pf*wt(abs(Rn' - mean(Rn)) > 4*std(Rn));

            % calc anomaly score
            dist               = sum((sqrt((Cn - HSI.C(idx, :)).^2)), 2);
            anomaly_score(idx) = (1/length(dist(dist > 0)))*(wt*dist);

        end
    end
end