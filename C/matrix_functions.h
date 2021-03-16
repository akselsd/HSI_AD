#ifndef mat_func
#define mat_func

#include "params.h"
#include <stdio.h>
#include <stdlib.h>

void print_mat(matrix_float* mat);
float mat_get(matrix_float* mat, int h_idx, int w_idx);
matrix_float* blank_matrix_float(size_t width, size_t height);
void free_matrix_float(matrix_float* f);
void transpose(matrix_float* mat);
matrix_float* mat_mult(matrix_float* first, matrix_float* second, matrix_float* result);
matrix_float* mat_add(matrix_float* first, matrix_float* second, matrix_float* result);
matrix_float* mat_div_scalar(matrix_float* in, float scalar, matrix_float* result);
matrix_float* mat_mul_scalar(matrix_float* in, float scalar, matrix_float* result);
matrix_float* mat_sub(matrix_float* first, matrix_float* second, matrix_float* result);
matrix_float* sigmoid(matrix_float* in, matrix_float* result);


#endif