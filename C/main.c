#include "read_hsi.h"
#include "params.h"
#include "matrix_functions.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <string.h>
#include <assert.h>


int main()
{
	printf("==Starting HAD test==\n");
	/*
	size_t spatial_height = HEIGHT;
	size_t spatial_width = WIDTH;
	size_t spectral_bands = BANDS;
	size_t N_pixels = HEIGHT * WIDTH;

	
	HSI* hsi = read_hsi(DATA, spatial_width, spatial_height, spectral_bands);
	HSI* tmp = blank_hsi(spatial_width, spatial_height, spectral_bands);
	
	if (!hsi)
    {
        printf("Failed to read hsi\n");
        return -1;
    }

	print_hsi(hsi);
	*/

	int h1 = 6;
	int w2 = 3;

	matrix_float* a = blank_matrix_float(2, h1);
	matrix_float* b = blank_matrix_float(2, w2);
	matrix_float* c = blank_matrix_float(w2, h1);

	for (size_t i = 0; i < 12; i++)
	{
		if (i < 6)
		{
			b->buf[i] = (float)(i + 1);
		}
		a->buf[i] = (float)(i + 1);
	}

	b = sigmoid(b, b);

	free_matrix_float(a);
	free_matrix_float(b);
	free_matrix_float(c);
	
	printf("==Ending HAD test==\n");
	return 0;
}

// 1. open "developer command prompt for VS 2019"
// 2. cd to C-folder
// 3. run "cl main.c read_hsi.c matrix_functions.c && main"
// 4. run "main"

// "clang -Wall -o runme main.c read_hsi.c matrix_functions.c" on mac
// "./runme"