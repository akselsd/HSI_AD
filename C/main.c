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

	//print_hsi(hsi);

	tmp->two_dim_matrix = mat_mult(hsi->two_dim_matrix, hsi->two_dim_matrix, tmp->two_dim_matrix);
	print_hsi(tmp);

	free_hsi(hsi);
	free_hsi(tmp);
	
	printf("==Ending HAD test==\n");
	return 0;
}

// 1. open "developer command prompt for VS 2019"
// 2. cd to C-folder
// 3. run "cl main.c read_hsi.c"
// 4. run "main"