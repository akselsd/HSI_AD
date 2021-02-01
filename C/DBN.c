#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <assert.h>
#include <math.h>
#include "DBN.h"

DBN* initDBN(int zeros)
{
    
    RBM_one rbm1;
    RBM_two rbm2;
    int i, n;
    time_t t;
    srand((unsigned) time(&t));

    memset(rbm1.bias_a, 0, MID_LAYER);
    memset(rbm1.bias_b, 0, BANDS);
    memset(rbm2.bias_b, 0, MID_LAYER);
    memset(rbm2.bias_a, 0, BANDS);

    for( i = 0 ; i < BANDS ; i++ ){
        for( n = 0 ; i < MID_LAYER ; n++ ){
            if (zeros)
            {
                rbm1.weights[i][n] = 0.1*((float)rand()/(float)RAND_MAX);
                rbm2.weights[n][i] = 0.1*((float)rand()/(float)RAND_MAX);
            } else{
                rbm1.weights[i][n] = 0.0;
                rbm2.weights[n][i] = 0.0;  
            }
        }
    }


    DBN* dbn  = malloc(sizeof(DBN));
    dbn->rbm1 = rbm1;
    dbn->rbm2 = rbm2;
    return dbn;
}


DBN* trainDBN(DBN* dbn, HSI* hsi, train_config* con){
    DBN* delta = initDBN(0);
    float moment;

    for( int i = 0 ; i < con->MaxIter ; i++ ){
        if (i < con->mom_init_Iter){
            moment = con->mom_init;
        }else{
            moment = con->mom_final;
        }

        int* ind = randPerm(hsi->pixels);

        for( int j = 0 ; j < (hsi->pixels - con->BatchSize); j + con->BatchSize ){
            
        }



    }




    /*
    N_rbm    = numel( DBN.rbm );
    num      = size(IN,1);
    deltaDbn = DBN;


    for iter=1:opts.MaxIter
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
            fprintf( '%3d : %9.4f \n', iter, rmse);          
        end
    end
end
    */

}



int* randPerm(int max){
    int perm[max];
    for (int i = 0; i < max; i++) perm[i] = i;

    // Random permutation the order
    for (int i = 0; i < max; i++) {
	    int j, t;
	    j = rand() % (max-i) + i;
	    t = perm[j]; perm[j] = perm[i]; perm[i] = t; // Swap i and j
    }
    return perm;
}





