function anomaly_score = adaptiveWeights(h, w, R, C)
    win   = 3;                   %Length of one side of inner quadrat window in pixels
    N_n   = (win + 2)^2 - win^2; % Nr of neighbours

    wt            = zeros(1, N_n); 
    Pf            = 0;                %penalty factor (Recommended set to 0)
    outer_sq      = (ceil(win/2) + 1);
    anomaly_score = nan(1, w*h);

    for col = outer_sq:w-outer_sq
        for row = outer_sq:h-outer_sq

            idx = (col - 1)*h + row;
            Rn  = findNeighbours(idx, h, R, win); %Reconstruction error neighbours
            Cn  = findNeighbours(idx, h, C, win); %codelayer neighbours

            % find weights
            wt  = 1./Rn';
            wt(abs(wt - mean(wt)) > std(wt)) = Pf*wt(abs(wt - mean(wt)) > std(wt));

            % calc anomaly score
            dist               = sum((sqrt((Cn - C(idx, :)).^2)), 2);
            anomaly_score(idx) = (1/N_n)*(wt*dist);

        end
    end
end