#ifndef REVENGE_TACTICAL_DATA_H
#define REVENGE_TACTICAL_DATA_H

#include <stddef.h>

#include "revenge/types.h"

enum
{
	TACTICAL_PROJECTILE_RECORD_COUNT = 0x50,
	TACTICAL_IMPACT_RECORD_COUNT = 0x50,
	TERRAIN_IMPACT_ANIMATION_RECORD_COUNT = 0x5A,
	MAP_EDGE_EFFECT_RECORD_COUNT = 0x03,
	TERRAIN_DAMAGE_QUEUE_ENTRY_COUNT = 0x19
};

#pragma pack(push, 1)
typedef struct RevengeTacticalProjectileRecord
{
	byte weaponIndex;
	RevengeUnitSlot targetUnitIndex;
	byte shotHit;
	RevengeUnitSlot attackerUnitIndex;
	word16 spriteId;
	int16 currentMapX;
	int16 currentMapY;
	int16 destinationMapX;
	int16 destinationMapY;
} RevengeTacticalProjectileRecord;

typedef struct RevengeTacticalImpactRecord
{
	int16 mapX;
	int16 mapY;
	word16 spriteId;
	word16 terminalSpriteId;
} RevengeTacticalImpactRecord;

typedef struct RevengeTerrainImpactAnimationRecord
{
	int16 mapX;
	int16 mapY;
	word16 animationVariant;
} RevengeTerrainImpactAnimationRecord;

typedef struct RevengeMapEdgeEffectRecord
{
	int16 mapX;
	int16 mapY;
	word16 spriteId;
	word16 edgeDirection;
} RevengeMapEdgeEffectRecord;

typedef struct RevengeTerrainDamageQueueEntry
{
	word16 packedByteIndex;
	word16 subcellIndex;
} RevengeTerrainDamageQueueEntry;
#pragma pack(pop)

_Static_assert(sizeof(RevengeTacticalProjectileRecord) == 0x0E,
	"Tactical projectile records must retain their DOS layout");
_Static_assert(offsetof(RevengeTacticalProjectileRecord, spriteId) == 0x04,
	"Projectile sprite ID must remain at record offset 04h");
_Static_assert(sizeof(RevengeTacticalImpactRecord) == 0x08,
	"Tactical impact records must retain their four-word DOS layout");
_Static_assert(offsetof(RevengeTacticalProjectileRecord, destinationMapY) == 0x0C,
	"Projectile destination Y must remain at record offset 0Ch");
_Static_assert(sizeof(RevengeTerrainImpactAnimationRecord) == 0x06,
	"Terrain-impact records must retain their DOS layout");
_Static_assert(sizeof(RevengeMapEdgeEffectRecord) == 0x08,
	"Map-edge effect records must retain their DOS layout");
_Static_assert(sizeof(RevengeTerrainDamageQueueEntry) == 0x04,
	"Terrain-damage queue entries must retain their DOS layout");

#endif
