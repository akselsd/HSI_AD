function HSI = loadHSI(optsHSI)
    addpath('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data')

    if strcmp(optsHSI.dataset , 'salinas')
        
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/Salinas.mat')
        
        HSI.goodBands      = [4:104 116:135 137:149 174:220];
        HSI.M_3D             = hyperNormalize(double(salinas));
        [HSI.h, HSI.w, ~]    = size(HSI.M_3D);
        
    elseif strcmp(optsHSI.dataset, 'indian_pines')
        
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/Indian_pines.mat')
        
        HSI.goodBands     = [4:104 116:135 137:149 174:220];
        HSI.M_3D          = hyperNormalize( indian_pines);
        [HSI.h, HSI.w, ~] = size(HSI.M_3D);
    
    elseif strcmp(optsHSI.dataset, 'KSC')
        
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/KSC.mat')
        
        HSI.goodBands      = [4:104 116:135 137:149];
        HSI.M_3D           = hyperNormalize(KSC);
        [HSI.h, HSI.w, ~]  = size(HSI.M_3D);
        
    elseif strcmp(optsHSI.dataset, 'air1')
        
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/abu-airport-1.mat')
        
        HSI.goodBands     = [4:104 116:135 137:149 174:205];
        
        HSI.an_map               = map;
        %HSI.M_3D                = hyperNormalize(data(:,:,HSI.goodBands));
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return
        
    elseif strcmp(optsHSI.dataset, 'air2')
        
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/abu-airport-2.mat')
        HSI.goodBands     = [4:104 116:135 137:149 174:205];
        
        HSI.an_map               = map;
        %HSI.M_3D                = hyperNormalize(data(:,:,HSI.goodBands));
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'air3')
        HSI.goodBands      = [4:104 116:135 137:149 174:205];
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/abu-airport-3.mat')
        
        HSI.an_map               = map;
        %HSI.M_3D                = hyperNormalize(data(:,:,HSI.goodBands));
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'air4')
        
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/abu-airport-4.mat')
        HSI.goodBands     = [4:104 116:135 137:149 174:191];
        
        HSI.an_map               = map;
        %HSI.M_3D                = hyperNormalize(data(:,:,HSI.goodBands));
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'beach1')
        
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/abu-beach-1.mat')
        
        HSI.goodBands     = [4:104 116:135 137:149 174:188];
        
        HSI.an_map               = map;
        %HSI.M_3D                = hyperNormalize(data(:,:,HSI.goodBands));
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'beach2')
        
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/abu-beach-2.mat')
        
        HSI.goodBands     = [4:104 116:135 137:149 174:193];
        
        HSI.an_map               = map;
        %HSI.M_3D                = hyperNormalize(data(:,:,HSI.goodBands));
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'beach3')
        
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/abu-beach-3.mat')
        
        HSI.goodBands     = [4:104 116:135 137:149 174:188];
        
        HSI.an_map               = map;
        %HSI.M_3D                = hyperNormalize(data(:,:,HSI.goodBands));
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'beach4')
        
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/abu-beach-4.mat')
        
        HSI.goodBands     = (4:102);
        
        HSI.an_map               = map;
        %HSI.M_3D                = hyperNormalize(data(:,:,HSI.goodBands));
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'urban1')
        
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/abu-urban-1.mat')
        HSI.goodBands     = [4:104 116:135 137:149 174:204];
        
        HSI.an_map               = map;
        %HSI.M_3D                = hyperNormalize(data(:,:,HSI.goodBands));
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return

    elseif strcmp(optsHSI.dataset, 'urban2')
        
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/abu-urban-2.mat')
        HSI.goodBands     = [4:104 116:135 137:149 174:207];
        
        HSI.an_map               = map;
        %HSI.M_3D                = hyperNormalize(data(:,:,HSI.goodBands));
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return
        
    elseif strcmp(optsHSI.dataset, 'urban3')
        
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/abu-urban-3.mat')        
        HSI.goodBands     = [4:104 116:135 137:149 174:191];
        
        HSI.an_map               = map;
        %HSI.M_3D                = hyperNormalize(data(:,:,HSI.goodBands));
        HSI.M_3D                 = hyperNormalize(data);
        HSI.M_2D                 = hyperConvert2d(HSI.M_3D)';
        HSI.M_2D(HSI.M_2D(:)< 0) = 0; %remove all negative values
        [HSI.h, HSI.w, ~]        = size(HSI.M_3D);
        [HSI.N_pix, HSI.N_band]  = size(HSI.M_2D);
        return
        
    elseif strcmp(optsHSI.dataset, 'urban4')
        
        load('/Users/aksel/Desktop/OneDrive - NTNU/HYPSO/Code/data/abu-urban-4.mat')        
        HSI.goodBands     = [4:104 116:135 137:149 174:205];
        
        HSI.an_map               = map;
        %HSI.M_3D                = hyperNormalize(data(:,:,HSI.goodBands));
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

