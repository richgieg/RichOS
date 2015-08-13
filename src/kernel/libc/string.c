#include <string.h>

void *memcpy(void *destination, const void *source, size_t num)
{
    int *dsti = (int *)destination;
    int *srci = (int *)source;
    char *dstb, *srcb;
    size_t intsToCopy = num / sizeof(int);
    size_t bytesToCopy = num % sizeof(int);

    while (intsToCopy--)
        *dsti++ = *srci++;

    dstb = (char *)dsti;
    srcb = (char *)srci;

    while (bytesToCopy--)
        *dstb++ = *srcb++;

    return destination;
}

void *memmove(void *destination, const void *source, size_t num)
{
    // Check for overlapping and change direction if necessary.
    return destination;
}

size_t strlen(char *str)
{
    char *e = str;
    while (*e)
        e++;
    return e - str;
}

void strrev(char *str)
{
    char temp;
    char *b = str;
    char *e = str + strlen(str) - 1;

    while (b < e) {
        temp = *b;
        *b++ = *e;
        *e-- = temp;
    }
}