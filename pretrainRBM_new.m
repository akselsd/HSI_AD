function rbm = pretrainRBM_new(rbm, V, opts )

    N_bands  = size(V,1);
    N_hid    = size(rbm.b, 2);
    N_vis    = size(rbm.c, 2);


    deltaW = zeros(N_vis, N_hid);
    deltaB = zeros(1, N_hid);
    deltaC = zeros(1, N_vis);

    if( opts.Verbose ) 
        timer = tic;
    end

    for iter = 1 : opts.MaxIter
        
        if( iter <= opts.InitialMomentumIter )
            momentum = opts.InitialMomentum;
        else
            momentum = opts.FinalMomentum;
        end

        ind = randperm(N_bands);

        for batch = 1 : opts.BatchSize : N_bands

            bind = ind( batch : min([batch + opts.BatchSize - 1, N_bands]));


            % Gibbs sampling step 0
            vis0  = double( V( bind, : )); % Set values of visible nodes
            hid0  = sigmoid( vis0 * rbm.W + rbm.b );

            % Gibbs sampling step 1
            bhid0 = double( rand(size(hid0)) < hid0 );

            vis1  = sigmoid(  bhid0 * rbm.W' + rbm.c ); % Compute visible nodes
            hid1  = sigmoid(  vis1 * rbm.W + rbm.b  );  % Compute hidden nodes

            posprods = hid0' * vis0;
            negprods = hid1' * vis1;
            % Compute the weights update by contrastive divergence

            dW = (posprods - negprods)';
            dB = (sum(hid0, 1) - sum(hid1, 1));
            dC = (sum(vis0, 1) - sum(vis1, 1));

            deltaW = momentum * deltaW + (opts.StepRatio / N_bands) * dW;
            deltaB = momentum * deltaB + (opts.StepRatio / N_bands) * dB;
            deltaC = momentum * deltaC + (opts.StepRatio / N_bands) * dC;

            % Update the network weights
            rbm.W = rbm.W + deltaW - opts.WeightCost * rbm.W;
            rbm.b = rbm.b + deltaB;
            rbm.c = rbm.c + deltaC;

        end



        if ( opts.Verbose )
            H    = sigmoid( V * rbm.W + rbm.b  );
            Vr   = sigmoid(  H * rbm.W' + rbm.c  );
            err  = power( V - Vr, 2 );
            rmse = sqrt( sum(err(:)) / numel(err) );

            totalti = toc(timer);
            aveti   = totalti / iter;
            estti   = (opts.MaxIter-iter) * aveti;
            eststr  = datestr(datenum(0,0,0,0,0,estti),'DD:HH:MM:SS');

            fprintf( '%3d : %9.4f %9.4f %9.4f %s\n', iter, rmse, mean(H(:)), aveti, eststr );
        end
    end
end
