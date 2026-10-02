#ifndef REVENGE_PILOT_H
#define REVENGE_PILOT_H

#include "revenge/types.h"
#include "revenge/unit.h"
#include "revenge/roster.h"

const RevengePilotRosterRecord *GetPilotRosterRecord(
    uint16 rosterSlot);
void InitializePilotRosterMetadata(
    byte pilotRoster[REVENGE_PILOT_ROSTER_COUNT][0x04]);
void AssignPilotRosterEntryToUnit(
    byte unitRecord[UNIT_RECORD_SIZE],
    uint16 rosterSlot);
const char *GetPilotName(uint16 identityId);
const char *GetPilotGivenName(uint16 identityId);
const char *GetPilotExperienceName(uint16 experienceIndex);
const char *GetPilotGunneryName(uint16 gunneryIndex);

#endif
