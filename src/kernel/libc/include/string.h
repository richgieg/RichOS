#ifndef STRING_H
#define STRING_H

#include <stddef.h>

void *memcpy(void *destination, const void *source, size_t num);
size_t strlen(char *str);
void strrev(char *str);

#endif