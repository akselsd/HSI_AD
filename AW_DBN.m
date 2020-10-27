if (~exist('M_2D', 'var'))
    clear, clc, close all;
    
    [M_2D, h, w, N_band] = loadHSI();
    N_pix                = h*w;
end

if (~exist('DBN', 'var'))
    N_hid     = 13;
    Nodes     = [ N_band, N_hid, N_band ];
    DBN       = HSI_TRAIN_DBN(M_2D, Nodes, N_pix);
end

if (~exist('R', 'var'))
    [C, R, Y] = encodeDecode(DBN, M_2D, N_hid, N_pix, N_band);
end


win = 7;  %Length of one side of inner quadrat window in pixels


N_n       = (win + 2)^2 - win^2;       % Nr of neighbours

wt  = zeros(1, N_n); 
Pf  = 0.4; %penalty factor
outer_sq = (ceil(win/2) + 1);
anomaly_score = nan(1, N_pix);

for row = outer_sq:h-outer_sq
    for col = outer_sq:w-outer_sq
        idx = (row - 1)*w + col;
        Rn = findNeighbours(idx, w, R, win);
        Cn = findNeighbours(idx, w, C, win);

        % find weights
        wt  = 1./Rn';
        wt(abs(wt - mean(wt)) > std(wt)) = Pf*wt(abs(wt - mean(wt)) > std(wt));

        % calc anomaly score
        dist               = sum((sqrt((Cn - C(idx, :)).^2)), 2);
        anomaly_score(idx) = (1/N_n)*(wt*dist);
        
    end
    row
end

