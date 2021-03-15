#include "read_hsi.h"
#include "params.h"
#include "DBN.h"
#include "matrix_functions.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <string.h>
#include <assert.h>


int main()
{
	printf("==Start main==\n");

	HSI* hsi = read_hsi(DATA, WIDTH, HEIGHT, BANDS);

	DBN* dbn = initDBN(hsi->bands, MID_LAYER, 0);
	matrix_float* V_tmp = blank_matrix_float(dbn->bands_n, 4);
	matrix_float* V_tmp2 = blank_matrix_float(dbn->bands_n +1, 4);

	printf("==HSI==\n");
	print_mat(hsi->two_dim_matrix);

	
	V_tmp = mat_cpy_batch(0, 4, hsi, V_tmp, ind);
	V_tmp2 = mat_cat(V_tmp, V_tmp2);
	print_mat(V_tmp2);

	printf("==End main==\n");
	return 0;
}

// 1. open "developer command prompt for VS 2019"
// 2. cd to C-folder
// 3. run "cl main.c read_hsi.c matrix_functions.c DBN.c && main"

// "clang -Wall -o runme main.c read_hsi.c matrix_functions.c" on mac
// "./runme"