#ifndef REVENGE_TYPES_H
#define REVENGE_TYPES_H

#include <stdint.h>

typedef uint8_t byte;
typedef int8_t int8;
typedef int16_t int16;
typedef uint16_t uint16;
typedef uint16_t word16;
typedef uint32_t uint32;

/*
 * Original one-byte identifiers use FFh as the unassigned sentinel.  Keep
 * that signed interpretation in their C types so callers do not have to
 * reproduce the DOS compiler's CBW instruction at every use.
 */
typedef int8 RevengePilotId;
typedef int8 RevengeUnitTypeId;
typedef int8 RevengeUnitSlot;
typedef int8 RevengeAssignmentSlot;

enum
{
    REVENGE_PILOT_ID_NONE = -1,
    REVENGE_UNIT_TYPE_NONE = -1,
    REVENGE_UNIT_SLOT_NONE = -1,
    REVENGE_UNIT_SLOT_UNAVAILABLE = -2,
    REVENGE_ASSIGNMENT_SLOT_NONE = -1
};

#pragma pack(push, 1)
/*
 * Exact on-disk/in-memory representation of a DOS offset:segment address.
 * This is binary data, not a host C pointer. Runtime objects use native
 * pointers and translate only when crossing an original DOS data boundary.
 */
typedef struct DosAddress
{
    word16 offset;
    word16 segment;
} DosAddress;
#pragma pack(pop)

_Static_assert(sizeof(DosAddress) == 0x04,
    "A DOS offset:segment address occupies four bytes.");

static inline DosAddress DosAddress_FromValue(uint32 value)
{
    DosAddress pointer;

    pointer.offset = (word16)value;
    pointer.segment = (word16)(value >> 0x10);
    return pointer;
}

static inline uint32 DosAddress_ToValue(DosAddress pointer)
{
    return ((uint32)pointer.segment << 0x10) | pointer.offset;
}

static inline int DosAddress_IsNull(DosAddress pointer)
{
    return pointer.offset == 0x0000 && pointer.segment == 0x0000;
}

enum
{
    FALSE = 0x00,
    TRUE = 0x01
};

#endif
