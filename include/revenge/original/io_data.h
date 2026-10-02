#ifndef REVENGE_ORIGINAL_IO_DATA_H
#define REVENGE_ORIGINAL_IO_DATA_H

#include <stddef.h>

#include "revenge/types.h"

enum
{
    ORIGINAL_FILE_HANDLE_COUNT = 0x14,

    CRT_FILE_STATE_TEXT_EOF = 0x0200,
    CRT_FILE_STATE_APPEND = 0x0800,
    CRT_FILE_STATE_WRITE_OCCURRED = 0x1000,
    CRT_FILE_STATE_DEVICE = 0x2000,
    CRT_FILE_STATE_TEXT = 0x4000,
    CRT_FILE_STATE_BINARY = 0x8000,
    CRT_FILE_STATE_UNUSED = 0xFFFF,

    CRT_OPEN_ACCESS_SHARE_MASK = 0x00F0,
    CRT_OPEN_CREATE = 0x0100,
    CRT_OPEN_TRUNCATE = 0x0200,
    CRT_OPEN_EXCLUSIVE = 0x0400,
    CRT_OPEN_APPEND = 0x0800,
    CRT_OPEN_DEVICE = 0x2000,
    CRT_OPEN_TEXT_BINARY_MASK = 0xC000,
    CRT_OPEN_RUNTIME_STATE_MASK = 0xF8FF,

    CRT_CREATE_WRITE = 0x0080,
    CRT_CREATE_READ_WRITE_MASK = 0x0180
};

#pragma pack(push, 1)
typedef struct OriginalFileRuntime
{
    word16 handleState[ORIGINAL_FILE_HANDLE_COUNT]; /* DS:712A */
    word16 defaultOpenFlags;                        /* DS:7152 */
    word16 creationModeMask;                        /* DS:7154 */
} OriginalFileRuntime;
#pragma pack(pop)

_Static_assert(offsetof(OriginalFileRuntime, defaultOpenFlags) == 0x28,
    "DS:7152 must follow the twenty handle-state words.");
_Static_assert(offsetof(OriginalFileRuntime, creationModeMask) == 0x2A,
    "DS:7154 must follow the default open flags.");
_Static_assert(sizeof(OriginalFileRuntime) == 0x2C,
    "The reconstructed DS:712A-7155 file runtime block must be exact.");

extern OriginalFileRuntime FileRuntime;
extern word16 SecondaryResourceDriveEnabled; /* DS:B662 */
extern word16 ResourceDriveSelectionDisabled; /* DS:B668 */
extern DosAddress CriticalErrorCallback; /* DS:B888 */

#endif
