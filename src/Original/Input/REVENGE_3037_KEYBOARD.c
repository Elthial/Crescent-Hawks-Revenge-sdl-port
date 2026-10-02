// REVENGE_3037_KEYBOARD.c
// Assembly-led translation of the resident keyboard consumer and translator.

#include "REVENGE.h"
#include "revenge/input.h"
#include "revenge/platform_backend.h"

#include <stddef.h>

enum
{
	KEYBOARD_EVENT_COUNT = 0x40,
	KEYBOARD_EVENT_WRAP_MASK = 0x7F,
	KEY_ID_ASCII_TABLE_LIMIT = 0x3E,
	KEY_ID_EXTENDED_LOOKUP_FIRST = 0x4B,
	KEY_ID_ESCAPE = 0x6E,
	KEY_EXTENDED_OUTPUT_FLAG = 0x80,
	KEY_MODIFIER_SHIFT = 0x01,
	KEY_MODIFIER_CTRL = 0x02,
	KEY_MODIFIER_ALT = 0x04,
	KEY_MODIFIER_ANY_MASK = 0x07,
	KEY_CTRL_OUTPUT_MASK = 0x1F,
	KEYBOARD_LOCK_NUM = 0x02,
	KEYBOARD_MODE_FORCE_EXTENDED_TABLE = 0x0200,
	KEY_SCAN_F1 = 0x70,
	KEY_SCAN_F10 = 0x79,
	KEYCODE_F1_BASE = 0xC5,
	KEYCODE_SHIFT_F1_BASE = 0xAC,
	KEYCODE_CTRL_F1_BASE = 0xA2,
	KEYCODE_ALT_F1_BASE = 0x98,
	INTERRUPT_KEYBOARD_IRQ = 0x09,
	INTERRUPT_DOS_CTRL_BREAK = 0x23
};

static const byte KeyBitMasks[0x08] =
{
	0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80
};

static const byte CtrlTranslationBitmap[0x08] =
{
	0x00, 0x00, 0xFE, 0x87, 0xFF, 0xC0, 0x1F, 0x00
};

static const byte AsciiTranslationTable[0x3E] =
{
	0x00, 0x60, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36,
	0x37, 0x38, 0x39, 0x30, 0x2D, 0x3D, 0x00, 0x08,
	0x09, 0x71, 0x77, 0x65, 0x72, 0x74, 0x79, 0x75,
	0x69, 0x6F, 0x70, 0x5B, 0x5D, 0x5C, 0x00, 0x61,
	0x73, 0x64, 0x66, 0x67, 0x68, 0x6A, 0x6B, 0x6C,
	0x3B, 0x27, 0x5C, 0x0D, 0x00, 0x00, 0x7A, 0x78,
	0x63, 0x76, 0x62, 0x6E, 0x6D, 0x2C, 0x2E, 0x2F,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x20
};

static const byte ShiftedAsciiTranslationTable[0x3E] =
{
	0x00, 0x7E, 0x21, 0x40, 0x23, 0x24, 0x25, 0x5E,
	0x26, 0x2A, 0x28, 0x29, 0x5F, 0x2B, 0x00, 0x08,
	0x09, 0x51, 0x57, 0x45, 0x52, 0x54, 0x59, 0x55,
	0x49, 0x4F, 0x50, 0x7B, 0x7D, 0x7C, 0x00, 0x41,
	0x53, 0x44, 0x46, 0x47, 0x48, 0x4A, 0x4B, 0x4C,
	0x3A, 0x22, 0x7C, 0x0D, 0x00, 0x00, 0x5A, 0x58,
	0x43, 0x56, 0x42, 0x4E, 0x4D, 0x3C, 0x3E, 0x3F,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x20
};

static const byte ExtendedTranslationTable[0x23] =
{
	0xAE, 0xAD, 0x00, 0x00, 0xB5, 0xB9, 0xB1, 0x00,
	0xB8, 0xB0, 0xB7, 0xAF, 0x00, 0x00, 0xB3, 0x00,
	0xB9, 0xB5, 0xB1, 0x00, 0x2F, 0xB8, 0x00, 0xB0,
	0xAE, 0x2A, 0xB7, 0xB3, 0xAF, 0xAD, 0x2D, 0x2B,
	0x00, 0x0D, 0x00
};

static const byte NumericKeypadTranslationTable[0x14] =
{
	0x00, 0x37, 0x34, 0x31, 0x00, 0x2F, 0x38, 0x35,
	0x32, 0x30, 0x2A, 0x39, 0x36, 0x33, 0x2E, 0x2D,
	0x2B, 0x00, 0x0D, 0x00
};

#pragma pack(push, 1)
typedef struct KeyboardRuntime
{
	word16 events[KEYBOARD_EVENT_COUNT]; /* CS:007C */
	word16 readOffset; /* CS:00FC */
	word16 writeOffset; /* CS:00FE */
	word16 translationMode; /* CS:0100 */
	word16 modeFlags; /* CS:0102 */
} KeyboardRuntime;
#pragma pack(pop)

_Static_assert(sizeof(KeyboardRuntime) == 0x88,
	"The reconstructed CS:007C-0103 keyboard runtime block must be exact.");
_Static_assert(offsetof(KeyboardRuntime, readOffset) == 0x80,
	"The keyboard read offset must remain at CS:00FC.");
_Static_assert(offsetof(KeyboardRuntime, translationMode) == 0x84,
	"The translation mode must remain at CS:0100.");

static KeyboardRuntime Keyboard =
{
	{ 0x0000 },
	0x0000,
	0x0000,
	0x0110,
	0x0000
};
static uint32 SavedKeyboardInterruptVector; /* CS:018F */
static uint32 SavedCtrlBreakInterruptVector; /* CS:0193 */

// 3037:01A0
word16 KeyboardInputPending(void)
{
	if (SDLBackend_InputPending() != 0x0000)
	{
		word16 nextWriteOffset =
			(Keyboard.writeOffset + 0x02) &
			KEYBOARD_EVENT_WRAP_MASK;
		if (nextWriteOffset != Keyboard.readOffset)
		{
			Keyboard.events[Keyboard.writeOffset >> 0x01] =
				SDLBackend_ReadRawKeypress();
			Keyboard.writeOffset = nextWriteOffset;
		}
	}
	return Keyboard.readOffset ^ Keyboard.writeOffset;
}

// 3037:01B5
word16 ReadRawKeypress(void)
{
	word16 readOffset;
	word16 rawKeypress;

	do
	{
		if (SDLBackend_InputPending() != 0x0000)
		{
			word16 nextWriteOffset =
				(Keyboard.writeOffset + 0x02) &
				KEYBOARD_EVENT_WRAP_MASK;
			if (nextWriteOffset != Keyboard.readOffset)
			{
				Keyboard.events[Keyboard.writeOffset >> 0x01] =
					SDLBackend_ReadRawKeypress();
				Keyboard.writeOffset = nextWriteOffset;
			}
		}
		readOffset = Keyboard.readOffset;
	} while (readOffset == Keyboard.writeOffset);
	rawKeypress = Keyboard.events[readOffset >> 0x01];
	Keyboard.readOffset = (readOffset + 0x02) &
		KEYBOARD_EVENT_WRAP_MASK;
	return rawKeypress;
}

// 3037:01D7
int8 TranslateKeyCode(void)
{
	word16 rawKeypress = ReadRawKeypress();
	byte keyId = LOW_BYTE(rawKeypress);
	byte modifierFlags = HIGH_BYTE(rawKeypress);
	int8 translatedKeyCode;

	if (keyId == KEY_ID_ESCAPE)
		return KEY_ESCAPE;
	if (keyId < KEY_ID_ASCII_TABLE_LIMIT)
	{
		word16 tableIndex = keyId & 0x3F;
		translatedKeyCode = (int8)((modifierFlags & KEY_MODIFIER_SHIFT) == 0x00 ?
			AsciiTranslationTable[tableIndex] :
			ShiftedAsciiTranslationTable[tableIndex]);
		if ((modifierFlags & KEY_MODIFIER_CTRL) != 0x00 &&
			(CtrlTranslationBitmap[tableIndex >> 0x03] &
			 KeyBitMasks[tableIndex & 0x07]) != 0x00)
			translatedKeyCode &= KEY_CTRL_OUTPUT_MASK;
		return translatedKeyCode;
	}
	if (keyId >= KEY_ID_EXTENDED_LOOKUP_FIRST && keyId < KEY_ID_ESCAPE)
	{
		word16 translationIndex = keyId - KEY_ID_EXTENDED_LOOKUP_FIRST;
		if ((Keyboard.translationMode &
			KEYBOARD_MODE_FORCE_EXTENDED_TABLE) == 0x00 &&
			(Keyboard.modeFlags & KEYBOARD_LOCK_NUM) != 0x00)
			return (int8)NumericKeypadTranslationTable[translationIndex - 0x0F];
		return (int8)ExtendedTranslationTable[translationIndex];
	}
	if (keyId >= KEY_SCAN_F1 && keyId <= KEY_SCAN_F10)
	{
		byte functionKeyCode = KEYCODE_F1_BASE;
		if ((modifierFlags & KEY_MODIFIER_ANY_MASK) != 0x00)
		{
			functionKeyCode = KEYCODE_ALT_F1_BASE;
			if ((modifierFlags & KEY_MODIFIER_ALT) == 0x00)
			{
				functionKeyCode = KEYCODE_CTRL_F1_BASE;
				if ((modifierFlags & KEY_MODIFIER_CTRL) == 0x00)
					functionKeyCode = KEYCODE_SHIFT_F1_BASE;
			}
		}
		return (int8)(functionKeyCode - (keyId - KEY_SCAN_F1));
	}
	return (int8)(keyId | KEY_EXTENDED_OUTPUT_FLAG);
}

// 3037:0468
void InstallKeyboardHandlers(void)
{
	uint32 previousVector;

	Keyboard.readOffset = 0x0000;
	Keyboard.writeOffset = 0x0000;
	previousVector = SDLBackend_SwapInterruptVector(
		INTERRUPT_KEYBOARD_IRQ, MAKE_DWORD(0x3037, 0x0510));
	SavedKeyboardInterruptVector = previousVector;
	previousVector = SDLBackend_SwapInterruptVector(
		INTERRUPT_DOS_CTRL_BREAK, MAKE_DWORD(0x3037, 0x0762));
	SavedCtrlBreakInterruptVector = previousVector;
	SDLBackend_InstallKeyboardHandlers();
}

// 3037:0763
void RestoreKeyboardHandlers(void)
{
	SDLBackend_SwapInterruptVector(INTERRUPT_DOS_CTRL_BREAK,
		SavedCtrlBreakInterruptVector);
	SDLBackend_SwapInterruptVector(INTERRUPT_KEYBOARD_IRQ,
		SavedKeyboardInterruptVector);
	SDLBackend_RestoreKeyboardHandlers();
}
