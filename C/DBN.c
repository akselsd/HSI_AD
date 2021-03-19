#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <assert.h>
#include <math.h>
#include "DBN.h"

/***********************************************************************************************BLANK_RBM*/
RBM* blank_rbm(size_t visual_n, size_t hidden_n)
{
    RBM* rbm = malloc(sizeof(RBM));
    if (!rbm)
    {
        printf("==problem RBM==\n");
        return NULL;
    }

    rbm->visual  = visual_n;
    rbm->hidden  = hidden_n;
    rbm->bias_v  = blank_matrix_float(rbm->visual, 1);
    rbm->bias_h  = blank_matrix_float(rbm->hidden, 1);
    rbm->weights = blank_matrix_float(hidden_n, visual_n);
    return rbm;
}
/***********************************************************************************************BLANK_DBN*/
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
/***********************************************************************************************FREE_DBN*/
void free_DBN(DBN* dbn)
{
    free_matrix_float(dbn->rbm1->weights);
    free_matrix_float(dbn->rbm2->weights);
    free_matrix_float(dbn->rbm1->bias_h);
    free_matrix_float(dbn->rbm2->bias_h);
    free_matrix_float(dbn->rbm1->bias_v);
    free_matrix_float(dbn->rbm2->bias_v);
    free(dbn->rbm1);
    free(dbn->rbm2);
    free(dbn);
}
/***********************************************************************************************INIT_DBN*/
DBN* initDBN(size_t bands_n, size_t mid_layer_size, int zeros)
{
    DBN* dbn = blank_DBN(bands_n, mid_layer_size);
    time_t t;
    srand((unsigned) time(&t));

    for( int i = 0 ; i < bands_n ; i++ ){
        for( int j = 0 ; j < mid_layer_size ; j++ ){
            if (!zeros)
            {
                dbn->rbm1->weights->buf[i*mid_layer_size + j] = 0.1*((float)rand()/(float)RAND_MAX) -0.05;
                dbn->rbm2->weights->buf[i*mid_layer_size + j] = 0.1*((float)rand()/(float)RAND_MAX) - 0.05;
            } else{
                dbn->rbm1->weights->buf[i*mid_layer_size + j] = 0.0;
                dbn->rbm2->weights->buf[i*mid_layer_size + j] = 0.0;
            }
        }
    }
    return dbn;
}
/***********************************************************************************************PRINT_RMSE*/
void print_rmse(DBN* dbn, HSI* hsi, size_t ite){
    matrix_float* H1 = blank_matrix_float(dbn->mid_layer_size, hsi->pixels);
    matrix_float* H2 = blank_matrix_float(dbn->bands_n, hsi->pixels);

    H1 = mat_mult(hsi->two_dim_matrix, dbn->rbm1->weights, H1);
    H1 = mat_add_bias(H1, dbn->rbm1->bias_h, H1);
    H1 = sigmoid(H1, H1);    

    H2 = mat_mult(H1, dbn->rbm2->weights, H2);
    H2 = mat_add_bias(H2, dbn->rbm2->bias_h, H2);
    H2 = sigmoid(H2, H2);    

    float rmse = 0;
    H2 = mat_sub(hsi->two_dim_matrix, H2, H2);
    for (size_t i = 0; i < hsi->pixels*hsi->bands; i++)
    {
        rmse = rmse + pow(H2->buf[i], 2);
    }
    rmse = sqrt(rmse/(hsi->pixels*hsi->bands));
    printf("Iteration: %i -- RMSE = %f\n", ite, rmse);

    free_matrix_float(H1);
    free_matrix_float(H2);
}
/***********************************************************************************************MAT_CPY_BATCH*/
matrix_float* mat_cpy_batch(int start_i, int batchSize, HSI* hsi, matrix_float* mat_new, int* ind)
{
    for (size_t i = start_i; i < (start_i + batchSize); i++)
    {
        for (size_t j = 0; j < hsi->bands; j++)
        {
            mat_new->buf[(i - start_i)*hsi->bands + j] = hsi->two_dim_matrix->buf[ind[i]*hsi->bands + j];
        }
    }
    return mat_new;
}
/***********************************************************************************************RAND_PERM*/
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
/***********************************************************************************************MAT_CAT*/
matrix_float* mat_cat(matrix_float* old, matrix_float* new)
{
    for (size_t i = 0; i < new->height; i++)
    {
        for (size_t j = 0; j < new->width; j++)
        {
            if (j == 0){
                new->buf[i*new->width + j] = 1;
            }else{
                new->buf[i*new->width + j] = old->buf[i*new->width + j - (i+1)];
            }
        }
        
    }
    return new;
    
}
/***********************************************************************************************MAT_ADD_BIAS*/
matrix_float* mat_add_bias(matrix_float* mat, matrix_float* bias, matrix_float* result)
{
    if (!((result->height == mat->height) && (result->width == mat->width) && (result->width == bias->width)))
    {
        printf("==Wrong matrix dimensions mat_add==\n");
        return NULL;
    }

    for (int i = 0; i < result->height; i++){
        for (int j = 0; j < result->width; j++){
           result->buf[i*result->width + j] = mat_get(mat, i, j) + mat_get(bias, 0, j);
        }
    }
    return result;
}
/***********************************************************************************************TRAIN_DBN*/
DBN* trainDBN(DBN* dbn, HSI* hsi, train_config* con, int debug){
    
    DBN* delta             = initDBN(dbn->bands_n, dbn->mid_layer_size, 1);
    matrix_float* H1       = blank_matrix_float(dbn->mid_layer_size, con->BatchSize);
    matrix_float* H2       = blank_matrix_float(dbn->bands_n, con->BatchSize);
    matrix_float* der1     = blank_matrix_float(dbn->bands_n, con->BatchSize);
    matrix_float* V_tmp    = blank_matrix_float(dbn->bands_n, con->BatchSize);
    matrix_float* in1      = blank_matrix_float(dbn->mid_layer_size + 1, con->BatchSize);
    matrix_float* deltaWB1 = blank_matrix_float(dbn->bands_n, dbn->mid_layer_size + 1);
    matrix_float* deltaW1  = blank_matrix_float(dbn->bands_n, dbn->mid_layer_size);
    matrix_float* deltaB1  = blank_matrix_float(dbn->bands_n, 1);
    matrix_float* der2     = blank_matrix_float(dbn->mid_layer_size, con->BatchSize);
    matrix_float* deltaWB2 = blank_matrix_float(dbn->mid_layer_size, dbn->bands_n + 1);
    matrix_float* deltaW2  = blank_matrix_float(dbn->mid_layer_size, dbn->bands_n);
    matrix_float* deltaB2  = blank_matrix_float(dbn->mid_layer_size, 1);
    matrix_float* in2      = blank_matrix_float(dbn->bands_n + 1, con->BatchSize);
    float moment;
    int i, j, k, l;


    for( i = 0 ; i < con->MaxIter ; i++ )
    {
        //Setting momentum-----------------------------------------------------------------------------------------------
        if (i < con->mom_init_Iter)
        {
            moment = con->mom_init;
        }else
        {
            moment = con->mom_final;
        }
        //----------------------------------------------------------------------------------------------------------------

        if (debug){
            printf("Iteration: %i |=====| Momen: %f \n", i, moment);
        }


        int* ind = randPerm(hsi->pixels); //Randomizing the order of the pixels

        for( int j = 0 ; j < (hsi->pixels - con->BatchSize + 1); j = j + con->BatchSize )
        {
            V_tmp = mat_cpy_batch(j, con->BatchSize, hsi, V_tmp, ind); //V_tmp is a matrix with a number of pixels decided by batchsize


            if (debug){
            printf("Batch: %i\n", j/con->BatchSize);
            }


            H1 = mat_mult(V_tmp, dbn->rbm1->weights, H1);
            H1 = mat_add_bias(H1, dbn->rbm1->bias_h, H1);
            H1 = sigmoid(H1, H1);                           //H1 = sigmoid(IN*W1 + bias1)

            H2 = mat_mult(H1, dbn->rbm2->weights, H2);
            H2 = mat_add_bias(H2, dbn->rbm2->bias_h, H2);
            H2 = sigmoid(H2, H2);                           //H2 = sigmoid(H1*W2 + bias2)

            der1 = mat_sub(H2, V_tmp, der1);
            in1  = mat_cat(H1, in1);

            transpose(in1);
            deltaWB1 = mat_mult(in1, der1, deltaWB1);
            deltaWB1 = mat_div_scalar(deltaWB1, con->BatchSize, deltaWB1);
            transpose(in1);

            for (k = 0; k < (deltaWB1->height * deltaWB1->width); k++){
                if (k < dbn->bands_n){
                    deltaB1->buf[k] = con->StepRatio * deltaWB1->buf[k];
                }else{
                    deltaW1->buf[k - dbn->bands_n] = con->StepRatio * deltaWB1->buf[k];
                }
            }

            delta->rbm2->weights = mat_mul_scalar(delta->rbm2->weights, moment, delta->rbm2->weights);
            delta->rbm2->bias_h  = mat_mul_scalar(delta->rbm2->bias_h, moment, delta->rbm2->bias_h);            
            delta->rbm2->weights = mat_sub(delta->rbm2->weights, deltaW1, delta->rbm2->weights);
            delta->rbm2->bias_h  = mat_sub(delta->rbm2->bias_h, deltaB1, delta->rbm2->bias_h);

            transpose(dbn->rbm2->weights);
            der2 = mat_mult(der1, dbn->rbm2->weights, der2);
            transpose(dbn->rbm2->weights);

            for (int i = 0; i < (der2->height * der2->width); i++){
                der2->buf[i] = H1->buf[i] * (1 - H1->buf[i]) * der2->buf[i];
            }


            in2  = mat_cat(V_tmp, in2);
            transpose(in2);
            deltaWB2 = mat_mult(in2, der2, deltaWB2);
            transpose(in2);
            deltaWB2 = mat_div_scalar(deltaWB2, con->BatchSize, deltaWB2);


            for ( l = 0; l < (deltaWB2->height * deltaWB2->width); l++){
                if (l < dbn->mid_layer_size){
                    deltaB2->buf[l] = con->StepRatio * deltaWB2->buf[l];
                }else{
                    deltaW2->buf[l - dbn->mid_layer_size] = con->StepRatio * deltaWB2->buf[l];
                }
            }
            
            delta->rbm1->weights = mat_mul_scalar(delta->rbm1->weights, moment, delta->rbm1->weights);
            delta->rbm1->bias_h  = mat_mul_scalar(delta->rbm1->bias_h, moment, delta->rbm1->bias_h);
            delta->rbm1->weights = mat_sub(delta->rbm1->weights, deltaW2, delta->rbm1->weights);
            delta->rbm1->bias_h  = mat_sub(delta->rbm1->bias_h, deltaB2, delta->rbm1->bias_h);

            if (debug && (i == 0) && (j == 0)){
                printf("W1\n");
                print_mat(dbn->rbm1->weights);

                printf("W2\n");
                print_mat(dbn->rbm2->weights);

                printf("dWB1\n");
                print_mat(deltaWB1);

                printf("dW1\n");
                print_mat(deltaW1);

                printf("dB1\n");
                print_mat(deltaB1);

                printf("dWB2\n");
                print_mat(deltaWB2);

                printf("dW2\n");
                print_mat(deltaW2);

                printf("dB2\n");
                print_mat(deltaB2);
                
            }

            dbn->rbm1->weights = mat_add(dbn->rbm1->weights, delta->rbm1->weights, dbn->rbm1->weights);
            dbn->rbm2->weights = mat_add(dbn->rbm2->weights, delta->rbm2->weights, dbn->rbm2->weights);
            dbn->rbm1->bias_h  = mat_add(dbn->rbm1->bias_h, delta->rbm1->bias_h, dbn->rbm1->bias_h);
            dbn->rbm2->bias_h  = mat_add(dbn->rbm2->bias_h, delta->rbm2->bias_h, dbn->rbm2->bias_h);

             if (debug && (i == 0) && (j == 0)){
                printf("W1 after\n");
                print_mat(dbn->rbm1->weights);

                printf("W2 after\n");
                print_mat(dbn->rbm2->weights);

                printf("b1\n");
                print_mat(dbn->rbm1->bias_h);

                printf("b2\n");
                print_mat(dbn->rbm2->bias_h);
            }
        }
        print_rmse(dbn, hsi, i);
    }
    free_matrix_float(H1);
    free_matrix_float(H2);
    free_matrix_float(der1);
    free_matrix_float(der2);
    free_matrix_float(V_tmp);
    free_matrix_float(in1);
    free_matrix_float(deltaW1);
    free_matrix_float(deltaWB1);
    free_matrix_float(deltaB1);
    free_matrix_float(deltaW2);
    free_matrix_float(deltaWB2);
    free_matrix_float(deltaB2);
    free_matrix_float(in2);
    free_DBN(delta);
    return dbn;
}
/************************************************************************************************/
matrix_float* encodeDecode(DBN* dbn, HSI* hsi){
    matrix_float* H1 = blank_matrix_float(dbn->mid_layer_size, hsi->pixels);
    matrix_float* H2 = blank_matrix_float(dbn->bands_n, hsi->pixels);
    matrix_float* R  = blank_matrix_float(1, hsi->pixels);

    H1 = mat_mult(hsi->two_dim_matrix, dbn->rbm1->weights, H1);
    H1 = mat_add_bias(H1, dbn->rbm1->bias_h, H1);
    H1 = sigmoid(H1, H1);    

    H2 = mat_mult(H1, dbn->rbm2->weights, H2);
    H2 = mat_add_bias(H2, dbn->rbm2->bias_h, H2);
    H2 = sigmoid(H2, H2);

    float sum;
    H2 = mat_sub(hsi->two_dim_matrix, H2);
    for (size_t i = 0; i < hsi->pixels; i++)
    {
        sum = 0;
        for (size_t j = 0; j < dbn->bands_n; j++)
        {
            sum += pow(H2->buf[i*dbn->bands_n], 2);
        }
        
        R->buf[i] = sqrt(sum);
    }
    


}