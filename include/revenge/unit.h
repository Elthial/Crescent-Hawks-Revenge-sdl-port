#ifndef REVENGE_UNIT_H
#define REVENGE_UNIT_H

#include "revenge/battletech.h"
#include "revenge/types.h"

#include <stddef.h>

typedef struct RevengeGameRuntime RevengeGameRuntime;

typedef enum RevengeBattleMechLocation
{
    BATTLEMECH_LOCATION_HEAD = 0x00,
    BATTLEMECH_LOCATION_LEFT_ARM = 0x01,
    BATTLEMECH_LOCATION_LEFT_TORSO = 0x02,
    BATTLEMECH_LOCATION_CENTER_TORSO = 0x03,
    BATTLEMECH_LOCATION_RIGHT_TORSO = 0x04,
    BATTLEMECH_LOCATION_RIGHT_ARM = 0x05,
    BATTLEMECH_LOCATION_LEFT_LEG = 0x06,
    BATTLEMECH_LOCATION_RIGHT_LEG = 0x07,
    BATTLEMECH_LOCATION_COUNT = 0x08
} RevengeBattleMechLocation;

typedef enum RevengeBattleMechArmorLocation
{
    BATTLEMECH_ARMOR_HEAD = BATTLEMECH_LOCATION_HEAD,
    BATTLEMECH_ARMOR_LEFT_ARM = BATTLEMECH_LOCATION_LEFT_ARM,
    BATTLEMECH_ARMOR_LEFT_TORSO = BATTLEMECH_LOCATION_LEFT_TORSO,
    BATTLEMECH_ARMOR_CENTER_TORSO = BATTLEMECH_LOCATION_CENTER_TORSO,
    BATTLEMECH_ARMOR_RIGHT_TORSO = BATTLEMECH_LOCATION_RIGHT_TORSO,
    BATTLEMECH_ARMOR_RIGHT_ARM = BATTLEMECH_LOCATION_RIGHT_ARM,
    BATTLEMECH_ARMOR_LEFT_LEG = BATTLEMECH_LOCATION_LEFT_LEG,
    BATTLEMECH_ARMOR_RIGHT_LEG = BATTLEMECH_LOCATION_RIGHT_LEG,
    BATTLEMECH_ARMOR_LEFT_REAR_TORSO = 0x08,
    BATTLEMECH_ARMOR_CENTER_REAR_TORSO = 0x09,
    BATTLEMECH_ARMOR_RIGHT_REAR_TORSO = 0x0A,
    BATTLEMECH_ARMOR_LOCATION_COUNT = 0x0B
} RevengeBattleMechArmorLocation;

/*
 * Vehicle templates use the same eight internal and eleven armor slots as a
 * BattleMech. The executable does not provide a defensible one-to-one mapping
 * from those slots to tabletop front/left/right/rear/turret locations, so the
 * vehicle view deliberately retains the engine's shared slot numbering.
 */
typedef enum RevengeVehicleSharedLocation
{
    VEHICLE_SHARED_LOCATION_0 = 0x00,
    VEHICLE_SHARED_LOCATION_1 = 0x01,
    VEHICLE_SHARED_LOCATION_2 = 0x02,
    VEHICLE_SHARED_LOCATION_3 = 0x03,
    VEHICLE_SHARED_LOCATION_4 = 0x04,
    VEHICLE_SHARED_LOCATION_5 = 0x05,
    VEHICLE_SHARED_LOCATION_6 = 0x06,
    VEHICLE_SHARED_LOCATION_7 = 0x07,
    VEHICLE_SHARED_LOCATION_COUNT = 0x08
} RevengeVehicleSharedLocation;

/* Verified MECHTYPE.DAT indices 37h..3Eh and UnitNameTable order. */
typedef enum RevengeVehicleUnitType
{
    UNIT_TYPE_ROMMEL_TANK = 0x37,
    UNIT_TYPE_PEGASUS = 0x38,
    UNIT_TYPE_DRILLSON = 0x39,
    UNIT_TYPE_MOBILE_HQ = 0x3A,
    UNIT_TYPE_APC = 0x3B,
    UNIT_TYPE_AMMO_CARRIER = 0x3C,
    UNIT_TYPE_GALLEON = 0x3D,
    UNIT_TYPE_SKULKER = 0x3E
} RevengeVehicleUnitType;

typedef enum RevengeUnitDamageModel
{
    UNIT_DAMAGE_MODEL_BATTLEMECH = 0x00,
    UNIT_DAMAGE_MODEL_HOVER_VEHICLE = 0x01,
    UNIT_DAMAGE_MODEL_COMBAT_VEHICLE = 0x02,
    UNIT_DAMAGE_MODEL_INFANTRY = 0x03,
    UNIT_DAMAGE_MODEL_APC = 0x04,
    UNIT_DAMAGE_MODEL_AMMO_CARRIER = 0x05,
    UNIT_DAMAGE_MODEL_MOBILE_HQ = 0x06,
    UNIT_DAMAGE_MODEL_OVERBURN_CAPABLE_MINIMUM = 0x07
} RevengeUnitDamageModel;

typedef struct RevengeBattleMechDurabilityView
{
    byte headInternal;
    byte leftArmInternal;
    byte leftTorsoInternal;
    byte centerTorsoInternal;
    byte rightTorsoInternal;
    byte rightArmInternal;
    byte leftLegInternal;
    byte rightLegInternal;
    byte headArmor;
    byte leftArmArmor;
    byte leftTorsoArmor;
    byte centerTorsoArmor;
    byte rightTorsoArmor;
    byte rightArmArmor;
    byte leftLegArmor;
    byte rightLegArmor;
    byte leftRearTorsoArmor;
    byte centerRearTorsoArmor;
    byte rightRearTorsoArmor;
} RevengeBattleMechDurabilityView;

/*
 * This view records only what is proven: vehicle templates occupy the same
 * nineteen durability bytes. Naming the individual vehicle facings would
 * assert a slot projection that has not yet been established from the ASM.
 */
typedef struct RevengeVehicleDurabilityView
{
    byte internalSlot[0x08];
    byte armorSlot[0x0B];
} RevengeVehicleDurabilityView;

enum
{
    UNIT_RECORD_SIZE = 0x0096,
    REVENGE_UNIT_TYPE_COUNT = 0x59,
    UNIT_FIELD_DEPLOYMENT_STATE = 0x0000,
    UNIT_FIELD_TYPE_ID = 0x0001,
    UNIT_FIELD_WALK_MOVEMENT = 0x0002,
    UNIT_FIELD_JUMP_MOVEMENT = 0x0003,
    UNIT_FIELD_CURRENT_INTERNAL = 0x0004,
    UNIT_FIELD_CURRENT_ARMOR = 0x000C,
    UNIT_FIELD_MAXIMUM_INTERNAL = 0x0017,
    UNIT_FIELD_MAXIMUM_ARMOR = 0x001F,
    UNIT_FIELD_WEAPON_FAMILY_COUNTS = 0x002A,
    UNIT_FIELD_CURRENT_AMMUNITION = 0x0038,
    UNIT_FIELD_ENGINE_HEAT_SINK_CAPACITY = 0x0054,
    UNIT_FIELD_EQUIPMENT_HEAD = 0x0055,
    UNIT_FIELD_EQUIPMENT_LEFT_ARM = 0x0056,
    UNIT_FIELD_EQUIPMENT_LEFT_TORSO = 0x005E,
    UNIT_FIELD_EQUIPMENT_CENTER_TORSO = 0x006A,
    UNIT_FIELD_EQUIPMENT_RIGHT_TORSO = 0x006C,
    UNIT_FIELD_EQUIPMENT_RIGHT_ARM = 0x0078,
    UNIT_FIELD_EQUIPMENT_LEFT_LEG = 0x0080,
    UNIT_FIELD_EQUIPMENT_RIGHT_LEG = 0x0082,
    UNIT_FIELD_TONNAGE = 0x0084,
    UNIT_FIELD_ENGINE_HITS = 0x0085,
    UNIT_FIELD_HEAT_ACCUMULATOR_Q8_8 = 0x0086,
    UNIT_FIELD_CURRENT_HEAT = 0x0087,
    UNIT_FIELD_TACTICAL_SPRITE_BASE = 0x0088,
    UNIT_FIELD_SENSOR_HITS = 0x0089,
    UNIT_FIELD_GUNNERY_TARGET_NUMBER = 0x008A,
    UNIT_FIELD_TARGET_MOVEMENT_MODIFIER = 0x008B,
    UNIT_FIELD_MISSILE_UPGRADE_STATE = 0x008C,
    UNIT_FIELD_BEAGLE_ACTIVE_PROBE = 0x008D,
    UNIT_FIELD_INDIRECT_FIRE_SPOTTER = 0x008E,
    UNIT_FIELD_DOUBLE_HEAT_SINKS = 0x0090,
    UNIT_FIELD_CASE = 0x0091,
    UNIT_FIELD_PILOT_ID = 0x0092,
    UNIT_FIELD_PILOT_EXPERIENCE = 0x0093,
    UNIT_FIELD_ALLEGIANCE = 0x0094,
    UNIT_FIELD_DAMAGE_MODEL = 0x0095
};

enum
{
    EQUIPMENT_SLOT_EMPTY = 0x00,
    EQUIPMENT_ID_MASK = 0x7F,
    EQUIPMENT_DAMAGED_FLAG = 0x80,
    EQUIPMENT_ID_HEAT_SINK = 0x18,
    BATTLEMECH_HEAD_EQUIPMENT_SLOT_COUNT = 0x01,
    BATTLEMECH_ARM_EQUIPMENT_SLOT_COUNT = 0x08,
    BATTLEMECH_TORSO_EQUIPMENT_SLOT_COUNT = 0x0C,
    BATTLEMECH_CENTER_TORSO_EQUIPMENT_SLOT_COUNT = 0x02,
    BATTLEMECH_LEG_EQUIPMENT_SLOT_COUNT = 0x02,
    BATTLEMECH_MAX_SENSOR_HITS = 0x02,
    BATTLEMECH_ENGINE_HITS_DESTROYED = 0x03,
    BATTLEMECH_HEAT_SCALE = 0x05,
    BATTLEMECH_SHUTDOWN_HEAT_MINIMUM = 0x0E,
    BATTLEMECH_MAXIMUM_HEAT = 0x1E
};

enum
{
	TACTICAL_TARGET_NONE = -1,
	TACTICAL_TARGET_MAP_CELL = TACTICAL_UNIT_COUNT
};

#pragma pack(push, 1)
typedef union RevengeUnitRecord
{
    struct
    {
        byte deploymentState;             /* +00 */
        RevengeUnitTypeId unitTypeId;     /* +01 */
        byte walkMovement;                /* +02 */
        byte jumpMovement;                /* +03 */
        union
        {
            struct
            {
                byte currentInternal[0x08]; /* +04 */
                byte currentArmor[0x0B];    /* +0C */
            };
            byte currentDurability[0x13];   /* +04 */
            RevengeBattleMechDurabilityView currentBattleMech;
            RevengeVehicleDurabilityView currentVehicle;
        };
        union
        {
            struct
            {
                byte maximumInternal[0x08]; /* +17 */
                byte maximumArmor[0x0B];    /* +1F */
            };
            byte maximumDurability[0x13];   /* +17 */
            RevengeBattleMechDurabilityView maximumBattleMech;
            RevengeVehicleDurabilityView maximumVehicle;
        };
        union
        {
            struct
            {
                byte autocannon2Count;      /* +2A */
                byte autocannon5Count;      /* +2B */
                byte autocannon10Count;     /* +2C */
                byte lb10xAutocannonCount;  /* +2D */
                byte gaussRifleCount;       /* +2E */
                byte autocannon20Count;     /* +2F */
                byte machineGunCount;       /* +30 */
                byte lrm5Count;             /* +31 */
                byte lrm10Count;            /* +32 */
                byte lrm15Count;            /* +33 */
                byte lrm20Count;            /* +34 */
                byte srm2Count;             /* +35 */
                byte srm4Count;             /* +36 */
                byte srm6Count;             /* +37 */
            };
            byte weaponFamilyCounts[0x0E]; /* +2A */
        };
        union
        {
            struct
            {
                word16 autocannon2Ammunition;      /* +38 */
                word16 autocannon5Ammunition;      /* +3A */
                word16 autocannon10Ammunition;     /* +3C */
                word16 lb10xAutocannonAmmunition;  /* +3E */
                word16 gaussRifleAmmunition;       /* +40 */
                word16 autocannon20Ammunition;     /* +42 */
                word16 machineGunAmmunition;       /* +44 */
                word16 lrm5Ammunition;             /* +46 */
                word16 lrm10Ammunition;            /* +48 */
                word16 lrm15Ammunition;            /* +4A */
                word16 lrm20Ammunition;            /* +4C */
                word16 srm2Ammunition;             /* +4E */
                word16 srm4Ammunition;             /* +50 */
                word16 srm6Ammunition;             /* +52 */
            };
            word16 currentAmmunition[0x0E]; /* +38 */
        };
        byte engineHeatSinkCapacity;       /* +54 */
        union
        {
            struct
            {
                byte headEquipment;                /* +55 */
                byte leftArmEquipment[0x08];       /* +56 */
                byte leftTorsoEquipment[0x0C];     /* +5E */
                byte centerTorsoEquipment[0x02];   /* +6A */
                byte rightTorsoEquipment[0x0C];    /* +6C */
                byte rightArmEquipment[0x08];      /* +78 */
                byte leftLegEquipment[0x02];       /* +80 */
                byte rightLegEquipment[0x02];      /* +82 */
            };
            byte equipmentSlots[0x2F];             /* +55 */
        };
        byte tonnage;                      /* +84 */
        byte engineHits;                   /* +85 */
        union
        {
            struct
            {
                byte heatAccumulator;      /* +86 */
                byte currentHeat;          /* +87 */
            };
            word16 heatAccumulatorQ8_8;    /* +86 */
        };
        union
        {
            struct
            {
                byte tacticalSpriteBaseLow; /* +88 */
                byte sensorHits;            /* +89 */
            };
            word16 tacticalSpriteBase;      /* +88 */
        };
        byte gunneryTargetNumber;          /* +8A */
        byte targetMovementModifier;       /* +8B */
        byte missileUpgradeState;          /* +8C */
        byte beagleActiveProbe;            /* +8D */
        byte indirectFireSpotter;          /* +8E */
        byte unknown8F;                    /* +8F */
        byte doubleHeatSinks;              /* +90 */
        byte caseProtection;               /* +91 */
        RevengePilotId pilotId;            /* +92 */
        byte pilotExperience;              /* +93 */
        byte allegiance;                   /* +94 */
        byte damageModel;                  /* +95 */
    };
    byte raw[UNIT_RECORD_SIZE];
} RevengeUnitRecord;
#pragma pack(pop)

#define REVENGE_UNIT_OFFSET_ASSERT(field, offset) \
    _Static_assert(offsetof(RevengeUnitRecord, field) == (offset), \
        "RevengeUnitRecord field offset changed: " #field)

_Static_assert(sizeof(RevengeUnitRecord) == UNIT_RECORD_SIZE,
    "A Revenge unit record must retain its original 0x96-byte layout.");
_Static_assert(sizeof(((RevengeUnitRecord *)0)->headEquipment) ==
    BATTLEMECH_HEAD_EQUIPMENT_SLOT_COUNT,
    "The head equipment-slot count must retain its DOS layout.");
_Static_assert(sizeof(((RevengeUnitRecord *)0)->leftArmEquipment) ==
    BATTLEMECH_ARM_EQUIPMENT_SLOT_COUNT,
    "The arm equipment-slot count must retain its DOS layout.");
_Static_assert(sizeof(((RevengeUnitRecord *)0)->leftTorsoEquipment) ==
    BATTLEMECH_TORSO_EQUIPMENT_SLOT_COUNT,
    "The torso equipment-slot count must retain its DOS layout.");
_Static_assert(sizeof(((RevengeUnitRecord *)0)->centerTorsoEquipment) ==
    BATTLEMECH_CENTER_TORSO_EQUIPMENT_SLOT_COUNT,
    "The center-torso equipment-slot count must retain its DOS layout.");
_Static_assert(sizeof(((RevengeUnitRecord *)0)->leftLegEquipment) ==
    BATTLEMECH_LEG_EQUIPMENT_SLOT_COUNT,
    "The leg equipment-slot count must retain its DOS layout.");
_Static_assert(sizeof(RevengeBattleMechDurabilityView) == 0x13,
    "A BattleMech durability view must cover the original 19 bytes.");
_Static_assert(sizeof(RevengeVehicleDurabilityView) == 0x13,
    "A vehicle durability view must cover the original 19 bytes.");
REVENGE_UNIT_OFFSET_ASSERT(deploymentState, 0x00);
REVENGE_UNIT_OFFSET_ASSERT(unitTypeId, 0x01);
REVENGE_UNIT_OFFSET_ASSERT(walkMovement, 0x02);
REVENGE_UNIT_OFFSET_ASSERT(jumpMovement, 0x03);
REVENGE_UNIT_OFFSET_ASSERT(currentInternal, 0x04);
REVENGE_UNIT_OFFSET_ASSERT(currentDurability, 0x04);
REVENGE_UNIT_OFFSET_ASSERT(currentBattleMech, 0x04);
REVENGE_UNIT_OFFSET_ASSERT(currentVehicle, 0x04);
REVENGE_UNIT_OFFSET_ASSERT(currentArmor, 0x0C);
REVENGE_UNIT_OFFSET_ASSERT(maximumInternal, 0x17);
REVENGE_UNIT_OFFSET_ASSERT(maximumDurability, 0x17);
REVENGE_UNIT_OFFSET_ASSERT(maximumBattleMech, 0x17);
REVENGE_UNIT_OFFSET_ASSERT(maximumVehicle, 0x17);
REVENGE_UNIT_OFFSET_ASSERT(maximumArmor, 0x1F);
REVENGE_UNIT_OFFSET_ASSERT(weaponFamilyCounts, 0x2A);
REVENGE_UNIT_OFFSET_ASSERT(currentAmmunition, 0x38);
REVENGE_UNIT_OFFSET_ASSERT(lrm5Ammunition, 0x46);
REVENGE_UNIT_OFFSET_ASSERT(lrm10Ammunition, 0x48);
REVENGE_UNIT_OFFSET_ASSERT(lrm15Ammunition, 0x4A);
REVENGE_UNIT_OFFSET_ASSERT(lrm20Ammunition, 0x4C);
REVENGE_UNIT_OFFSET_ASSERT(engineHeatSinkCapacity, 0x54);
REVENGE_UNIT_OFFSET_ASSERT(headEquipment, 0x55);
REVENGE_UNIT_OFFSET_ASSERT(equipmentSlots, 0x55);
REVENGE_UNIT_OFFSET_ASSERT(leftArmEquipment, 0x56);
REVENGE_UNIT_OFFSET_ASSERT(leftTorsoEquipment, 0x5E);
REVENGE_UNIT_OFFSET_ASSERT(centerTorsoEquipment, 0x6A);
REVENGE_UNIT_OFFSET_ASSERT(rightTorsoEquipment, 0x6C);
REVENGE_UNIT_OFFSET_ASSERT(rightArmEquipment, 0x78);
REVENGE_UNIT_OFFSET_ASSERT(leftLegEquipment, 0x80);
REVENGE_UNIT_OFFSET_ASSERT(rightLegEquipment, 0x82);
REVENGE_UNIT_OFFSET_ASSERT(tonnage, 0x84);
REVENGE_UNIT_OFFSET_ASSERT(engineHits, 0x85);
REVENGE_UNIT_OFFSET_ASSERT(heatAccumulatorQ8_8, 0x86);
REVENGE_UNIT_OFFSET_ASSERT(tacticalSpriteBase, 0x88);
REVENGE_UNIT_OFFSET_ASSERT(gunneryTargetNumber, 0x8A);
REVENGE_UNIT_OFFSET_ASSERT(targetMovementModifier, 0x8B);
REVENGE_UNIT_OFFSET_ASSERT(missileUpgradeState, 0x8C);
REVENGE_UNIT_OFFSET_ASSERT(beagleActiveProbe, 0x8D);
REVENGE_UNIT_OFFSET_ASSERT(indirectFireSpotter, 0x8E);
REVENGE_UNIT_OFFSET_ASSERT(doubleHeatSinks, 0x90);
REVENGE_UNIT_OFFSET_ASSERT(caseProtection, 0x91);
REVENGE_UNIT_OFFSET_ASSERT(pilotId, 0x92);
REVENGE_UNIT_OFFSET_ASSERT(pilotExperience, 0x93);
REVENGE_UNIT_OFFSET_ASSERT(allegiance, 0x94);
REVENGE_UNIT_OFFSET_ASSERT(damageModel, 0x95);

#undef REVENGE_UNIT_OFFSET_ASSERT

typedef struct RevengeUnitTypeDatabase
{
    RevengeUnitRecord records[REVENGE_UNIT_TYPE_COUNT];
} RevengeUnitTypeDatabase;

uint16 LoadUnitTypeDatabase(
    const RevengeGameRuntime *game,
    RevengeUnitTypeDatabase *database);
uint16 LoadUnitTemplateFromDatabase(
    const RevengeUnitTypeDatabase *database,
    int16 unitType,
    RevengeUnitRecord *destination);

#endif
