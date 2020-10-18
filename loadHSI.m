function [M_2D, N_pix, N_band] = loadHSI()
    
    % Set path to useful functions
    addpath('~/Desktop/HYPSO/HYPSO_matlab/HSI_AD/data')

    % Load in HSI as a .mat file
    load('Cuprite_f970619t01p02_r02_sc03.a.rfl.mat'); % X is now the 3D HSI

    % Preprocess HSI
    M_3D            = hyperNormalize(double(X)); 
    M_2D            = hyperConvert2d(M_3D)';
    [N_pix, N_band] = size(M_2D);
end

