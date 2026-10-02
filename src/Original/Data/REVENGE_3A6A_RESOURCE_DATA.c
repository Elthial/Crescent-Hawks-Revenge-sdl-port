// REVENGE_3A6A_RESOURCE_DATA.c
// Typed objects recovered from REVENGE.EXE DS segment 3A6A.

#include "revenge/original_data.h"
#include "revenge/audio.h"
#include "revenge/far_memory.h"
#include "revenge/video.h"
#include "REVENGE.h"

char ResourceFileNames[
	ORIGINAL_RESOURCE_DESCRIPTOR_COUNT][0x10] =
{
	"BTBORDER.CPS", "BASEEXT.CPS", "BLAZACE.CPS", "DSATTACK.CPS",
	"DSLYONS.CPS", "ENDGAME.CPS", "HAWKLOGO.CPS", "JUMPSHIP.CPS",
	"KHBASE.CPS", "KHHANGER.CPS", "MECHBAY.CPS", "QUADPICS.CPS",
	"RIP.CPS", "SWAMP.CPS", "TANK.CPS", "TITLE.CPS",
	"HALFDS.CPS", "HALFDSSH.CPS", "FINAL.CPS", "BRUSHES.CPS",
	"MAP1.CPS", "MAP2.CPS", "ISMAP1.CPS", "ISMAP2.CPS",
	"ISMAPO.CPS", "COMM.CPS", "ORDERS.CPS", "CHIUN.CPS",
	"CHIUN'50.CPS", "GREASE.CPS", "JEN.CPS", "KELL.CPS",
	"KURT.CPS", "REX.CPS", "SHAW.CPS", "MECHS1.CPS",
	"MECHS2.CPS", "PILOTS1.CPS", "PILOTS2.CPS", "BASEEXT.COL",
	"BLAZACE.COL", "DSATTACK.COL", "DSLYONS.COL", "ENDGAME.COL",
	"HAWKLOGO.COL", "JUMPSHIP.COL", "KHBASE.COL", "KHHANGER.COL",
	"MECHBAY.COL", "QUADPICS.COL", "RIP.COL", "SWAMP.COL",
	"TANK.COL", "TITLE.COL", "HALFDS.COL", "FINAL.COL",
	"MAPS.COL", "ISMAPS.COL", "FACES.COL", "SELCTION.COL",
	"MAPx.MAP", "ICONSETx.ICN", "DESTROYx.ICN", "ICONLIST.DAT",
	"MECHTYPE.DAT", "MECHSETX.ICN", "SCENEx.DAT", "BOOMS.CMP",
	"SAVEGAME.DAT", "MEDIA.CFG", "DETHMEC1.MUS", "DETHMEC2.MUS",
	"MARCH1.MUS", "MARCH2.MUS", "SUBTITLE.MUS", "SUSP1.MUS",
	"SUSP2.MUS", "TITLE.MUS", "VICTORY.MUS", "WINGAME.MUS",
	"INFOCOM.BIN", "DPHRASES.BIN", "INCOMING.BIN", "LASER3.BIN",
	"LASER4.BIN", "LARGEGUN.BIN", "LGBOOM1.BIN", "SMGUN1.BIN",
	"WARN1.BIN", ""
};

const uint32 ResourceFileLengths[
	ORIGINAL_RESOURCE_DESCRIPTOR_COUNT] =
{
	0x00007D00UL, 0x000048F3UL, 0x00006658UL, 0x00007D00UL,
	0x000048D0UL, 0x00007D00UL, 0x00001037UL, 0x0000566EUL,
	0x00004B0EUL, 0x0000479CUL, 0x00007D00UL, 0x00007D00UL,
	0x00007D00UL, 0x00007D00UL, 0x00007D00UL, 0x00007D00UL,
	0x00007D00UL, 0x00007D00UL, 0x00007D00UL, 0x00007D00UL,
	0x00007D00UL, 0x00007D00UL, 0x00007D00UL, 0x00007D00UL,
	0x00007D00UL, 0x00007D00UL, 0x00007D00UL, 0x00007D00UL,
	0x00007D00UL, 0x00007D00UL, 0x00007D00UL, 0x00007D00UL,
	0x00007D00UL, 0x00007D00UL, 0x00007D00UL, 0x00007D00UL,
	0x00007D00UL, 0x00007D00UL, 0x00007D00UL, 0x00000300UL,
	0x00000300UL, 0x00000300UL, 0x00000300UL, 0x00000300UL,
	0x00000300UL, 0x00000300UL, 0x00000300UL, 0x00000300UL,
	0x00000300UL, 0x00000300UL, 0x00000300UL, 0x00000300UL,
	0x00000300UL, 0x00000300UL, 0x00000300UL, 0x00000300UL,
	0x00000300UL, 0x00000300UL, 0x00000300UL, 0x00000300UL,
	0x00001F8CUL, 0x000060EFUL, 0x00006561UL, 0x00007D00UL,
	0x000033CDUL, 0x000068FAUL, 0x000000E3UL, 0x00001886UL,
	0x00007D00UL, 0x00007D00UL, 0x00000A12UL, 0x00001075UL,
	0x000012C0UL, 0x00001C51UL, 0x00000EE0UL, 0x000002DCUL,
	0x00001D5BUL, 0x000030A3UL, 0x00000955UL, 0x00001AC1UL,
	0x000072F7UL, 0x00011A16UL, 0x00002000UL, 0x00001240UL,
	0x00000581UL, 0x00001618UL, 0x00001EF0UL, 0x000005B8UL,
	0x000009E0UL, 0x00000000UL
};

CachedFileDescriptor CachedFileDescriptors[
	ORIGINAL_RESOURCE_DESCRIPTOR_COUNT];
word16 ResourceRetryCount = 0x0003;
word16 ReservedConventionalMemoryKB = 0x00C8;
word16 SharedCompressionDictionarySegment;
word16 SharedCompressionDictionaryByteCount;
word16 FailedAllocationSizeLow;
word16 FailedAllocationSizeHigh;
ResourceFileRuntime ResourceFiles;
word16 ExitHandlerCount;
OriginalExitHandler ExitHandlerTable[0x20];
OriginalExitHandler RuntimeExitHook1;
OriginalExitHandler RuntimeExitHook2;
OriginalExitHandler RuntimeExitHook3;
OriginalExitHandler RuntimeTerminationHook;
DOS_InterruptHandler SavedDivideErrorHandler;
DOS_InterruptHandler SavedOverflowHandler;
DOS_InterruptHandler SavedBoundsHandler;
DOS_InterruptHandler SavedInvalidOpcodeHandler;
ResourceErrorCallback ResourceErrorDisplayCallback;
ResourceErrorCallback ResourceErrorDismissCallback;
const char ResourceCreateFileErrorText[] =
	"Could not create the file on disk...";
const char ResourceIllegalOpenModeErrorText[] =
	"Illegal MODE in Open_File...";
const char ResourceInsertDiskErrorText[] =
	"Insert disk _ in drive _: and press a key...";
const char ResourceTooManyOpenFilesErrorText[] =
	"Too many files open...";
const char ResourceCloseUnopenedErrorText[] =
	"Attempting to close unopened file...";
const char ResourceReadUnopenedErrorText[] =
	"Attempting to read unopened file...";
const char ResourceWriteUnopenedErrorText[] =
	"Attempting to write unopened file...";
const char ResourceSeekUnopenedErrorText[] =
	"Attempting to seek unopened file...";
const char ResourceIllegalSeekOriginErrorText[] =
	"Illegal starting position in Seek_File...";
const char ResourceWriteCachedErrorText[] =
	"Attempting to write a resident file...";
const char ResourceUnknownDriveErrorText[] =
	"Attempting to Find_Disk_Number on unknown file...";
const char ResourceUnknownCacheIndexErrorText[] =
	"Attempting to Get_Resident_Index on unknown file...";
const char ResourceOpenFilesAtExitErrorText[] =
	"You are exiting with open files...";

