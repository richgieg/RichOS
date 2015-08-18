#include <kernel.h>
#include <string.h>

#define SYSTEM_INIT_DATA_ORIGIN 0x90000

static const struct SystemInitData g_SystemInitData;

static void MoveSystemInitData();
void main();

void _start()
{
    MoveSystemInitData();
    main();
}

static void MoveSystemInitData()
{
    struct SystemInitData *old;
    struct SystemInitData *new_addr;
    old = (struct SystemInitData *)SYSTEM_INIT_DATA_ORIGIN;
    new_addr = (struct SystemInitData *)&g_SystemInitData;
    *new_addr = *old;
}

void GetSystemInitData(struct SystemInitData *sid)
{
    *sid = g_SystemInitData;
}