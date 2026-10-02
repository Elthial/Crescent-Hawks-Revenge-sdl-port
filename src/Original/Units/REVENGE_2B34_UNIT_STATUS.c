// REVENGE_2B34_UNIT_STATUS.c
// Reconstructed from REVENGE.EXE and its annotated instruction listing.
// using Reko decompiler version 0.11.4.0.

#include "REVENGE.h"
#include "revenge/original_data.h"
#include "revenge/text.h"

enum
{
	WEAPON_STATUS_HAS_AMMUNITION_WEAPON = 0x80,
	WEAPON_STATUS_HAS_USABLE_AMMUNITION = 0x01
};

void CountUnitWeaponsByType(const RevengeUnitRecord *unitRecord);
word16 CountOrRemoveUnitHeatSinks(RevengeUnitRecord *unitRecord, word16 removeInstalledHeatSinks);
word16 CalculateUnitWeaponHeatScale(RevengeUnitRecord *unitRecord);
void RecalculateUnitCombatRatings(
	RevengeUnitRecord *unitRecord,
	word16 unitSlot,
	word16 rebuildWeaponCounts,
	word16 advanceRecovery);
word16 HasUnitLineOfSight(
	int16 sourceUnitIndex,
	int16 targetUnitIndex);
word16 IsCurrentLanceLeader(word16 unitIndex);
void DrawTacticalUnitControlPanel(word16 unitIndex);
word16 PrepareDisplayedUnitCombatRatings(word16 unitIndex);
void BuildDamagedWeaponRangeFlags(word16 unitIndex);
void DrawCombatRatingDescription(
	int16 combatRating,
	word16 x,
	word16 y,
	byte foregroundColor,
	byte backgroundColor);
void HideMouseCursorOverlay(void);
void ShowMouseCursorOverlay(void);
void SelectAndClearTextWindow(word16 windowIndex);
void SelectTextWindow(word16 windowIndex);
void DrawActiveTextWindowBorder(word16 color);
void SelectTacticalTextForegroundColor(void);
void DrawTileAlignedText(
	const char *text,
	word16 tileX,
	word16 tileY,
	byte foregroundColor,
	byte backgroundColor);
word16 UpdateUnitEnemyProximityState(word16 unitIndex);
word16 UpdateUnitEnemyVisibility(word16 unitIndex);
word16 HasTacticalReferencePointLineOfSightToUnit(
	word16 referencePointIndex, word16 unitIndex);
char *FarStringCopy(
	char *destination, const char *source);
char *FarStringConcat(
	char *destination, const char *source);
char *IntegerToString(
	int16 value, char *destination, word16 radix);

// 2B34:04B5: render the shared formatted-text line-break command at DS:38BE.
// Called from the tactical command and game-options panels in REVENGE_2208_TACTICAL_INTERACTION.c.
void RenderFormattedLineBreak(void)
{
	RenderFormattedText(FormattedLineBreak);
}

// 2B34:04C2: draw the complete tactical detail/control panel for one unit.
// Verified against ASM 2B34:04C2-0FDA. It deliberately retains the
// original DS tables, visibility tests, integer arithmetic and render order.
void DrawTacticalUnitControlPanel(word16 unitIndex)
{
	word16 lateCampaignVariant;
	word16 enemyUnit;
	word16 firstDetailRow;
	word16 friendlyHasLineOfSight;
	word16 revealEnemyDamage;
	word16 concealEnemyDamage;
	word16 panelSuppressed;
	word16 candidateIndex;
	RevengeUnitRecord *unitRecord;
	word16 unitType;
	word16 damageModel;
	word16 currentDurability;
	word16 maximumDurability;
	word16 durabilityBand;
	word16 conditionPercent;
	word16 movementDescription;
	word16 textColor;

	lateCampaignVariant =
		ScenarioFileSuffix >= 0x46 &&
		ScenarioFileSuffix < 0x54;
	enemyUnit = unitIndex >= ENEMY_FORCE_FIRST_UNIT;
	firstDetailRow = enemyUnit != FALSE ? 0x00 : 0x02;
	unitRecord = &PersistentUnitRoster[unitIndex];

	HideMouseCursorOverlay();
	friendlyHasLineOfSight = FALSE;
	for (candidateIndex = 0x00;
		candidateIndex < TACTICAL_FORCE_UNIT_COUNT;
		++candidateIndex)
	{
		if (PersistentUnitRoster[candidateIndex].deploymentState != 0x00 &&
			PersistentUnitRoster[candidateIndex].beagleActiveProbe != 0x00 &&
			HasUnitLineOfSight(candidateIndex, unitIndex) != FALSE)
		{
			friendlyHasLineOfSight = TRUE;
		}
	}

	revealEnemyDamage = TRUE;
	if (enemyUnit != FALSE && friendlyHasLineOfSight == FALSE &&
		UnitEnemyInProximityRange[unitIndex] == 0x00)
	{
		revealEnemyDamage = FALSE;
	}
	concealEnemyDamage = PrepareDisplayedUnitCombatRatings(unitIndex);
	BuildDamagedWeaponRangeFlags(unitIndex);
	SelectAndClearTextWindow(0x03);
	DrawActiveTextWindowBorder(0x0E);
	ActiveTextForegroundColor = 0x0F;
	panelSuppressed = FALSE;

	if (enemyUnit != FALSE &&
		UpdateUnitEnemyProximityState(unitIndex) == FALSE &&
		UpdateUnitEnemyVisibility(unitIndex) == FALSE)
	{
		for (candidateIndex = 0x00; candidateIndex < 0x04;
			++candidateIndex)
		{
			if (CampaignUpgradeAwards[candidateIndex] != 0x00 &&
				HasTacticalReferencePointLineOfSightToUnit(
					candidateIndex, unitIndex) != FALSE)
			{
				DrawCenteredTextInActiveWindow(
					DetectedByText,
					0x05, 0x0F, 0x00);
				DrawCenteredTextInActiveWindow(
					RadarSensorText,
					0x06, 0x0F, 0x00);
				panelSuppressed = TRUE;
				break;
			}
		}
	}

	if (panelSuppressed == FALSE)
	{
		unitType = unitRecord->unitTypeId;
		DrawCenteredTextInActiveWindow(
			UnitNameTable[unitType],
			0x00, 0x0F, 0x00);
		if (enemyUnit == FALSE)
		{
			FarStringCopy(
				(char *)SharedNumericTextBuffer,
				PilotSurnameTable[unitRecord->pilotId]);
			FarStringConcat(
				(char *)SharedNumericTextBuffer,
				PathSeparatorText);
			FarStringConcat(
				(char *)SharedNumericTextBuffer,
				PilotExperienceNameTable[unitRecord->pilotExperience]);
			DrawCenteredTextInActiveWindow(
				(const char *)SharedNumericTextBuffer,
				0x01, 0x0F, 0x00);
			DrawCenteredTextInActiveWindow(
				UnitAffiliationNameTable[unitRecord->allegiance],
				0x02, 0x0F, 0x00);
		}

		SelectTacticalTextForegroundColor();
		DrawTileAlignedText(
			(char *)UnitStatusRatingLabels,
			ActiveTextWindowLeftTile,
			ActiveTextWindowTopTile + firstDetailRow + 0x02,
			((byte)ActiveTextForegroundColor), 0x00);
		if (concealEnemyDamage != FALSE)
		{
			if (UpdateUnitEnemyProximityState(unitIndex) != FALSE)
			{
				DrawTileAlignedText(
					(char *)UnitStatusDamageLabel,
					ActiveTextWindowLeftTile,
					ActiveTextWindowTopTile + 0x08,
					((byte)ActiveTextForegroundColor), 0x00);
			}
		}
		else
		{
			word16 heatScale;
			DrawTileAlignedText(
				(char *)UnitStatusHeatDetailLabel,
				ActiveTextWindowLeftTile,
				ActiveTextWindowTopTile + 0x09,
				((byte)ActiveTextForegroundColor), 0x00);
			heatScale = unitRecord->currentHeat / BATTLEMECH_HEAT_SCALE;
			if (heatScale > 0x05)
				heatScale = 0x05;
			if (UnitShutdownState[unitIndex] != 0x00)
				heatScale = 0x06;
			DrawTileAlignedText(
				(char *)HeatScaleDescriptionTable[heatScale],
				ActiveTextWindowLeftTile + 0x05,
				ActiveTextWindowTopTile + 0x09,
				0x0F, 0x00);
		}

		textColor = DamagedWeaponRangeFlags[0x00] == 0x00 ? 0x0F : 0x0E;
		if (revealEnemyDamage == FALSE)
			textColor = 0x0F;
		DrawCombatRatingDescription(
			UnitCombatRatings[unitIndex].longFirepower,
			(ActiveTextWindowLeftTile + 0x04) << 0x03,
			(ActiveTextWindowTopTile + firstDetailRow + 0x02) << 0x03,
			(byte)textColor, 0x00);
		textColor = DamagedWeaponRangeFlags[0x01] == 0x00 ? 0x0F : 0x0E;
		if (revealEnemyDamage == FALSE)
			textColor = 0x0F;
		DrawCombatRatingDescription(
			UnitCombatRatings[unitIndex].mediumFirepower,
			(ActiveTextWindowLeftTile + 0x04) << 0x03,
			(ActiveTextWindowTopTile + firstDetailRow + 0x03) << 0x03,
			(byte)textColor, 0x00);
		textColor = DamagedWeaponRangeFlags[0x02] == 0x00 ? 0x0F : 0x0E;
		if (revealEnemyDamage == FALSE)
			textColor = 0x0F;
		DrawCombatRatingDescription(
			UnitCombatRatings[unitIndex].closeFirepower,
			(ActiveTextWindowLeftTile + 0x04) << 0x03,
			(ActiveTextWindowTopTile + firstDetailRow + 0x04) << 0x03,
			(byte)textColor, 0x00);

		currentDurability = 0x00;
		maximumDurability = 0x00;
		damageModel = unitRecord->damageModel;
		for (candidateIndex = 0x00; candidateIndex < 0x0B; ++candidateIndex)
		{
			if (damageModel == UNIT_DAMAGE_MODEL_INFANTRY)
			{
				currentDurability += unitRecord->currentDurability[candidateIndex];
				maximumDurability += unitRecord->maximumDurability[candidateIndex];
			}
			else
			{
				currentDurability += unitRecord->currentArmor[candidateIndex];
				maximumDurability += unitRecord->maximumArmor[candidateIndex];
			}
		}
		durabilityBand = (word16)((int16)maximumDurability / 0x46);
		if ((int16)durabilityBand > 0x03)
			durabilityBand = 0x03;
		DrawTileAlignedText(
			(char *)DurabilityDescriptionTable[durabilityBand],
			ActiveTextWindowLeftTile + 0x04,
			ActiveTextWindowTopTile + firstDetailRow + 0x05,
			0x0F, 0x00);
		if (concealEnemyDamage != FALSE)
		{
			conditionPercent = (word16)
				(((int32)(currentDurability * 0x0A) /
					(int16)maximumDurability) * 0x0A);
		}
		else
		{
			conditionPercent = (word16)
				((int32)(currentDurability * 0x64) /
					(int16)maximumDurability);
		}
		SharedNumericTextBuffer[0x00] = 0x28;
		IntegerToString(
			(int16)conditionPercent,
			(char *)&SharedNumericTextBuffer[0x01], 0x0A);
		FarStringConcat(
			(char *)SharedNumericTextBuffer,
			PercentCloseText);
		if (concealEnemyDamage == FALSE ||
			UpdateUnitEnemyProximityState(unitIndex) != FALSE)
		{
			DrawTileAlignedText(
				(char *)SharedNumericTextBuffer,
				ActiveTextWindowLeftTile + 0x05 +
					StringLength(DurabilityDescriptionTable[durabilityBand]),
				ActiveTextWindowTopTile + firstDetailRow + 0x05,
				0x0F, 0x00);
		}
		if (concealEnemyDamage != FALSE &&
			UpdateUnitEnemyProximityState(unitIndex) != FALSE)
		{
			word16 conditionBand = conditionPercent / 0x14;
			DrawTileAlignedText(
				(char *)ConditionDescriptionTable[conditionBand],
				ActiveTextWindowLeftTile + 0x04,
				ActiveTextWindowTopTile + 0x08,
				0x0F, 0x00);
		}

		textColor = unitRecord->walkMovement == 0x00
			? 0x0E : 0x0F;
		movementDescription = MovementRatingByWalkMP[
			unitRecord->walkMovement];
		DrawTileAlignedText(
			(char *)MovementDescriptionTable[movementDescription],
			ActiveTextWindowLeftTile + 0x04,
			ActiveTextWindowTopTile + firstDetailRow + 0x06,
			(byte)textColor, 0x00);
		if (unitRecord->jumpMovement != 0x00)
		{
			DrawTileAlignedText(
				(char *)JumpEquipmentSuffix,
				ActiveTextWindowLeftTile + 0x04 +
					StringLength(MovementDescriptionTable[movementDescription]),
				ActiveTextWindowTopTile + firstDetailRow + 0x06,
				(byte)textColor, 0x00);
		}

		if (enemyUnit != FALSE)
		{
			if (friendlyHasLineOfSight != FALSE)
			{
				DrawTileAlignedText(
					(char *)ScannedByActiveProbeText,
					ActiveTextWindowLeftTile,
					ActiveTextWindowTopTile + 0x0B,
					0x0F, 0x00);
			}
			else if (concealEnemyDamage != FALSE &&
				UpdateUnitEnemyProximityState(unitIndex) == FALSE)
			{
				DrawCenteredTextInActiveWindow(
					OutOfScanningText,
					0x09, 0x0F, 0x00);
				DrawCenteredTextInActiveWindow(
					RangeText,
					0x0A, 0x0F, 0x00);
			}
		}
		else
		{
			ActiveTextForegroundColor = 0x0F;
			ActiveTextCursorColumn = 0x00;
			ActiveTextCursorRow = 0x0A;
			if (unitRecord->missileUpgradeState != 0x00)
				RenderFormattedText(
					FriendlyEquipmentDescriptionTable[lateCampaignVariant]);
			if (unitRecord->beagleActiveProbe != 0x00)
				RenderFormattedText(BapEquipmentText);
			if (unitRecord->indirectFireSpotter != 0x00)
				RenderFormattedText(ArrowTagEquipmentText);
			if (unitRecord->unknown8F != 0x00)
				RenderFormattedText(AccuracyEquipmentText);
			if (unitRecord->doubleHeatSinks != 0x00)
				RenderFormattedText(DoubleHeatSinkEquipmentText);
			if (unitRecord->caseProtection != 0x00)
				RenderFormattedText(CaseEquipmentText);
		}

		if (enemyUnit != FALSE && concealEnemyDamage != FALSE &&
			UpdateUnitEnemyProximityState(unitIndex) != FALSE)
		{
			int16 assessmentIndex = 0x06;
			int16 renderedAssessment;
			ActiveTextCursorColumn = 0x00;
			ActiveTextCursorRow = 0x0A;
			if (conditionPercent != 0x64)
			{
				assessmentIndex = 0x07;
				if (unitRecord->walkMovement == 0x00)
				{
					assessmentIndex = 0x0B;
				}
				else if (DamagedWeaponRangeFlags[0x00] != 0x00)
				{
					assessmentIndex =
						UnitCombatRatings[unitIndex].longFirepower == 0x00
							? 0x01 : 0x00;
				}
				else if (DamagedWeaponRangeFlags[0x01] != 0x00)
				{
					assessmentIndex =
						UnitCombatRatings[unitIndex].mediumFirepower == 0x00
							? 0x03 : 0x02;
				}
				else if (DamagedWeaponRangeFlags[0x02] != 0x00)
				{
					assessmentIndex =
						UnitCombatRatings[unitIndex].closeFirepower == 0x00
							? 0x05 : 0x04;
				}

				if (assessmentIndex == 0x07 &&
					damageModel == UNIT_DAMAGE_MODEL_INFANTRY)
					assessmentIndex = 0x0D;
				if (assessmentIndex == 0x07)
				{
					word16 currentArmor =
						unitRecord->currentArmor[BATTLEMECH_ARMOR_LEFT_LEG] +
						unitRecord->currentArmor[BATTLEMECH_ARMOR_RIGHT_LEG];
					word16 maximumArmor =
						unitRecord->maximumArmor[BATTLEMECH_ARMOR_LEFT_LEG] +
						unitRecord->maximumArmor[BATTLEMECH_ARMOR_RIGHT_LEG];
					if (currentArmor != maximumArmor)
					{
						assessmentIndex = 0x08;
						if ((word16)(currentArmor << 0x01) < maximumArmor)
							assessmentIndex = 0x09;
					}
					if (assessmentIndex == 0x07)
					{
						if (UnitShutdownState[unitIndex] != 0x00)
						{
							assessmentIndex = 0x0E;
						}
						else if ((unitRecord->currentInternal[
								BATTLEMECH_LOCATION_LEFT_ARM] != 0x00 &&
							unitRecord->currentInternal[
								BATTLEMECH_LOCATION_RIGHT_ARM] != 0x00) ||
							damageModel != UNIT_DAMAGE_MODEL_BATTLEMECH)
						{
							word16 weaponDamageFlags = 0x00;
							for (candidateIndex = 0x00;
								candidateIndex < AMMUNITION_FAMILY_COUNT;
								++candidateIndex)
							{
								if (unitRecord->weaponFamilyCounts[candidateIndex]
									!= 0x00)
								{
									weaponDamageFlags |=
										WEAPON_STATUS_HAS_AMMUNITION_WEAPON;
									if (unitRecord->currentAmmunition[candidateIndex]
										!= 0x00)
									{
										weaponDamageFlags |=
											WEAPON_STATUS_HAS_USABLE_AMMUNITION;
									}
								}
							}
							if (weaponDamageFlags ==
								WEAPON_STATUS_HAS_AMMUNITION_WEAPON)
								assessmentIndex = 0x0C;
						}
						else
						{
							assessmentIndex = 0x0A;
						}
					}
				}
			}

			if (assessmentIndex >= 0x00 && assessmentIndex <= 0x0E)
			{
				renderedAssessment = assessmentIndex;
				if ((assessmentIndex == 0x08 || assessmentIndex == 0x09 ||
					assessmentIndex == 0x0B) &&
					damageModel != UNIT_DAMAGE_MODEL_BATTLEMECH)
				{
					if (renderedAssessment == 0x0B)
						renderedAssessment = 0x11;
					if (renderedAssessment == 0x08)
						renderedAssessment = 0x0F;
					if (renderedAssessment == 0x09)
						renderedAssessment = 0x10;
				}
				SelectTextWindow(0x15);
				ActiveTextCursorRow = 0x00;
				ActiveTextCursorColumn = 0x02;
				RenderFormattedText(
					EnemyAssessmentTextTable[renderedAssessment]);
			}
		}
	}

	RecalculateUnitCombatRatings(
		unitRecord,
		unitIndex, TRUE, FALSE);
	ShowMouseCursorOverlay();
}

// 2B34:0FDB: center a string horizontally in the active tile window and draw
// it at the requested row offset. The two color arguments occupy words on the
// Borland stack even though the renderer consumes their low bytes.
void DrawCenteredTextInActiveWindow(
	const char *text,
	word16 rowOffset,
	word16 foregroundColor,
	word16 backgroundColor)
{
	word16 textLength = StringLength(text);
	word16 tileX = ActiveTextWindowLeftTile +
		((ActiveTextWindowWidthTiles - textLength) >> 0x01);
	word16 tileY = ActiveTextWindowTopTile + rowOffset;

	DrawTileAlignedText(
		(char *) text,
		tileX,
		tileY,
		(byte) foregroundColor,
		(byte) backgroundColor);
}

// 2B2D:0077: word16 CountOrRemoveUnitHeatSinks(
//     RevengeUnitRecord *unitRecord, word16 removeInstalledHeatSinks)
// Called from:
//      CalculateUnitWeaponHeatScale
//      RecalculateUnitCombatRatings
// Verified against the aliased entry 2B34:0007-0120
// (logical address 2B2D:0077).
word16 CountOrRemoveUnitHeatSinks(
	RevengeUnitRecord *unitRecord,
	word16 removeInstalledHeatSinks)
{
	word16 heatSinkCount = unitRecord->engineHeatSinkCapacity;
	word16 equipmentSlot;

	for (equipmentSlot = 0x00;
		equipmentSlot < sizeof(unitRecord->equipmentSlots);
		++equipmentSlot)
	{
		if (unitRecord->equipmentSlots[equipmentSlot] != EQUIPMENT_ID_HEAT_SINK)
			continue;

		++heatSinkCount;
		if (removeInstalledHeatSinks != 0x00)
			unitRecord->equipmentSlots[equipmentSlot] = EQUIPMENT_SLOT_EMPTY;
	}

	return heatSinkCount;
}

// 2B2D:0191: word16 CalculateUnitWeaponHeatScale(RevengeUnitRecord *unitRecord)
// Called from:
//      DrawUnitStatusScreen
// Verified against 2B2D:0191-021A.
word16 CalculateUnitWeaponHeatScale(RevengeUnitRecord *unitRecord)
{
	int16 calculatedHeat;
	word16 weaponIndex;
	word16 heatScaleIndex;

	CountUnitWeaponsByType(unitRecord);

	calculatedHeat = unitRecord->jumpMovement == 0x00
		? 0x02
		: 0x05;

	for (weaponIndex = 0x00; weaponIndex < WEAPON_DEFINITION_COUNT; ++weaponIndex)
	{
		int16 weaponHeat = WeaponDefinitions[weaponIndex].heat;
		word16 equippedCount = WeaponCountScratch[weaponIndex];
		calculatedHeat += weaponHeat * equippedCount;
	}

	calculatedHeat -= CountOrRemoveUnitHeatSinks(unitRecord, 0x00);
	if (calculatedHeat < 0x00)
		calculatedHeat = 0x00;
	else if (calculatedHeat > BATTLEMECH_MAXIMUM_HEAT)
		calculatedHeat = BATTLEMECH_MAXIMUM_HEAT;

	heatScaleIndex = (word16) (calculatedHeat / 0x04);
	if (heatScaleIndex > 0x05)
		heatScaleIndex = 0x05;

	return heatScaleIndex;
}

// 2B34:01AB: int16 FindUnitWeaponByOrdinal(
//     Stack RevengeUnitRecord *unitRecord, Stack word16 weaponOccurrence,
//     Stack word16 removeWeapon)
// Called from the original assembly implementation of:
//      CountUnitWeaponsByType
int16 FindUnitWeaponByOrdinal(
	RevengeUnitRecord *unitRecord,
	word16 weaponOccurrence,
	word16 removeWeapon)
{
	// V: scan one-based weapon equipment IDs 01h..17h in the eight stored
	// location groups. Vehicle records reuse the groups, but their exact
	// front/side/rear/turret projection still requires UI/damage evidence.
	byte *locationEquipment[BATTLEMECH_LOCATION_COUNT] =
	{
		&unitRecord->headEquipment,
		unitRecord->leftArmEquipment,
		unitRecord->leftTorsoEquipment,
		unitRecord->centerTorsoEquipment,
		unitRecord->rightTorsoEquipment,
		unitRecord->rightArmEquipment,
		unitRecord->leftLegEquipment,
		unitRecord->rightLegEquipment
	};
	static const byte locationLengths[BATTLEMECH_LOCATION_COUNT] =
	{
		BATTLEMECH_HEAD_EQUIPMENT_SLOT_COUNT,
		BATTLEMECH_ARM_EQUIPMENT_SLOT_COUNT,
		BATTLEMECH_TORSO_EQUIPMENT_SLOT_COUNT,
		BATTLEMECH_CENTER_TORSO_EQUIPMENT_SLOT_COUNT,
		BATTLEMECH_TORSO_EQUIPMENT_SLOT_COUNT,
		BATTLEMECH_ARM_EQUIPMENT_SLOT_COUNT,
		BATTLEMECH_LEG_EQUIPMENT_SLOT_COUNT,
		BATTLEMECH_LEG_EQUIPMENT_SLOT_COUNT
	};
	word16 locationIndex;
	word16 matchingWeaponIndex = 0x00;

	// Verified against 2B34:01AB-0374.
	for (locationIndex = 0x00;
		locationIndex < BATTLEMECH_LOCATION_COUNT;
		++locationIndex)
	{
		word16 slotIndex;
		for (slotIndex = 0x00;
			slotIndex < locationLengths[locationIndex];
			++slotIndex)
		{
			byte equipmentId = locationEquipment[locationIndex][slotIndex];
			word16 weaponIndex;
			byte ammunitionFamily;

			if (equipmentId < WEAPON_EQUIPMENT_ID(WEAPON_SMALL_LASER)
				|| equipmentId > WEAPON_EQUIPMENT_ID(WEAPON_SRM_6))
			{
				continue;
			}
			if (matchingWeaponIndex++ != weaponOccurrence)
				continue;

			SelectedUnitEquipmentLocation = locationIndex;
			if (removeWeapon == 0x00)
				return equipmentId;

			locationEquipment[locationIndex][slotIndex] = EQUIPMENT_SLOT_EMPTY;
			weaponIndex = WEAPON_INDEX_FROM_EQUIPMENT_ID(equipmentId);
			ammunitionFamily =
				WeaponDefinitions[weaponIndex].ammunitionFamilyId;
			if (ammunitionFamily == AMMUNITION_NONE)
				return equipmentId;

			CountUnitWeaponsByType(unitRecord);
			if (WeaponCountScratch[weaponIndex] == 0x00)
			{
				unitRecord->weaponFamilyCounts[
					AMMUNITION_INDEX(ammunitionFamily)] = 0x00;
				unitRecord->currentAmmunition[
					AMMUNITION_INDEX(ammunitionFamily)] = 0x00;
			}
			return equipmentId;
		}
	}

	return -0x01;
}

// 2B34:0422: void DrawCombatRatingDescription(uint16 combatRating,
//     uint16 x, uint16 y, byte foregroundColor, byte backgroundColor)
// Called from:
//      DrawUnitStatusScreen
void DrawCombatRatingDescription(
	int16 combatRating,
	uint16 x,
	uint16 y,
	byte foregroundColor,
	byte backgroundColor)
{
	// V: DS:40CF is a seven-entry far-pointer table containing Light,
	// Moderate, Heavy, Brutal, Devastating, Incredible, and None.
	uint16 descriptionIndex;
	if (combatRating == 0x00)
		descriptionIndex = 0x06;
	else
	{
		descriptionIndex = combatRating / 0x09;
		if (descriptionIndex > 0x05)
			descriptionIndex = 0x05;
	}

	const char *description =
		CombatRatingDescriptionTable[descriptionIndex];
	DrawTextString(
		description,
		x,
		y,
		foregroundColor,
		backgroundColor);
}

// 2B34:0469: void CountUnitWeaponsByType(const RevengeUnitRecord *unitRecord)
// Called from:
//      DrawUnitStatusScreen
//      CalculateUnitWeaponHeatScale
//      FindUnitWeaponByOrdinal
//      RecalculateUnitCombatRatings
void CountUnitWeaponsByType(const RevengeUnitRecord *unitRecord)
{
	word16 weaponTypeIndex;
	word16 weaponOccurrence = 0x00;
	int16 equipmentId;

	for (weaponTypeIndex = 0x00;
		weaponTypeIndex < WEAPON_DEFINITION_COUNT;
		++weaponTypeIndex)
	{
		WeaponCountScratch[weaponTypeIndex] = 0x00;
	}

	for (;;)
	{
		equipmentId = FindUnitWeaponByOrdinal(
			(RevengeUnitRecord *)unitRecord,
			weaponOccurrence++, FALSE);
		if (equipmentId == -0x01)
			break;
		++WeaponCountScratch[
			WEAPON_INDEX_FROM_EQUIPMENT_ID((word16)equipmentId)];
	}
}

// 2B34:140F: void FlagDamagedWeaponRanges(
//     const byte *equipmentSlots, word16 slotCount)
// Called from:
//      BuildDamagedWeaponRangeFlags
void FlagDamagedWeaponRanges(
	const byte *equipmentSlots,
	word16 slotCount)
{
	// V: DS:99C2..99C4 are long-, medium-, and close-range flags. Only
	// equipment entries carrying the damage bit participate in the status-panel
	// summary; the remaining seven bits contain the one-based weapon ID.
	byte *damagedRangeFlags =
		(byte *) DamagedWeaponRangeFlags;
	word16 slotIndex;

	for (slotIndex = 0x00; slotIndex < slotCount; ++slotIndex)
	{
		byte equipmentId = equipmentSlots[slotIndex];
		word16 rangeClass;

		if ((equipmentId & EQUIPMENT_DAMAGED_FLAG) == 0x00)
			continue;

		equipmentId &= EQUIPMENT_ID_MASK;
		if (equipmentId < WEAPON_EQUIPMENT_ID(WEAPON_SMALL_LASER)
			|| equipmentId > WEAPON_EQUIPMENT_ID(WEAPON_SRM_6))
			continue;

		switch (WEAPON_INDEX_FROM_EQUIPMENT_ID(equipmentId))
		{
		case WEAPON_LARGE_LASER:
		case WEAPON_LARGE_PULSE_LASER:
		case WEAPON_AUTOCANNON_10:
			rangeClass = WEAPON_RANGE_MEDIUM;
			break;

		case WEAPON_ER_LARGE_LASER:
		case WEAPON_PPC:
		case WEAPON_ER_PPC:
		case WEAPON_AUTOCANNON_2:
		case WEAPON_AUTOCANNON_5:
		case WEAPON_LB_10X_AUTOCANNON:
		case WEAPON_GAUSS_RIFLE:
		case WEAPON_LRM_5:
		case WEAPON_LRM_10:
		case WEAPON_LRM_15:
		case WEAPON_LRM_20:
			rangeClass = WEAPON_RANGE_LONG;
			break;

		default:
			rangeClass = WEAPON_RANGE_CLOSE;
			break;
		}

		damagedRangeFlags[rangeClass] = TRUE;
	}
}

// 2B34:130C: void BuildDamagedWeaponRangeFlags(word16 unitIndex)
// Called from:
//      DrawTacticalUnitControlPanel
void BuildDamagedWeaponRangeFlags(word16 unitIndex)
{
	static const byte equipmentGroupLengths[BATTLEMECH_LOCATION_COUNT] =
	{
		BATTLEMECH_ARM_EQUIPMENT_SLOT_COUNT,
		BATTLEMECH_ARM_EQUIPMENT_SLOT_COUNT,
		BATTLEMECH_TORSO_EQUIPMENT_SLOT_COUNT,
		BATTLEMECH_TORSO_EQUIPMENT_SLOT_COUNT,
		BATTLEMECH_CENTER_TORSO_EQUIPMENT_SLOT_COUNT,
		BATTLEMECH_LEG_EQUIPMENT_SLOT_COUNT,
		BATTLEMECH_LEG_EQUIPMENT_SLOT_COUNT,
		BATTLEMECH_HEAD_EQUIPMENT_SLOT_COUNT
	};
	RevengeUnitRecord *unitRecord = &PersistentUnitRoster[unitIndex];
	byte *damagedRangeFlags =
		(byte *) DamagedWeaponRangeFlags;
	byte *equipmentGroups[BATTLEMECH_LOCATION_COUNT] =
	{
		unitRecord->leftArmEquipment,
		unitRecord->rightArmEquipment,
		unitRecord->leftTorsoEquipment,
		unitRecord->rightTorsoEquipment,
		unitRecord->centerTorsoEquipment,
		unitRecord->leftLegEquipment,
		unitRecord->rightLegEquipment,
		&unitRecord->headEquipment
	};
	word16 groupIndex;

	// The assembly uses DI=0..2. Reko's generated 6641h upper bound was a
	// malformed reconstruction of that three-byte clear.
	for (groupIndex = 0x00;
		groupIndex < WEAPON_RANGE_CLASS_COUNT;
		++groupIndex)
		damagedRangeFlags[groupIndex] = FALSE;

	for (groupIndex = 0x00;
		groupIndex < BATTLEMECH_LOCATION_COUNT;
		++groupIndex)
	{
		FlagDamagedWeaponRanges(
			equipmentGroups[groupIndex],
			equipmentGroupLengths[groupIndex]);
	}
}

// 2B34:11D2: void BuildUndamagedUnitCombatEstimate(word16 unitIndex)
// Called from:
//      PrepareDisplayedUnitCombatRatings
//      CalculateLanceAverageCombatRatings
void BuildUndamagedUnitCombatEstimate(word16 unitIndex)
{
	RevengeUnitRecord *sourceUnit = &PersistentUnitRoster[unitIndex];
	RevengeUnitRecord *estimatedUnit =
		(RevengeUnitRecord *) &EstimatedUnitRecord;
	word16 fieldIndex;

	// V: construct the information-safe enemy estimate consumed by the combat
	// rating calculator. Maximum armor becomes displayed current armor, weapon
	// family counts become widened ammunition values, and every equipment
	// damage bit is stripped. Fields irrelevant to rating calculation are not
	// copied into this shared scratch record.
	for (fieldIndex = 0x00;
		fieldIndex < BATTLEMECH_TORSO_EQUIPMENT_SLOT_COUNT;
		++fieldIndex)
	{
		if (fieldIndex < BATTLEMECH_ARMOR_LOCATION_COUNT)
		{
			estimatedUnit->currentArmor[fieldIndex] =
				sourceUnit->maximumArmor[fieldIndex];
		}

		estimatedUnit->currentAmmunition[fieldIndex] =
			sourceUnit->weaponFamilyCounts[fieldIndex];
		estimatedUnit->leftTorsoEquipment[fieldIndex] =
			sourceUnit->leftTorsoEquipment[fieldIndex] & EQUIPMENT_ID_MASK;
		estimatedUnit->rightTorsoEquipment[fieldIndex] =
			sourceUnit->rightTorsoEquipment[fieldIndex] & EQUIPMENT_ID_MASK;

		if (fieldIndex < BATTLEMECH_ARM_EQUIPMENT_SLOT_COUNT)
		{
			estimatedUnit->leftArmEquipment[fieldIndex] =
				sourceUnit->leftArmEquipment[fieldIndex] & EQUIPMENT_ID_MASK;
			estimatedUnit->rightArmEquipment[fieldIndex] =
				sourceUnit->rightArmEquipment[fieldIndex] & EQUIPMENT_ID_MASK;
		}

		if (fieldIndex < BATTLEMECH_CENTER_TORSO_EQUIPMENT_SLOT_COUNT)
		{
			estimatedUnit->centerTorsoEquipment[fieldIndex] =
				sourceUnit->centerTorsoEquipment[fieldIndex] & EQUIPMENT_ID_MASK;
			estimatedUnit->leftLegEquipment[fieldIndex] =
				sourceUnit->leftLegEquipment[fieldIndex] & EQUIPMENT_ID_MASK;
			estimatedUnit->rightLegEquipment[fieldIndex] =
				sourceUnit->rightLegEquipment[fieldIndex] & EQUIPMENT_ID_MASK;
		}
	}

	estimatedUnit->headEquipment =
		sourceUnit->headEquipment & EQUIPMENT_ID_MASK;
}

// 2B34:10F4: void CalculateLanceAverageCombatRatings(
//     word16 leaderUnitIndex, word16 useActualUnitData)
// Called from:
//      PrepareDisplayedUnitCombatRatings
void CalculateLanceAverageCombatRatings(
	word16 leaderUnitIndex,
	word16 useActualUnitData)
{
	RevengeTacticalCombatRatings *averageRatings =
		&DisplayedUnitCombatRatings;
	word16 lanceEndUnitIndex = (leaderUnitIndex + 0x04) & 0x00FC;
	word16 includedUnitCount = 0x00;
	word16 ratingIndex;
	word16 unitIndex;

	for (ratingIndex = 0x00; ratingIndex < 0x06; ++ratingIndex)
		((int16 *)averageRatings)[ratingIndex] = 0x00;

	for (unitIndex = leaderUnitIndex;
		unitIndex < lanceEndUnitIndex;
		++unitIndex)
	{
		RevengeUnitRecord *unitRecord = &PersistentUnitRoster[unitIndex];
		RevengeTacticalCombatRatings *unitRatings;

		if (unitRecord->deploymentState == 0x00)
			continue;

		if (useActualUnitData != FALSE)
		{
			RecalculateUnitCombatRatings(
				unitRecord, unitIndex, TRUE, FALSE);
		}
		else
		{
			BuildUndamagedUnitCombatEstimate(unitIndex);
			RecalculateUnitCombatRatings(
				(RevengeUnitRecord *) &EstimatedUnitRecord,
				unitIndex,
				TRUE,
				FALSE);
		}

		unitRatings = &UnitCombatRatings[unitIndex];
		for (ratingIndex = 0x00; ratingIndex < 0x06; ++ratingIndex)
			((int16 *)averageRatings)[ratingIndex] +=
				((int16 *)unitRatings)[ratingIndex];
		++includedUnitCount;
	}

	// The caller supplies a deployed lance leader, so the original performs an
	// unconditional division here. Preserve that contract while making the
	// invariant explicit for readers of the reconstructed C.
	if (includedUnitCount != 0x00)
	{
		for (ratingIndex = 0x00; ratingIndex < 0x06; ++ratingIndex)
			((int16 *)averageRatings)[ratingIndex] /= (int16)includedUnitCount;
	}
}

// 2B34:1014: word16 PrepareDisplayedUnitCombatRatings(word16 unitIndex)
// Called from:
//      DrawTacticalUnitControlPanel
word16 PrepareDisplayedUnitCombatRatings(word16 unitIndex)
{
	word16 concealEnemyDamage = unitIndex >= ENEMY_FORCE_FIRST_UNIT;
	word16 unitIsLanceLeader;

	if (concealEnemyDamage != FALSE)
	{
		word16 friendlyUnitIndex;
		for (friendlyUnitIndex = 0x00;
			friendlyUnitIndex < TACTICAL_FORCE_UNIT_COUNT;
			++friendlyUnitIndex)
		{
			RevengeUnitRecord *friendlyUnit =
				&PersistentUnitRoster[friendlyUnitIndex];
			if (friendlyUnit->deploymentState != 0x00
				&& friendlyUnit->beagleActiveProbe != 0x00
				&& HasUnitLineOfSight(
					friendlyUnitIndex, unitIndex) != FALSE)
			{
				concealEnemyDamage = FALSE;
			}
		}
	}

	unitIsLanceLeader = IsCurrentLanceLeader(unitIndex);
	if (unitIsLanceLeader != FALSE)
	{
		CalculateLanceAverageCombatRatings(
			unitIndex, concealEnemyDamage == FALSE);
	}
	else if (concealEnemyDamage != FALSE)
	{
		BuildUndamagedUnitCombatEstimate(unitIndex);
		RecalculateUnitCombatRatings(
			(RevengeUnitRecord *) &EstimatedUnitRecord,
			unitIndex,
			TRUE,
			FALSE);
	}
	else
	{
		RecalculateUnitCombatRatings(
			&PersistentUnitRoster[unitIndex],
			unitIndex,
			TRUE,
			FALSE);
	}

	return concealEnemyDamage;
}
