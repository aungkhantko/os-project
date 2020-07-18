#include "util.h"

void memcpy(char* src, char* dst, int bytes) 
{
        for (int i = 0; i < bytes; i++) {
                *(dst + i) = *(src + i);
        }
}
