#include <string.h>

void _memcpy_asm(int *destination, const int *source, size_t num);

void *memcpy(void *destination, const void *source, size_t num)
{
    int *dst_dword;
    const int *src_dword;
    char *dst_byte;
    const char *src_byte;
    size_t dwords_to_copy;
    size_t bytes_to_copy;
    size_t distance;

    // Initialize the byte pointers.
    dst_byte = destination;
    src_byte = source;
    
    // If the number of bytes to copy is less than the size of a double-word,
    // then just copy bytes. Otherwise, we will copy double-words.
    if (num < sizeof(int)) {
        while (num--)
            *dst_byte++ = *src_byte++;
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
                *dst_byte++ = *src_byte++;
            }
        }

        // Initialize pointers for double-word copy.
        dst_dword = (int *)dst_byte;
        src_dword = (const int *)src_byte;
        dwords_to_copy = num / sizeof(int);

        // Call the opimized assembly routine for double-word copy.
        _memcpy_asm(dst_dword, src_dword, dwords_to_copy);

        // Copy trailing bytes, if any.
        dst_byte = (char *)(dst_dword + dwords_to_copy);
        src_byte = (const char *)(src_dword + dwords_to_copy);
        bytes_to_copy = num % sizeof(int);
        while (bytes_to_copy--)
            *dst_byte++ = *src_byte++;
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