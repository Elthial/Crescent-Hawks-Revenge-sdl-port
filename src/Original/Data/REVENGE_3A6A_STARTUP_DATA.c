// REVENGE_3A6A_STARTUP_DATA.c
// Typed objects recovered from REVENGE.EXE DS segment 3A6A.

#include "revenge/original_data.h"
#include "revenge/audio.h"
#include "revenge/far_memory.h"
#include "revenge/video.h"
#include "REVENGE.h"

word16 MemoryBlockSegment;
byte VideoPathUnavailable;
word16 DialogFramingEnabled;
word16 MinimumProgramBreakOffset;
word16 MinimumProgramBreakSegment;
word16 CurrentProgramBreakOffset;
word16 MapWidth;
word16 MapHeight;
word16 CurrentProgramBreakSegment;
word16 MaximumProgramBreakOffset;
word16 MaximumProgramBreakSegment;
word16 SavedBIOSVideoMode;
word16 GameInitialized;
word16 StartupResourceState = 0x0001;
byte *InvalidSaveDialogBacking;

const word16 BIOSVideoModeByAdapter[0x07] =
{
	0x0004, 0x0009, 0x000D, 0x0013, 0x0007, 0x0002, 0x0000
};

const char MediaConfigurationFileName[] = "MEDIA.CFG";
char TacticalMapFileName[0x09] = "MAPx.MAP";
char TacticalIconSetFileName[0x0D] = "ICONSETx.ICN";
char TacticalDestroyIconFileName[0x0D] = "DESTROYx.ICN";
char TacticalIconListFileName[0x0D] = "ICONLIST.DAT";
char TacticalMechSetFileName[0x0D] = "MECHSETX.ICN";
const char InvalidSaveVersionText[] =
	"Invalid version of save game.  Please use another save game.\r"
	"Press ESC to exit to DOS.\r"
	"Press space bar to try another.";
const char CampaignClockSeparatorText[] = ":";
const char FormattedLineBreak[] = "\r";
const char PathSeparatorText[] = "/";
const char PercentCloseText[] = "%)";
const char VersionDecimalSeparator[] = ".";

const MediaConfigurationChoice VideoConfigurationRecords[0x05] =
{
	{ "VGA",  0x03 },
	{ "MCGA", 0x07 },
	{ "EGA",  0x02 },
	{ "TNDY", 0x01 },
	{ "CGA",  0x00 }
};

const MediaConfigurationChoice MusicConfigurationRecords[0x07] =
{
	{ "LAPC", 0x04 },
	{ "MT32", 0x04 },
	{ "SNBL", 0x03 },
	{ "ADLB", 0x03 },
	{ "PS/1", 0x02 },
	{ "TNDY", 0x01 },
	{ "SPKR", 0x00 }
};

const MediaConfigurationChoice InputConfigurationRecords[0x02] =
{
	{ "MOUS", 0x01 },
	{ "KEYB", 0x00 }
};

const SoundConfigurationChoice SoundConfigurationRecords[0x09] =
{
	{ "SNBL", 0x05, 0x01 },
	{ "GMBL", 0x08, 0x01 },
	{ "INNV", 0x07, 0x01 },
	{ "SNMS", 0x06, 0x01 },
	{ "ADLB", 0x04, 0x00 },
	{ "PS/1", 0x02, 0x00 },
	{ "TDAC", 0x03, 0x00 },
	{ "TNDY", 0x01, 0x00 },
	{ "SPKR", 0x00, 0x00 }
};

const char VersionTranslationSource[] = " ";
const char VersionTranslationReplacement[] = "0";
const char MediaConfigAssignmentDelimiter[] = "=";
const char VideoConfigTokenDelimiters[] = " \n\r";
const char MusicConfigTokenDelimiters[] = " \n\r";
const char SoundConfigTokenDelimiters[] = " \n\r";
const char SoundParameterTokenDelimiters[] = " \n\r";
const char InputConfigTokenDelimiters[] = " \n\r";

word16 NumericKeypadNavigationEnabled;
word16 StartupInputMode;
word16 SoundEffectsEnabled;
word16 DigitalSoundBusy;
word16 AppliedMusicEnabled;
word16 SoundDriverNumericParameter;
word16 UseEgaTacticalFallback;
word16 InputDeviceType;
int8 SoundDriverIndex;
byte *Font6Resource;
byte *Font8Resource;
byte *SecondaryScreenBuffer;
byte *PlanarScreenBuffer;
/* Initial values recovered from REVENGE.EXE DS:277B-2782. */
word16 MouseCursorBackingSourceTileX = 0x0000;
word16 MouseCursorBackingSourcePixelY = 0x0008;
word16 MouseCursorBackingWidthTiles = 0x0002;
word16 MouseCursorBackingHeightPixels = 0x0010;
byte *SharedGraphicsBackingBuffers[0x20];
byte *VideoFramebuffer;
word16 ResourceRuntimeInitialized;
