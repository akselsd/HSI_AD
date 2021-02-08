#ifndef params
#define params

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <string.h>
#include <assert.h>

/*****************************************************************************/
#define DATA "./data/test_hsi.bip"
#define BANDS 5
#define HEIGHT 4
#define WIDTH 3
#define MID_LAYER 2
/*****************************************************************************/
typedef struct
{
    size_t width;
    size_t height;
    float* buf;
} matrix_float;

typedef struct
{
    size_t width;
    size_t height;
    size_t bands;
    size_t pixels;
    matrix_float* two_dim_matrix;
} HSI;



#endif