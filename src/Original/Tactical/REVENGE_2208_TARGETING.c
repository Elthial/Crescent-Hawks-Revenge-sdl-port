// REVENGE_2208_TARGETING.c
// Procedures preserved from REVENGE_2208_TACTICAL_INTERACTION.c.

#include "REVENGE_2208_INTERNAL.h"

// 2208:060D
void SelectTacticalMapCoordinate(word16 unitIndex)
{
	word16 savedSelectedUnit;
	word16 savedCursorColumn;
	word16 savedViewportX;
	word16 savedViewportY;
	word16 savedCursorX;
	word16 savedCursorY;
	word16 cursorMapX;
	word16 cursorMapY;
	byte savedAttackTarget;
	byte savedTargetMapX;
	byte savedTargetMapY;
	int16 inputAction;
	int16 maximumViewportX;
	int16 maximumViewportY;

	HideMouseCursorOverlay();
	savedViewportX = TacticalViewportMapX;
	savedViewportY = TacticalViewportMapY;
	savedCursorX = TacticalCursorViewportX;
	savedCursorY = TacticalCursorViewportY;
	cursorMapX = savedViewportX + savedCursorX;
	cursorMapY = savedViewportY + savedCursorY;

	TacticalViewportMapX += savedCursorX - 0x0A;
	if ((int16)savedCursorX < 0x0A
		&& (int16)TacticalViewportMapX >= 0x00)
	{
		TacticalCursorViewportX = 0x0A;
	}
	if ((int16)savedCursorX > 0x0A
		&& (int16)(MapWidth - 0x13)
			>= (int16)TacticalViewportMapX)
	{
		TacticalCursorViewportX = 0x0A;
	}
	maximumViewportX = (int16)MapWidth - 0x13;
	if ((int16)TacticalViewportMapX < 0x00)
		TacticalViewportMapX = 0x00;
	if (maximumViewportX <= (int16)TacticalViewportMapX)
		TacticalViewportMapX = (word16)maximumViewportX;

	TacticalViewportMapY += savedCursorY - 0x06;
	if ((int16)savedCursorY < 0x06
		&& (int16)TacticalViewportMapY >= 0x00)
	{
		TacticalCursorViewportY = 0x06;
	}
	if ((int16)savedCursorY > 0x06
		&& (int16)(MapHeight - 0x0C)
			>= (int16)TacticalViewportMapY)
	{
		TacticalCursorViewportY = 0x06;
	}
	maximumViewportY = (int16)MapHeight - 0x0C;
	if ((int16)TacticalViewportMapY < 0x00)
		TacticalViewportMapY = 0x00;
	if (maximumViewportY <= (int16)TacticalViewportMapY)
		TacticalViewportMapY = (word16)maximumViewportY;

	TacticalCursorViewportX =
		cursorMapX - TacticalViewportMapX;
	TacticalCursorViewportY =
		cursorMapY - TacticalViewportMapY;
	if ((int16)TacticalCursorViewportX < 0x00)
		TacticalCursorViewportX = 0x00;
	if ((int16)TacticalCursorViewportX >= 0x13)
		TacticalCursorViewportX = 0x12;
	if ((int16)TacticalCursorViewportY < 0x00)
		TacticalCursorViewportY = 0x00;
	if ((int16)TacticalCursorViewportY >= 0x0C)
		TacticalCursorViewportY = 0x0B;

	savedSelectedUnit = TacticalSelectedUnitIndex;
	TacticalSelectedUnitIndex = 0xFFFF;
	savedCursorColumn = ActiveTextCursorColumn;
	savedAttackTarget = UnitAttackTarget[unitIndex];
	savedTargetMapX = UnitTargetMapX[unitIndex];
	savedTargetMapY = UnitTargetMapY[unitIndex];

	do
	{
		RefreshTacticalCoordinateSelection(
			unitIndex, 0x00, savedCursorColumn);
		inputAction = 0x00;
		if (ServiceMusicAndCheckKeyboardInput() != FALSE)
		{
			inputAction = ReadTranslatedKeypress();
			while (ServiceMusicAndCheckKeyboardInput() != FALSE)
				(void)ReadTranslatedKeypress();
		}
		inputAction = NormalizeNavigationKeyCode(
			TranslateTacticalMouseInput(inputAction));

		switch (inputAction)
		{
		case (int16)(KEY_PAGE_DOWN - 0x0100):
		case (int16)(KEY_DOWN - 0x0100):
		case (int16)(KEY_END - 0x0100):
		case (int16)(KEY_RIGHT - 0x0100):
		case (int16)(KEY_LEFT - 0x0100):
		case (int16)(KEY_PAGE_UP - 0x0100):
		case (int16)(KEY_UP - 0x0100):
		case (int16)(KEY_HOME - 0x0100):
			MoveTacticalCursorByInput(inputAction);
			break;

		case (int16)(KEY_F9 - 0x0100):
		case '+':
			if (unitIndex < 0x0C)
				CycleTacticalEnemyTarget();
			break;
		}
	} while (inputAction != KEY_ESCAPE
		&& inputAction != KEY_SPACE
		&& inputAction != KEY_CARRIAGE_RETURN);

	if (inputAction == KEY_ESCAPE)
	{
		UnitAttackTarget[unitIndex] = savedAttackTarget;
		UnitTargetMapX[unitIndex] = savedTargetMapX;
		UnitTargetMapY[unitIndex] = savedTargetMapY;
	}
	TacticalSelectedUnitIndex = savedSelectedUnit;
	TacticalViewportMapX = savedViewportX;
	TacticalViewportMapY = savedViewportY;
	TacticalCursorViewportX = savedCursorX;
	TacticalCursorViewportY = savedCursorY;
	ShowMouseCursorOverlay();
}

// 2208:0857: rebuild the tactical viewport while the player selects an attack
// coordinate or movement route, draw the appropriate cursor/route overlays,
// and refresh the coordinate or contact text at the saved text column.
void RefreshTacticalCoordinateSelection(
	word16 unitIndex,
	word16 selectionMode,
	word16 savedCursorColumn)
{
	word16 savedCursorMapX;
	word16 savedCursorMapY;
	word16 savedUnitMapX;
	word16 savedUnitMapY;
	word16 previousRouteX;
	word16 previousRouteY;
	word16 routeX;
	word16 routeY;
	int16 routeIndex;
	word16 targetFound;
	word16 enemyUnitIndex;
	word16 cursorColorPhase;
	int16 maximumViewportX;
	int16 maximumViewportY;
	SceneUnitRoute *route;
	RevengeUnitRecord *unitRecord;

	if (TacticalCursorAutoScroll != FALSE)
	{
		ScrollTacticalViewportToCursor();
	}
	else
	{
		TacticalViewportMapX +=
			TacticalCursorViewportX - 0x0A;
		if ((int16) TacticalCursorViewportX < 0x0A
			&& (int16) TacticalViewportMapX >= 0x00)
			TacticalCursorViewportX = 0x0A;
		if ((int16) TacticalCursorViewportX > 0x0A
			&& (int16) (MapWidth - 0x13)
				>= (int16) TacticalViewportMapX)
			TacticalCursorViewportX = 0x0A;
		maximumViewportX = (int16) MapWidth - 0x13;
		if ((int16) TacticalViewportMapX < 0x00)
			TacticalViewportMapX = 0x00;
		if (maximumViewportX <= (int16) TacticalViewportMapX)
			TacticalViewportMapX = (word16) maximumViewportX;

		TacticalViewportMapY +=
			TacticalCursorViewportY - 0x06;
		if ((int16) TacticalCursorViewportY < 0x06
			&& (int16) TacticalViewportMapY >= 0x00)
			TacticalCursorViewportY = 0x06;
		if ((int16) TacticalCursorViewportY > 0x06
			&& (int16) (MapHeight - 0x0C)
				>= (int16) TacticalViewportMapY)
			TacticalCursorViewportY = 0x06;
		maximumViewportY = (int16) MapHeight - 0x0C;
		if ((int16) TacticalViewportMapY < 0x00)
			TacticalViewportMapY = 0x00;
		if (maximumViewportY <= (int16) TacticalViewportMapY)
			TacticalViewportMapY = (word16) maximumViewportY;

		if ((int16) TacticalCursorViewportX < 0x00)
			TacticalCursorViewportX = 0x00;
		if ((int16) TacticalCursorViewportX >= 0x13)
			TacticalCursorViewportX = 0x12;
		if ((int16) TacticalCursorViewportY < 0x00)
			TacticalCursorViewportY = 0x00;
		if ((int16) TacticalCursorViewportY >= 0x0C)
			TacticalCursorViewportY = 0x0B;
	}

	RebuildTacticalViewport();
	cursorColorPhase = GameAnimationTicks & 0x0008;
	route = &SceneUnitRoutes[unitIndex];

	if (selectionMode != FALSE)
	{
		savedCursorMapX = TacticalCursorViewportX
			+ TacticalViewportMapX;
		savedCursorMapY = TacticalCursorViewportY
			+ TacticalViewportMapY;
		UnitRouteTargetMapX[unitIndex] = (byte) savedCursorMapX;
		UnitRouteTargetMapY[unitIndex] = (byte) savedCursorMapY;

		TacticalCursorViewportX =
			ScenarioUnitMapX[unitIndex]
			- TacticalViewportMapX;
		TacticalCursorViewportY =
			ScenarioUnitMapY[unitIndex]
			- TacticalViewportMapY;
		if ((int16) TacticalCursorViewportX >= 0x00
			&& (int16) TacticalCursorViewportX < 0x13
			&& (int16) TacticalCursorViewportY >= 0x00
			&& (int16) TacticalCursorViewportY < 0x0C)
		{
			DrawTacticalCursorOutline(
				cursorColorPhase != FALSE ? 0x0F : 0x0C);
		}

		for (routeIndex = 0x0000;
			routeIndex <= route->waypointIndex;
			++routeIndex)
		{
			TacticalCursorViewportX =
				route->waypointMapX[routeIndex]
				- TacticalViewportMapX;
			TacticalCursorViewportY =
				route->waypointMapY[routeIndex]
				- TacticalViewportMapY;
			if ((int16) TacticalCursorViewportX >= 0x00
				&& (int16) TacticalCursorViewportX < 0x13
				&& (int16) TacticalCursorViewportY >= 0x00
				&& (int16) TacticalCursorViewportY < 0x0C)
			{
				DrawTacticalCursorOutline(
					cursorColorPhase != FALSE ? 0x0E : 0x0D);
			}
		}
		TacticalCursorViewportX =
			savedCursorMapX - TacticalViewportMapX;
		TacticalCursorViewportY =
			savedCursorMapY - TacticalViewportMapY;
	}
	else
	{
		UnitTargetMapX[unitIndex] = (byte)
			(TacticalCursorViewportX
				+ TacticalViewportMapX);
		UnitTargetMapY[unitIndex] = (byte)
			(TacticalCursorViewportY
				+ TacticalViewportMapY);
		if ((int16) TacticalCursorViewportX >= 0x00
			&& (int16) TacticalCursorViewportX < 0x13
			&& (int16) TacticalCursorViewportY >= 0x00
			&& (int16) TacticalCursorViewportY < 0x0C)
		{
			DrawTacticalCursorOutline(
				cursorColorPhase != FALSE ? 0x08 : 0x05);
		}
	}

	HideMouseCursorOverlay();
	if (selectionMode == FALSE)
	{
		targetFound = TRUE;
		UnitTacticalTarget[unitIndex] = TACTICAL_TARGET_NONE;
		if (TacticalCellSpriteMap[
			TacticalCursorViewportY * 0x13
				+ TacticalCursorViewportX] != 0x0000)
		{
			for (enemyUnitIndex = 0x000C;
				enemyUnitIndex < 0x0018;
				++enemyUnitIndex)
			{
				unitRecord = &PersistentUnitRoster[enemyUnitIndex];
				if (unitRecord->deploymentState != FALSE
					&& ScenarioUnitMapX[enemyUnitIndex]
						== TacticalViewportMapX
							+ TacticalCursorViewportX
					&& ScenarioUnitMapY[enemyUnitIndex]
						== TacticalViewportMapY
							+ TacticalCursorViewportY)
				{
					targetFound = FALSE;
					UnitAttackTarget[unitIndex] =
						(byte) enemyUnitIndex;
					UnitTacticalTarget[unitIndex] =
						(byte) enemyUnitIndex;
					enemyUnitIndex = 0x0018;
				}
			}
		}
		if (unitIndex == 0x0018)
			targetFound = TRUE;

		ActiveTextCursorColumn = savedCursorColumn;
		ActiveTextCursorRow = 0x0000;
		if (targetFound != FALSE)
		{
			FormatTacticalMapCoordinates(
				UnitTargetMapX[unitIndex],
				UnitTargetMapY[unitIndex]);
			RenderFormattedText(SharedNumericTextBuffer);
			ActiveTextBackgroundColor = 0x000C;
			ActiveTextForegroundColor = 0x000C;
			while (ActiveTextCursorColumn < 0x0026)
				RenderFormattedText(TacticalPaddingSpace);
			ActiveTextForegroundColor = 0x000F;
			UnitTacticalTarget[unitIndex] = TACTICAL_TARGET_MAP_CELL;
			UnitAttackTarget[unitIndex] = TACTICAL_TARGET_MAP_CELL;
		}
		else
		{
			enemyUnitIndex = UnitTacticalTarget[unitIndex];
			ActiveTextForegroundColor = 0x0008;
			unitRecord = &PersistentUnitRoster[enemyUnitIndex];
			RenderFormattedText(UnitNameTable[
				unitRecord->unitTypeId]);
			RenderFormattedText(TacticalStatusSeparator);
			FormatUnitDurabilityPercentage(enemyUnitIndex);
			RenderFormattedText(SharedNumericTextBuffer);
			ActiveTextBackgroundColor = 0x000C;
			ActiveTextForegroundColor = 0x000C;
			while (ActiveTextCursorColumn < 0x0026)
				RenderFormattedText(TacticalStatusPadding);
			ActiveTextForegroundColor = 0x000F;
		}
	}
	else
	{
		ActiveTextCursorColumn = savedCursorColumn;
		ActiveTextCursorRow = 0x0000;
		FormatTacticalMapCoordinates(
			TacticalCursorViewportX
				+ TacticalViewportMapX,
			TacticalCursorViewportY
				+ TacticalViewportMapY);
		RenderFormattedText(SharedNumericTextBuffer);

		savedCursorMapX = TacticalCursorViewportX;
		savedCursorMapY = TacticalCursorViewportY;
		savedUnitMapX = ScenarioUnitMapX[unitIndex];
		savedUnitMapY = ScenarioUnitMapY[unitIndex];
		previousRouteX = savedUnitMapX;
		previousRouteY = savedUnitMapY;
		for (routeIndex = 0x0000;
			routeIndex <= route->waypointIndex;
			++routeIndex)
		{
			ScenarioUnitMapX[unitIndex] = (byte) previousRouteX;
			ScenarioUnitMapY[unitIndex] = (byte) previousRouteY;
			routeX = route->waypointMapX[routeIndex];
			routeY = route->waypointMapY[routeIndex];
			if (ScenarioUnitMapX[unitIndex] != routeX
				|| ScenarioUnitMapY[unitIndex] != routeY)
			{
				DrawWeaponAttackTrace(
					unitIndex, routeX, routeY, 0x0001, 0x0001, 0x0000);
			}
			previousRouteX = routeX;
			previousRouteY = routeY;
		}
		TacticalCursorViewportX = savedCursorMapX;
		TacticalCursorViewportY = savedCursorMapY;
		ScenarioUnitMapX[unitIndex] = (byte) savedUnitMapX;
		ScenarioUnitMapY[unitIndex] = (byte) savedUnitMapY;
	}
	ShowMouseCursorOverlay();
}

// 2208:0DA1: cycle F9/'+' targeting through the twelve opposing tactical
// slots. Only deployed, currently visible or proximate contacts qualify; the
// first qualifying slot in cyclic unit order is focused.
void CycleTacticalEnemyTarget(void)
{
	int16 selectedTarget;
	word16 firstCandidate;
	word16 candidateOffset;
	word16 candidateUnit;
	word16 contactKnown;
	word16 followsCursor;
	word16 cursorMapX;
	word16 cursorMapY;
	RevengeUnitRecord *unitRecord;

	selectedTarget = -0x01;
	firstCandidate = TacticalSelectedUnitIndex + 0x0001;
	if ((int16) firstCandidate < 0x0C)
		firstCandidate = 0x0C;
	if ((int16) firstCandidate > 0x17)
		firstCandidate = 0x18;

	// The executable uses the cursor-Y word in both comparisons here.
	cursorMapX = TacticalViewportMapX
		+ TacticalCursorViewportY;
	cursorMapY = TacticalViewportMapY
		+ TacticalCursorViewportY;

	for (candidateOffset = 0x0000;
		candidateOffset < 0x000C;
		++candidateOffset)
	{
		candidateUnit = firstCandidate + candidateOffset;
		while ((int16) candidateUnit >= 0x18)
			candidateUnit -= 0x0C;

		unitRecord = &PersistentUnitRoster[candidateUnit];
		if (unitRecord->deploymentState == FALSE)
			continue;

		(void) UpdateUnitEnemyProximityState(candidateUnit);
		(void) UpdateUnitEnemyVisibility(candidateUnit);
		contactKnown = UnitEnemyInProximityRange[candidateUnit]
			| UnitEnemyVisible[candidateUnit];
		if (contactKnown == FALSE)
			continue;

		if (selectedTarget == -0x01)
			selectedTarget = (int16) candidateUnit;

		followsCursor = FALSE;
		if (ScenarioUnitMapY[candidateUnit] > cursorMapY)
			followsCursor = TRUE;
		else if (ScenarioUnitMapY[candidateUnit] == cursorMapY
			&& ScenarioUnitMapX[candidateUnit] > cursorMapX)
		{
			followsCursor = TRUE;
		}

		if (followsCursor != FALSE && selectedTarget != -0x01)
		{
			if (ScenarioUnitMapY[candidateUnit]
				< ScenarioUnitMapY[selectedTarget])
			{
				selectedTarget = (int16) candidateUnit;
			}
			else if (ScenarioUnitMapY[candidateUnit]
				== ScenarioUnitMapY[selectedTarget]
				&& ScenarioUnitMapX[candidateUnit]
				< ScenarioUnitMapX[selectedTarget])
			{
				selectedTarget = (int16) candidateUnit;
			}
		}

		if (selectedTarget != -0x01)
		{
			FocusTacticalViewOnUnit((word16) selectedTarget);
			break;
		}
	}
}

// 2208:0EBC
word16 SelectTacticalMoveDestinationInput(
	word16 unitIndex,
	word16 mode)
{
	word16 selectionAccepted;
	word16 savedSelectedUnit;
	word16 savedCursorColumn;
	word16 savedViewportX;
	word16 savedViewportY;
	word16 savedCursorX;
	word16 savedCursorY;
	word16 cursorMapX;
	word16 cursorMapY;
	word16 routeIndex;
	word16 remainingPoints;
	byte savedUnitMapX;
	byte savedUnitMapY;
	SceneUnitRoute *route;
	int16 inputAction;
	int16 maximumViewportX;
	int16 maximumViewportY;

	HideMouseCursorOverlay();
	savedViewportX = TacticalViewportMapX;
	savedViewportY = TacticalViewportMapY;
	savedCursorX = TacticalCursorViewportX;
	savedCursorY = TacticalCursorViewportY;
	cursorMapX = savedViewportX + savedCursorX;
	cursorMapY = savedViewportY + savedCursorY;

	TacticalViewportMapX += savedCursorX - 0x0A;
	if ((int16)savedCursorX < 0x0A
		&& (int16)TacticalViewportMapX >= 0x00)
	{
		TacticalCursorViewportX = 0x0A;
	}
	if ((int16)savedCursorX > 0x0A
		&& (int16)(MapWidth - 0x13)
			>= (int16)TacticalViewportMapX)
	{
		TacticalCursorViewportX = 0x0A;
	}
	maximumViewportX = (int16)MapWidth - 0x13;
	if ((int16)TacticalViewportMapX < 0x00)
		TacticalViewportMapX = 0x00;
	if (maximumViewportX <= (int16)TacticalViewportMapX)
		TacticalViewportMapX = (word16)maximumViewportX;

	TacticalViewportMapY += savedCursorY - 0x06;
	if ((int16)savedCursorY < 0x06
		&& (int16)TacticalViewportMapY >= 0x00)
	{
		TacticalCursorViewportY = 0x06;
	}
	if ((int16)savedCursorY > 0x06
		&& (int16)(MapHeight - 0x0C)
			>= (int16)TacticalViewportMapY)
	{
		TacticalCursorViewportY = 0x06;
	}
	maximumViewportY = (int16)MapHeight - 0x0C;
	if ((int16)TacticalViewportMapY < 0x00)
		TacticalViewportMapY = 0x00;
	if (maximumViewportY <= (int16)TacticalViewportMapY)
		TacticalViewportMapY = (word16)maximumViewportY;

	TacticalCursorViewportX =
		cursorMapX - TacticalViewportMapX;
	TacticalCursorViewportY =
		cursorMapY - TacticalViewportMapY;
	if ((int16)TacticalCursorViewportX < 0x00)
		TacticalCursorViewportX = 0x00;
	if ((int16)TacticalCursorViewportX >= 0x13)
		TacticalCursorViewportX = 0x12;
	if ((int16)TacticalCursorViewportY < 0x00)
		TacticalCursorViewportY = 0x00;
	if ((int16)TacticalCursorViewportY >= 0x0C)
		TacticalCursorViewportY = 0x0B;

	selectionAccepted = TRUE;
	savedSelectedUnit = TacticalSelectedUnitIndex;
	TacticalSelectedUnitIndex = 0xFFFF;
	remainingPoints = unitIndex == 0x18 ? 0x01 : 0x04;
	route = &SceneUnitRoutes[unitIndex];
	*route = SavedTacticalRoute;
	savedUnitMapX = UnitRouteTargetMapX[unitIndex];
	savedUnitMapY = UnitRouteTargetMapY[unitIndex];
	route->waypointIndex = 0x00;
	savedCursorColumn = ActiveTextCursorColumn;
	inputAction = (int16)mode;

	while (remainingPoints-- != 0x00)
	{
		while (inputAction != KEY_SPACE
			&& inputAction != KEY_CARRIAGE_RETURN
			&& inputAction != KEY_ESCAPE)
		{
			switch (inputAction)
			{
			case (int16)(KEY_PAGE_DOWN - 0x0100):
			case (int16)(KEY_DOWN - 0x0100):
			case (int16)(KEY_END - 0x0100):
			case (int16)(KEY_RIGHT - 0x0100):
			case (int16)(KEY_LEFT - 0x0100):
			case (int16)(KEY_PAGE_UP - 0x0100):
			case (int16)(KEY_UP - 0x0100):
			case (int16)(KEY_HOME - 0x0100):
				MoveTacticalCursorByInput(inputAction);
				break;
			}

			/* The original word-sized additions wrap before the signed and
			 * unsigned bounds checks.  Retain those 16-bit intermediates:
			 * ordinary C integer promotion would interpret cursor -1 as 65535
			 * and incorrectly snap it to the opposite map edge. */
			cursorMapX = (word16)(TacticalCursorViewportX
				+ TacticalViewportMapX);
			cursorMapY = (word16)(TacticalCursorViewportY
				+ TacticalViewportMapY);
			if ((int16)cursorMapX < 0x00)
			{
				TacticalViewportMapX = 0x00;
				TacticalCursorViewportX = 0x00;
			}
			if ((int16)cursorMapY < 0x00)
			{
				TacticalViewportMapY = 0x00;
				TacticalCursorViewportY = 0x00;
			}
			cursorMapX = (word16)(TacticalCursorViewportX
				+ TacticalViewportMapX);
			cursorMapY = (word16)(TacticalCursorViewportY
				+ TacticalViewportMapY);
			if (cursorMapX >= MapWidth)
			{
				TacticalCursorViewportX =
					MapWidth - 0x01
					- TacticalViewportMapX;
			}
			if (cursorMapY >= MapHeight)
			{
				TacticalCursorViewportY =
					MapHeight - 0x01
					- TacticalViewportMapY;
			}

			route->waypointMapX[route->waypointIndex] = (byte)(
				TacticalCursorViewportX
				+ TacticalViewportMapX);
			route->waypointMapY[route->waypointIndex] = (byte)(
				TacticalCursorViewportY
				+ TacticalViewportMapY);
			UnitRouteTargetMapX[unitIndex] =
				route->waypointMapX[route->waypointIndex];
			UnitRouteTargetMapY[unitIndex] =
				route->waypointMapY[route->waypointIndex];
			RefreshTacticalCoordinateSelection(
				unitIndex, 0x01, savedCursorColumn);

			inputAction = 0x00;
			if (ServiceMusicAndCheckKeyboardInput() != FALSE)
			{
				inputAction = ReadTranslatedKeypress();
				while (ServiceMusicAndCheckKeyboardInput() != FALSE)
					(void)ReadTranslatedKeypress();
			}
			inputAction = NormalizeNavigationKeyCode(
				TranslateTacticalMouseInput(inputAction));
			if ((inputAction == KEY_SPACE
					|| inputAction == KEY_CARRIAGE_RETURN)
				&& route->waypointIndex == 0x00
				&& UnitRouteTargetMapX[unitIndex]
					== ScenarioUnitMapX[unitIndex]
				&& UnitRouteTargetMapY[unitIndex]
					== ScenarioUnitMapY[unitIndex])
			{
				inputAction = 'A';
			}
		}

		if (inputAction != KEY_ESCAPE
			&& route->waypointIndex > 0x00
			&& route->waypointIndex < 0x03)
		{
			routeIndex = route->waypointIndex;
			if (route->waypointMapX[routeIndex - 0x01] ==
				route->waypointMapX[routeIndex]
				&& route->waypointMapY[routeIndex - 0x01] ==
				route->waypointMapY[routeIndex])
			{
				while (++routeIndex < 0x04)
				{
					route->waypointMapX[routeIndex] =
						route->waypointMapX[routeIndex - 0x01];
					route->waypointMapY[routeIndex] =
						route->waypointMapY[routeIndex - 0x01];
				}
				remainingPoints = 0x00;
			}
		}
		if (inputAction != KEY_ESCAPE)
		{
			++route->waypointIndex;
			inputAction = 0x00;
		}
	}

	if (inputAction == KEY_ESCAPE)
	{
		*route = SavedTacticalRoute;
		UnitRouteTargetMapX[unitIndex] = savedUnitMapX;
		UnitRouteTargetMapY[unitIndex] = savedUnitMapY;
		selectionAccepted = FALSE;
	}
	else
	{
		route->waypointIndex = 0x00;
		route->activeMapX = ScenarioUnitMapX[unitIndex];
		route->activeMapY = ScenarioUnitMapY[unitIndex];
		UnitRouteTargetMapX[unitIndex] = route->waypointMapX[0x00];
		UnitRouteTargetMapY[unitIndex] = route->waypointMapY[0x00];
		if (unitIndex == 0x18)
		{
			route->waypointMapX[0x03] = UnitRouteTargetMapX[unitIndex];
			route->waypointMapY[0x03] = UnitRouteTargetMapY[unitIndex];
			route->waypointIndex = 0x03;
		}
	}

	TacticalSelectedUnitIndex = savedSelectedUnit;
	TacticalViewportMapX = savedViewportX;
	TacticalViewportMapY = savedViewportY;
	TacticalCursorViewportX = savedCursorX;
	TacticalCursorViewportY = savedCursorY;
	ShowMouseCursorOverlay();
	return selectionAccepted;
}

// 2208:1F0C
void DisplayDropShipIntelligence(void)
{
	word16 unitIndex;
	word16 left;
	word16 right;
	word16 firstLineY;
	word16 secondLineY;

	HideMouseCursorOverlay();
	SelectAndClearTextWindow(0x08);
	DrawActiveTextWindowBorder(0x0E);

	left = ActiveTextWindowLeftTile << 0x03;
	right = ((ActiveTextWindowLeftTile
		+ ActiveTextWindowWidthTiles) << 0x03) - 0x01;
	firstLineY = (ActiveTextWindowTopTile << 0x03) + 0x07;
	secondLineY = ((ActiveTextWindowTopTile + 0x07) << 0x03)
		+ 0x04;
	DrawClippedAxisAlignedLine(left, firstLineY, right, firstLineY, 0x0D);
	DrawClippedAxisAlignedLine(left, secondLineY, right, secondLineY, 0x0D);
	DrawCenteredTextInActiveWindow(
		IntelligenceHeading,
		0x00,
		0x0F,
		0x00);

	for (unitIndex = 0x0C; unitIndex < 0x18; ++unitIndex)
	{
		(void)UpdateUnitEnemyVisibility(unitIndex);
		(void)UpdateUnitEnemyProximityState(unitIndex);
	}

	ActiveTextCursorColumn = 0x00;
	ActiveTextCursorRow = 0x02;
	RenderFormattedText(EnemyAndFriendlyLancesText);

	ActiveTextCursorColumn = 0x00;
	ActiveTextCursorRow = 0x03;
	for (unitIndex = 0x0C; unitIndex < 0x18; unitIndex += 0x04)
		RenderLanceIntelligenceSummary(unitIndex);

	ActiveTextCursorColumn = 0x00;
	ActiveTextCursorRow = 0x09;
	for (unitIndex = 0x00; unitIndex < 0x0C; unitIndex += 0x04)
		RenderLanceIntelligenceSummary(unitIndex);

	ShowMouseCursorOverlay();
	(void)WaitForDismissInput();
}

// 2208:203B: render one four-unit lance row in the DropShip intelligence
// window, including its readiness label, first known member position,
// formation marker, facing, and movement vector.
void RenderLanceIntelligenceSummary(word16 firstUnitIndex)
{
	word16 fallbackLanceState;
	word16 hasContact;
	word16 hasEngagement;
	word16 lanceLabelIndex;
	word16 totalRating;
	word16 hasDeployedUnit;
	word16 memberOffset;
	word16 firstDeployedMemberOffset;
	word16 selectedUnitIndex;
	RevengeUnitRecord *unitRecord;

	fallbackLanceState = FALSE;
	hasEngagement = FALSE;
	hasContact = FALSE;
	for (memberOffset = 0x0000; memberOffset < 0x0004; ++memberOffset)
	{
		selectedUnitIndex = firstUnitIndex + memberOffset;
		if (UnitEnemyContactEstablished[selectedUnitIndex]
			!= FALSE)
		{
			hasContact = TRUE;
		}
		if (UnitEnemyEngagementActive[selectedUnitIndex]
			!= FALSE)
		{
			hasEngagement = TRUE;
		}
		if (firstUnitIndex < 0x000C
			&& ScenarioUnitNeedsUpdate[selectedUnitIndex] != FALSE)
		{
			hasContact = TRUE;
			hasEngagement = TRUE;
		}
	}

	if (hasContact == FALSE && hasEngagement == FALSE)
	{
		if (firstUnitIndex == 0x0004)
			fallbackLanceState = TacticalScenarioLanceEnabled[0x01];
		else if (firstUnitIndex == 0x0008)
			fallbackLanceState = TacticalScenarioLanceEnabled[0x02];
	}
	if (fallbackLanceState != FALSE)
	{
		hasContact = TRUE;
		hasEngagement = TRUE;
	}
	if (hasContact == FALSE)
		return;

	if (hasEngagement != FALSE)
	{
		lanceLabelIndex =
			LanceFormationProfile[firstUnitIndex / 0x0004];
	}
	else
	{
		totalRating = 0x0000;
		for (memberOffset = 0x0000; memberOffset < 0x0004; ++memberOffset)
		{
			unitRecord = &PersistentUnitRoster[
				firstUnitIndex + memberOffset];
			totalRating += unitRecord->tonnage;
		}
		lanceLabelIndex = (word16)
			((((int16) totalRating >> 0x02) - 0x14) / 0x14 + 0x04);
	}
	RenderFormattedText(LanceStatusTextTable[lanceLabelIndex]);

	hasDeployedUnit = FALSE;
	memberOffset = 0x0000;
	firstDeployedMemberOffset = 0x0000;
	while (memberOffset < 0x0004)
	{
		unitRecord = &PersistentUnitRoster[
			firstUnitIndex + memberOffset];
		if (unitRecord->deploymentState != FALSE)
		{
			hasDeployedUnit = TRUE;
			firstDeployedMemberOffset = memberOffset;
			break;
		}
		++memberOffset;
	}

	if (hasDeployedUnit == FALSE)
	{
		ActiveTextCursorColumn = 0x000C;
		RenderFormattedText(DeadText);
		return;
	}

	if (firstUnitIndex == 0x000C)
	{
		hasDeployedUnit = FALSE;
		memberOffset = firstDeployedMemberOffset;
		while (memberOffset < 0x0004)
		{
			if (UpdateUnitEnemyVisibility(
				firstUnitIndex + memberOffset) != FALSE)
			{
				hasDeployedUnit = TRUE;
			}
			++memberOffset;
		}
	}

	if (hasDeployedUnit != FALSE)
	{
		selectedUnitIndex = firstUnitIndex + firstDeployedMemberOffset;
		DrawLanceFormationMarker(
			UnitFormationMode[selectedUnitIndex], 0x0009);
		ActiveTextCursorColumn = 0x000C;
		FormatTacticalMapCoordinates(
			ScenarioUnitMapX[selectedUnitIndex],
			ScenarioUnitMapY[selectedUnitIndex]);
		RenderFormattedText(SharedNumericTextBuffer);
		DrawUnitFacingAndMovementVectors(selectedUnitIndex);
	}
	else
	{
		ActiveTextCursorColumn = 0x000C;
		RenderFormattedText(UnknownUnitText);
	}
}

// 2208:2323: draw the selected unit's facing vector, secondary facing arm,
// and optional movement-heat vector beside its intelligence-row position.
void DrawUnitFacingAndMovementVectors(word16 unitIndex)
{
	word16 originX;
	word16 originY;
	word16 facing;
	word16 movementBand;
	word16 tableOffset;

	originX = (ActiveTextWindowLeftTile + 0x000F) << 0x03;
	originY = (ActiveTextWindowTopTile
		+ ActiveTextCursorRow) << 0x03;
	facing = ScenarioUnitFacing[unitIndex];

	DrawClippedWeaponTraceLine(
		(int16) (originX + FacingVectorStartX[facing]),
		(int16) (originY + FacingVectorStartY[facing]),
		(int16) (originX + FacingVectorStartX[facing + 0x08]),
		(int16) (originY + FacingVectorStartY[facing + 0x08]),
		0x0005,
		0x0000);
	DrawClippedWeaponTraceLine(
		(int16) (originX + FacingVectorEndX[facing]),
		(int16) (originY + FacingVectorEndY[facing]),
		(int16) (originX + FacingVectorEndX[facing + 0x08]),
		(int16) (originY + FacingVectorEndY[facing + 0x08]),
		0x0005,
		0x0000);

	if (UnitMovementHeatExponent[unitIndex] != 0x00)
	{
		movementBand =
			UnitMovementHeatExponent[unitIndex] - 0x01;
		tableOffset = movementBand << 0x04;
		DrawClippedWeaponTraceLine(
			(int16) (originX + MovementVectorX[tableOffset + facing]),
			(int16) (originY + MovementVectorY[tableOffset + facing]),
			(int16) (originX +
				MovementVectorX[tableOffset + facing + 0x08]),
			(int16) (originY +
				MovementVectorY[tableOffset + facing + 0x08]),
			0x0005,
			0x0000);
	}
}

// 2208:2224: draw the six-pixel marker for one of the ten lance formations.
// Verified against ASM 2208:2224-2322.
void DrawLanceFormationMarker(
	int16 formationCode,
	word16 tileColumnOffset)
{
	word16 formationIndex;
	int16 originX;
	int16 originY;
	word16 memberIndex;
	word16 tableOffset;
	int16 memberX;
	int16 memberY;

	formationIndex = (word16) formationCode & 0x7F;
	originX = (int16) (((ActiveTextWindowLeftTile +
		tileColumnOffset) << 0x03) + FormationMarkerOriginX[formationIndex]);
	originY = (int16) (((ActiveTextWindowTopTile +
		ActiveTextCursorRow) << 0x03) +
		FormationMarkerOriginY[formationIndex]);

	DrawClippedPixel(originX, originY, 0x0F);
	DrawClippedPixel((int16) (originX + 0x01), originY, 0x0F);
	for (memberIndex = 0x00; memberIndex < 0x03; ++memberIndex)
	{
		tableOffset = formationIndex * 0x06 + memberIndex;
		memberX = (int16) (originX +
			(FormationOffsetTable[tableOffset] << 0x02));
		memberY = (int16) (originY +
			(FormationOffsetTable[tableOffset + 0x03]
				<< 0x01));
		DrawClippedPixel(memberX, memberY, 0x0F);
		DrawClippedPixel((int16) (memberX + 0x01), memberY, 0x0F);
	}
}

// 2208:25F0: format a tactical map position as sector letter plus two decimal
// sub-cell digits in the shared four-byte text buffer at DS:B67E. Verified
// against ASM 2208:25F0-26B0.
void FormatTacticalMapCoordinates(word16 mapX, word16 mapY)
{
	int16 sectorWidth;
	int16 sectorHeight;
	int16 sectorX;
	int16 sectorY;
	int16 subCellX;
	int16 subCellY;
	byte sectorLetter;

	sectorWidth = (int16) MapWidth / 0x05;
	sectorHeight = (int16) MapHeight / 0x05;
	sectorX = (int16) mapX / sectorWidth;
	if (sectorX > 0x04)
		sectorX = 0x04;
	sectorY = (int16) mapY / sectorHeight;
	if (sectorY > 0x04)
		sectorY = 0x04;

	subCellX = (int16) ((((word16) mapX -
		(word16) (sectorX * sectorWidth)) * 0x0A) / sectorWidth);
	subCellY = (int16) ((((word16) mapY -
		(word16) (sectorY * sectorHeight)) * 0x0A) / sectorHeight);
	if (subCellX > 0x09)
		subCellX = 0x09;
	if (subCellY > 0x09)
		subCellY = 0x09;

	sectorLetter = (byte) ('A' + sectorX + sectorY * 0x05);
	if (sectorLetter > 'Y')
		sectorLetter = 'Y';
	SharedNumericTextBuffer[0x00] = sectorLetter;
	SharedNumericTextBuffer[0x01] = (byte) ('0' + subCellX);
	SharedNumericTextBuffer[0x02] = (byte) ('0' + subCellY);
	SharedNumericTextBuffer[0x03] = 0x00;
}

// 2208:146C: select the center of the strafing area and preserve it in the
// tactical support-command state. Verified against 2208:146C-1489.
void SelectStrafingArea(void)
{
	SelectTacticalMapCoordinate(0x0018);
	ArtilleryShellingActive = 0x00;
	RollingBarrageActive = 0x00;
	RollingBarrageEndMapX = UnitTargetMapX[0x18];
	RollingBarrageEndMapY = UnitTargetMapY[0x18];
}

// 2208:25C4: replace the command-window text while preserving the tactical
// display beneath the mouse cursor. Verified against 2208:25C4-25EF.
void ShowTacticalCommandPrompt(const char *prompt)
{
	HideMouseCursorOverlay();
	SelectAndClearTextWindow(0x0006);
	ActiveTextForegroundColor = 0x000F;
	RenderFormattedText(prompt);
	ShowMouseCursorOverlay();
}

// 2208:2A8A: draw the selection outline over each deployed follower in the
// selected leader's four-unit lance, restoring the caller's cursor afterward.
// Verified against ASM 2208:2A8A-2B0D.
void HighlightLanceFollowers(word16 leaderUnitIndex)
{
	int16 savedCursorX;
	int16 savedCursorY;
	word16 unitIndex;

	savedCursorX = TacticalCursorViewportX;
	savedCursorY = TacticalCursorViewportY;
	unitIndex = leaderUnitIndex + 0x01;
	while ((unitIndex & 0x03) != 0x00)
	{
		if (PersistentUnitRoster[unitIndex].deploymentState != FALSE)
		{
			TacticalCursorViewportX =
				(int16) ((word16) ScenarioUnitMapX[unitIndex] -
					TacticalViewportMapX);
			TacticalCursorViewportY =
				(int16) ((word16) ScenarioUnitMapY[unitIndex] -
					TacticalViewportMapY);
			if (TacticalCursorViewportX >= 0x00 &&
				TacticalCursorViewportX < 0x13 &&
				TacticalCursorViewportY >= 0x00 &&
				TacticalCursorViewportY < 0x0C)
			{
				DrawTacticalCursorOutline(0x05);
			}
		}
		++unitIndex;
	}

	TacticalCursorViewportX = savedCursorX;
	TacticalCursorViewportY = savedCursorY;
}

