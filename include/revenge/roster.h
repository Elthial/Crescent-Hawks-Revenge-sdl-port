#ifndef REVENGE_ROSTER_H
#define REVENGE_ROSTER_H

#include "revenge/far_memory.h"
#include "revenge/types.h"

#include <stddef.h>

enum
{
    REVENGE_PILOT_ROSTER_COUNT = 0x3B,
    REVENGE_PLAYER_PILOT_COUNT = 0x25,
    REVENGE_LANCE_ASSIGNMENT_COUNT = 0x0D
};

#pragma pack(push, 1)
typedef struct RevengePilotRosterRecord
{
    int8 identityId;          /* +00 */
    int8 experienceIndex;     /* +01 */
    int8 gunneryIndex;        /* +02 */
    byte availability;        /* +03 */
} RevengePilotRosterRecord;

typedef struct RevengeUnitLanceAssignment
{
    uint16 left;              /* +00 */
    uint16 top;               /* +02 */
    uint16 width;             /* +04 */
    byte style;               /* +06 */
    RevengeUnitSlot persistentUnitSlot;  /* +07 */
    RevengeUnitSlot liveUnitSlot;        /* +08 */
    RevengePilotId pilotId;              /* +09 */
} RevengeUnitLanceAssignment;

typedef struct UnitSelectionCard
{
    word16 left;
    word16 top;
    word16 width;
    byte state;
    RevengeUnitSlot persistentUnitSlot;
    RevengeAssignmentSlot assignmentSlot;
    RevengePilotId selectionId;
    RevengePilotId alternateId;
    DosAddress spriteBuffer;
} UnitSelectionCard;
#pragma pack(pop)

_Static_assert(sizeof(RevengePilotRosterRecord) == 0x04,
    "Pilot roster records must retain their original four-byte layout.");
_Static_assert(offsetof(RevengePilotRosterRecord, availability) == 0x03,
    "Pilot availability must remain at record offset +03.");
_Static_assert(sizeof(RevengeUnitLanceAssignment) == 0x0A,
    "Lance assignments must retain their original ten-byte layout.");
_Static_assert(offsetof(RevengeUnitLanceAssignment, style) == 0x06,
    "Lance assignment style must remain at record offset +06.");
_Static_assert(offsetof(RevengeUnitLanceAssignment, persistentUnitSlot) == 0x07,
    "Persistent unit slot must remain at record offset +07.");
_Static_assert(offsetof(RevengeUnitLanceAssignment, liveUnitSlot) == 0x08,
    "Live unit slot must remain at record offset +08.");
_Static_assert(offsetof(RevengeUnitLanceAssignment, pilotId) == 0x09,
    "Pilot ID must remain at record offset +09.");
_Static_assert(sizeof(UnitSelectionCard) == 0x0F,
    "UnitSelectionCard must retain its original 0Fh-byte layout");
_Static_assert(offsetof(UnitSelectionCard, state) == 0x06,
    "UnitSelectionCard state must remain at offset 06h");
_Static_assert(offsetof(UnitSelectionCard, persistentUnitSlot) == 0x07,
    "UnitSelectionCard persistent slot must remain at offset 07h");
_Static_assert(offsetof(UnitSelectionCard, assignmentSlot) == 0x08,
    "UnitSelectionCard assignment slot must remain at offset 08h");
_Static_assert(offsetof(UnitSelectionCard, selectionId) == 0x09,
    "UnitSelectionCard selection ID must remain at offset 09h");
_Static_assert(offsetof(UnitSelectionCard, spriteBuffer) == 0x0B,
    "UnitSelectionCard sprite pointer must remain at offset 0Bh");

#endif
