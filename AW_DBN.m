clear
% Load in a HSI
%--------------------------------------------------------------------------
if (~exist('HSI', 'var'))
    clear, close all, clc;
    doPlot = 1;
    optsHSI.dataset        = 'indian_pines';    % indian_pines, salinas, KSC, air(1-4), beach(1-4), urban(1-4)
    optsHSI.N_an           = 1;          % Nr of fake Anomalies to add to HSI
    optsHSI.maxAnomalySize = 6;           % Maximum size of synthetic anomalies (length of one side of a quadrant)
    
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
window_size   = 9;   %Length of one side of inner quadrat window in pixels
anomaly_score = adaptiveWeights(HSI, DBN, window_size);



% Plot results
%--------------------------------------------------------------------------
if (doPlot)
    plotResults;
    auc = plotAUC (anomaly_score, HSI.an_map);
end

