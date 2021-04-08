function HSI = loadHSI(optsHSI)
    addpath('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data')
    path = '/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/';

    if strcmp(optsHSI.dataset , 'salinas')
        load([path  'Salinas.mat']);
        HSI.goodBands      = [4:104 116:135 137:149 174:220];
        HSI.M_3D           = hyperNormalize(double(salinas));
        [HSI.h, HSI.w, ~]  = size(HSI.M_3D);
        
    elseif strcmp(optsHSI.dataset, 'indian_pines')
        load([path  'Indian_pines.mat']);        
        HSI.goodBands     = [4:104 116:135 137:149 174:220];
        HSI.M_3D          = hyperNormalize( indian_pines);
        [HSI.h, HSI.w, ~] = size(HSI.M_3D);
    
    elseif strcmp(optsHSI.dataset, 'KSC')
        load([path  'KSC.mat']);
        HSI.goodBands      = [4:104 116:135 137:149];
        HSI.M_3D           = hyperNormalize(KSC);
        [HSI.h, HSI.w, ~]  = size(HSI.M_3D);
        
    elseif strcmp(optsHSI.dataset, 'air1')
        load([path  'abu-airport-1.mat']);
        HSI.an_map               = map;
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return
        
    elseif strcmp(optsHSI.dataset, 'air2')
        load([path  'abu-airport-2.mat']);
        HSI.an_map               = map;
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'air3')
        load([path  'abu-airport-3.mat']);
        HSI.an_map               = map;
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'air4')
        load([path  'abu-airport-4.mat']);
        HSI.an_map               = map;
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'beach1')
        load([path  'abu-beach-1.mat']);
        HSI.an_map               = map;
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'beach2')
        load([path  'abu-beach-2.mat']);
        HSI.an_map               = map;
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'beach3')
        load([path  'abu-beach-3.mat']);
        HSI.an_map               = map;
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'beach4')
        load([path  'abu-beach-4.mat']);
        HSI.an_map               = map;
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'urban1')
        load([path  'abu-urban-1.mat']);
        HSI.an_map               = map;
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'urban2')
        load([path  'abu-urban-2.mat']);
        HSI.an_map               = map;
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return
        
    elseif strcmp(optsHSI.dataset, 'urban3')
        load([path  'abu-urban-3.mat']);
        HSI.an_map               = map;
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return
        
    elseif strcmp(optsHSI.dataset, 'urban4')
        load([path  'abu-urban-4.mat']);
        HSI.an_map               = map;
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return
        
    else
        fprintf('error, select a valid dataset')
    end
    
    M_3D                     = HSI.M_3D(:,:, HSI.goodBands);
    [HSI.M3D_an, HSI.an_map] = insertAnomalies(M_3D, optsHSI, HSI.goodBands);
    HSI.M_2D                 = hyperConvert2d(HSI.M3D_an)';
    HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
    [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
end
