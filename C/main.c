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
	train_config* con = malloc(sizeof(train_config));
	con->BatchSize     = 40;
	con->MaxIter       = 10;
	con->mom_final     = 0.9;
	con->mom_init      = 0.5;
	con->mom_init_Iter = 5;
	con->StepRatio     = 0.01;
	con->WeigthCost    = 0.0002; 

	DBN* dbn = initDBN(hsi->bands, MID_LAYER, 0);
	dbn      = trainDBN(dbn, hsi, con);
	
	printf("==End main==\n");
	return 0;
}


// Windows: "cl main.c read_hsi.c matrix_functions.c DBN.c && main"
// MAC: "clang -Wall -o runme main.c read_hsi.c matrix_functions.c"
// ./runme