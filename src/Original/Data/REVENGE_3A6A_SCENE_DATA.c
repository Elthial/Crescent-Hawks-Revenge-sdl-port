// REVENGE_3A6A_SCENE_DATA.c
// Canonical C objects for the SCENE interpreter's original DS:3A6A state.

#include "revenge/original/scene_data.h"

SceneFileBuffer LoadedSceneFile;
SceneUnitRoute SceneUnitRoutes[SCENE_ROUTE_COUNT];
word16 SceneInstructionBaseOffset;
DosAddress SceneInstructionCursor;
/* Relocated initial pointer at REVENGE.EXE DS:1554 -> DS:21D2. */
DosAddress ScenarioResourcePathPointer = { 0x21D2, 0x3A6A };
