#ifndef READ_HSI
#define READ_HSI

#include "params.h"
#include <stdint.h>
#include <stdlib.h>
#include <string.h>


size_t get_file_size(const char* filename);
HSI* read_hsi(const char* filename, size_t width, size_t height, size_t bands);
HSI* blank_hsi(size_t width, size_t height, size_t bands);
void free_hsi(HSI* f);
void print_hsi(const HSI* frame);
void write_results(matrix_float* R);
#endif