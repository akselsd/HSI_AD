figure()
subplot(2,2,1)
imagesc(HSI.an_map)
title('Reference anomaly map')
axis image;

subplot(2,2,2)
imagesc(HSI.M_3D(:, :, [31,20,12]))
title('RGB')
axis image;

subplot(2,2,3)
imagesc(reshape(HSI.anomaly_score, HSI.h, HSI.w))
title('AW-DBN')
axis image;

subplot(2,2,4)
imagesc(reshape(HSI.R, HSI.h, HSI.w))
title('DBN')
axis image;

% AUC
[auc, fpr, tpr] = calcAUC(HSI.R, HSI.an_map);
[auc_AW, fpr_AW, tpr_AW] = calcAUC(HSI.anomaly_score, HSI.an_map);

% Plot ROC
figure()
title(['ROC for ', optsHSI.dataset])
plot(fpr , tpr, fpr_AW, tpr_AW, '-' , 'Linewidth' , 2);
legend('DBN', 'AW-DBN')
set(gca, 'XScale', 'log');
set(gca, 'YScale', 'log');