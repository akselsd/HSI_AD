function NN = findNeighbours(idx, w, M, win_i)
    
    i_tl = idx - (floor(win_i/2) + 1)*(w + 1); % top left corner of window
    i_tr = idx - (floor(win_i/2) + 1)*(w - 1); % top right corner
    
    i_bl = idx + (floor(win_i/2) + 1)*(w - 1); % bottom left corner
    i_br = idx + (floor(win_i/2) + 1)*(w + 1); % bottom right corner
    
    n1 = M(i_tl:i_tr, :);
    n2 = M(i_bl:i_br, :);
    
    i_tl = i_tl + w;
    i_tr = i_tr + w;
    
    i_bl = i_bl - w;
    i_br = i_br - w;
    
    n3 = M(i_tl:w:i_bl, :);
    n4 = M(i_tr:w:i_br, :);
    
    NN = [n1; n2; n3; n4];
end