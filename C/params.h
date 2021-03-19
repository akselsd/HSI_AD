#ifndef params
#define params

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <string.h>
#include <assert.h>

/****************************************************************************
#define DATA "./data/beach2_small_float.bip"
#define BANDS 5
#define HEIGHT 3
#define WIDTH 4
#define MID_LAYER 2

/****************************************************************************
#define DATA "./data/beach1.bip"
#define BANDS 188
#define HEIGHT 150
#define WIDTH 150
#define MID_LAYER 13
****************************************************************************/
#define DATA "./data/beach2_float.bip"
#define BANDS 21
#define HEIGHT 100
#define WIDTH 100
#define MID_LAYER 13
/****************************************************************************/
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