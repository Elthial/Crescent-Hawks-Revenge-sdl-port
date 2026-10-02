#include "revenge/dos.h"

#include <assert.h>
#include <string.h>

int main(void)
{
    static const char path[] = "revenge-dos-io-test.tmp";
    static const char source[] = "REVENGE!";
    char destination[sizeof(source)];
    int16 fileHandle;

    (void)DOS_DeleteFile(path);

    fileHandle = DOS_CreateFile(0x0000, path);
    assert(fileHandle >= 0x0000);
    assert(DOS_WriteFile(
        (uint16)fileHandle,
        source,
        (uint16)(sizeof(source) - 0x01)) == sizeof(source) - 0x01);
    assert(DOS_SeekFile((uint16)fileHandle, 0x0004L, 0x00) == 0x0004L);
    assert(DOS_WriteFile((uint16)fileHandle, 0, 0x0000) == 0x0000);
    assert(DOS_CloseFile(fileHandle) == 0x0000);

    fileHandle = DOS_OpenFile(path, 0x8000);
    assert(fileHandle >= 0x0000);
    assert(DOS_ReadFile((uint16)fileHandle, 0, 0x0000) == 0x0000);
    memset(destination, 0, sizeof(destination));
    assert(DOS_ReadFile(
        (uint16)fileHandle,
        destination,
        (uint16)sizeof(destination)) == 0x0004);
    assert(memcmp(destination, "REVE", 0x0004) == 0);
    assert(DOS_CloseFile(fileHandle) == 0x0000);

    fileHandle = DOS_OpenFile(path, 0x8002);
    assert(fileHandle >= 0x0000);
    assert(DOS_ReadFile(
        (uint16)fileHandle,
        destination,
        0x0001) < 0x0000);
    assert(DOS_WriteFile(
        (uint16)fileHandle,
        source,
        0x0001) == 0x0001);
    assert(DOS_CloseFile(fileHandle) == 0x0000);

    fileHandle = DOS_OpenFile(path, 0x8000);
    assert(fileHandle >= 0x0000);
    assert(DOS_WriteFile(
        (uint16)fileHandle,
        source,
        0x0001) < 0x0000);
    assert(DOS_CloseFile(fileHandle) == 0x0000);
    assert(DOS_DeleteFile(path) == 0x0000);

    return 0;
}
