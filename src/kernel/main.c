#include <kernel.h>
#include <stdlib.h>
#include <string.h>
#include <text.h>

void main()
{
    char buffer[64];
    struct SystemInitData system_init_data;

    GetSystemInitData(&system_init_data);
    puts("Values from SystemInitData structure:", 240);
    uitoa(system_init_data.cursor_row, buffer, 10);
    puts(buffer, 320);
    uitoa(system_init_data.cursor_column, buffer, 10);
    puts(buffer, 324);
    uitoa(system_init_data.kilobytes_of_memory, buffer, 10);
    puts(buffer, 328);

    // Test memcpy by copying five megabytes of data.
    char *test = "This is a test string for memcpy!";
    memcpy((void *)0x300000, test, 1024 * 1024 * 5);
    // Display the copied string at the beginning of the copied data.
    puts((void *)0x300000, 400);

    while (1) ;
}