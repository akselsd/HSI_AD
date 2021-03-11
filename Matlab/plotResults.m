figure(1)

subplot(2,3,1)
plot(fpr , tpr, fpr_AW, tpr_AW, '-' , 'Linewidth' , 2);
title(['ROC for ', optsHSI.dataset])
legend('DBN', 'AW-DBN')
set(gca, 'XScale', 'log');

subplot(2,3,4)
plot(window.win_sizes, window.auc_win);
title('Performance for different window sizes')
xlabel('Window size [Pixels]'), ylabel('AUC');

subplot(2,3,2)
imagesc(HSI.an_map)
title('Reference anomaly map')
axis image;

subplot(2,3,5)
imagesc(reshape(bin_det_map, HSI.h, HSI.w))
title('Binary detection map')
axis image;

subplot(2,3,3)
imagesc(reshape(HSI.anomaly_score, HSI.h, HSI.w))
title('AW-DBN')
axis image;

subplot(2,3,6)
imagesc(reshape(HSI.R, HSI.h, HSI.w))
title('DBN')
axis image;



