function DBN = initDBN( Nodes )
    N_rbm      = length(Nodes)s - 1;
    DBN.rbm    = cell( N_rbm, 1 );
    
    for i = 1 : N_rbm
        DBN.rbm{i} = initRBM( Nodes(i), Nodes(i+1) );
    end
end

