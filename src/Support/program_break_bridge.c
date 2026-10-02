#include "../Original/REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/representation.h"

void *ProgramBreakBridge_GetMinimum(void)
{
	return FAR_POINTER(void,
		MinimumProgramBreakSegment, MinimumProgramBreakOffset);
}

void *ProgramBreakBridge_GetCurrent(void)
{
	return FAR_POINTER(void,
		CurrentProgramBreakSegment, CurrentProgramBreakOffset);
}

void ProgramBreakBridge_SetCurrent(void *programBreak)
{
	CurrentProgramBreakSegment = FAR_SEGMENT(programBreak);
	CurrentProgramBreakOffset = FAR_OFFSET(programBreak);
}

void *ProgramBreakBridge_GetMaximum(void)
{
	return FAR_POINTER(void,
		MaximumProgramBreakSegment, MaximumProgramBreakOffset);
}

void ProgramBreakBridge_SetMaximum(void *programBreak)
{
	MaximumProgramBreakSegment = FAR_SEGMENT(programBreak);
	MaximumProgramBreakOffset = FAR_OFFSET(programBreak);
}
