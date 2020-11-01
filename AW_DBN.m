% Load in a HSI
%--------------------------------------------------------------------------
if (~exist('M_2D', 'var'))
    clear, clc, close all;
    %[M_2D, h, w, N_bands] = loadHSI();
    gen_synth_image;
    N_pix      = h*w;
end

% Initialize and train a DBN auto-encoder
%--------------------------------------------------------------------------
if (~exist('DBN', 'var'))
    N_hid     = 13;
    Nodes     = [ N_bands, N_hid, N_bands ];
    DBN       = HSI_TRAIN_DBN(M_2D, Nodes, N_pix);
end

% Run the HSI through the DBN
%--------------------------------------------------------------------------
if (~exist('R', 'var'))
    [C, R, Y] = encodeDecode(DBN, M_2D, N_hid, N_pix, N_bands);
end

% Calculate the anomaly score of the HSI
%--------------------------------------------------------------------------
if (~exist('anomaly_score', 'var'))
    anomaly_score = adaptiveWeights(h, w, R, C);
end

% Locate anomalies
%--------------------------------------------------------------------------
avg_as = mean(anomaly_score(~isnan(anomaly_score)));
std_as = std(anomaly_score(~isnan(anomaly_score)));

anomaly_idx = find(anomaly_score > avg_as + 3*std_as);