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

    while (1) ;
}