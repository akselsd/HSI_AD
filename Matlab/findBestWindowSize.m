function window = findBestWindowSize(HSI, DBN, max_size)
    window.win_sizes = 1:2:max_size;
    window.auc_win   = zeros(length(window.win_sizes), 1);

    for k = 1:length(window.win_sizes)
        HSI.anomaly_score = adaptiveWeights_new(HSI, DBN, window.win_sizes(k));
        res = calcAUC(HSI.anomaly_score(HSI.anomaly_score > 0), HSI.an_map(HSI.anomaly_score > 0));
        window.auc_win(k) = res.auc;
    end
    [~ ,I] = max(window.auc_win);
    window.size = window.win_sizes(I);
end