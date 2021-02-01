#include "read_hsi.h"
#include "params.h"
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

	HSI* hsi = read_hsi(DATA, spatial_width, spatial_height, spectral_bands);
	
	if (!hsi)
    {
        printf("Failed to read hsi\n");
        return -1;
    }

	print_hsi(hsi);

	free_hsi(hsi);
	
	printf("==Ending HAD test==\n");
	return 0;
}
