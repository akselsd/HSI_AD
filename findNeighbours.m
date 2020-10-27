function NN = findNeighbours(idx, h, M, win_i)
    
    i_tl = idx - ceil(win_i/2)*(h + 1); % top left corner of window
    i_tr = idx + ceil(win_i/2)*(h - 1); % top right corner
    
    i_bl = idx - ceil(win_i/2)*(h - 1); % bottom left corner
    i_br = idx + ceil(win_i/2)*(h + 1); % bottom right corner
    
    n1 = M(i_tl:i_bl, :);
    
    n2 = M(i_tr:i_br, :);
    
    i_tl = i_tl + h;
    i_tr = i_tr - h;
    
    i_bl = i_bl + h;
    i_br = i_br - h;
    
    n3 = M(i_tl:h:i_tr, :);
    n4 = M(i_bl:h:i_br, :);
   
    NN = [n1; n2; n3; n4];
end