function DBN = HSI_TRAIN_DBN(M_2D, Nodes, N_pix)

    opts.MaxIter             = 50;
    opts.BatchSize           = 50;
    opts.Verbose             = 1;
    opts.StepRatio           = 0.1;
    opts.DropOutRate         = 0;
    opts.InitialMomentum     = 0.5;       % momentum for first five iterations
    opts.FinalMomentum       = 0.9;       % momentum for remaining iterations
    opts.WeightCost          = 0.0002;    % costs of weight update
    opts.InitialMomentumIter = 5;

    % Deep Belief Network
    DBN   = initDBN( Nodes );
    DBN   = pretrainDBN_new(DBN, M_2D, opts);
    %DBN   = SetLinearMapping_new(DBN, M_2D, M_2D);
    
    opts.StepRatio           = 0.05;
    opts.MaxIter             = 100;
    DBN   = trainDBN_new(DBN, M_2D, M_2D, opts);
end