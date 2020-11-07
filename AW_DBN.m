% Load in a HSI
%--------------------------------------------------------------------------
clc, close all;
doPlot = 1;
if (~exist('M_2D', 'var'))
    clear
    [M_2D, h, w, N_bands] = loadHSI(); doPlot = 0;
    %gen_synth_image;
    %indPines_synt;
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

% Plot results
%--------------------------------------------------------------------------
if (doPlot)
    figure
    subplot(2,3,1)
    imagesc(ref_an_map)
    title('Reference anomaly map')
    axis image;

    subplot(2,3,2)
    imagesc(reshape(anomaly_score, h, w))
    title('AW-DBN')
    axis image;

    subplot(2,3,3)
    imagesc(reshape(R, h, w))
    title('DBN')
    axis image;

    subplot(2,3,4)
    M3 = reshape(M_2D, h, w, 163);
    imagesc(M3(:, :, [31,20,12]))
    title('RGB')
    axis image;

    subplot(2,3,4)
    M3 = reshape(M_2D, h, w, 163);
    imagesc(M3(:, :, [31,20,12]))
    title('RGB')
    axis image;
end

