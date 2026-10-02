#ifndef REVENGE_ORIGINAL_INPUT_DATA_H
#define REVENGE_ORIGINAL_INPUT_DATA_H

#include <stddef.h>

#include "revenge/types.h"

enum
{
	ORIGINAL_UI_REGION_COUNT = 0x10,
	ORIGINAL_UI_SELECTION_PENDING = 0x00FF
};

#pragma pack(push, 1)
typedef struct OriginalUiRegionRecord
{
	word16 leftColumn; /* +00 */
	word16 topRow; /* +02 */
	word16 widthColumns; /* +04 */
	word16 rowCount; /* +06 */
	word16 selectedRow; /* +08 */
	word16 unknown000A;
	word16 xorColor; /* +0C */
	word16 unknown000E;
} OriginalUiRegionRecord;
#pragma pack(pop)

_Static_assert(offsetof(OriginalUiRegionRecord, selectedRow) == 0x08,
	"The selected UI row must remain at record offset 08h.");
_Static_assert(offsetof(OriginalUiRegionRecord, xorColor) == 0x0C,
	"The UI highlight color must remain at record offset 0Ch.");
_Static_assert(sizeof(OriginalUiRegionRecord) == 0x10,
	"OriginalUiRegionRecord must retain its DOS layout.");

extern OriginalUiRegionRecord UiRegionTable[ORIGINAL_UI_REGION_COUNT];

#endif
