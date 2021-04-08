clear, clc
cleanUp = 1;

% Load in a HSI
%--------------------------------------------------------------------------
if (~exist('HSI', 'var'))
    doPlot = 1;
    optsHSI.dataset        = 'KSC';   %indian_pines, salinas, KSC, air(1-4), beach(1-4), urban(1-4)
    optsHSI.N_an           = 15;          %Nr of fake Anomalies to add to HSI
    optsHSI.maxAnomalySize = 6;           %Maximum size of synthetic anomalies
    HSI = loadHSI(optsHSI);
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
if (~exist('window', 'var'))
    max_size   = 27;
    window     = findBestWindowSize(HSI, DBN, max_size);   % Find best window size
end

% Calculate the anomaly score of the HSI
%--------------------------------------------------------------------------
HSI.an_sc_new   = adaptiveWeights_new(HSI, DBN, window.size);
HSI.an_sc_AWDBN = adaptiveWeights(HSI, DBN, window.size);
HSI.an_sc_DBN   = HSI.R;

% AUC
%--------------------------------------------------------------------------
res_DBN   = calcAUC(HSI.an_sc_DBN(HSI.an_sc_new > 0), HSI.an_map(HSI.an_sc_new > 0));
res_AWDBN = calcAUC(HSI.an_sc_AWDBN(HSI.an_sc_AWDBN > 0), HSI.an_map(HSI.an_sc_AWDBN > 0));
res_new   = calcAUC(HSI.an_sc_new(HSI.an_sc_new > 0), HSI.an_map(HSI.an_sc_new > 0));


% Plot results
%--------------------------------------------------------------------------
if (doPlot)
    plotResults;
end

fprintf('AUC AWDBN: %f \n',res_AWDBN.auc)
fprintf('AUC DBN: %f \n',res_DBN.auc)
fprintf('AUC New: %f \n',res_new.auc)

if (cleanUp)
    clear bin_det_map doPlot  ...
        max_size window cleanUp
end
