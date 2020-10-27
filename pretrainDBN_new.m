function DBN = pretrainDBN_new(DBN, V, opts)

N_rbm       = numel( DBN.rbm );
DropOutRate = ones(N_rbm, 1) * opts.DropOutRate;

for i = 1 : N_rbm -1
	opts.DropOutRate = DropOutRate(i);
    DBN.rbm{i}       = pretrainRBM_new(DBN.rbm{i}, V, opts);
    V                = sigmoid( V * DBN.rbm{i}.W + DBN.rbm{i}.b );
end