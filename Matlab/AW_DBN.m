%clear, close all, clc


% Load in a HSI
%--------------------------------------------------------------------------
if (~exist('HSI', 'var'))
    doPlot = 1;
    optsHSI.dataset        = 'urban4';    % indian_pines, salinas, KSC, air(1-4), beach(1-4), urban(1-4)
    optsHSI.N_an           = 15;          % Nr of fake Anomalies to add to HSI
    optsHSI.maxAnomalySize = 8;           % Maximum size of synthetic anomalies (length of one side of a quadrant)
    HSI                    = loadHSI(optsHSI);
end


% Initialize and train a DBN auto-encoder
%--------------------------------------------------------------------------
if (~exist('DBN', 'var'))
    DBN.N_hid = 13;
    DBN.dbn   = HSI_TRAIN_DBN(HSI, DBN.N_hid);
end


% Feedforward HSI through the DBN
%--------------------------------------------------------------------------
if (~exist('R', 'var'))
    HSI = encodeDecode(DBN, HSI);
end


% Calculate the anomaly score of the HSI
%--------------------------------------------------------------------------
if (~exist('win_size', 'var'))
    plot_win_auc = 1;
    win_size = findBestWindowSize(HSI, DBN, plot_win_auc); % Find best window size
end


% Calculate the anomaly score of the HSI
%--------------------------------------------------------------------------
HSI.anomaly_score = adaptiveWeights_test(HSI, DBN, win_size);


% AUC
%--------------------------------------------------------------------------
[auc, fpr, tpr] = ...
    calcAUC(HSI.R(HSI.anomaly_score > 0), HSI.an_map(HSI.anomaly_score > 0), 1000);
[auc_AW, fpr_AW, tpr_AW] = ...
    calcAUC(HSI.anomaly_score(HSI.anomaly_score > 0), HSI.an_map(HSI.anomaly_score > 0), 1000);


% Change from grayscale to absolute detection maps
%--------------------------------------------------------------------------
if (1)
    thresh = 4;
    HSI.anomaly_score(HSI.anomaly_score < thresh) = 0;
    HSI.anomaly_score(HSI.anomaly_score > thresh) = 1;
end


% Plot results
%--------------------------------------------------------------------------
if (doPlot)
    plotResults;
end



