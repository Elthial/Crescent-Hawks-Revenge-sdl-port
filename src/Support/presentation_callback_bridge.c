/* Mechanical dispatch for the original DS:24E6:24E8 far callback. */

#include "REVENGE.h"

#include "revenge/original_data.h"

void RenderActivePilotList(void);
void RenderSurvivingCommanderList(void);
void RenderFallenPilotList(void);
void RunCampaignPathSelectionCallback(void);
void RunScenarioVariantSelectionCallback(void);
void RunAlternateScenarioVariantSelectionCallback(void);

void InvokePresentationCallback(void)
{
	if (PresentationCallbackSegment != 0x0D73)
		return;

	switch (PresentationCallbackOffset)
	{
	case 0x214B: RenderActivePilotList(); break;
	case 0x223D: RenderSurvivingCommanderList(); break;
	case 0x2361: RenderFallenPilotList(); break;
	case 0x249E: RunCampaignPathSelectionCallback(); break;
	case 0x24B3: RunScenarioVariantSelectionCallback(); break;
	case 0x24C9: RunAlternateScenarioVariantSelectionCallback(); break;
	default: break;
	}
}
