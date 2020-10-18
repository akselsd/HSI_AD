function rbm = initRBM( dimV, dimH)

    rbm.W = randn(dimV, dimH) * 0.1;
    rbm.b = zeros(1, dimH);
    rbm.c = zeros(1, dimV);
    
end
