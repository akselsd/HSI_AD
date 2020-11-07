%for Cuprite scene
clc; close all; clear;

h = 12;
w = 12;
N_an = 1;

load('groundTruth_Cuprite_nEnd12.mat','-mat');

goodBands    = [10:100 116:150 180:216]; % for AVIRIS with 224 channels
M_endmembers = M(goodBands,:);
[N_bands,k]  = size(M_endmembers);

image        = zeros(h, w, N_bands);
ref_an_map   = zeros(h, w);


% Setting background
for i=1:h
    for j=1:w
        %dice = 1;%randi(6);
        if i < h/2%dice>4
            image(i,j,:)= M_endmembers(:,1); %setting background to alunite
%         elseif dice>2 
%             image(i,j,:)= M_endmembers(:,6); %setting background to Kalonite
        else 
            image(i,j,:)= M_endmembers(:,10);% setting background to pyrope
        end
    end
end
imnoise(image,'gaussian',1);


for i=1: N_an
    h_index = randi(h-10) + 5;
    w_index = randi(w - 10) + 5;

    
    signature_index            = 8;%randi([2 12]);
    image(h_index, w_index, :) = M_endmembers(:,signature_index);
    
    ref_an_map(h_index     ,w_index) = 1;
    ref_an_map(h_index + 1 ,w_index) = 1;
    ref_an_map(h_index + 2 ,w_index) = 1;
    ref_an_map(h_index     ,w_index + 1) = 1;
    ref_an_map(h_index + 1 ,w_index + 1) = 1;
    ref_an_map(h_index + 2 ,w_index + 1) = 1;
end

M_2D = hyperConvert2d(image)';

figure
imagesc(ref_an_map)
axis image;
colorbar;


