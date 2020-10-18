function H = v2h_dbn(DBN, V)

    N_rbm = numel( DBN.rbm );
    
    for i=1:N_rbm
        H = sigmoid(  V * DBN.rbm{i}.W + DBN.rbm{i}.b  );
        V = H;
    end
end