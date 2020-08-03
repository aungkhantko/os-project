#include "system.h"

unsigned char *memset(unsigned char *dest, unsigned char val, int count) 
{
	for (int i = 0; i < count; i++) {
		*(dest + i) = val;
	}
	return dest;
}
