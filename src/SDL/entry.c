#include "revenge/original_data.h"
#include "revenge/platform_backend.h"
#include "revenge/debug.h"

#include "host_config.h"

#include <stdio.h>
#include <string.h>

#ifndef CHR_VERSION
#define CHR_VERSION "development"
#endif

void InitializeGame(void);
void RunCampaignLoop(void);
void ShutdownGame(void);

/*
 * Host entry shim for the preserved 2C7F:000F flow.  The Original library is
 * compiled without a DOS main so tests may provide their own entry points;
 * these five statements are the complete original main, not new game flow.
 */
int main(int argc, char **argv)
{
	if (argc == 0x02 && strcmp(argv[0x01], "--version") == 0x00)
	{
		printf("Revenge %s\n", CHR_VERSION);
		return 0x00;
	}
	if (argc != 0x01)
	{
		fputs("Usage: Revenge [--version]\n", stderr);
		return 0x02;
	}
	if (!SDLHost_ConfigureAssetDirectory())
		return 0x01;
	RevengeInstallCrashDiagnostics();
	RevengeTrace("entry: initialize\n");
	SDLBackend_InitializeDOSMemoryArena();
	ResourceFiles.preloadFiles = FALSE;
	StartupResourceState = 0x01;
	NumericKeypadNavigationEnabled = FALSE;
	InitializeGame();
	RevengeTrace("entry: initialized=%u\n", GameInitialized);
	if (GameInitialized != FALSE)
	{
		RunCampaignLoop();
	}
	RevengeTrace("entry: campaign returned; shutdown\n");
	ShutdownGame();
	RevengeTrace("entry: shutdown complete\n");
	return 0x00;
}
