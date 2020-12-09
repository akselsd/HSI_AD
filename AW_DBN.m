
clear
% Load in a HSI
%--------------------------------------------------------------------------
if (~exist('HSI', 'var'))
    doPlot = 1;
    optsHSI.dataset        = 'beach2';    % indian_pines, salinas, KSC, air(1-4), beach(1-4), urban(1-4)
    optsHSI.N_an           = 15;          % Nr of fake Anomalies to add to HSI
    optsHSI.maxAnomalySize = 8;           % Maximum size of synthetic anomalies (length of one side of a quadrant)
    
    HSI        = loadHSI(optsHSI);
end

% Initialize and train a DBN auto-encoder
%--------------------------------------------------------------------------
if (~exist('DBN', 'var'))
    DBN.N_hid = 13;
    DBN.dbn   = HSI_TRAIN_DBN(HSI, DBN.N_hid);
end

% Run the HSI through the DBN
%--------------------------------------------------------------------------
if (~exist('R', 'var'))
    HSI = encodeDecode(DBN, HSI);
end

% Calculate the anomaly score of the HSI
%--------------------------------------------------------------------------
% Check best window size
win_sizes = 1:2:21;
auc_win = zeros(length(win_sizes), 1);

for k = 1:length(win_sizes)
    HSI.anomaly_score = adaptiveWeights(HSI, DBN, win_sizes(k));
    [auc_win(k), ~, ~] = calcAUC(HSI.anomaly_score(HSI.anomaly_score > 0), ...
    HSI.an_map(HSI.anomaly_score > 0), 1000);
end

[M,I] = max(auc_win);
HSI.anomaly_score = adaptiveWeights(HSI, DBN, win_sizes(I));

% AUC
%--------------------------------------------------------------------------
[auc, fpr, tpr] = calcAUC(HSI.R(HSI.anomaly_score > 0), HSI.an_map(HSI.anomaly_score > 0), 1000);
[auc_AW, fpr_AW, tpr_AW] = calcAUC(HSI.anomaly_score(HSI.anomaly_score > 0), ...
    HSI.an_map(HSI.anomaly_score > 0), 1000);

% Plot results
%--------------------------------------------------------------------------
if (doPlot)
    plotResults;
end



