function DBN = trainDBN_new( DBN, IN, OUT, opts)

    N_rbm    = numel( DBN.rbm );
    num      = size(IN,1);
    deltaDbn = DBN;


    for n=1:N_rbm
        deltaDbn.rbm{n}.W = zeros(size(DBN.rbm{n}.W));
        deltaDbn.rbm{n}.b = zeros(size(DBN.rbm{n}.b));
    end


    for iter=1:opts.MaxIter
        
        % Set momentum
        if( iter <= opts.InitialMomentumIter )
            momentum = opts.InitialMomentum;
        else
            momentum = opts.FinalMomentum;
        end

        ind = randperm(num);
        for batch = 1 : opts.BatchSize:num

            bind      = ind(batch:min([batch + opts.BatchSize - 1, num]));
            Hall      = v2hall_new( DBN, IN(bind,:) ); 

            for n = N_rbm:-1:1

                derSgm = Hall{n} .* ( 1 - Hall{n} );

                if( n+1 > N_rbm )
                    der = ( Hall{N_rbm} - OUT(bind,:) );
                else
                    der = derSgm .* ( der * DBN.rbm{n+1}.W' );
                end


                if( n-1 > 0 )
                    in = cat(2, ones(numel(bind),1), Hall{n-1});
                else    
                    in = cat(2, ones(numel(bind),1), IN(bind, :));
                end

                deltaWb = in' * der / numel(bind);
                deltab  = deltaWb(1,:);
                deltaW  = deltaWb(2:end,:);
                
                if( opts.gaus )
                    deltaW = bsxfun( @rdivide, deltaW, DBN.rbm{n}.sig' );
                end

                deltaDbn.rbm{n}.W = momentum * deltaDbn.rbm{n}.W;
                deltaDbn.rbm{n}.b = momentum * deltaDbn.rbm{n}.b;    
                deltaDbn.rbm{n}.W = deltaDbn.rbm{n}.W - opts.StepRatio * deltaW;
                deltaDbn.rbm{n}.b = deltaDbn.rbm{n}.b - opts.StepRatio * deltab;

            end


            % Update W and B
            for n = 1 : N_rbm            
                DBN.rbm{n}.W = DBN.rbm{n}.W + deltaDbn.rbm{n}.W;
                DBN.rbm{n}.b = DBN.rbm{n}.b + deltaDbn.rbm{n}.b;  
            end

        end
        
        if( opts.Verbose )
            rmse = calcRmse_new( DBN, IN );
            fprintf('%3d : %9.4f \n', iter, rmse );          
        end
    end
end

