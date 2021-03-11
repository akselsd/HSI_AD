function bin_det_map = findBestBinDetMap(HSI)
    auc = 0;
    best_th = 0;
    for thresh = 1:15
        an_sc = HSI.anomaly_score;
        an_sc(an_sc < thresh) = 0;
        an_sc(an_sc > thresh) = 1;
        [auc_th, ~, ~] = calcAUC(an_sc(HSI.anomaly_score > 0), HSI.an_map(HSI.anomaly_score > 0), 1000);
        if (auc_th > auc)
            auc = auc_th;
            best_th = thresh; 
        end
    end
    bin_det_map = HSI.anomaly_score;
    bin_det_map(bin_det_map < best_th) = 0;
    bin_det_map(bin_det_map > best_th) = 1;
end