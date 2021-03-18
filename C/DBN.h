#ifndef DBN_inc
#define DBN_inc

#include "params.h"
#include "matrix_functions.h"
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

/*****************************************************************************/


typedef struct
{
    size_t BatchSize;
    float StepRatio;
    float mom_init;
    float mom_final;
    float WeigthCost;
    size_t MaxIter;
    size_t mom_init_Iter;
} train_config;

typedef struct
{
    size_t visual;
    size_t hidden;
    matrix_float* weights;
    matrix_float* bias_v;
    matrix_float* bias_h;
} RBM;


typedef struct
{
    size_t bands_n;
    size_t mid_layer_size;
    RBM* rbm1;
    RBM* rbm2;
} DBN;

RBM* blank_rbm(size_t visual_n, size_t hidden_n);
void free_DBN(DBN* dbn);
DBN* blank_DBN(size_t bands_n, size_t mid_layer_size);
DBN* initDBN(size_t bands_n, size_t mid_layer_size, int zeros);
void print_rmse(DBN* dbn, HSI* hsi, size_t ite);
matrix_float* mat_cpy_batch(int start_i, int batchSize, HSI* hsi, matrix_float* mat_new, int* ind);
int* randPerm(int max);
matrix_float* mat_cat(matrix_float* old, matrix_float* new);
matrix_float* mat_add_bias(matrix_float* mat, matrix_float* bias, matrix_float* result);
DBN* trainDBN(DBN* dbn, HSI* hsi, train_config* con, int debug);

#endif