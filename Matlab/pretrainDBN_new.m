function DBN = pretrainDBN_new(DBN, V, opts)

for i = 1 : numel( DBN.rbm ) 
    DBN.rbm{i}       = pretrainRBM_new(DBN.rbm{i}, V, opts);
    V                = sigmoid( V * DBN.rbm{i}.W + DBN.rbm{i}.b );
    %opts.MaxIter     = floor(opts.MaxIter/2);
end