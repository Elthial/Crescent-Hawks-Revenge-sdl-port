// Reconstructed original exit-handler dispatcher (segment 38C6).

#include "REVENGE.h"
#include "revenge/original_data.h"

void DOS_TerminateProcess(word16 exitCode);

// 38C6:0010: void RunExitHandlersAndTerminate(word16 exitCode)
// Called from:
//      PrintAllocationErrorAndExit
//      ShowInvalidSaveVersionDialog
//      ShutdownAndExit
void RunExitHandlersAndTerminate(word16 exitCode)
{
	word16 previousHandlerCount;

	do
	{
		previousHandlerCount = ExitHandlerCount;
		--ExitHandlerCount;
		if (previousHandlerCount != 0x00)
			ExitHandlerTable[ExitHandlerCount]();
	}
	while (previousHandlerCount != 0x00);

	RuntimeExitHook1();
	RuntimeExitHook2();
	RuntimeExitHook3();
	DOS_TerminateProcess(exitCode);
}
