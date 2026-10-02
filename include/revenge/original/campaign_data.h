#ifndef REVENGE_ORIGINAL_CAMPAIGN_DATA_H
#define REVENGE_ORIGINAL_CAMPAIGN_DATA_H

#include "revenge/far_memory.h"
#include "revenge/save_data.h"
#include "revenge/types.h"

#include <stddef.h>

enum
{
	CAMPAIGN_DATA_SEGMENT = 0x3A6A,
	CAMPAIGN_PRIMARY_STATE_COUNT = 0x07,
	CAMPAIGN_EXTENDED_STATE_COUNT = 0x0F,
	CAMPAIGN_STAGE_COUNT = 0x16
};

#pragma pack(push, 1)
typedef struct CampaignMessageEntry
{
	DosAddress text;
	byte presentationFlags;
} CampaignMessageEntry;

typedef union CampaignSaveDirectory
{
	struct
	{
		byte prefix[REVENGE_SAVE_DIRECTORY_PREFIX_SIZE];
		RevengeSaveSlotDescriptor slots[REVENGE_SAVE_SLOT_COUNT];
	};
	byte raw[REVENGE_SAVE_DIRECTORY_PREFIX_SIZE +
		REVENGE_SAVE_SLOT_COUNT * REVENGE_SAVE_DESCRIPTOR_SIZE];
} CampaignSaveDirectory;
#pragma pack(pop)

_Static_assert(sizeof(CampaignMessageEntry) == 0x05,
	"Campaign message entries must retain their original five-byte layout");
_Static_assert(offsetof(CampaignMessageEntry, presentationFlags) == 0x04,
	"Campaign message flags must remain at entry offset 04h");
_Static_assert(offsetof(CampaignSaveDirectory, slots) ==
	REVENGE_SAVE_DIRECTORY_PREFIX_SIZE,
	"Save descriptors must follow the original four-byte directory prefix");

enum
{
	CAMPAIGN_TITLE_TEXT_COUNT = 0x12,
	CAMPAIGN_MONTH_COUNT = 0x0C,
	CAMPAIGN_MISSION_DATE_COUNT = 0x0C,
	CAMPAIGN_SCREEN_PALETTE_COUNT = 0x26,
	CAMPAIGN_BLINK_RECT_COUNT = 0x07,
	CAMPAIGN_SPRITE_LAYOUT_COUNT = 0x0C,
	CAMPAIGN_MESSAGE_COUNT = 0xB2
};

extern byte TrainingScenarioCompletionFlags[0x06];
extern int8 ScreenPaletteResourceByScreen[CAMPAIGN_SCREEN_PALETTE_COUNT];
extern CampaignSaveDirectory SaveDirectory;
extern RevengeCampaignSnapshot SaveCampaignSnapshot;

extern byte InitialCampaignState[CAMPAIGN_PRIMARY_STATE_COUNT];
extern byte ForwardCampaignState[CAMPAIGN_PRIMARY_STATE_COUNT];
extern byte ReplayCampaignState[CAMPAIGN_PRIMARY_STATE_COUNT];
extern byte InitialExtendedCampaignState[CAMPAIGN_EXTENDED_STATE_COUNT];
extern byte ForwardExtendedCampaignState[CAMPAIGN_EXTENDED_STATE_COUNT];
extern byte ReplayExtendedCampaignState[CAMPAIGN_EXTENDED_STATE_COUNT];

extern const char * const TitleTextTable[CAMPAIGN_TITLE_TEXT_COUNT];
extern const char * const MonthNameTextTable[CAMPAIGN_MONTH_COUNT];
extern const char * const MissionDateLabelTextTable[CAMPAIGN_MISSION_DATE_COUNT];
extern byte ScenarioOrdinalBaseByCampaignStage[CAMPAIGN_STAGE_COUNT];

extern const char ExitToDosPrompt[];
extern const char * const CampaignPathMenuTextTable[0x02];
extern const char * const ScenarioVariantMenuTextTable[0x02];
extern const char * const AlternateScenarioMenuTextTable[0x02];
extern const char * const MainMenuTextTable[0x03];
extern const char * const InGameMenuTextTable[0x0B];
extern const char SaveGameSeparatorText[];

extern byte MissionFadeColorTable[0x04];
extern word16 MissionBlinkRectX[CAMPAIGN_BLINK_RECT_COUNT];
extern word16 MissionBlinkRectY[CAMPAIGN_BLINK_RECT_COUNT];
extern byte MissionBlinkRectExtent[CAMPAIGN_BLINK_RECT_COUNT];
extern byte MissionDateMonthIndex[CAMPAIGN_MISSION_DATE_COUNT];
extern word16 MissionDateYear[CAMPAIGN_MISSION_DATE_COUNT];
extern word16 MissionDateAdvanceMonths[0x10];
extern word16 MissionSpriteSourceTileX[CAMPAIGN_SPRITE_LAYOUT_COUNT];
extern word16 MissionSpriteSourcePixelY[CAMPAIGN_SPRITE_LAYOUT_COUNT];
extern word16 MissionSpriteWidthTiles[CAMPAIGN_SPRITE_LAYOUT_COUNT];
extern word16 MissionSpriteHeightPixels[CAMPAIGN_SPRITE_LAYOUT_COUNT];

extern const char PilotIdentityPrefixText[];
extern const char PilotNamePrefixText[];
extern const char DateCommaSpaceText[];
extern const char DateSpaceText[];
extern const char ScenarioCompleteHeadingText[];
extern const char ScenarioFailedHeadingText[];
extern CampaignMessageEntry CampaignMessageTable[CAMPAIGN_MESSAGE_COUNT];
extern const char * const CampaignMessageTextTable[CAMPAIGN_MESSAGE_COUNT];

extern const char PilotRosterHeadingText[];

#endif
