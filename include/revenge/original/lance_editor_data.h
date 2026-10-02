#ifndef REVENGE_ORIGINAL_LANCE_EDITOR_DATA_H
#define REVENGE_ORIGINAL_LANCE_EDITOR_DATA_H

#include "revenge/far_memory.h"
#include "revenge/original/campaign_data.h"
#include "revenge/roster.h"
#include "revenge/types.h"

extern byte *SharedGraphicsBackingBuffers[0x20];

enum
{
	LANCE_EDITOR_DATA_SEGMENT = 0x3A6A,
	UNIT_SELECTION_CARD_COUNT = 0x12,
	LANCE_EDITOR_GRAPHICS_BUFFER_COUNT = 0x20,
	LANCE_EDITOR_SECTION_COUNT = 0x04,
	LANCE_EDITOR_SECTION_LAYOUT_COUNT = 0x08,
	LANCE_EDITOR_UNIT_TYPE_COUNT = 0x59,
	LANCE_EDITOR_PILOT_NAME_COUNT = 0x3B
};

/* This bridge remains only for genuine 16:16 addresses stored in original
 * records, such as the spriteBuffer member of UnitSelectionCard. */
#define LANCE_EDITOR_FAR(type, pointer) \
	((type *)HostFarPointer_Resolve(DosAddress_ToValue(pointer)))

/* These aliases are two domain names for the same original DS bytes. */
#define TrainingScenarioAvailability TrainingScenarioCompletionFlags
#define RandomUnitTypePool ReplayCampaignState
#define RandomPilotPool ReplayExtendedCampaignState

extern byte RandomSelectionPoolCount;
extern UnitSelectionCard UnitSelectionCards[UNIT_SELECTION_CARD_COUNT];
extern word16 LanceEditorFirstBriefingPending;
extern word16 LanceEditorBriefingPresented;
extern word16 LanceEditorReloadGraphics;

extern const char * const UnitAllegianceLabelTextTable[0x02];
extern const char UnknownUnitLabel[];
extern const char UnitStatusSpace[];
extern const char UnitRosterSeparator[];
extern const char UnitStatusSeparator[];
extern const char * const UnitStatHeaderTextTable[0x06];

extern word16 UnitEditorLanceSlotCount[0x03];
extern byte RandomUnitTypeCount;
extern byte UnitEditorUnitSpriteIndex[LANCE_EDITOR_UNIT_TYPE_COUNT];
extern byte UnitMovementClassByType[LANCE_EDITOR_UNIT_TYPE_COUNT];
extern byte PredefinedUnitTypeTable[0x1E];
extern byte UnitEditorSectionEnabled[0x1D];
extern byte UnitEditorScenarioCardCountByFamily[0x07];
extern byte RandomUnitTypeCountByFamily[0x0A];
extern byte RandomUnitTypePoolByFamily[0x31];
extern byte PilotPortraitIndexById[0x21];
extern word16 DefaultPilotIdsByScenario[0x14];
extern byte UnitEditorPilotCardCountByFamily[0x07];

extern const byte * const UnitClassTypeLists[0x07];
extern const char * const UnitClassLabelTextTable[0x07];
extern const char * const TrainingDeploymentLabelTextTable[0x04];
extern const char * const TrainingControlLabelTextTable[0x04];
extern const char * const ScenarioVariantDescriptionTextTable[0x04];
extern const char * const UnitEditorSectionLabelTextTable[0x04];
extern byte FixedPilotIds[0x02];
extern byte FixedUnitTypeIds[0x02];
extern const char * const ScenarioRouteLabelTextTable[0x04];
extern const char * const UnitEditorSectionButtonLabelTextTable[0x04];
extern const char * const TrainingDeploymentRosterLabelTextTable[0x02];
extern const char * const UnitRosterColumnLabelTextTable[0x03];
extern const char FriendlyEnemySuffixText[];
extern const char TrainingCategoryHeadingText[];
extern const char * const TrainingCategoryLabelTextTable[0x02];
extern const char TrainingScenarioHeadingText[];
extern char * const TrainingScenarioLabelTextTable[0x06];
extern const char NoSelectionOptionsText[];
extern const char TrainingUnitSelectionPrompt[];

#pragma pack(push, 1)
typedef struct LanceEditorLayoutData
{
	word16 TrainingUnitChoiceLeft[0x0C];
	word16 TrainingUnitChoiceTop[0x0C];
	word16 TrainingControlChoiceLeft[0x04];
	word16 TrainingControlChoiceTop[0x04];
	word16 TrainingUnitGroupLeft[0x02];
	word16 TrainingUnitGroupBottom;
	word16 TrainingUnitGroupLabelLeft[0x03];
	word16 TrainingUnitGroupLabelWidth[0x03];
	byte AllegianceHeaderColor[0x02];
	word16 TrainingDeploymentSlotLeft[0x03];
	word16 TrainingControlChoiceColumn[0x02];
	word16 TrainingCategoryRegionLeft[0x02];
	word16 TrainingCategoryRegionTop[0x02];
	word16 TrainingCategoryRegionWidth[0x02];
	word16 TrainingCategoryRegionHeight[0x02];
	word16 TrainingScenarioRegionLeft[0x06];
	word16 TrainingScenarioRegionTop[0x06];
	word16 TrainingScenarioRegionWidth[0x06];
	word16 TrainingScenarioRegionHeight[0x06];
	word16 TrainingDeploymentFrameLeft[0x02];
	word16 TrainingDeploymentFrameBottom;
	word16 TrainingDeploymentTextColor[0x02];
	word16 TrainingDeploymentBackgroundColor[0x02];
	word16 TrainingRosterLabelLeft[0x03];
	word16 TrainingRosterLabelWidth[0x03];
	word16 TrainingCategoryTextColor[0x02];
	word16 TrainingCategoryBackgroundColor[0x02];
	word16 TrainingScenarioTextColor[0x02];
	word16 TrainingScenarioBackgroundColor[0x02];
	word16 UnitEditorSectionLeft[0x08];
	word16 UnitEditorSectionTop[0x08];
	word16 UnitEditorSectionWidth[0x08];
	word16 UnitEditorSectionHeight[0x08];
	word16 ScenarioVariantTextLeft[0x02];
	word16 ScenarioVariantTextTop[0x02];
	word16 ScenarioVariantNormalColor;
	word16 ScenarioVariantSelectedColor;
	word16 ScenarioVariantLabelColor[0x04];
	word16 ScenarioVariantRegionLeft[0x02];
	word16 ScenarioVariantRegionTop[0x02];
	word16 ScenarioVariantRegionWidth[0x02];
	word16 ScenarioVariantRegionHeight[0x02];
	word16 UnitRosterLeftColumn;
	word16 UnitRosterRightColumn;
	word16 UnitEditorSectionRows[0x04];
	word16 UnitEditorSectionButtonRows[0x04];
	word16 UnitCardBackgroundColorByState[0x04];
	word16 UnitCardTextColorByState[0x04];
	word16 LanceAssignmentTextColor[0x02];
	word16 PilotEditorSectionRows[0x04];
	word16 PilotCardTextColor[0x04];
	word16 LanceBackingSourceTileX[0x04];
	word16 LanceBackingSourcePixelY[0x04];
	word16 LanceBackingWidthTiles[0x04];
	word16 LanceBackingHeightPixels[0x04];
	word16 ScenarioBackingSourceTileX[0x02];
	word16 ScenarioBackingSourcePixelY[0x02];
	word16 ScenarioBackingWidthTiles[0x02];
	word16 ScenarioBackingHeightPixels[0x02];
	word16 EditorBackingSourceTileX[0x08];
	word16 EditorBackingSourcePixelY[0x08];
	word16 EditorBackingWidthTiles[0x08];
	word16 EditorBackingHeightPixels[0x08];
} LanceEditorLayoutData;
#pragma pack(pop)

_Static_assert(sizeof(LanceEditorLayoutData) == 0x01D4,
	"Lance editor layout must retain DS:3470-3643 byte layout");

extern LanceEditorLayoutData LanceEditorLayout;

extern const char * const PilotSurnameTextTable[LANCE_EDITOR_PILOT_NAME_COUNT];
extern const char * const PilotGivenNameTextTable[LANCE_EDITOR_PILOT_NAME_COUNT];
extern const char * const PilotExperienceLabelTextTable[0x04];
extern const char * const PilotGunneryLabelTextTable[0x04];
extern const char * const UnitMovementClassLabelTextTable[0x05];
extern const char * const UnitArmorConditionLabelTextTable[0x06];
extern const char UnitStatusEquipmentSeparator[];

#define UnitEditorGraphicsBuffer(index) \
	SharedGraphicsBackingBuffers[(index)]

#endif
