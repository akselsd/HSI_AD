#include "params.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <string.h>
#include <assert.h>
#include <math.h>


matrix_float* blank_matrix_float(size_t width, size_t height){
    matrix_float* mat = malloc(sizeof(matrix_float));

    if (!mat)
    {
        printf("==problem 1==\n");
        return NULL;
    }

    mat->height = height;
    mat->width = width;
    mat->buf = calloc(height * width, sizeof(float));
    return mat;
}

void free_matrix_float(matrix_float* f)
{
    free(f->buf);
    free(f);
}


matrix_float* mat_mult(matrix_float* first, matrix_float* second, matrix_float* result){
    printf("==mat_mult==\n");

    if (!((result->height == first->height) && (result->width == second->width))){
        printf("==Wrong matrix dimensions==\n");
        return NULL;
    }

    for (int i = 0; i < result->height; i++){
        for (int j = 0; j < result->width; j++){
            printf("%i \n ", (i*result->width + j));
            for (int k = 0; k < first->width; k++){
                //result->buf[i*result->width + j] += first->buf[i*first->width + k] * second->buf[k*second->width + j];
            }
        }
    }
    return result;
}


matrix_float* mat_add(matrix_float* first, matrix_float* second, matrix_float* result){
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

matrix_float* sigmoid(matrix_float* in, matrix_float* result){
    for (int i = 0; i < result->height; i++){
        for (int j = 0; j < result->width; j++){
            result->buf[i*result->height + j] = 1/(1 + expf(-in->buf[i*result->height + j]));
        }
    }
    return result;
}