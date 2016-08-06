#include <string.h>
#include <stdlib.h>

void uitoa(unsigned int value, char *str, unsigned int radix)
{
    char *s = str;
    int remainder;

    do {
        remainder = value % radix;

        if (remainder < 10) {
            *s = '0' + remainder;
        } else {
            remainder -= 10;
            *s = 'a' + remainder;
        }
        
        s++;
        value /= radix;
    } while (value > 0);

    // Terminate the string.
    *s = 0;

    // Put the characters in the correct order.
    strrev(str);
}