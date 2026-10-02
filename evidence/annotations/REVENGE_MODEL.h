#ifndef REVENGE_MODEL_H
#define REVENGE_MODEL_H

/*
 * Portable binary contracts recovered from REVENGE.EXE and its data files.
 *
 * This deliberately does not include REVENGE.h. That file preserves Reko's
 * generated type graph; this file is the small, implementation-facing schema.
 * Multi-byte values are little-endian on disk and in the original 8086 data
 * segment. A RevengeFarPointer stores offset first, then segment.
 */

#include <stddef.h>
#include <stdint.h>

#if defined(__cplusplus)
#define REVENGE_STATIC_ASSERT(condition, message) static_assert(condition, message)
#else
#define REVENGE_STATIC_ASSERT(condition, message) _Static_assert(condition, message)
#endif

#pragma pack(push, 1)

typedef struct RevengeFarPointer
{
    uint16_t offset;
    uint16_t segment;
} RevengeFarPointer;

/* DS:0435, 23 records. Field meanings are V except the effect ID, which is P. */
typedef struct RevengeWeaponDefinition
{
    RevengeFarPointer name;
    uint8_t heat;
    uint8_t damage;
    uint8_t minimumRange;
    uint8_t maximumRangeUnits;
    uint16_t weightHalfTons;
    uint8_t missileRackSize;
    uint8_t ammunitionFamilyId;
    uint8_t criticalSlotCount;
    uint8_t recoveryDelayTicks;
    uint8_t effectId;
} RevengeWeaponDefinition;

/*
 * Shared 96h-byte MECHTYPE, persistent-roster, live-unit, and save record.
 * Array geometry and offsets are V. Fields marked P retain their working
 * interpretation until controlled saves or traces promote them.
 */
typedef struct RevengeUnitRecord
{
    uint8_t deploymentState;             /* 00h [P] */
    uint8_t unitTypeId;                  /* 01h [V] */
    uint8_t walkMovement;                /* 02h [P] */
    uint8_t jumpMovement;                /* 03h [P] */
    uint8_t currentInternal[8];           /* 04h [V] */
    uint8_t currentArmor[11];             /* 0Ch [V] */
    uint8_t maximumInternal[8];           /* 17h [V] */
    uint8_t maximumArmor[11];             /* 1Fh [V] */
    uint8_t weaponFamilyCount[14];        /* 2Ah [P] */
    uint16_t currentAmmunition[14];       /* 38h [V shape/P families] */
    uint8_t engineHeatSinkCapacity;       /* 54h [P] */
    uint8_t headEquipment[1];             /* 55h [P location] */
    uint8_t leftArmEquipment[8];          /* 56h [P location] */
    uint8_t leftTorsoEquipment[12];       /* 5Eh [P location] */
    uint8_t centerTorsoEquipment[2];      /* 6Ah [P location] */
    uint8_t rightTorsoEquipment[12];      /* 6Ch [P location] */
    uint8_t rightArmEquipment[8];         /* 78h [P location] */
    uint8_t leftLegEquipment[2];          /* 80h [P location] */
    uint8_t rightLegEquipment[2];         /* 82h [P location] */
    uint8_t tonnage;                      /* 84h [V] */
    uint8_t engineHits;                   /* 85h [V] */
    uint8_t heatFraction;                 /* 86h [V, low byte of Q8.8] */
    uint8_t currentHeat;                  /* 87h [V, high byte of Q8.8] */
    uint8_t tacticalSpriteBase;           /* 88h [V] */
    uint8_t sensorHits;                   /* 89h [P] */
    uint8_t gunneryTargetNumber;          /* 8Ah [P] */
    uint8_t targetMovementModifier;       /* 8Bh [P] */
    uint8_t missileUpgradeState;          /* 8Ch [P] */
    uint8_t hasBeagleActiveProbe;         /* 8Dh [V] */
    uint8_t canSpotIndirectFire;          /* 8Eh [P] */
    uint8_t hasAccuracyUpgrade;           /* 8Fh [V] */
    uint8_t hasDoubleHeatSinks;           /* 90h [V] */
    uint8_t hasCase;                      /* 91h [V] */
    uint8_t pilotId;                      /* 92h [P] */
    uint8_t pilotExperience;              /* 93h [P] */
    uint8_t allegiance;                   /* 94h [P] */
    uint8_t damageModel;                  /* 95h [P name/V correlations] */
} RevengeUnitRecord;

typedef struct RevengePilotRosterRecord
{
    uint8_t reserved00;
    uint8_t experience;
    uint8_t gunneryTargetNumber;
    uint8_t availability;
} RevengePilotRosterRecord;

/* DS:1CCA and save snapshot +017Ah, 13 records. */
typedef struct RevengeUnitLanceAssignmentRecord
{
    uint16_t left;
    uint16_t top;
    uint16_t width;
    uint8_t style;
    uint8_t persistentUnitSlot;
    uint8_t liveUnitSlot;
    uint8_t pilotId;
} RevengeUnitLanceAssignmentRecord;

/* DS:063A, 17h records. */
typedef struct RevengeTextWindowContext
{
    uint16_t leftTile;
    uint16_t topTile;
    uint16_t widthTiles;
    uint16_t heightTiles;
    uint16_t foregroundColor;
    uint16_t backgroundColor;
    uint16_t cursorColumn;
    uint16_t cursorRow;
} RevengeTextWindowContext;

/* DS:07AA. The two reserved words remain deliberately unnamed. */
typedef struct RevengeUiRegionRecord
{
    uint16_t leftColumn;
    uint16_t topRow;
    uint16_t widthColumns;
    uint16_t rowCount;
    uint16_t selectedRow;
    uint16_t reserved0A;
    uint16_t xorColor;
    uint16_t reserved0E;
} RevengeUiRegionRecord;

/* DS:10B0, 12h-byte records. Far pointers remain serialized 16:16 values. */
typedef struct RevengeCachedFileDescriptor
{
    RevengeFarPointer fileName;
    uint32_t fileLength;
    RevengeFarPointer cachedData;
    uint16_t resourceDriveMask;
    uint32_t currentPosition;
} RevengeCachedFileDescriptor;

/* DS:5C5C, 16 records. */
typedef struct RevengeDigitalWeaponEffectRecord
{
    uint16_t resourceIndex;
    uint16_t playbackScale;
    uint16_t packedBufferOffset;
    uint16_t sampleLength;
    uint16_t loadState;
} RevengeDigitalWeaponEffectRecord;

/* DS:5CFC, 16h records. */
typedef struct RevengeDigitalSoundEntry
{
    uint8_t sampleKey;
    uint16_t resourceIndex;
    uint32_t sourceFileOffset;
    uint16_t sampleLength;
    uint16_t packedBufferOffset;
} RevengeDigitalSoundEntry;

/* DS:AEF1, 24 records. */
typedef struct RevengeTacticalCombatRatings
{
    uint16_t movement;
    uint16_t durabilityDividedBy16;
    uint16_t closeFirepower;
    uint16_t mediumFirepower;
    uint16_t longFirepower;
    uint16_t sensorHits;
} RevengeTacticalCombatRatings;

/* DS:810C, 5Ah records. */
typedef struct RevengeTerrainImpactAnimationRecord
{
    int16_t mapX;
    int16_t mapY;
    uint16_t animationVariant;
} RevengeTerrainImpactAnimationRecord;

/* DS:B2F4, at most 50h records. */
typedef struct RevengeTacticalImpactRecord
{
    uint16_t mapX;
    uint16_t mapY;
    uint16_t impactClass;
    uint16_t spriteId;
} RevengeTacticalImpactRecord;

/* SAVEGAME.DAT directory entry: one occupied byte and a 15h-byte label. */
typedef struct RevengeSaveSlotDescriptor
{
    uint8_t occupied;
    char name[0x15];
} RevengeSaveSlotDescriptor;

/*
 * The exact 221h-byte campaign portion at the beginning of every 1031h-byte
 * save payload. Unknown fields keep address-derived names and raw storage.
 */
typedef struct RevengeCampaignSnapshot
{
    uint16_t campaignStageIndex;                  /* 0000h [P] */
    uint16_t scenarioVariantIndex;                /* 0002h [H] */
    uint8_t campaignPhase;                        /* 0004h [P] */
    uint8_t trainingSequenceFlag;                 /* 0005h [H] */
    uint16_t campaignFlags;                       /* 0006h [P] */
    uint16_t state24E1;                           /* 0008h [U meaning] */
    uint16_t stateA967;                           /* 000Ah [U meaning] */
    uint16_t scene3RosterSelector9991;            /* 000Ch [V use] */
    uint16_t state88F1;                           /* 000Eh [U meaning] */
    uint16_t state8925;                           /* 0010h [U meaning] */
    uint16_t state99C5;                           /* 0012h [U meaning] */
    uint16_t stateA965;                           /* 0014h [U meaning] */
    uint16_t state8594;                           /* 0016h [U meaning] */
    uint16_t lrmShipmentLoaded;                   /* 0018h [P] */
    uint16_t srmShipmentLoaded;                   /* 001Ah [P] */
    uint8_t scenarioClock[3];                     /* 001Ch [P] */
    uint8_t state00A0[6];                         /* 001Fh [U meaning] */
    uint8_t scenarioUnitMapX[24];                 /* 0025h [P] */
    uint8_t scenarioUnitMapY[24];                 /* 003Dh [P] */
    uint8_t state1B85[7];                         /* 0055h [U meaning] */
    uint8_t state1B8E;                            /* 005Ch [U meaning] */
    uint8_t state1BAD[15];                        /* 005Dh [U meaning] */
    uint8_t scenarioRecords[18][15];              /* 006Ch [V shape/U semantics] */
    RevengeUnitLanceAssignmentRecord lanceAssignments[13]; /* 017Ah [P] */
    uint8_t pilotAvailability[37];                /* 01FCh [P] */
} RevengeCampaignSnapshot;

/* Borland far-heap header. All links are stored real-mode far pointers. */
typedef struct RevengeFarHeapBlockHeader
{
    uint32_t sizeAndAllocated;
    RevengeFarPointer previousPhysical;
    RevengeFarPointer previousFree;
    RevengeFarPointer nextFree;
} RevengeFarHeapBlockHeader;

#pragma pack(pop)

enum
{
    REVENGE_WEAPON_DEFINITION_COUNT = 0x17,
    REVENGE_UNIT_RECORD_SIZE = 0x96,
    REVENGE_UNIT_SLOT_COUNT = 0x18,
    REVENGE_SAVE_SLOT_DESCRIPTOR_SIZE = 0x16,
    REVENGE_CAMPAIGN_SNAPSHOT_SIZE = 0x0221,
    REVENGE_SAVE_UNIT_BLOCK_SIZE = 0x0E10,
    REVENGE_SAVE_PAYLOAD_SIZE = 0x1031
};

REVENGE_STATIC_ASSERT(sizeof(RevengeFarPointer) == 0x04, "far pointer size");
REVENGE_STATIC_ASSERT(sizeof(RevengeWeaponDefinition) == 0x0F, "weapon record size");
REVENGE_STATIC_ASSERT(offsetof(RevengeWeaponDefinition, effectId) == 0x0E, "weapon effect offset");
REVENGE_STATIC_ASSERT(sizeof(RevengeUnitRecord) == 0x96, "unit record size");
REVENGE_STATIC_ASSERT(offsetof(RevengeUnitRecord, currentAmmunition) == 0x38, "unit ammunition offset");
REVENGE_STATIC_ASSERT(offsetof(RevengeUnitRecord, tonnage) == 0x84, "unit tonnage offset");
REVENGE_STATIC_ASSERT(offsetof(RevengeUnitRecord, pilotId) == 0x92, "unit pilot offset");
REVENGE_STATIC_ASSERT(offsetof(RevengeUnitRecord, damageModel) == 0x95, "unit damage-model offset");
REVENGE_STATIC_ASSERT(sizeof(RevengePilotRosterRecord) == 0x04, "pilot record size");
REVENGE_STATIC_ASSERT(sizeof(RevengeUnitLanceAssignmentRecord) == 0x0A, "lance assignment size");
REVENGE_STATIC_ASSERT(sizeof(RevengeTextWindowContext) == 0x10, "text-window size");
REVENGE_STATIC_ASSERT(sizeof(RevengeUiRegionRecord) == 0x10, "UI-region size");
REVENGE_STATIC_ASSERT(offsetof(RevengeUiRegionRecord, xorColor) == 0x0C, "UI XOR-color offset");
REVENGE_STATIC_ASSERT(sizeof(RevengeCachedFileDescriptor) == 0x12, "cached-file descriptor size");
REVENGE_STATIC_ASSERT(sizeof(RevengeDigitalWeaponEffectRecord) == 0x0A, "weapon-effect record size");
REVENGE_STATIC_ASSERT(sizeof(RevengeDigitalSoundEntry) == 0x0B, "digital-sound entry size");
REVENGE_STATIC_ASSERT(sizeof(RevengeTacticalCombatRatings) == 0x0C, "combat-rating record size");
REVENGE_STATIC_ASSERT(sizeof(RevengeTerrainImpactAnimationRecord) == 0x06, "terrain-animation record size");
REVENGE_STATIC_ASSERT(sizeof(RevengeTacticalImpactRecord) == 0x08, "impact record size");
REVENGE_STATIC_ASSERT(sizeof(RevengeSaveSlotDescriptor) == 0x16, "save-slot descriptor size");
REVENGE_STATIC_ASSERT(offsetof(RevengeCampaignSnapshot, scenarioUnitMapX) == 0x25, "saved X-array offset");
REVENGE_STATIC_ASSERT(offsetof(RevengeCampaignSnapshot, scenarioRecords) == 0x6C, "scenario-record offset");
REVENGE_STATIC_ASSERT(offsetof(RevengeCampaignSnapshot, lanceAssignments) == 0x17A, "lance table offset");
REVENGE_STATIC_ASSERT(offsetof(RevengeCampaignSnapshot, pilotAvailability) == 0x1FC, "pilot-state offset");
REVENGE_STATIC_ASSERT(sizeof(RevengeCampaignSnapshot) == 0x0221, "campaign snapshot size");
REVENGE_STATIC_ASSERT(sizeof(RevengeFarHeapBlockHeader) == 0x10, "far-heap header size");

#undef REVENGE_STATIC_ASSERT

#endif
