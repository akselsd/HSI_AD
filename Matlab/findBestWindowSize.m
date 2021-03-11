function window = findBestWindowSize(HSI, DBN, max_size)
    % Check best window size
    window.win_sizes = 1:2:max_size;
    window.auc_win = zeros(length(window.win_sizes), 1);

    for k = 1:length(window.win_sizes)
        HSI.anomaly_score = adaptiveWeights_test(HSI, DBN, window.win_sizes(k));
        [window.auc_win(k), ~, ~] = calcAUC(HSI.anomaly_score(HSI.anomaly_score > 0), HSI.an_map(HSI.anomaly_score > 0), 1000);
    end

    [~ ,I] = max(window.auc_win);
    window.size = window.win_sizes(I);
end