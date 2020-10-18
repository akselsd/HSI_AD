function rmse  = calcRmse_new( DBN, HSI )
 
 HSI_hat  = v2h_dbn( DBN, HSI );
 err  = power( HSI - HSI_hat, 2 );
 rmse = sqrt( sum(err(:)) / numel(err) );
 
end