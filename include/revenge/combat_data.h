#ifndef REVENGE_COMBAT_DATA_H
#define REVENGE_COMBAT_DATA_H

#include <stddef.h>

#include "revenge/types.h"

enum
{
	WEAPON_DEFINITION_COUNT = 0x17,
	WEAPON_DEFINITION_RECORD_SIZE = 0x0F,
	AMMUNITION_FAMILY_COUNT = 0x0E,
	WEAPON_PRIORITY_PROFILE_COUNT = 0x10,
	WEAPON_PRIORITY_DATA_BYTE_COUNT = 0x0580,
	WEAPON_PRIORITY_DATA_ENTRY_COUNT =
		WEAPON_PRIORITY_DATA_BYTE_COUNT / sizeof(uint32),
	HIT_LOCATION_FACING_TABLE_COUNT = 0x04,
	HIT_LOCATION_TABLE_INFANTRY = 0x04,
	HIT_LOCATION_TABLE_COUNT = 0x05,
	HIT_LOCATION_ROLL_COUNT = 0x0B,
	HIT_LOCATION_TABLE_WORD_COUNT = 0x0C
};

typedef enum RevengeWeaponIndex
{
	WEAPON_SMALL_LASER = 0x00,
	WEAPON_SMALL_PULSE_LASER = 0x01,
	WEAPON_MEDIUM_LASER = 0x02,
	WEAPON_MEDIUM_PULSE_LASER = 0x03,
	WEAPON_LARGE_LASER = 0x04,
	WEAPON_LARGE_PULSE_LASER = 0x05,
	WEAPON_ER_LARGE_LASER = 0x06,
	WEAPON_PPC = 0x07,
	WEAPON_ER_PPC = 0x08,
	WEAPON_AUTOCANNON_2 = 0x09,
	WEAPON_AUTOCANNON_5 = 0x0A,
	WEAPON_AUTOCANNON_10 = 0x0B,
	WEAPON_LB_10X_AUTOCANNON = 0x0C,
	WEAPON_GAUSS_RIFLE = 0x0D,
	WEAPON_AUTOCANNON_20 = 0x0E,
	WEAPON_MACHINE_GUN = 0x0F,
	WEAPON_LRM_5 = 0x10,
	WEAPON_LRM_10 = 0x11,
	WEAPON_LRM_15 = 0x12,
	WEAPON_LRM_20 = 0x13,
	WEAPON_SRM_2 = 0x14,
	WEAPON_SRM_4 = 0x15,
	WEAPON_SRM_6 = 0x16
} RevengeWeaponIndex;

typedef enum RevengeAmmunitionFamily
{
	AMMUNITION_NONE = 0x00,
	AMMUNITION_AUTOCANNON_2 = 0x01,
	AMMUNITION_AUTOCANNON_5 = 0x02,
	AMMUNITION_AUTOCANNON_10 = 0x03,
	AMMUNITION_LB_10X_AUTOCANNON = 0x04,
	AMMUNITION_GAUSS_RIFLE = 0x05,
	AMMUNITION_AUTOCANNON_20 = 0x06,
	AMMUNITION_MACHINE_GUN = 0x07,
	AMMUNITION_LRM_5 = 0x08,
	AMMUNITION_LRM_10 = 0x09,
	AMMUNITION_LRM_15 = 0x0A,
	AMMUNITION_LRM_20 = 0x0B,
	AMMUNITION_SRM_2 = 0x0C,
	AMMUNITION_SRM_4 = 0x0D,
	AMMUNITION_SRM_6 = 0x0E
} RevengeAmmunitionFamily;

#define WEAPON_EQUIPMENT_ID(weaponIndex) ((weaponIndex) + 0x01)
#define WEAPON_INDEX_FROM_EQUIPMENT_ID(equipmentId) ((equipmentId) - 0x01)
#define AMMUNITION_INDEX(ammunitionFamily) ((ammunitionFamily) - 0x01)

enum
{
	WEAPON_CLOSE_FIREPOWER_PRIMARY_MASK = 0x00008003UL,
	WEAPON_CLOSE_FIREPOWER_SECONDARY_MASK = 0x007049FCUL,
	WEAPON_MEDIUM_FIREPOWER_HALF_RATING_MASK = 0x0070400CUL,
	WEAPON_MEDIUM_FIREPOWER_FULL_RATING_MASK = 0x000F3FF0UL,
	WEAPON_LONG_FIREPOWER_HALF_RATING_MASK = 0x00000810UL,
	WEAPON_LONG_FIREPOWER_FULL_RATING_MASK = 0x000F37E0UL
};

typedef enum RevengeWeaponRangeClass
{
	WEAPON_RANGE_LONG = 0x00,
	WEAPON_RANGE_MEDIUM = 0x01,
	WEAPON_RANGE_CLOSE = 0x02,
	WEAPON_RANGE_CLASS_COUNT = 0x03
} RevengeWeaponRangeClass;

enum
{
	WEAPON_AI_MAXIMUM_ATTACK_DISTANCE = 0x18,
	WEAPON_AI_LONG_RANGE_DISTANCE = 0x13,
	WEAPON_AI_MEDIUM_RANGE_DISTANCE = 0x0A,
	WEAPON_AI_CLOSE_RANGE_DISTANCE = 0x04,
	WEAPON_AI_LOW_HEAT_LIMIT = 0x06,
	WEAPON_AI_MEDIUM_HEAT_LIMIT = 0x0C,
	INFERNO_MISSILE_HEAT = 0x1E,
	HEAVY_WEAPON_DAMAGE_THRESHOLD = 0x03
};

#pragma pack(push, 1)
typedef struct RevengeWeaponDefinition
{
	word16 nameOffset;
	word16 nameSegment;
	byte heat;
	byte damage;
	byte minimumRange;
	byte maximumRangeUnits;
	word16 weightHalfTons;
	byte missileRackSize;
	byte ammunitionFamilyId;
	byte criticalSlotCount;
	byte recoveryDelayTicks;
	byte effectId;
} RevengeWeaponDefinition;

typedef struct RevengeTacticalCombatRatings
{
	int16 movement;
	int16 durabilityDividedBy16;
	int16 closeFirepower;
	int16 mediumFirepower;
	int16 longFirepower;
	int16 sensorHits;
} RevengeTacticalCombatRatings;

/*
 * DS:09C6 is a bank of variable-length weapon-priority lists. Each list is
 * two adjacent arrays of 32-bit entries: availability masks followed by the
 * corresponding one-based weapon IDs. The union preserves the exact byte
 * image while exposing the longword access performed by 2D1B:16E5..1722.
 */
typedef union RevengeWeaponPriorityData
{
	byte raw[WEAPON_PRIORITY_DATA_BYTE_COUNT];
	uint32 entries[WEAPON_PRIORITY_DATA_ENTRY_COUNT];
} RevengeWeaponPriorityData;
#pragma pack(pop)

_Static_assert(sizeof(RevengeWeaponDefinition) ==
	WEAPON_DEFINITION_RECORD_SIZE,
	"RevengeWeaponDefinition must retain its DOS data layout");
_Static_assert(offsetof(RevengeWeaponDefinition, heat) == 0x04,
	"Weapon heat must remain at record offset 04h");
_Static_assert(offsetof(RevengeWeaponDefinition, damage) == 0x05,
	"Weapon damage must remain at record offset 05h");
_Static_assert(offsetof(RevengeWeaponDefinition, minimumRange) == 0x06,
	"Weapon minimum range must remain at record offset 06h");
_Static_assert(offsetof(RevengeWeaponDefinition, maximumRangeUnits) == 0x07,
	"Weapon maximum range must remain at record offset 07h");
_Static_assert(offsetof(RevengeWeaponDefinition, weightHalfTons) == 0x08,
	"Weapon weight must remain at record offset 08h");
_Static_assert(offsetof(RevengeWeaponDefinition, missileRackSize) == 0x0A,
	"Weapon rack size must remain at record offset 0Ah");
_Static_assert(offsetof(RevengeWeaponDefinition, ammunitionFamilyId) == 0x0B,
	"Weapon ammunition family must remain at record offset 0Bh");
_Static_assert(offsetof(RevengeWeaponDefinition, criticalSlotCount) == 0x0C,
	"Weapon critical-slot count must remain at record offset 0Ch");
_Static_assert(offsetof(RevengeWeaponDefinition, recoveryDelayTicks) == 0x0D,
	"Weapon recovery delay must remain at record offset 0Dh");
_Static_assert(offsetof(RevengeWeaponDefinition, effectId) == 0x0E,
	"Weapon effect must remain at record offset 0Eh");

_Static_assert(sizeof(RevengeTacticalCombatRatings) == 0x0C,
	"RevengeTacticalCombatRatings must retain its DOS data layout");
_Static_assert(offsetof(RevengeTacticalCombatRatings, closeFirepower) == 0x04,
	"Close firepower must remain at record offset 04h");
_Static_assert(offsetof(RevengeTacticalCombatRatings, sensorHits) == 0x0A,
	"Sensor hits must remain at record offset 0Ah");
_Static_assert(sizeof(RevengeWeaponPriorityData) ==
	WEAPON_PRIORITY_DATA_BYTE_COUNT,
	"Weapon priority data must retain its DOS data layout");

extern const RevengeWeaponDefinition
	WeaponDefinitions[WEAPON_DEFINITION_COUNT];

#endif
