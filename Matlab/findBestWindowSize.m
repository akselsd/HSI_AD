function window_size = findBestWindowSize(HSI, DBN, doPlot)
    % Check best window size
    win_sizes = 1:2:18;
    auc_win = zeros(length(win_sizes), 1);

    for k = 1:length(win_sizes)
        HSI.anomaly_score = adaptiveWeights_test(HSI, DBN, win_sizes(k));
        [auc_win(k), ~, ~] = calcAUC(HSI.anomaly_score(HSI.anomaly_score > 0), HSI.an_map(HSI.anomaly_score > 0), 1000);
    end

    [M,I] = max(auc_win);
    window_size = win_sizes(I);
    
    if (doPlot)
        figure(2)
        title('Performance for different window sizes')
        plot(win_sizes, auc_win);
        xlabel('Window size [Pixels]'), ylabel('AUC');
    end
end