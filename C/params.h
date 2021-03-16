#ifndef params
#define params

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <string.h>
#include <assert.h>

/*****************************************************************************/
#define DATA "./data/beach1.bip"
#define BANDS 188
#define HEIGHT 150
#define WIDTH 150
#define MID_LAYER 10
/*****************************************************************************/
typedef struct
{
    size_t width;
    size_t height;
    int transpose;
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