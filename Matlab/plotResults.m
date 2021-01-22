figure(1)
subplot(2,2,1)
imagesc(HSI.an_map)
title('Reference anomaly map')
axis image;

subplot(2,2,2)
plot(fpr , tpr, fpr_AW, tpr_AW, '-' , 'Linewidth' , 2);
title(['ROC for ', optsHSI.dataset])
legend('DBN', 'AW-DBN')
set(gca, 'XScale', 'log');
%set(gca, 'YScale', 'log');

subplot(2,2,3)
imagesc(reshape(HSI.anomaly_score, HSI.h, HSI.w))
title('AW-DBN')
axis image;

subplot(2,2,4)
imagesc(reshape(HSI.R, HSI.h, HSI.w))
title('DBN')
axis image;



