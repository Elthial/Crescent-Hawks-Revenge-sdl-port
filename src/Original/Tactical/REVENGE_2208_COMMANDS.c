// REVENGE_2208_COMMANDS.c
// Procedures preserved from REVENGE_2208_TACTICAL_INTERACTION.c.

#include "REVENGE_2208_INTERNAL.h"
#include "revenge/debug.h"

// 2208:000B: void RunTacticalUnitCommandMenu(word16 unitIndex)
// Verified against ASM 2208:000B-060C. The original eight-entry
// command table at 2208:033A dispatches values 00h-06h and Escape.
void RunTacticalUnitCommandMenu(word16 unitIndex)
{
	word16 savedWindowLeft;
	word16 savedWindowRight;
	word16 hasLanceFollowers;
	word16 menuStateChanged;
	word16 movementCommandAccepted;
	word16 exitMenu;
	byte savedLanceMapX;
	byte savedLanceMapY;
	word16 damageModel;

	TacticalMenuInputState = 0x00;
	TacticalInteractionLocked = 0x01;
	SceneUnitRoutes[0x00] = SavedTacticalRoute;
	savedLanceMapX = UnitRouteTargetMapX[0x00];
	savedLanceMapY = UnitRouteTargetMapY[0x00];
	savedWindowLeft = TacticalMenuFirstRegion;
	savedWindowRight = TacticalMenuLastRegion;
	hasLanceFollowers = FALSE;
	menuStateChanged = FALSE;
	movementCommandAccepted = FALSE;
	exitMenu = FALSE;

	if (IsCurrentLanceLeader(unitIndex) != FALSE)
	{
		hasLanceFollowers = HasActiveLanceFollowers(unitIndex);
		if (hasLanceFollowers != FALSE)
		{
			--TacticalMenuFirstRegion;
			++TacticalMenuLastRegion;
		}
	}

	damageModel = PersistentUnitRoster[unitIndex].damageModel;
	if (damageModel == UNIT_DAMAGE_MODEL_BATTLEMECH
		|| damageModel == UNIT_DAMAGE_MODEL_INFANTRY
		|| damageModel >= UNIT_DAMAGE_MODEL_OVERBURN_CAPABLE_MINIMUM)
	{
		--TacticalMenuFirstRegion;
		++TacticalMenuLastRegion;
	}

	TacticalMenuSelectedOption = 0x00;
	while (exitMenu == FALSE)
	{
		word16 selectedOption;
		word16 specialAttackAvailable = FALSE;
		int16 attackTarget;
		int16 movementHeatExponent =
			(int8)UnitMovementHeatExponent[unitIndex];

		REVENGE_PRESERVATION_TRACE(
			"tactical: command unit=%u damage=%u movement=%d raw=%02X order=%u target=%d\n",
			unitIndex, damageModel, movementHeatExponent,
			UnitMovementHeatExponent[unitIndex],
			UnitTacticalOrderMode[unitIndex],
			(int16)UnitAttackTarget[unitIndex]);

		RedrawTacticalStatusPanel();
		HideMouseCursorOverlay();
		SelectAndClearTextWindow(0x04);
		DrawActiveTextWindowBorder(0x0E);
		if (hasLanceFollowers != FALSE)
		{
			DrawCenteredTextInActiveWindow(
				TacticalUnitCommandTextTable[0x01],
				0x00, 0x05, 0x00);
		}
		else
		{
			DrawCenteredTextInActiveWindow(
				TacticalUnitCommandTextTable[0x00],
				0x00, 0x0F, 0x00);
		}

		RenderFormattedLineBreak();
		RenderFormattedText(TacticalUnitCommandTextTable[0x07]);
		/* ASM 2208:0148-0157 and 0164-0173 sign-extend AL with CBW
		 * before applying this four-byte far-pointer displacement. */
		RenderFormattedText(TacticalUnitCommandTextTable[
			PersistentUnitRoster[unitIndex].damageModel ==
				UNIT_DAMAGE_MODEL_BATTLEMECH
					? 0x04 + movementHeatExponent
					: 0x08 + movementHeatExponent]);

		RenderFormattedLineBreak();
		RenderFormattedText(TacticalUnitCommandTextTable[0x02]);
		attackTarget = UnitAttackTarget[unitIndex];
		if (attackTarget == TACTICAL_TARGET_NONE)
		{
			RenderFormattedText(NoTacticalTargetText);
		}
		else if (attackTarget < TACTICAL_TARGET_MAP_CELL)
		{
			word16 targetType =
				PersistentUnitRoster[attackTarget].unitTypeId;
			FarStringNCopy(
				(char *)SharedNumericTextBuffer,
				UnitNameTable[targetType],
				0x09);
			SharedNumericTextBuffer[0x09] = 0x00;
			RenderFormattedText(SharedNumericTextBuffer);
		}
		else
		{
			FormatTacticalMapCoordinates(
				UnitTargetMapX[unitIndex],
				UnitTargetMapY[unitIndex]);
			RenderFormattedText(SharedNumericTextBuffer);
		}

		RenderFormattedLineBreak();
		RenderFormattedText(TacticalUnitCommandTextTable[
				0x0B + UnitTacticalOrderMode[unitIndex]]);
		TacticalMenuOptionCount = 0x05;
		if (damageModel == UNIT_DAMAGE_MODEL_BATTLEMECH
			|| damageModel >= UNIT_DAMAGE_MODEL_OVERBURN_CAPABLE_MINIMUM)
		{
			RenderFormattedLineBreak();
			RenderFormattedText(TacticalOverburnTextTable[
					UnitOverburnOrCloseAssaultEnabled[unitIndex]]);
			TacticalMenuOptionCount = 0x06;
			specialAttackAvailable = TRUE;
		}
		else if (damageModel == UNIT_DAMAGE_MODEL_INFANTRY)
		{
			RenderFormattedLineBreak();
			RenderFormattedText(TacticalSupportCommandTextTable[
					0x06 + UnitOverburnOrCloseAssaultEnabled[unitIndex]]);
			TacticalMenuOptionCount = 0x06;
			specialAttackAvailable = TRUE;
		}
		if (hasLanceFollowers != FALSE)
		{
			RenderFormattedText(FormationHeading);
			DrawLanceFormationMarker(
				UnitFormationMode[unitIndex], 0x0B);
			++TacticalMenuOptionCount;
		}
		RenderFormattedLineBreak();
		RenderFormattedText(DoneText);
		ShowMouseCursorOverlay();

		selectedOption = (word16)RunOptionsMenuSelection(0x01);
		HideMouseCursorOverlay();
		switch (selectedOption)
		{
		case 0x00:
			if (SelectTacticalMoveDestination(unitIndex, 0x00) != FALSE)
			{
				menuStateChanged = TRUE;
				movementCommandAccepted = TRUE;
			}
			TacticalMenuSelectedOption =
				TacticalMenuOptionCount - 0x01;
			RefreshTacticalDisplay(FALSE);
			if (hasLanceFollowers != FALSE)
				HighlightLanceFollowers(unitIndex);
			DrawTacticalUnitControlPanel(unitIndex);
			break;

		case 0x01:
			++UnitMovementHeatExponent[unitIndex];
			if (UnitMovementHeatExponent[unitIndex] >= 0x03)
				UnitMovementHeatExponent[unitIndex] = 0x00;
			menuStateChanged = TRUE;
			break;

		case 0x02:
			if (UnitAttackTarget[unitIndex] != TACTICAL_TARGET_NONE)
			{
				UnitAttackTarget[unitIndex] = TACTICAL_TARGET_NONE;
			}
			else
			{
				ShowTacticalCommandPrompt(SelectFireTargetPrompt);
				SelectTacticalMapCoordinate(unitIndex);
				RedrawTacticalStatusPanel();
			}
			TacticalMenuSelectedOption =
				TacticalMenuOptionCount - 0x01;
			RefreshTacticalDisplay(FALSE);
			if (hasLanceFollowers != FALSE)
				HighlightLanceFollowers(unitIndex);
			DrawTacticalUnitControlPanel(unitIndex);
			menuStateChanged = TRUE;
			break;

		case 0x03:
			++UnitTacticalOrderMode[unitIndex];
			if (UnitTacticalOrderMode[unitIndex] >= 0x03)
				UnitTacticalOrderMode[unitIndex] = 0x00;
			menuStateChanged = TRUE;
			break;

		case 0x04:
			if (specialAttackAvailable != FALSE)
			{
				UnitOverburnOrCloseAssaultEnabled[unitIndex] ^= 0x01;
			}
			else if (hasLanceFollowers != FALSE)
			{
				AdvanceLanceFormation(unitIndex);
			}
			else
			{
				exitMenu = TRUE;
			}
			break;

		case 0x05:
			if (hasLanceFollowers != FALSE && specialAttackAvailable != FALSE)
				AdvanceLanceFormation(unitIndex);
			else
				exitMenu = TRUE;
			break;

		case 0x06:
		case 0x1B:
			exitMenu = TRUE;
			break;

		default:
			break;
		}
		ShowMouseCursorOverlay();
	}

	if (menuStateChanged != FALSE)
	{
		if (movementCommandAccepted != FALSE)
		{
			/* ASM 2208:0499-04AC: accepting a Move command deliberately
			 * changes Fire At Will to Fire Defensively and raises a stopped
			 * unit to walking speed.  Merely opening or dismissing this menu
			 * does not modify either setting. */
			if (UnitTacticalOrderMode[unitIndex] == 0x02)
				UnitTacticalOrderMode[unitIndex] = 0x01;
			if (UnitMovementHeatExponent[unitIndex] == 0x00)
				UnitMovementHeatExponent[unitIndex] = 0x01;
		}
		if (unitIndex < 0x04)
			UnitLanceFormationState[unitIndex] = 0x01;

		if (ValidatePrimaryLanceLeader(unitIndex) != FALSE)
		{
			word16 preserveFollowers = unitIndex == 0x00
				? FirstLanceOrdersEnabled : 0x01;
			if (preserveFollowers == FALSE && unitIndex == 0x00)
			{
				word16 followerIndex;
				for (followerIndex = 0x01; followerIndex < 0x04;
					++followerIndex)
				{
					if (UnitLanceFormationState[followerIndex] == 0x00)
					{
						UnitLanceFormationState[followerIndex] = 0x01;
						UnitConsecutiveAttackTicks[followerIndex] = 0x00;
						SceneUnitRoutes[followerIndex] =
							SavedTacticalRoute;
						UnitRouteTargetMapX[followerIndex] = savedLanceMapX;
						UnitRouteTargetMapY[followerIndex] = savedLanceMapY;
					}
				}
			}
			else
			{
				word16 followerIndex;
				word16 lanceEnd = (unitIndex + 0x04) & 0x00FC;
				for (followerIndex = unitIndex + 0x01;
					followerIndex < lanceEnd; ++followerIndex)
				{
					UnitConsecutiveAttackTicks[followerIndex] = 0x00;
					UnitLanceFormationState[followerIndex] = 0x00;
					SceneUnitRoutes[followerIndex] =
						SceneUnitRoutes[unitIndex];
					UnitRouteTargetMapX[followerIndex] =
						SceneUnitRoutes[unitIndex].waypointMapX[0x00];
					UnitRouteTargetMapY[followerIndex] =
						SceneUnitRoutes[unitIndex].waypointMapY[0x00];
				}
				SelectLanceFormationMode(unitIndex, FALSE);
			}
		}

		if (PendingNarrationDelay != 0x00)
		{
			if (unitIndex >= 0x04)
			{
				if ((unitIndex & 0x00FC) ==
					(ActiveNarrationSubject & 0x00FC) &&
					NarrationMessageCategory != 0x11)
				{
					PendingNarrationDelay = 0x00;
				}
			}
			else if (unitIndex == ActiveNarrationSubject &&
				NarrationMessageCategory != 0x11)
			{
				PendingNarrationDelay = 0x00;
			}
		}
	}

	TacticalInteractionLocked = 0x00;
	TacticalMenuFirstRegion = savedWindowLeft;
	TacticalMenuLastRegion = savedWindowRight;
	if (TacticalOverviewActive == 0x00)
		RedrawTacticalStatusPanel();
}

// 2208:148A: void RunTacticalGameOptionsMenu(void)
// Verified against ASM 2208:148A-17D4. The procedure is the tactical
// options panel, not the DropShip-control abstraction retained in Rejected.
void RunTacticalGameOptionsMenu(void)
{
	word16 exitMenu = FALSE;
	word16 unitIndex;

	TacticalInteractionLocked = 0x01;
	TacticalMenuInputState = 0x00;
	TacticalCursorOutlineEnabled = 0x00;
	for (unitIndex = 0x00; unitIndex < 0x08; ++unitIndex)
		TacticalStatusRowInvalidation[unitIndex] = 0xFF;

	RefreshTacticalDisplay(FALSE);
	TacticalUiSuppressed = TRUE;
	TacticalCursorOutlineEnabled = TRUE;

	while (exitMenu == FALSE)
	{
		int16 selectedOption;

		RedrawTacticalStatusPanel();
		HideMouseCursorOverlay();
		SelectAndClearTextWindow(0x07);
		DrawActiveTextWindowBorder(0x0E);
		DrawTacticalCellOutline(0x00, 0x00B0, 0x05);
		DrawCenteredTextInActiveWindow(
			TacticalUnitCommandTextTable[0x00],
			0x00,
			0x0F,
			0x00);
		RenderFormattedLineBreak();
		RenderFormattedText(IntelligenceHeading);

		if (ArtilleryShellingActive != 0x00)
		{
			RenderFormattedText(TacticalSupportCommandTextTable[0x01]);
		}
		else
		{
			if (ArtillerySupportAvailable == 0x00)
				ActiveTextForegroundColor = 0x0D;
			RenderFormattedText(TacticalSupportCommandTextTable[0x00]);
			ActiveTextForegroundColor = 0x0F;
		}

		RenderFormattedLineBreak();
		if (RollingBarrageActive != 0x00)
		{
			RenderFormattedText(TacticalSupportCommandTextTable[0x03]);
		}
		else
		{
			if (ArtillerySupportAvailable == 0x00)
				ActiveTextForegroundColor = 0x0D;
			RenderFormattedText(TacticalSupportCommandTextTable[0x02]);
			ActiveTextForegroundColor = 0x0F;
		}

		RenderFormattedLineBreak();
		if (StrafingRunActive != 0x00)
		{
			RenderFormattedText(TacticalSupportCommandTextTable[0x05]);
		}
		else
		{
			if (StrafingSupportAvailable == 0x00)
				ActiveTextForegroundColor = 0x0D;
			RenderFormattedText(TacticalSupportCommandTextTable[0x04]);
			ActiveTextForegroundColor = 0x0F;
		}

		DrawTileAlignedText(
			(char *)ViewSatelliteMapText,
			ActiveTextWindowLeftTile,
			ActiveTextWindowTopTile + 0x05,
			0x0F,
			0x00);
		DrawTileAlignedText(
			(char *)DoneText,
			ActiveTextWindowLeftTile,
			ActiveTextWindowTopTile + 0x06,
			0x0F,
			0x00);
		ShowMouseCursorOverlay();

		selectedOption = RunOptionsMenuSelection(0x02);
		switch (selectedOption)
		{
		case 0x00:
			DisplayDropShipIntelligence();
			HideMouseCursorOverlay();
			RebuildTacticalViewport();
			ShowMouseCursorOverlay();
			break;

		case 0x01:
			if (ArtilleryShellingActive != 0x00)
			{
				ArtilleryShellingActive = 0x00;
			}
			else if (ArtillerySupportAvailable != 0x00)
			{
				ShowTacticalCommandPrompt(SelectArtilleryTargetPrompt);
				SelectTacticalMapCoordinate(0x18);
				TacticalCursorOutlineEnabled = FALSE;
				RefreshTacticalDisplay(FALSE);
				TacticalCursorOutlineEnabled = TRUE;
				RollingBarrageActive = 0x00;
				ArtilleryShellingActive = 0x01;
				ArtilleryTargetMapX = UnitTargetMapX[0x18];
				ArtilleryTargetMapY = UnitTargetMapY[0x18];
			}
			break;

		case 0x02:
			if (RollingBarrageActive != 0x00)
			{
				RollingBarrageActive = 0x00;
			}
			else if (ArtillerySupportAvailable != 0x00)
			{
				ShowTacticalCommandPrompt(SelectBarrageStartPrompt);
				SelectTacticalMapCoordinate(0x18);
				ArtilleryShellingActive = 0x00;
				RollingBarrageActive = 0x01;
				DropShipMapX = UnitTargetMapX[0x18];
				RollingBarrageStartMapX = UnitTargetMapX[0x18];
				ArtilleryTargetMapX = UnitTargetMapX[0x18];
				DropShipMapY = UnitTargetMapY[0x18];
				RollingBarrageStartMapY = UnitTargetMapY[0x18];
				ArtilleryTargetMapY = UnitTargetMapY[0x18];
				ShowTacticalCommandPrompt(SelectBarrageEndPrompt);
				SelectTacticalMoveDestinationInput(0x18, 0x00);
				RollingBarrageEndMapX = UnitRouteTargetMapX[0x18];
				RollingBarrageEndMapY = UnitRouteTargetMapY[0x18];
				TacticalCursorOutlineEnabled = FALSE;
				RefreshTacticalDisplay(FALSE);
				TacticalCursorOutlineEnabled = TRUE;
			}
			break;

		case 0x03:
			if (StrafingRunActive != 0x00)
			{
				StrafingRunActive = 0x00;
			}
			else if (StrafingSupportAvailable != 0x00)
			{
				ShowTacticalCommandPrompt(SelectStrafingAreaPrompt);
				StrafingRunActive = 0x01;
				SelectStrafingArea();
				TacticalCursorOutlineEnabled = FALSE;
				RefreshTacticalDisplay(FALSE);
				TacticalCursorOutlineEnabled = TRUE;
			}
			break;

		case 0x04:
			EnterTacticalOverview();
			if (TacticalOverviewActive != 0x00)
			{
				exitMenu = TRUE;
			}
			else
			{
				HideMouseCursorOverlay();
				RebuildTacticalViewport();
				ShowMouseCursorOverlay();
			}
			break;

		case 0x05:
		case 0x1B:
			exitMenu = TRUE;
			break;

		default:
			break;
		}
	}

	if (TacticalOverviewActive == 0x00)
		RedrawTacticalStatusPanel();
	TacticalUiSuppressed = FALSE;
	TacticalInteractionLocked = 0x00;
}

