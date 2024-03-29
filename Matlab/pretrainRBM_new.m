function rbm = pretrainRBM_new(rbm, V, opts )

    N_pix    = size(V,1);
    N_hid    = size(rbm.b, 2);
    N_vis    = size(rbm.c, 2);
    deltaW   = zeros(N_vis, N_hid);
    deltaB   = zeros(1, N_hid);
    deltaC   = zeros(1, N_vis);

    for iter = 1 : opts.MaxIter
        
        if( iter <= opts.InitialMomentumIter )
            momentum = opts.InitialMomentum;
        else
            momentum = opts.FinalMomentum;
        end

        ind = randperm(N_pix);
        for batch = 1 : opts.BatchSize : N_pix

            bind = ind( batch : min([batch + opts.BatchSize - 1, N_pix]));

            % Gibbs sampling step 0
            vis0  = double( V( bind, : )); % Set values of visible nodes
            hid0  = sigmoid( vis0 * rbm.W + rbm.b );

            % Gibbs sampling step 1
            bhid0 = double( rand(size(hid0)) < hid0 );
            vis1  = sigmoid(  bhid0 * rbm.W' + rbm.c ); % Compute visible nodes
            hid1  = sigmoid(  vis1 * rbm.W + rbm.b  );  % Compute hidden nodes

            posprods = hid0' * vis0;
            negprods = hid1' * vis1;

            dW = (posprods - negprods)';
            dB = (sum(hid0, 1) - sum(hid1, 1));
            dC = (sum(vis0, 1) - sum(vis1, 1));

%             deltaW = momentum * deltaW + (opts.StepRatio / N_pix) * dW;
%             deltaB = momentum * deltaB + (opts.StepRatio / N_pix) * dB;
%             deltaC = momentum * deltaC + (opts.StepRatio / N_pix) * dC;

            deltaW = momentum * deltaW + (opts.StepRatio / opts.BatchSize) * dW;
            deltaB = momentum * deltaB + (opts.StepRatio / opts.BatchSize) * dB;
            deltaC = momentum * deltaC + (opts.StepRatio / opts.BatchSize) * dC;

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
            fprintf( '%3d : %9.4f \n', iter, rmse);
        end
    end
end
