#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <assert.h>
#include <math.h>
#include "DBN.h"


RBM* blank_rbm(size_t visual_n, size_t hidden_n)
{
    RBM* rbm = malloc(sizeof(RBM));
    if (!rbm)
    {
        printf("==problem RBM==\n");
        return NULL;
    }
    rbm->visual = visual_n;
    rbm->hidden = hidden_n;
    rbm->bias_v = blank_matrix_float(1, rbm->visual);
    rbm->bias_h = blank_matrix_float(1, rbm->hidden);
    rbm->weights = blank_matrix_float(visual_n, hidden_n);
    return rbm;
}

DBN* blank_DBN(size_t bands_n, size_t mid_layer_size)
{
    DBN* dbn = malloc(sizeof(DBN));

    if (!dbn)
    {
        printf("==problem DBN==\n");
        return NULL;
    }

    dbn->rbm1 = blank_rbm(bands_n, mid_layer_size);
    dbn->rbm2 = blank_rbm(mid_layer_size, bands_n);
    dbn->bands_n = bands_n;
    dbn->mid_layer_size = mid_layer_size;
    return dbn;
}

DBN* initDBN(size_t bands_n, size_t mid_layer_size, int zeros)
{
    DBN* dbn = blank_DBN(bands_n, mid_layer_size);
    time_t t;
    srand((unsigned) time(&t));

    for( int i = 0 ; i < bands_n ; i++ ){
        for( int j = 0 ; j < mid_layer_size ; j++ ){
            if (!zeros)
            {
                dbn->rbm1->weights->buf[i*mid_layer_size + j] = 0.1*((float)rand()/(float)RAND_MAX);
                dbn->rbm1->weights->buf[j*bands_n + j] = 0.1*((float)rand()/(float)RAND_MAX);
            } else{
                dbn->rbm1->weights->buf[i*mid_layer_size + j] = 0.0;
                dbn->rbm1->weights->buf[j*bands_n + j] = 0.0;
            }
        }
    }
    return dbn;
}


DBN* trainDBN(DBN* dbn, HSI* hsi, train_config* con){
    DBN* delta = initDBN(dbn->bands_n, dbn->mid_layer_size, 1);
    matrix_float* H1 = blank_matrix_float(dbn->mid_layer_size, con->BatchSize);
    matrix_float* H2 = blank_matrix_float(dbn->bands_n, con->BatchSize);
    matrix_float* der1 = blank_matrix_float(dbn->bands_n, con->BatchSize);
    matrix_float* V_tmp = blank_matrix_float(dbn->bands_n, con->BatchSize);
    matrix_float* in1 = blank_matrix_float(dbn->mid_layer_size + 1, con->BatchSize);
    matrix_float* deltaWB1 = blank_matrix_float(dbn->bands_n, dbn->mid_layer_size + 1);
    matrix_float* deltaW1 = blank_matrix_float(dbn->bands_n, dbn->mid_layer_size);
    matrix_float* deltaB1 = blank_matrix_float(dbn->bands_n, 1);
    matrix_float* der2 = blank_matrix_float(con->BatchSize, dbn->mid_layer_size);
    float moment;
    int start;
    int end;

    for( int i = 0 ; i < con->MaxIter ; i++ )
    {
        if (i < con->mom_init_Iter)
        {
            moment = con->mom_init;
        }else
        {
            moment = con->mom_final;
        }
        int* ind = randPerm(hsi->pixels);

        for( int j = 0 ; j < (hsi->pixels - con->BatchSize); j + con->BatchSize )
        {
            V_tmp = mat_cpy_batch(j, con->BatchSize, hsi, V_tmp, ind);

            H1 = mat_mult(V_tmp, dbn->rbm1->weights, H1);
            H1 = mat_add(H1, dbn->rbm1->bias_h, H1);
            H1 = sigmoid(H1, H1);

            H2 = mat_mult(H1, dbn->rbm2->weights, H2);
            H2 = mat_add(H2, dbn->rbm2->bias_h, H2);
            H2 = sigmoid(H2, H2);

            der1 = mat_sub(H2, V_tmp, der1);

            in1  = mat_cat(con->BatchSize, H1, in1);
            in1->transpose = 1;

            deltaWB1 = mat_mult(in1, der1, deltaWB1);
            deltaWB1 = mat_div_scalar(deltaWB1, con->BatchSize, deltaWB1);

            for (int i = 0; i < (deltaWB1->height * deltaWB1->width); i++){
                if (i < con->BatchSize){
                    deltaB1->buf[i] = con->StepRatio * deltaWB1->buf[i];
                }else{
                    deltaW1->buf[i - con->BatchSize] = con->StepRatio * deltaWB1->buf[i];
                }
            }

            delta->rbm2->weights = mat_mul_scalar(delta->rbm2->weights, moment, delta->rbm2->weights);
            delta->rbm2->bias_h = mat_mul_scalar(delta->rbm2->bias_h, moment, delta->rbm2->bias_h);
            
            delta->rbm2->weights = mat_sub(delta->rbm2->weights, deltaW1, delta->rbm2->weights);
            delta->rbm2->bias_h = mat_sub(delta->rbm2->bias_h, deltaB1, delta->rbm2->bias_h);

            
            for (int i = 0; i < (derSgm->height * derSgm->width); i++){
                derSgm->buf[i] = H1->buf[i] * (1 - H1->buf[i]);
            }


        }
    }

}


matrix_float* mat_cpy_batch(int start_i, int batchSize, HSI* hsi, matrix_float* mat_new, int* ind)
{
    for (size_t i = start_i; i < (start_i + batchSize); i++)
    {
        for (size_t j = 0; j < hsi->bands; i++)
        {
            mat_new->buf[(i - start_i)*hsi->bands + j] = hsi->two_dim_matrix->buf[ind[i]*hsi->bands + j];
        }
    }
    return mat_new;
}


int* randPerm(int max){
    int* perm = malloc(max*sizeof(int));
    for (int i = 0; i < max; i++) perm[i] = i;

    // Random permutation the order
    for (int i = 0; i < max; i++) {
	    int j, t;
	    j = rand() % (max-i) + i;
	    t = perm[j]; perm[j] = perm[i]; perm[i] = t; // Swap i and j
    }
    return perm;
}




matrix_float* mat_cat(int batchSize, matrix_float* old, matrix_float* new)
{
    for (size_t i = 0; i < new->height; i++)
    {
        for (size_t j = 0; j < new->width; j++)
        {
            if (j == 0){
                new->buf[i*new->width + j] = 1;
            }else{
                new->buf[i*new->width + j] = old->buf[i*new->width + j - 1];
            }
        }
        
    }
    return new;
    
}

