function Hall = v2hall_new(DBN, V)
    nrbm = numel( DBN.rbm );
    Hall = cell(nrbm,1);
    for i=1:nrbm
        H = sigmoid(  V * DBN.rbm{i}.W + DBN.rbm{i}.b  );
        V = H;
        Hall{i} = H;
    end
end