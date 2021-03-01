#include "params.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <string.h>
#include <assert.h>
#include <math.h>


void print_mat(const matrix_float* mat)
{
    size_t n = mat->height * mat->width;
    for (size_t j = 0; j < n; j++)
    {
        printf("%f \n ", mat->buf[j]);
    }
}

float mat_get(matrix_float* mat, int h_idx, int w_idx)
{
    if (mat->transpose)
    {
        return mat->buf[w_idx*mat->width + h_idx];
    }
    return mat->buf[h_idx*mat->width + w_idx];
}

matrix_float* blank_matrix_float(size_t width, size_t height)
{
    matrix_float* mat = malloc(sizeof(matrix_float));

    if (!mat)
    {
        printf("==problem 1==\n");
        return NULL;
    }

    mat->height = height;
    mat->width = width;
    mat->buf = calloc(height * width, sizeof(float));
    mat->transpose = 0;
    return mat;
}

void free_matrix_float(matrix_float* f)
{
    free(f->buf);
    free(f);
}


matrix_float* mat_mult(matrix_float* first, matrix_float* second, matrix_float* result)
{
    printf("==mat_mult==\n");

    /*
    if (!((result->height == first->height) && (result->width == second->width))){
        printf("%u %u \n ", first->height, first->width);
        printf("%u %u \n ", second->height, first->width);
        printf("%u %u \n ", result->height, first->width);
        printf("==Wrong matrix dimensions==\n");
        return NULL;
    }
    */
    for (int i = 0; i < result->height; i++){
        for (int j = 0; j < result->width; j++){
            for (int k = 0; k < first->width; k++){
                result->buf[i*result->width + j] += mat_get(first, i, k) * mat_get(second, k, j);
            }
        }
    }
    return result;
}


matrix_float* mat_add(matrix_float* first, matrix_float* second, matrix_float* result)
{
    printf("==mat_add==\n");

    if (!((result->height == first->height) && (result->width == second->width))){
        printf("==Wrong matrix dimensions==\n");
        return NULL;
    }

    for (int i = 0; i < (result->height * result->width); i++){
        result->buf[i] = first->buf[i] + second->buf[i];
        printf("%i \n ", i);
    }
    return result;
}

matrix_float* mat_div_scalar(matrix_float* in, float scalar, matrix_float* result)
{
    printf("==mat_add==\n");

    for (int i = 0; i < (result->height * result->width); i++){
        result->buf[i] = in->buf[i] / scalar;
        printf("%i \n ", i);
    }
    return result;
}

matrix_float* mat_mul_scalar(matrix_float* in, float scalar, matrix_float* result)
{
    printf("==mat_add==\n");

    for (int i = 0; i < (result->height * result->width); i++){
        result->buf[i] = in->buf[i] * scalar;
        printf("%i \n ", i);
    }
    return result;
}

matrix_float* mat_sub(matrix_float* first, matrix_float* second, matrix_float* result)
{
    printf("==mat_add==\n");

    if (!((result->height == first->height) && (result->width == second->width))){
        printf("==Wrong matrix dimensions==\n");
        return NULL;
    }

    for (int i = 0; i < (result->height * result->width); i++){
        result->buf[i] = first->buf[i] - second->buf[i];
        printf("%i \n ", i);
    }
    return result;
}

matrix_float* sigmoid(matrix_float* in, matrix_float* result)
{
    printf("==sigmoid==\n");
    print_mat(in);
    for (int i = 0; i < result->height; i++){
        for (int j = 0; j < result->width; j++){
            result->buf[i*result->width + j] = 1/(1 + expf(- mat_get(in, i, j)));
        }
    }
    print_mat(result);
    return result;
}

