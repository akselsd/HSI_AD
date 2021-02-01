#include "read_hsi.h"
#include "params.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <string.h>
#include <assert.h>


static int read_binary(const char* filename, uint16_t* buf, size_t num_elements);

/*****************************************************************************/
HSI* read_hsi(const char* filename, size_t width, size_t height, size_t bands)
{
	printf("==read_hsi==\n");
    HSI* hsi = blank_hsi(width, height, bands);

    if (!hsi)
    {
        return NULL;
    }

    size_t sz = get_file_size(filename);
    assert(sz == width * height * bands * sizeof(uint16_t));

    read_binary(filename, hsi->buf, width * height * bands);

    return hsi;
    
}
/*****************************************************************************/
HSI* blank_hsi(size_t width, size_t height, size_t bands)
{
	printf("==blank_hsi==\n");
    HSI* hsi = malloc(sizeof(HSI));

    if (!hsi)
    {
        return NULL;
    }
    hsi->width = width;
    hsi->height = height;
    hsi->buf = calloc(width * height * bands, sizeof(uint16_t));

    if (!(hsi->buf))
    {
        free_hsi(hsi);
        return NULL;
    }
    return hsi;
}
/*****************************************************************************/
static int read_binary(const char* filename, uint16_t* buf, size_t num_elements)
{
	printf("==read_binary==\n");
    FILE* fp = fopen(filename, "rb");

    if (!fp)
    {
        printf("Could not open file \n");
        return -1;
    }

    size_t unit_size = sizeof(uint16_t);

    int unused = fread(buf, unit_size, num_elements, fp);
    unused++;

    fclose(fp);

    return 0;
}

/*****************************************************************************/
size_t get_file_size(const char* filename)
{
	printf("==get_file_size==\n");
    FILE* fp = fopen(filename, "rb");

    if (!fp)
    {
        printf("Could not read file \n");
    }

    fseek(fp, 0L, SEEK_END);
    size_t sz = ftell(fp);
    fclose(fp);

    return sz;
}
/*****************************************************************************/
void free_hsi(HSI* f)
{
    free(f->buf);
    free(f);
}

/*****************************************************************************/
void print_hsi(const HSI* hsi)
{
    size_t n = 3*4*5;

    for (size_t j = 0; j < n; j++)
    {
        printf("%u \n ", hsi->buf[j]);
    }
}
/*****************************************************************************/