#include "revenge/original_data.h"

#include <stdio.h>

void RunExitHandlersAndTerminate(word16 exitCode);

static byte callOrder[0x08];
static byte callCount;
static word16 capturedExitCode;

static void RecordCall(byte callId)
{
	callOrder[callCount++] = callId;
}

static void ExitHandler0(void) { RecordCall(0x01); }
static void ExitHandler1(void) { RecordCall(0x02); }
static void ExitHandler2(void) { RecordCall(0x03); }
static void RuntimeHook1(void) { RecordCall(0x04); }
static void RuntimeHook2(void) { RecordCall(0x05); }
static void RuntimeHook3(void) { RecordCall(0x06); }

void DOS_TerminateProcess(word16 exitCode)
{
	capturedExitCode = exitCode;
	RecordCall(0x07);
}

int main(void)
{
	static const byte expectedOrder[0x07] =
	{
		0x03, 0x02, 0x01, 0x04, 0x05, 0x06, 0x07
	};
	word16 index;

	ExitHandlerCount = 0x0003;
	ExitHandlerTable[0x00] = ExitHandler0;
	ExitHandlerTable[0x01] = ExitHandler1;
	ExitHandlerTable[0x02] = ExitHandler2;
	RuntimeExitHook1 = RuntimeHook1;
	RuntimeExitHook2 = RuntimeHook2;
	RuntimeExitHook3 = RuntimeHook3;

	RunExitHandlersAndTerminate(0x1234);

	if (ExitHandlerCount != 0xFFFF ||
		capturedExitCode != 0x1234 || callCount != 0x07)
	{
		fputs("exit-handler state mismatch\n", stderr);
		return 0x01;
	}
	for (index = 0x0000; index < 0x0007; ++index)
	{
		if (callOrder[index] != expectedOrder[index])
		{
			fputs("exit-handler call order mismatch\n", stderr);
			return 0x01;
		}
	}
	return 0x00;
}
