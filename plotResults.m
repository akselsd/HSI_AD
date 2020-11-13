figure()
subplot(3,2,1)
imagesc(HSI.an_map)
title('Reference anomaly map')
axis image;

subplot(2,2,2)
imagesc(HSI.M_3D(:, :, [31,20,12]))
title('RGB')
axis image;

subplot(2,2,3)
imagesc(reshape(anomaly_score, HSI.h, HSI.w))
title('AW-DBN')
axis image;

subplot(2,2,4)
imagesc(reshape(HSI.R, HSI.h, HSI.w))
title('DBN')
axis image;


