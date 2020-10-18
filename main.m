loadData = 0;

if (loadData )
    clear, clc, close all;
    [M_2D, N_pix, N_band] = loadHSI();
end


opts.MaxIter             = 15;
opts.BatchSize           = N_pix/4;
opts.Verbose             = 1;
opts.StepRatio           = 0.1;
opts.DropOutRate         = 0;
opts.InitialMomentum     = 0.5;     % momentum for first five iterations
opts.FinalMomentum       = 0.9;       % momentum for remaining iterations
opts.WeightCost          = 0.0002;       % costs of weight update
opts.InitialMomentumIter = 5;

% Deep Belief Network
Nodes = [ N_band, 13, N_band ];
DBN   = initDBN( Nodes );
DBN   = pretrainDBN_new(DBN, M_2D, opts);
DBN   = SetLinearMapping_new(DBN, M_2D, M_2D);


% Important parameters for gradient decent

DBN  = trainDBN_new(DBN, M_2D, M_2D, opts);