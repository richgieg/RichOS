#include <text.h>

#define TEXT_MEMORY 0xb8000

void putc(char c, int offset)
{
    *((char *)(TEXT_MEMORY + offset * 2)) = c;
}

void puts(const char * str, int offset)
{
    while (*str)
        putc(*str++, offset++);
}