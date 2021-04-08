
bin_det_map = HSI.an_sc_new;
th          = 12;
bin_det_map(bin_det_map < th) = 0;
bin_det_map(bin_det_map > th) = 1;


figure(1)

subplot(3,3,1)
plot(res_DBN.fpr , res_DBN.tpr, res_AWDBN.fpr, res_AWDBN.tpr, ...
   res_new.fpr, res_new.tpr, '-' , 'Linewidth' , 2);
title(['ROC for ', optsHSI.dataset])
legend('DBN', 'AW-DBN', 'New')
set(gca, 'XScale', 'log');

subplot(3,3,4)
plot(window.win_sizes, window.auc_win);
title('Performance for different window sizes')
xlabel('Window size [Pixels]'), ylabel('AUC');

subplot(3,3,2)
imagesc(HSI.an_map)
title('Reference anomaly map')
axis image;

subplot(3,3,5)
imagesc(reshape(bin_det_map, HSI.h, HSI.w))
title('Binary detection map (New)')
axis image;

subplot(3,3,3)
imagesc(reshape(HSI.an_sc_AWDBN, HSI.h, HSI.w))
title('AW-DBN')
axis image;

subplot(3,3,6)
imagesc(reshape(HSI.an_sc_DBN, HSI.h, HSI.w))
title('DBN')
axis image;

subplot(3,3,7)
imagesc(reshape(HSI.an_sc_new, HSI.h, HSI.w))
title('New')
axis image;



