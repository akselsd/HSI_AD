function DBN = HSI_TRAIN_DBN(HSI, N_hid)
    opts.MaxIter             = 15;
    opts.BatchSize           = 10;
    opts.Verbose             = 1;
    opts.StepRatio           = 0.02;
    opts.InitialMomentum     = 0.5;       % momentum for first five iterations
    opts.FinalMomentum       = 0.9;       % momentum for remaining iterations
    opts.WeightCost          = 0.0002;    % costs of weight update
    opts.InitialMomentumIter = 5;

    % Deep Belief Network
    DBN   = initDBN( [HSI.N_band, N_hid, HSI.N_band] );
    DBN   = pretrainDBN_new(DBN, HSI.M_2D, opts);
    
    opts.StepRatio           = 0.01;
    opts.MaxIter             = 40;
    
    DBN   = trainDBN_new(DBN, HSI.M_2D, HSI.M_2D, opts);
end