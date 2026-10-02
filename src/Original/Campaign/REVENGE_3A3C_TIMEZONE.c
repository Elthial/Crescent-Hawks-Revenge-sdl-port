// Reconstructed original timezone and daylight-saving runtime (segment 3A3C).

#include "REVENGE.h"
#include "revenge/original_data.h"

// 3A3C:0008
// Borland tzset path. Parse TZ as a three-character standard-zone name,
// signed decimal UTC offset in hours, and an optional three-character DST name.
void InitializeTimezoneFromEnvironment(void)
{
	const char * timezone = GetEnvironmentVariable(TimezoneEnvironmentName);
	word16 validTimezone = timezone != 0x00 && StringLength(timezone) >= 0x04;

	if (validTimezone)
	{
		word16 firstThreeAreLetters =
			(CharacterClassTable[(unsigned char) timezone[0x00]] & 0x0C) != 0x00 &&
			(CharacterClassTable[(unsigned char) timezone[0x01]] & 0x0C) != 0x00 &&
			(CharacterClassTable[(unsigned char) timezone[0x02]] & 0x0C) != 0x00;
		word16 offsetStartsWithDigit =
			(CharacterClassTable[(unsigned char) timezone[0x03]] & 0x02) != 0x00;
		word16 offsetStartsWithSign = timezone[0x03] == '-' || timezone[0x03] == '+';
		word16 signedOffsetHasDigit =
			(CharacterClassTable[(unsigned char) timezone[0x04]] & 0x02) != 0x00;

		validTimezone = firstThreeAreLetters &&
			(offsetStartsWithDigit || offsetStartsWithSign) &&
			(offsetStartsWithDigit || signedOffsetHasDigit);
	}

	if (!validTimezone)
	{
		DaylightSavingEnabled = 0x01;
		TimezoneOffsetHighWord = 0x00;
		TimezoneOffsetLowWord = 0x4650;
		FarStringCopy(StandardTimezoneName, DefaultStandardTimezoneName);
		FarStringCopy(DaylightTimezoneName, DefaultDaylightTimezoneName);
		return;
	}

	FarMemorySet((byte *) DaylightTimezoneName, 0x00, 0x04);
	FarStringNCopy(StandardTimezoneName, timezone, 0x03);
	StandardTimezoneName[0x03] = 0x00;

	{
		long offsetSeconds = ParseSignedDecimalLong(timezone + 0x03) * 0x0E10L;
		TimezoneOffsetLowWord = (word16) offsetSeconds;
		TimezoneOffsetHighWord = HIGH_WORD(offsetSeconds);
	}

	DaylightSavingEnabled = 0x00;
	{
		unsigned short index = 0x03;
		while (timezone[index] != '\0')
		{
			if ((CharacterClassTable[(unsigned char) timezone[index]] & 0x0C) != 0x00)
			{
				if (StringLength(timezone + index) >= 0x03 &&
					(CharacterClassTable[(unsigned char) timezone[index + 0x01]] & 0x0C) != 0x00 &&
					(CharacterClassTable[(unsigned char) timezone[index + 0x02]] & 0x0C) != 0x00)
				{
					FarStringNCopy(DaylightTimezoneName, timezone + index, 0x03);
					DaylightTimezoneName[0x03] = 0x00;
					DaylightSavingEnabled = 0x01;
				}
				return;
			}
			++index;
		}
	}
}

// 3A3C:01ED: word16 IsDaylightSavingTime(
//     word16 yearsSince1970, word16 month,
//     word16 dayOrDayOfYear, byte hour)
// Called from:
//      CaptureLocalClockSnapshot
//      ConvertLocalDateTimeToEpochSeconds
word16 IsDaylightSavingTime(
	word16 yearsSince1970,
	word16 month,
	word16 dayOrDayOfYear,
	byte hour)
{
	word16 resolvedMonth = month;
	if (month == 0x00)
	{
		word16 normalizedDay = dayOrDayOfYear;
		if (dayOrDayOfYear >= 0x3B && ((yearsSince1970 + 0x46) & 0x03) == 0x00)
			normalizedDay = dayOrDayOfYear - 0x01;
		resolvedMonth = 0x00;
		while (CalendarBoundaryTable[resolvedMonth + 0x01] <= normalizedDay)
			++resolvedMonth;
	}
	else
	{
		if (month < 0x03 || ((yearsSince1970 + 0x46) & 0x03) != 0x00)
			--dayOrDayOfYear;
		dayOrDayOfYear += CalendarBoundaryTable[month];
	}
	if (resolvedMonth < 0x04)
	{
		return FALSE;
	}
	if (resolvedMonth != 0x04)
	{
		if (resolvedMonth > 0x0A)
			return FALSE;
		if (resolvedMonth != 0x0A)
			return TRUE;
	}
	word16 transitionDay;
	if (yearsSince1970 > 0x10 && resolvedMonth == 0x04)
		transitionDay = CalendarBoundaryTable[resolvedMonth] + 0x07;
	else
		transitionDay = CalendarBoundaryTable[resolvedMonth + 0x01];
	if (((byte)yearsSince1970 + 0xB2 & 0x03) != 0x00)
		--transitionDay;
	transitionDay -= (uint16)((uint32)(yearsSince1970 * 0x016D
		+ transitionDay + ((yearsSince1970 + 0x01) >> 0x02) + 0x04) % 0x07);
	if (resolvedMonth == 0x04)
	{
		if (dayOrDayOfYear <= transitionDay
			&& (dayOrDayOfYear != transitionDay || hour < 0x02))
			return FALSE;
	}
	else if (dayOrDayOfYear >= transitionDay
		&& (dayOrDayOfYear != transitionDay || hour > 0x01))
		return FALSE;
	return TRUE;
}

