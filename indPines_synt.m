%for Cuprite scene
clc; close all; clear;

h = 145;
w = 145;
N_an = 10;

load('/Users/aksel/Desktop/HYPSO/HYPSO_matlab/HSI_AD/data/Indian_pines.mat')
load('groundTruth_Cuprite_nEnd12.mat','-mat');


goodBands    = [10:100 116:150 180:216]; % for AVIRIS with 224 channels
M_endmembers = M(goodBands,:);
indian_pines = hyperNormalize( indian_pines(:, :, goodBands));
N_bands      = length(goodBands);
ref_an_map   = zeros(h, w);





for i=1: N_an
    h_index = randi(h-10) + 5;
    w_index = randi(w - 10) + 5;

    
    signature_index            = randi([1 12]);
    
    indian_pines(h_index    , w_index, :) = M_endmembers(:,signature_index);
    indian_pines(h_index + 1, w_index, :) = M_endmembers(:,signature_index);
    indian_pines(h_index + 2, w_index, :) = M_endmembers(:,signature_index);
    indian_pines(h_index    , w_index + 1, :) = M_endmembers(:,signature_index);
    indian_pines(h_index + 1, w_index + 1, :) = M_endmembers(:,signature_index);
    indian_pines(h_index + 2, w_index + 1, :) = M_endmembers(:,signature_index);
    
    
    
    ref_an_map(h_index    , w_index, :) = 1;
    ref_an_map(h_index + 1, w_index, :) = 1;
    ref_an_map(h_index + 2, w_index, :) = 1;
    ref_an_map(h_index    , w_index + 1, :) = 1;
    ref_an_map(h_index + 1, w_index + 1, :) = 1;
    ref_an_map(h_index + 2, w_index + 1, :) = 1;
end

M_2D = reshape(indian_pines, h*w, N_bands);
clear N_an goodBands h_index i indian_pines M M_endmembers nEnd cood w_index waveLength slctBnds signature_index