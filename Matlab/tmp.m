figure(1)
subplot(1,3,1)
imagesc(HSI_a.an_map)
title('Reference map')
axis image;


subplot(1,3,2)
imagesc(reshape(HSI_a.anomaly_score, HSI_a.h, HSI_a.w))
title('AW-DBN')
axis image;

subplot(1,3,3)
imagesc(reshape(HSI_a.R, HSI_a.h, HSI_a.w))
title('DBN')
axis image;


figure(2)
subplot(1,3,1)
imagesc(HSI_b.an_map)
title('Reference map')
axis image;


subplot(1,3,2)
imagesc(reshape(HSI_b.anomaly_score, HSI_b.h, HSI_b.w))
title('AW-DBN')
axis image;

subplot(1,3,3)
imagesc(reshape(HSI_b.R, HSI_b.h, HSI_b.w))
title('DBN')
axis image;


figure(3)
subplot(1,3,1)
imagesc(HSI_c1.an_map)
title('Reference map')
axis image;


subplot(1,3,2)
imagesc(reshape(HSI_c1.anomaly_score, HSI_c1.h, HSI_c1.w))
title('AW-DBN')
axis image;

subplot(1,3,3)
imagesc(reshape(HSI_c1.R, HSI_c.h, HSI_c.w))
title('DBN')
axis image;

figure(4)
subplot(1,3,1)
imagesc(HSI_d.an_map)
title('Reference map')
axis image;


subplot(1,3,2)
imagesc(reshape(HSI_d.anomaly_score, HSI_d.h, HSI_d.w))
title('AW-DBN')
axis image;

subplot(1,3,3)
imagesc(reshape(HSI_d.R, HSI_d.h, HSI_d.w))
title('DBN')
axis image;





figure(5)

subplot(1,4,1)
plot(fpr_a , tpr_a , fpr_AW_a , tpr_AW_a , '-' , 'Linewidth' , 2);
title('ROC (a)')
legend('DBN', 'AW-DBN')
set(gca, 'XScale', 'log');

subplot(1,4,2)
plot(fpr_b , tpr_b , fpr_AW_b , tpr_AW_b , '-' , 'Linewidth' , 2);
title('ROC (b)')
legend('DBN', 'AW-DBN')
set(gca, 'XScale', 'log');

subplot(1,4,3)
plot(fpr_c1 , tpr_c1 , fpr_AW_c1 , tpr_AW_c1 , '-' , 'Linewidth' , 2);
title('ROC (c)')
legend('DBN', 'AW-DBN')
set(gca, 'XScale', 'log');

subplot(1,4,4)
plot(fpr_d , tpr_d , fpr_AW_d , tpr_AW_d , '-' , 'Linewidth' , 2);
title('ROC (d)')
legend('DBN', 'AW-DBN')
set(gca, 'XScale', 'log');









