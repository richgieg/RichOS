#include <string.h>

void _memcpy_asm(int *destination, const int *source, size_t num);

void *memcpy(void *destination, const void *source, size_t num)
{
    size_t dwords_to_copy;
    size_t bytes_to_copy;
    size_t distance;
    
    // If the number of bytes to copy is less than the size of a double-word,
    // then just copy bytes. Otherwise, we will copy double-words.
    if (num < sizeof(int)) {
        while (num--)
            *(char *)destination++ = *(char *)source++;
    } else {

        // Calculate distance between addresses.
        distance = destination - source;

        // If the distance is evenly divisible by four, then we will be able to
        // perform a double-word aligned copy for greater speed.
        if (distance % sizeof(int) == 0) {

            // If the source (and destination) addresses are not currently on a
            // double-word boundary, we will determine how many leading bytes
            // there are, then copy them.
            bytes_to_copy = (unsigned int)source % sizeof(int);
            if (bytes_to_copy != 0) {
                bytes_to_copy = sizeof(int) - bytes_to_copy;
            }

            // Deduct number of leading bytes from the total number of bytes.
            num = num - bytes_to_copy;

            // Copy the leading bytes.
            while (bytes_to_copy--) {
                *(char *)destination++ = *(char *)source++;
            }
        }

        // Call the opimized assembly routine for double-word copy.
        dwords_to_copy = num / sizeof(int);
        _memcpy_asm(destination, source, dwords_to_copy);

        // Advance the pointers.
        destination = destination + dwords_to_copy * sizeof(int);
        source = source + dwords_to_copy * sizeof(int);        

        // Copy trailing bytes, if any.
        bytes_to_copy = num % sizeof(int);
        while (bytes_to_copy--)
            *(char *)destination++ = *(char *)source++;
    }

    return destination;
}

// void *memmove(void *destination, const void *source, size_t num)
// {
//     // Check for overlapping and change direction if necessary.
//     return destination;
// }

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