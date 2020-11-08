%for Cuprite scene
clc; close all; clear;

h = 145;
w = 145;
N_an = 10;

load('/Users/aksel/Desktop/HYPSO/HYPSO_matlab/HSI_AD/data/Indian_pines.mat')


goodBands    = [10:100 116:150 180:216]; % for AVIRIS with 224 channels
N_bands      = length(goodBands);
indian_pines = hyperNormalize( indian_pines(:, :, goodBands));



M_2D = reshape(indian_pines, h*w, N_bands);
clear N_an goodBands h_index i indian_pines M M_endmembers nEnd cood w_index waveLength slctBnds signature_index