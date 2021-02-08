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
    float weights[BANDS * MID_LAYER];
    float bias_a[MID_LAYER];
    float bias_b[BANDS];
} RBM_one;

typedef struct
{
    float weights[MID_LAYER * BANDS];
    float bias_b[MID_LAYER];
    float bias_a[BANDS];
} RBM_two;


typedef struct
{
    RBM_one rbm1;
    RBM_two rbm2;
} DBN;

DBN* initDBN(void);



#endif