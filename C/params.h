#ifndef params
#define params

/*****************************************************************************/
#define DATA "./data/test_hsi.bip"
#define BANDS 5
#define HEIGHT 3
#define WIDTH 4
#define MID_LAYER 2
/*****************************************************************************/

typedef struct
{
    size_t width;
    size_t height;
    size_t bands;
    size_t pixels;
    uint16_t* buf;
} HSI;

#endif