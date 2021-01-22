function rmse  = calcRmse_new( DBN, X )
 
 Y    = v2h_dbn( DBN, X );
 err  = power( X - Y, 2 );
 rmse = sqrt( sum(err(:)) / numel(err) );
 
end