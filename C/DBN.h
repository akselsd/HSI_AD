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

DBN* initDBN(void);



#endif