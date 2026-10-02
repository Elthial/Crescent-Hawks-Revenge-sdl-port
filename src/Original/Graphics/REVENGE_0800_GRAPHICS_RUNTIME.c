// REVENGE_0800_GRAPHICS_RUNTIME.c
// Runtime, codec, tactical-map, and video procedures reconstructed from
// REVENGE.EXE segment 0800.

// Video-buffer, adapter, timer, and arithmetic procedures from segment 0800.
#include "REVENGE.h"
#include "revenge/interrupts.h"
#include "revenge/original_data.h"
#include "revenge/platform_backend.h"
#include "revenge/video.h"

#include <string.h>

#define CGA_BYTES_PER_SCANLINE         0x0050
#define TANDY_BYTES_PER_SCANLINE_GROUP 0x00A0
#define EGA_BYTES_PER_SCANLINE         0x0028
#define VGA_BYTES_PER_SCANLINE         0x0140
#define CGA_TANDY_BANK_SIZE            0x2000

enum
{
	EGA_GC_ENABLE_SET_RESET_REGISTER = 0x01,
	EGA_GC_MODE_REGISTER = 0x05,
	EGA_GC_BIT_MASK_REGISTER = 0x08,
	EGA_GC_WRITE_MODE_0 = 0x00,
	EGA_GC_WRITE_MODE_1 = 0x01,
	EGA_GC_WRITE_MODE_2 = 0x02,
	EGA_SEQ_MAP_MASK_REGISTER = 0x02,
	EGA_ALL_PLANES = 0x0F,
	EGA_ALL_WRITABLE_PIXEL_BITS = 0xFF
};

// 0800:2B00: copy an adapter-formatted rectangle between far video buffers.
// Called from:
//      CopyClippedVideoRegion
void CopyVideoRegion(
	int16 sourceX,
	int16 sourceY,
	int16 destinationX,
	int16 destinationY,
	word16 width,
	word16 height,
	const byte *sourceBase,
	byte *destinationBase)
{
	// V: Copy a rectangular region between two FAR video buffers. The first
	// coordinate pair is the source origin, followed by width and height, then
	// source offset/segment and destination offset/segment.
	byte adapterType = (byte) ActiveVideoAdapterType;
	byte hostIndexedCopy = FALSE;
	word16 sourceXByte;
	word16 destinationXByte;
	word16 rowByteCount;

	/* The original EGA path names the visible and shadow pages as A000:0000
	 * and A200:0000. At the hardware boundary those pages are represented by
	 * the SDL indexed framebuffer and the decoded primary work buffer. */
	if (adapterType == VIDEO_ADAPTER_EGA || adapterType == VIDEO_ADAPTER_VGA)
	{
		if ((uintptr_t)sourceBase == 0xA0000000UL)
		{
			sourceBase = SDLBackend_GetIndexedFramebuffer();
			hostIndexedCopy = TRUE;
		}
		else if ((uintptr_t)sourceBase == 0xA2000000UL)
		{
			sourceBase = PrimaryScreenBuffer;
			hostIndexedCopy = TRUE;
		}
		if ((uintptr_t)destinationBase == 0xA0000000UL)
		{
			destinationBase = SDLBackend_GetIndexedFramebuffer();
			hostIndexedCopy = TRUE;
		}
		else if ((uintptr_t)destinationBase == 0xA2000000UL)
		{
			destinationBase = PrimaryScreenBuffer;
			hostIndexedCopy = TRUE;
		}
	}

	if (hostIndexedCopy != FALSE)
	{
		word16 row;
		word16 pixelWidth = width << 0x03;
		word16 sourcePixelX = (word16)sourceX << 0x03;
		word16 destinationPixelX = (word16)destinationX << 0x03;

		for (row = 0x0000; row < height; ++row)
		{
			memmove(destinationBase +
				(uint32)(destinationY + row) * VIDEO_SCREEN_WIDTH +
				destinationPixelX,
				sourceBase + (uint32)(sourceY + row) * VIDEO_SCREEN_WIDTH +
				sourcePixelX,
				pixelWidth);
		}
		return;
	}

	switch (adapterType)
	{
	case VIDEO_ADAPTER_CGA:
		sourceXByte = sourceX << 0x01;
		destinationXByte = destinationX << 0x01;
		rowByteCount = width << 0x01;
		break;
	case VIDEO_ADAPTER_TANDY:
		sourceXByte = sourceX << 0x02;
		destinationXByte = destinationX << 0x02;
		rowByteCount = width << 0x02;
		break;
	case VIDEO_ADAPTER_EGA:
		sourceXByte = sourceX;
		destinationXByte = destinationX;
		rowByteCount = width;
		break;
	default:
		sourceXByte = sourceX << 0x03;
		destinationXByte = destinationX << 0x03;
		rowByteCount = width << 0x03;
		break;
	}

	if (adapterType == VIDEO_ADAPTER_EGA)
	{
		DisableHardwareInterrupts();
		SDLBackend_SetEgaGraphicsControllerRegister(
			EGA_GC_MODE_REGISTER, EGA_GC_WRITE_MODE_1);
	}

	for (word16 row = 0x00; row < height; ++row)
	{
		word16 sourcePixelY = sourceY + row;
		word16 destinationPixelY = destinationY + row;
		word16 sourceScanlineOffset;
		word16 destinationScanlineOffset;

		switch (adapterType)
		{
		case VIDEO_ADAPTER_CGA:
			sourceScanlineOffset = (sourcePixelY >> 0x01) * CGA_BYTES_PER_SCANLINE
				+ (sourcePixelY & 0x01) * CGA_TANDY_BANK_SIZE + sourceXByte;
			destinationScanlineOffset = (destinationPixelY >> 0x01) * CGA_BYTES_PER_SCANLINE
				+ (destinationPixelY & 0x01) * CGA_TANDY_BANK_SIZE + destinationXByte;
			break;
		case VIDEO_ADAPTER_TANDY:
			sourceScanlineOffset = (sourcePixelY >> 0x02) * TANDY_BYTES_PER_SCANLINE_GROUP
				+ (sourcePixelY & 0x03) * CGA_TANDY_BANK_SIZE + sourceXByte;
			destinationScanlineOffset = (destinationPixelY >> 0x02) * TANDY_BYTES_PER_SCANLINE_GROUP
				+ (destinationPixelY & 0x03) * CGA_TANDY_BANK_SIZE + destinationXByte;
			break;
		case VIDEO_ADAPTER_EGA:
			sourceScanlineOffset = sourcePixelY * EGA_BYTES_PER_SCANLINE + sourceXByte;
			destinationScanlineOffset = destinationPixelY * EGA_BYTES_PER_SCANLINE + destinationXByte;
			break;
		default:
			sourceScanlineOffset = sourcePixelY * VGA_BYTES_PER_SCANLINE + sourceXByte;
			destinationScanlineOffset = destinationPixelY * VGA_BYTES_PER_SCANLINE + destinationXByte;
			break;
		}

		const byte *sourceRow = sourceBase + sourceScanlineOffset;
		byte *destinationRow = destinationBase + destinationScanlineOffset;
		for (word16 columnByte = 0x00;
			columnByte < rowByteCount;
			++columnByte)
		{
			destinationRow[columnByte] = sourceRow[columnByte];
		}
	}

	if (adapterType == VIDEO_ADAPTER_EGA)
		EnableHardwareInterrupts();
	return;

}


void FillVideoTileRectangle(
	int16 x,
	word16 y,
	word16 width,
	word16 height,
	byte color)
{
	// Verified against 0800:2DB0-2EC7.
	// Fill the rectangle (X, Y, width, height) with the supplied logical
	// color, converting that color and row stride for the active adapter.
	byte adapterType = (byte) ActiveVideoAdapterType;
	word16 xByte;
	word16 rowByteCount;
	word16 firstPixelY = y << 0x03;
	word16 scanlineCount = height << 0x03;
	byte packedColor = (byte)color;
	byte *videoBase = Video_ResolveIndexedRenderTarget(ActiveRenderTarget);
	word16 pixelX;
	word16 pixelWidth;

	/* The original procedure below addresses packed or planar adapter bytes.
	 * SDL exposes the equivalent visible page as one indexed byte per pixel,
	 * so terminate the hardware representation at this lowest video boundary.
	 * X/width and Y/height remain the original 8-pixel tile units. */
	if (videoBase != NULL)
	{
		pixelX = (word16)x << 0x03;
		pixelWidth = width << 0x03;
		if (adapterType == VIDEO_ADAPTER_CGA)
			packedColor &= 0x03;
		else if (adapterType == VIDEO_ADAPTER_TANDY ||
			adapterType == VIDEO_ADAPTER_EGA)
			packedColor &= 0x0F;

		for (word16 row = 0x00; row < scanlineCount; ++row)
		{
			if ((word16)(firstPixelY + row) >= VIDEO_SCREEN_HEIGHT)
				break;
			if (pixelX < VIDEO_SCREEN_WIDTH)
			{
				word16 visibleWidth = pixelWidth;
				if ((uint32)pixelX + visibleWidth > VIDEO_SCREEN_WIDTH)
					visibleWidth = VIDEO_SCREEN_WIDTH - pixelX;
				memset(videoBase +
					(uint32)(firstPixelY + row) * VIDEO_SCREEN_WIDTH + pixelX,
					packedColor, visibleWidth);
			}
		}
		return;
	}

	switch (adapterType)
	{
	case VIDEO_ADAPTER_CGA:
		xByte = x << 0x01;
		rowByteCount = width << 0x01;
		break;
	case VIDEO_ADAPTER_TANDY:
		xByte = x << 0x02;
		rowByteCount = width << 0x02;
		break;
	case VIDEO_ADAPTER_EGA:
		xByte = x;
		rowByteCount = width;
		break;
	default:
		xByte = x << 0x03;
		rowByteCount = width << 0x03;
		break;
	}

	if (adapterType == VIDEO_ADAPTER_EGA)
	{
		DisableHardwareInterrupts();
		SDLBackend_SetEgaGraphicsControllerRegister(
			EGA_GC_MODE_REGISTER, EGA_GC_WRITE_MODE_2);
		SDLBackend_SetEgaGraphicsControllerRegister(
			EGA_GC_BIT_MASK_REGISTER, EGA_ALL_WRITABLE_PIXEL_BITS);
	}
	else if (adapterType == VIDEO_ADAPTER_TANDY)
	{
		packedColor &= 0x0F;
		packedColor |= packedColor << 0x04;
	}
	else if (adapterType == VIDEO_ADAPTER_CGA)
	{
		packedColor &= 0x03;
		packedColor |= packedColor << 0x02;
		packedColor |= packedColor << 0x04;
	}

	for (word16 row = 0x00; row < scanlineCount; ++row)
	{
		word16 pixelY = firstPixelY + row;
		word16 scanlineOffset;

		switch (adapterType)
		{
		case VIDEO_ADAPTER_CGA:
			scanlineOffset = (pixelY >> 0x01) * CGA_BYTES_PER_SCANLINE
				+ (pixelY & 0x01) * CGA_TANDY_BANK_SIZE + xByte;
			break;
		case VIDEO_ADAPTER_TANDY:
			scanlineOffset = (pixelY >> 0x02) * TANDY_BYTES_PER_SCANLINE_GROUP
				+ (pixelY & 0x03) * CGA_TANDY_BANK_SIZE + xByte;
			break;
		case VIDEO_ADAPTER_EGA:
			scanlineOffset = pixelY * EGA_BYTES_PER_SCANLINE + xByte;
			break;
		default:
			scanlineOffset = pixelY * VGA_BYTES_PER_SCANLINE + xByte;
			break;
		}

		byte *videoRow = videoBase + scanlineOffset;
		for (word16 columnByte = 0x00;
			columnByte < rowByteCount;
			++columnByte)
		{
			videoRow[columnByte] = packedColor;
		}
	}

	if (adapterType == VIDEO_ADAPTER_EGA)
		EnableHardwareInterrupts();
	return;

}


// 0800:2F05: draw one adapter-formatted 8x8 tile at tile coordinates X,Y.
// Called from:
//      DrawActiveTextWindowFrame
//      DrawRepeatingFrameTileSequence
void Draw8x8VideoTile(
	const byte *tilePixels,
	int16 x,
	word16 y)
{
	// V: Draw one adapter-formatted 8x8 tile from the FAR source at (X,Y).
	// The EGA path writes eight rows and selects each of the four planes.
	byte adapterType = (byte) ActiveVideoAdapterType;
	word16 xByte;
	word16 firstPixelY = y << 0x03;
	word16 bytesPerSourceRow;
	byte *videoBase = SDLBackend_GetIndexedFramebuffer();

	switch (adapterType)
	{
	case VIDEO_ADAPTER_CGA:
		xByte = x << 0x01;
		bytesPerSourceRow = 0x02;
		break;
	case VIDEO_ADAPTER_TANDY:
		xByte = x << 0x02;
		bytesPerSourceRow = 0x04;
		break;
	case VIDEO_ADAPTER_EGA:
		xByte = x;
		bytesPerSourceRow = 0x01;
		break;
	default:
		xByte = x << 0x03;
		bytesPerSourceRow = 0x08;
		break;
	}

	if (adapterType == VIDEO_ADAPTER_EGA)
	{
		word16 row;

		/* DOS writes one byte to each EGA plane at a 40-byte scanline.
		 * SDL exposes the same page as 320 indexed pixels per scanline, so
		 * expand the four plane bytes at this hardware boundary. */
		DisableHardwareInterrupts();
		SDLBackend_SetEgaGraphicsControllerRegister(
			EGA_GC_MODE_REGISTER, EGA_GC_WRITE_MODE_0);
		SDLBackend_SetEgaGraphicsControllerRegister(
			EGA_GC_BIT_MASK_REGISTER, EGA_ALL_WRITABLE_PIXEL_BITS);
		SDLBackend_SetEgaGraphicsControllerRegister(
			EGA_GC_ENABLE_SET_RESET_REGISTER, 0x00);

		for (row = 0x00; row < 0x08; ++row)
		{
			int16 pixelY;
			word16 pixel;

			pixelY = (int16) (firstPixelY + row);
			for (pixel = 0x00; pixel < 0x08; ++pixel)
			{
				int16 pixelX;
				byte pixelMask;
				byte color;
				byte plane;

				pixelX = (int16) (x * 0x08 + pixel);
				pixelMask = (byte) (0x80 >> pixel);
				color = 0x00;
				for (plane = 0x00; plane < 0x04; ++plane)
				{
					SDLBackend_SetEgaSequencerRegister(
						EGA_SEQ_MAP_MASK_REGISTER,
						(byte) (0x01 << plane));
					if ((tilePixels[row * 0x04 + plane] & pixelMask) != 0x00)
						color |= (byte) (0x01 << plane);
				}
				if (pixelX >= VIDEO_SCREEN_MIN_X &&
					pixelX <= VIDEO_SCREEN_MAX_X &&
					pixelY >= VIDEO_SCREEN_MIN_Y &&
					pixelY <= VIDEO_SCREEN_MAX_Y)
				{
					videoBase[(uint32) pixelY * VIDEO_SCREEN_WIDTH +
						(word16) pixelX] = color;
				}
			}
		}
		SDLBackend_SetEgaSequencerRegister(
			EGA_SEQ_MAP_MASK_REGISTER, EGA_ALL_PLANES);
		EnableHardwareInterrupts();
		return;
	}

	for (word16 row = 0x00; row < 0x08; ++row)
	{
		word16 pixelY = firstPixelY + row;
		word16 scanlineOffset;

		if (adapterType == VIDEO_ADAPTER_CGA)
		{
			scanlineOffset = (pixelY >> 0x01) * CGA_BYTES_PER_SCANLINE
				+ (pixelY & 0x01) * CGA_TANDY_BANK_SIZE + xByte;
		}
		else if (adapterType == VIDEO_ADAPTER_TANDY)
		{
			scanlineOffset = (pixelY >> 0x02) * TANDY_BYTES_PER_SCANLINE_GROUP
				+ (pixelY & 0x03) * CGA_TANDY_BANK_SIZE + xByte;
		}
		else
		{
			scanlineOffset = pixelY * VGA_BYTES_PER_SCANLINE + xByte;
		}

		byte *videoRow = videoBase + scanlineOffset;
		for (word16 columnByte = 0x00;
			columnByte < bytesPerSourceRow;
			++columnByte)
		{
			videoRow[columnByte] =
				tilePixels[row * bytesPerSourceRow + columnByte];
		}
	}
	return;

}


// 0800:33D6: decode the signed-run stream into 7D00h linear bytes.
void DecodeLinearRleScreen(
	const byte *compressedData,
	byte *destination)
{
	word16 remainingBytes = 0x7D00;

	while (remainingBytes != 0x00)
	{
		byte control = *compressedData++;
		word16 runLength;
		word16 runIndex;
		word16 repeatRun = control == 0x00 || control >= 0x80;
		byte repeatedValue;

		if (control == 0x00)
		{
			runLength = *(const word16 *)compressedData;
			compressedData += 0x02;
		}
		else if (control >= 0x80)
			runLength = (byte)-control;
		else
			runLength = control;
		repeatedValue = repeatRun ? *compressedData : 0x00;

		for (runIndex = 0x00; runIndex < runLength && remainingBytes != 0x00;
			++runIndex, --remainingBytes)
			*destination++ = repeatRun ? repeatedValue : *compressedData++;

		if (repeatRun)
			++compressedData;
	}
}

// 0800:342D: decode the same stream down 200-pixel columns in a
// 160-byte-stride 320x200 packed page.
void DecodeColumnMajorRleScreen(
	const byte *compressedData,
	byte *destination)
{
	word16 outputIndex = 0x00;

	while (outputIndex < 0x7D00)
	{
		byte control = *compressedData++;
		word16 runLength;
		word16 runIndex;
		word16 repeatRun = control == 0x00 || control >= 0x80;
		byte repeatedValue;

		if (control == 0x00)
		{
			runLength = *(const word16 *)compressedData;
			compressedData += 0x02;
		}
		else if (control >= 0x80)
			runLength = (byte)-control;
		else
			runLength = control;
		repeatedValue = repeatRun ? *compressedData : 0x00;

		for (runIndex = 0x00; runIndex < runLength && outputIndex < 0x7D00;
			++runIndex, ++outputIndex)
		{
			word16 column = outputIndex / 0x00C8;
			word16 row = outputIndex % 0x00C8;
			destination[row * 0x00A0 + column] =
				repeatRun ? repeatedValue : *compressedData++;
		}

		if (repeatRun)
			++compressedData;
	}
}


// 0800:072C: Register uint32 CalculateSelectedWeaponRating(
//     Stack uint32 weaponMask, Stack const byte *weaponCounts)
// Called from:
//      RecalculateUnitCombatRatings
uint32 CalculateSelectedWeaponRating(
	uint32 weaponMask,
	const uint16 *weaponCounts)
{
	uint32 rating;
	word16 weaponIndex;

	rating = 0x00000000UL;
	for (weaponIndex = 0x0000;
		weaponIndex < WEAPON_DEFINITION_COUNT
			&& weaponMask != 0x00000000UL;
		++weaponIndex)
	{
		if ((weaponMask & 0x00000001UL) != 0x00000000UL)
		{
			rating += (uint32) WeaponCombatRatingByType[weaponIndex]
				* (byte) weaponCounts[weaponIndex];
		}

		weaponMask >>= 0x01;
	}

	return rating;
}

void InstallDamagedTerrainSpriteLookup(void)
{
	/* 0800:0959 publishes CS:01C9 through DS:7A73. ICONLIST.DAT replaces these
	 * 300h bytes for the active icon set, and BuildTacticalTerrainCellMaps
	 * indexes the same table directly at 0800:0694 using (damageState - 1) in
	 * AH and terrainType in AL. The scenario classification map starts at the
	 * following CS:04C9; it is not the damaged-sprite lookup. */
	TerrainDamageCapabilityTable = (byte *) HostFarPointer_Resolve(
		0x080001C9UL);
	DamagedTerrainSpriteLookup = TerrainDamageCapabilityTable;
}

word16 GeneratePseudoRandomByte(void)
{
	/* 0800:4D46 -- three-byte Borland-era shift-register state. */
	static byte state[0x03] = { 0x34, 0x12, 0x76 };
	byte accumulator;
	byte carry;
	byte nextCarry;

	accumulator = state[0x00];
	accumulator >>= 0x01;
	carry = accumulator & 0x01;
	accumulator >>= 0x01;
	nextCarry = state[0x02] >> 0x07;
	state[0x02] = (byte) (state[0x02] << 0x01) | carry;
	carry = nextCarry;
	nextCarry = state[0x01] >> 0x07;
	state[0x01] = (byte) (state[0x01] << 0x01) | carry;
	carry = nextCarry == 0x00;
	accumulator = (byte) (accumulator - state[0x00] - carry);
	carry = accumulator & 0x01;
	state[0x00] = (byte) (state[0x00] >> 0x01) | (byte) (carry << 0x07);
	return (word16) (state[0x00] ^ state[0x01]);
}

uint32 NormalizeFarPointer(word16 offset, word16 segment)
{
	/* 0800:3B9E -- normalize to an offset in 0000h..000Fh. */
	return ((uint32) (segment + (offset >> 0x04)) << 0x10) |
		(offset & 0x000F);
}

void *AddSignedOffsetToFarPointer(const void *pointer, int32_t displacement)
{
	uint32 linearAddress = HostFarPointer_ToLinear(pointer) + displacement;
	uint32 normalized = ((linearAddress >> 0x04) << 0x10) |
		(linearAddress & 0x0F);
	return HostFarPointer_Resolve(normalized);
}

int16 CompareNormalizedFarPointers(const void *left, const void *right)
{
	uint32 leftLinear = HostFarPointer_ToLinear(left);
	uint32 rightLinear = HostFarPointer_ToLinear(right);

	if (leftLinear < rightLinear)
		return -0x01;
	if (leftLinear > rightLinear)
		return 0x01;
	return 0x00;
}

int32_t CalculateFarPointerByteDistance(
	word16 endOffset,
	word16 startSegment,
	word16 endSegment,
	word16 startOffset)
{
	int32_t endLinear = ((uint32) endSegment << 0x04) + endOffset;
	int32_t startLinear = ((uint32) startSegment << 0x04) + startOffset;
	return endLinear - startLinear;
}

void CopyFarBytes32(
	const void *source,
	void *destination,
	uint32 byteCount)
{
	const byte *sourceByte = (const byte *) source;
	byte *destinationByte = (byte *) destination;

	/* 0800:2EC8 is a forward REP MOVSW/MOVSB copy, not memmove. */
	while (byteCount-- != 0x00000000UL)
		*destinationByte++ = *sourceByte++;
}

// 0800:2D37: byte fill used by the graphics/runtime segment.
void FillRuntimeFarMemoryBytes(
	byte *destination,
	word16 byteCount,
	byte value)
{
	/* ES:DI destination, CX count, AL value, REP STOSB. */
	while (byteCount-- != 0x0000)
		*destination++ = value;
}

uint32 MultiplyUnsignedLong(
	word16 leftLow,
	word16 rightHigh,
	word16 leftHigh,
	word16 rightLow)
{
	/* 0800:542C returns the low 32 bits of unsigned DX:AX * CX:BX. */
	return (uint32) (((uint32) leftHigh << 0x10) | leftLow) *
		(uint32) (((uint32) rightHigh << 0x10) | rightLow);
}

uint32 ShiftLeft32_DXAX(
	word16 valueLow,
	byte shiftCount,
	word16 valueHigh)
{
	uint32 value = ((uint32) valueHigh << 0x10) | valueLow;

	/* All callers supply counts in the original helper's defined 0..31
	 * domain. The two assembly branches split that domain at 10h. */
	return value << shiftCount;
}

uint32 ShiftRight32_DXAX(
	word16 valueLow,
	byte shiftCount,
	word16 valueHigh)
{
	uint32 value = ((uint32) valueHigh << 0x10) | valueLow;

	return value >> shiftCount;
}

void CopyFarMemory(
	word16 byteCount,
	const byte *source,
	byte *destination)
{
	/* 0800:554B -- CLD; REP MOVSW; ADC CX,CX; REP MOVSB. This is a
	 * forward copy and deliberately does not provide memmove semantics. */
	while (byteCount-- != 0x0000)
		*destination++ = *source++;
}

void PackLowNibblesTo4Bpp(
	const byte *source,
	byte *destination)
{
	word16 packedByteCount;

	/* 0800:0F74 -- 7D00h LODSW/STOSB iterations. */
	for (packedByteCount = 0x7D00;
		packedByteCount != 0x0000;
		--packedByteCount)
	{
		*destination++ = (byte) ((source[0x00] << 0x04) |
			(source[0x01] & 0x0F));
		source += 0x02;
	}
}

byte ExtractHighNibbleAndShiftLeft(word16 *packedPixels)
{
	byte highNibble = (byte) (*packedPixels >> 0x0C);

	*packedPixels = (word16) (*packedPixels << 0x04);
	return highNibble;
}

word16 EncodeDisplayBackingRows(
	const byte *source,
	byte *destination,
	word16 groupsPerRow,
	byte rowCount,
	int16 sourceRowSkip)
{
	byte *destinationStart = destination;
	byte row;

	if (ActiveVideoAdapterType != VIDEO_ADAPTER_EGA)
	{
		for (row = 0x00; row < rowCount; ++row)
		{
			word16 group;

			for (group = 0x0000; group < (byte) groupsPerRow; ++group)
			{
				*destination++ = *source++;
				if (ActiveVideoAdapterType == VIDEO_ADAPTER_CGA)
					++source;
				else
					*destination++ = *source++;
			}
			source += sourceRowSkip;
		}
		return (word16) (destination - destinationStart);
	}

	for (row = 0x00; row < rowCount; ++row)
	{
		word16 group;

		for (group = 0x0000; group < (byte) groupsPerRow; ++group)
		{
			byte colorMasks[0x10] = { 0x00 };
			word16 firstPixels = (word16)
				(((word16) source[0x00] << 0x08) | source[0x01]);
			word16 secondPixels = (word16)
				(((word16) source[0x02] << 0x08) | source[0x03]);
			byte pixelMask = 0x80;
			byte pixel;
			byte colorIndex;
			byte emittedPair = FALSE;

			source += 0x04;
			for (pixel = 0x00; pixel < 0x08; ++pixel)
			{
				colorIndex = pixel < 0x04
					? ExtractHighNibbleAndShiftLeft(&firstPixels)
					: ExtractHighNibbleAndShiftLeft(&secondPixels);
				colorMasks[colorIndex] |= pixelMask;
				pixelMask >>= 0x01;
			}

			for (colorIndex = 0x01; colorIndex < 0x10; ++colorIndex)
			{
				if (colorMasks[colorIndex] != 0x00)
				{
					*destination++ = colorMasks[colorIndex];
					*destination++ = colorIndex;
					emittedPair = TRUE;
				}
			}
			if (emittedPair == FALSE)
			{
				*destination++ = 0x00;
				*destination++ = 0x00;
			}
			destination[-0x01] |= 0x80;
		}
		destination[-0x01] |= 0x40;
		source += sourceRowSkip;
	}
	destination[-0x01] |= 0x20;
	return (word16) (destination - destinationStart);
}

void RepackCgaAlternateScanlines(byte *screenBuffer)
{
	word16 row;

	/* 0800:32ED copies from the end toward the beginning so expansion in
	 * place cannot overwrite source rows that have not yet been read. */
	for (row = 0x0000; row < 0x00FA; ++row)
	{
		byte *source = screenBuffer + 0x3E40 - row * 0x0040;
		byte *destination = screenBuffer + 0x7C80 - row * 0x0080;

		CopyFarMemory(0x0040, source, destination);
	}
}

void ShiftPackedPixelsIntoEGAPlanes(
	byte packedPixels,
	byte *plane3,
	byte *plane2,
	byte *plane1,
	byte *plane0)
{
	*plane3 = (byte) ((*plane3 << 0x01) |
		((packedPixels >> 0x07) & 0x01));
	*plane2 = (byte) ((*plane2 << 0x01) |
		((packedPixels >> 0x06) & 0x01));
	*plane1 = (byte) ((*plane1 << 0x01) |
		((packedPixels >> 0x05) & 0x01));
	*plane0 = (byte) ((*plane0 << 0x01) |
		((packedPixels >> 0x04) & 0x01));
}

void ConvertPackedPixelsToEGAPlanar(
	const byte *source,
	byte *destination,
	word16 packedWordCount)
{
	word16 groupCount = packedWordCount >> 0x01;
	word16 group;

	for (group = 0x0000; group < groupCount; ++group)
	{
		byte plane0 = 0x00;
		byte plane1 = 0x00;
		byte plane2 = 0x00;
		byte plane3 = 0x00;
		byte packedByte;

		for (packedByte = 0x00; packedByte < 0x04; ++packedByte)
		{
			byte pixels = *source++;

			ShiftPackedPixelsIntoEGAPlanes(
				pixels, &plane3, &plane2, &plane1, &plane0);
			pixels <<= 0x04;
			ShiftPackedPixelsIntoEGAPlanes(
				pixels, &plane3, &plane2, &plane1, &plane0);
		}
		*destination++ = plane0;
		*destination++ = plane1;
		*destination++ = plane2;
		*destination++ = plane3;
	}
}

void ConvertCgaPackedPixels(
	const byte *source,
	byte *destination,
	byte phaseRunLength,
	word16 outputByteCount)
{
	byte oddPhase = FALSE;
	byte phaseRemaining = phaseRunLength;

	while (outputByteCount-- != 0x0000)
	{
		const byte *lookup = oddPhase != FALSE
			? CgaOddPixelPhaseLookup
			: CgaEvenPixelPhaseLookup;

		*destination++ = (byte) ((lookup[source[0x00]] << 0x04) |
			lookup[source[0x01]]);
		source += 0x02;
		if (--phaseRemaining == 0x00)
		{
			oddPhase ^= TRUE;
			phaseRemaining = phaseRunLength;
		}
	}
}

void ConvertCgaPackedPixelsAndBuildMask(
	byte *buffer,
	word16 narrowStrideMode)
{
	byte phaseRunLength = narrowStrideMode != FALSE ? 0x04 : 0x50;
	byte phaseRemaining = phaseRunLength;
	byte oddPhase = FALSE;
	word16 pairCount;

	for (pairCount = 0x0000; pairCount < 0x3E80; ++pairCount)
	{
		const byte *lookup = oddPhase != FALSE
			? CgaOddPixelPhaseLookup
			: CgaEvenPixelPhaseLookup;
		byte firstPackedPixels = buffer[0x00];
		byte secondPackedPixels = buffer[0x01];
		byte opaqueMask = 0x00;

		buffer[0x00] = (byte) ((lookup[firstPackedPixels] << 0x04) |
			lookup[secondPackedPixels]);
		if ((firstPackedPixels & 0xF0) != 0x00)
			opaqueMask |= 0xC0;
		if ((firstPackedPixels & 0x0F) != 0x00)
			opaqueMask |= 0x30;
		if ((secondPackedPixels & 0xF0) != 0x00)
			opaqueMask |= 0x0C;
		if ((secondPackedPixels & 0x0F) != 0x00)
			opaqueMask |= 0x03;
		buffer[0x01] = (byte) ~opaqueMask;
		buffer += 0x02;

		if (--phaseRemaining == 0x00)
		{
			oddPhase ^= TRUE;
			phaseRemaining = phaseRunLength;
		}
	}
}

uint32 DivideUnsignedLong(uint32 dividend, uint32 divisor)
{
	return dividend / divisor;
}
uint32 SavedGameClockVector;
static DOS_InterruptHandler SavedGameClockHostHandler;

void GameClockInt1CHandler(void)
{
	if (TacticalUpdateDelayTicks != 0x00)
		--TacticalUpdateDelayTicks;
	if (TacticalKeyRepeatDelayTicks != 0x00)
		--TacticalKeyRepeatDelayTicks;
	++GameTimerTicks;
	++GameAnimationTicks;
	if (SavedGameClockHostHandler != NULL)
		SavedGameClockHostHandler();
	else if (SavedGameClockVector != 0x00000000UL)
		SDLBackend_ChainInterruptVector(
			SavedGameClockVector);
}

void InstallGameClockTimer(void)
{
	/* 0800:23F0 -- save and replace DOS INT 1Ch. */
	SavedGameClockVector = SDLBackend_SwapInterruptVector(
		0x1C, 0x08002440UL);
	SavedGameClockHostHandler = SDLBackend_SwapInterruptHandler(
		0x1C, GameClockInt1CHandler);
}

void RestoreGameClockTimer(void)
{
	/* 0800:241E -- restore the saved DOS INT 1Ch handler. */
	SDLBackend_SwapInterruptVector(0x1C, SavedGameClockVector);
	SDLBackend_SwapInterruptHandler(0x1C, SavedGameClockHostHandler);
}

void EnableHardwareInterrupts(void)
{
	/* 0800:34F4 -- STI. */
	RevengeHost_EnableInterruptDelivery();
}

void DisableHardwareInterrupts(void)
{
	/* 0800:34F6 -- CLI. */
	RevengeHost_DisableInterruptDelivery();
}

void InitializeCgaPixelTranslationTables(const byte *seedTable)
{
	word16 packedPixels;

	if (ActiveVideoAdapterType != VIDEO_ADAPTER_CGA)
		return;
	memcpy(CgaPackedPixelSeedTable, seedTable,
		sizeof(CgaPackedPixelSeedTable));
	for (packedPixels = 0x00; packedPixels < 0x0100; ++packedPixels)
	{
		byte highPixel = (byte) (packedPixels >> 0x04);
		byte lowPixel = (byte) (packedPixels & 0x0F);

		CgaEvenPixelPhaseLookup[packedPixels] =
			(byte) ((CgaPackedPixelSeedTable[highPixel] << 0x02) |
			CgaPackedPixelSeedTable[0x10 + lowPixel]);
		CgaOddPixelPhaseLookup[packedPixels] =
			(byte) ((CgaPackedPixelSeedTable[0x10 + highPixel] << 0x02) |
			CgaPackedPixelSeedTable[lowPixel]);
	}
}

void InitializeMouseSupport(void)
{
	/* 0800:36A6 reserves the 0240h-byte cursor backing store, initializes
	 * the 320x200 bounds, centers the cursor, and installs the INT 33h ISR.
	 * SDL replaces only the driver probe and ISR boundary. */
	MouseCursorBackground = AllocateFarMemory(0x0240);
	if (MouseCursorBackground == NULL)
	{
		MouseDriverInstalled = FALSE;
		return;
	}
	MouseCursorRequestedX = 0x00A0;
	MouseY = 0x0064;
	MouseDriverDoubleX = FALSE;
	MouseCursorHideDepth = 0x01;
	MouseInputDisabled = FALSE;
	MouseCursorMinX = 0x0000;
	MouseCursorMaxX = 0x013F;
	MouseCursorMinY = 0x0000;
	MouseCursorMaxY = 0x00C7;
	MouseDriverInstalled = TRUE;
	SDLBackend_SetMousePosition(0x00A0, 0x0064);
	SDLBackend_SetMouseVisible(FALSE);
}

void CopyBufferToVideoRegion(
	int16 xColumn,
	word16 yCharacterRow,
	word16 widthColumns,
	word16 heightCharacterRows,
	const byte *source)
{
	word16 row;
	word16 pixelWidth;
	word16 pixelHeight;
	word16 leftX;
	word16 topY;
	byte *framebuffer;

	if (xColumn < 0x0000 || xColumn >= VIDEO_SCREEN_8PX_COLUMN_COUNT ||
		yCharacterRow >= VIDEO_SCREEN_HEIGHT / 0x0008 ||
		widthColumns == 0x0000 || heightCharacterRows == 0x0000)
		return;
	pixelWidth = (word16) (widthColumns << 0x03);
	pixelHeight = (word16) (heightCharacterRows << 0x03);
	leftX = (word16) xColumn << 0x03;
	topY = yCharacterRow << 0x03;
	if (leftX + pixelWidth > VIDEO_SCREEN_WIDTH)
		pixelWidth = VIDEO_SCREEN_WIDTH - leftX;
	if (topY + pixelHeight > VIDEO_SCREEN_HEIGHT)
		pixelHeight = VIDEO_SCREEN_HEIGHT - topY;
	framebuffer = SDLBackend_GetIndexedFramebuffer();
	for (row = 0x0000; row < pixelHeight; ++row)
	{
		memcpy(framebuffer + (uint32) (topY + row) * VIDEO_SCREEN_WIDTH + leftX,
			source, pixelWidth);
		source += pixelWidth;
	}
}

void CopyVideoRegionToBuffer(
	int16 xColumn,
	word16 yCharacterRow,
	word16 widthColumns,
	word16 heightCharacterRows,
	byte *destination)
{
	word16 row;
	word16 pixelWidth;
	word16 pixelHeight;
	word16 leftX;
	word16 topY;
	byte *framebuffer;

	if (xColumn < 0x0000 || xColumn >= VIDEO_SCREEN_8PX_COLUMN_COUNT ||
		yCharacterRow >= VIDEO_SCREEN_HEIGHT / 0x0008 ||
		widthColumns == 0x0000 || heightCharacterRows == 0x0000)
		return;
	pixelWidth = (word16) (widthColumns << 0x03);
	pixelHeight = (word16) (heightCharacterRows << 0x03);
	leftX = (word16) xColumn << 0x03;
	topY = yCharacterRow << 0x03;
	if (leftX + pixelWidth > VIDEO_SCREEN_WIDTH)
		pixelWidth = VIDEO_SCREEN_WIDTH - leftX;
	if (topY + pixelHeight > VIDEO_SCREEN_HEIGHT)
		pixelHeight = VIDEO_SCREEN_HEIGHT - topY;
	framebuffer = SDLBackend_GetIndexedFramebuffer();
	for (row = 0x0000; row < pixelHeight; ++row)
	{
		memcpy(destination,
			framebuffer + (uint32) (topY + row) * VIDEO_SCREEN_WIDTH + leftX,
			pixelWidth);
		destination += pixelWidth;
	}
}

void ShutdownMouseSupport(void)
{
	if (MouseDriverInstalled != FALSE)
		SDLBackend_SetMouseVisible(FALSE);
}

void Tandy_LoadPaletteRegisters(const byte *paletteValues)
{
	byte paletteRegister;

	if (ActiveVideoAdapterType != VIDEO_ADAPTER_TANDY)
		return;
	for (paletteRegister = 0x00; paletteRegister < 0x10; ++paletteRegister)
		SDLBackend_SetPaletteRegister(
			(byte) (0x10 + paletteRegister), paletteValues[paletteRegister]);
}

uint16 DOS_PrintCharacter(char character)
{
	/* 0800:3BBF -- DOS INT 21h/AH=06h. */
	return SDLBackend_DirectConsoleIO((byte) character);
}

void DOS_SelectDefaultDrive(byte zeroBasedDrive)
{
	/* 0800:4D81 -- DOS INT 21h/AH=0Eh. */
	SDLBackend_SelectDefaultDrive(zeroBasedDrive);
}

void BIOS_SelectCgaPalette(byte paletteId)
{
	/* 0800:4D98 -- BIOS INT 10h/AH=0Bh. */
	SDLBackend_SelectCgaPalette(paletteId);
}

void EGA_SetPaletteRegister(byte paletteRegister, byte paletteValue)
{
	/* 0800:4DB1 -- EGA attribute-controller register write. */
	SDLBackend_SetPaletteRegister(paletteRegister, paletteValue);
}

void VGA_LoadPalette(const byte *paletteRgbTriplets)
{
	/* 0800:0974 -- BIOS INT 10h/AX=1012h. */
	SDLBackend_LoadVgaPalette(paletteRgbTriplets);
}

void SetVideoAdapterType(uint16 adapterType)
{
	/* 0800:4DE7 -- original assignment to 4184:0E4C. */
	ActiveVideoAdapterType = adapterType;
	SDLBackend_SetVideoAdapter(adapterType);
}

uint16 IsVerticalRetraceActive(void)
{
	/* 0800:4EAA -- input-status port 03DAh, bit 3. */
	return SDLBackend_IsVerticalRetraceActive();
}

void WaitForVerticalRetraceEdge(byte waitForRetraceStart)
{
	/* 0800:4EC2 -- input-status port 03DAh polling loops. */
	SDLBackend_WaitVerticalRetrace(waitForRetraceStart);
}

void ClearActiveVideoBuffer(void)
{
	/* 0800:2D59 clears the entire adapter framebuffer. The original selects
	 * 2000h/4000h/0FA0h/8000h hardware byte counts; the host boundary stores
	 * the equivalent 320x200 indexed image. */
	DisableHardwareInterrupts();
	SDLBackend_ClearIndexedFramebuffer(0x00);
	EnableHardwareInterrupts();
}

void EGA_ConvertPackedScreenToPlanar(
	const byte *packedPixels,
	word16 destinationVideoSegment)
{
	word16 y;

	(void) destinationVideoSegment;
	DisableHardwareInterrupts();
	for (y = 0x0000; y < VIDEO_SCREEN_HEIGHT; ++y)
	{
		word16 packedX;

		for (packedX = 0x0000; packedX < VIDEO_SCREEN_WIDTH / 0x0002;
			++packedX)
		{
			byte packed = *packedPixels++;
			word16 x = packedX << 0x01;

			SDLBackend_DrawIndexedPixel(
				x, y, (byte) (packed >> 0x04));
			SDLBackend_DrawIndexedPixel(
				(word16) (x + 0x0001), y, (byte) (packed & 0x0F));
		}
	}
	EnableHardwareInterrupts();
}

void FillTandyPackedRectangle(
	int16 leftX,
	int16 topY,
	word16 packedWidthMinusOne,
	int16 heightMinusOne,
	byte color)
{
	word16 packedByteCount = (word16) (packedWidthMinusOne + 0x01);
	int16 row;
	word16 packedByte;
	byte pixelColor = color & 0x0F;
	int16 evenLeftX = (int16) (leftX & ~0x01);

	/* 0800:3327 uses REP STOSB for packed bytes and advances through the four
	 * Tandy scanline banks. SDL replaces only that physical layout. */
	for (row = 0x00; row <= heightMinusOne; ++row)
	{
		for (packedByte = 0x0000;
			packedByte < packedByteCount;
			++packedByte)
		{
			int16 x = (int16) (evenLeftX + packedByte * 0x02);

			SDLBackend_DrawIndexedPixel(
				(word16) x, (word16) (topY + row), pixelColor);
			SDLBackend_DrawIndexedPixel(
				(word16) (x + 0x01), (word16) (topY + row), pixelColor);
		}
	}
}

void ReadEGAPlanarTile(
	byte *destination,
	int16 sourceByteColumn,
	word16 sourceTileRow)
{
	byte *framebuffer = SDLBackend_GetIndexedFramebuffer();
	word16 row;
	word16 xStart = (word16) sourceByteColumn << 0x03;
	word16 yStart = sourceTileRow << 0x03;

	DisableHardwareInterrupts();
	for (row = 0x0000; row < 0x0008; ++row)
	{
		byte plane[0x04] = { 0x00, 0x00, 0x00, 0x00 };
		word16 pixel;

		for (pixel = 0x0000; pixel < 0x0008; ++pixel)
		{
			byte color = framebuffer[
				(uint32) (yStart + row) * 0x0140 + xStart + pixel];
			byte bit = (byte) (0x80 >> pixel);
			byte planeIndex;

			for (planeIndex = 0x00; planeIndex < 0x04; ++planeIndex)
			{
				if ((color & (0x01 << planeIndex)) != 0x00)
					plane[planeIndex] |= bit;
			}
		}
		*destination++ = plane[0x00];
		*destination++ = plane[0x01];
		*destination++ = plane[0x02];
		*destination++ = plane[0x03];
	}
	EnableHardwareInterrupts();
}

void DrawVerticalSpan(
	word16 x,
	word16 yStart,
	word16 yEnd,
	word16 color)
{
	word16 y;
	byte pixelColor = (byte) color;

	if (ActiveVideoAdapterType == VIDEO_ADAPTER_CGA)
		pixelColor &= 0x03;
	else if (ActiveVideoAdapterType == VIDEO_ADAPTER_TANDY ||
		ActiveVideoAdapterType == VIDEO_ADAPTER_EGA)
		pixelColor &= 0x0F;

	for (y = yStart; y <= yEnd; ++y)
		Video_DrawIndexedPixelToActiveTarget(x, y, pixelColor);
}

void DrawHorizontalVideoRun(
	int16 x,
	word16 y,
	word16 nativeRunLength,
	word16 color)
{
	word16 pixelsPerNativeByte;
	word16 pixelCount;
	word16 pixel;
	byte pixelColor = (byte) color;

	switch (ActiveVideoAdapterType)
	{
	case VIDEO_ADAPTER_CGA:
		pixelsPerNativeByte = 0x04;
		pixelColor &= 0x03;
		break;
	case VIDEO_ADAPTER_TANDY:
		pixelsPerNativeByte = 0x02;
		pixelColor &= 0x0F;
		break;
	case VIDEO_ADAPTER_EGA:
		pixelsPerNativeByte = 0x08;
		pixelColor &= 0x0F;
		break;
	default:
		pixelsPerNativeByte = 0x01;
		break;
	}

	pixelCount = nativeRunLength * pixelsPerNativeByte;
	for (pixel = 0x00; pixel < pixelCount; ++pixel)
		Video_DrawIndexedPixelToActiveTarget(
			(word16) (x + pixel), y, pixelColor);
}

void XorVideoRectangle(
	int16 leftX,
	int16 topY,
	int16 rightX,
	int16 bottomY,
	byte color)
{
	int16 x;
	int16 y;
	byte pixelColor = color;

	if (leftX < VIDEO_SCREEN_MIN_X)
		leftX = VIDEO_SCREEN_MIN_X;
	else if (leftX > VIDEO_SCREEN_MAX_X)
		leftX = VIDEO_SCREEN_MAX_X;
	if (rightX < VIDEO_SCREEN_MIN_X)
		rightX = VIDEO_SCREEN_MIN_X;
	else if (rightX > VIDEO_SCREEN_MAX_X)
		rightX = VIDEO_SCREEN_MAX_X;
	if (topY < VIDEO_SCREEN_MIN_Y)
		topY = VIDEO_SCREEN_MIN_Y;
	else if (topY > VIDEO_SCREEN_MAX_Y)
		topY = VIDEO_SCREEN_MAX_Y;
	if (bottomY < VIDEO_SCREEN_MIN_Y)
		bottomY = VIDEO_SCREEN_MIN_Y;
	else if (bottomY > VIDEO_SCREEN_MAX_Y)
		bottomY = VIDEO_SCREEN_MAX_Y;

	if (leftX > rightX)
	{
		int16 swap = leftX;
		leftX = rightX;
		rightX = swap;
	}
	if (topY > bottomY)
	{
		int16 swap = topY;
		topY = bottomY;
		bottomY = swap;
	}

	if (ActiveVideoAdapterType == VIDEO_ADAPTER_CGA)
		pixelColor &= 0x03;
	else if (ActiveVideoAdapterType == VIDEO_ADAPTER_TANDY ||
		ActiveVideoAdapterType == VIDEO_ADAPTER_EGA)
		pixelColor &= 0x0F;

	for (y = topY; y <= bottomY; ++y)
	{
		for (x = leftX; x <= rightX; ++x)
		{
			byte *framebuffer = Video_ResolveIndexedRenderTarget(
				ActiveRenderTarget);
			uint32 offset = (uint32) y * VIDEO_SCREEN_WIDTH + x;

			if (framebuffer == NULL)
				framebuffer = SDLBackend_GetIndexedFramebuffer();
			Video_DrawIndexedPixelToActiveTarget(
				(word16) x, (word16) y,
				(byte) (framebuffer[offset] ^ pixelColor));
		}
	}
}

word16 GetLargestFreeConventionalMemoryKB(void)
{
	word16 paragraphs =
		SDLBackend_GetLargestFreeConventionalMemoryParagraphs(0xA000);

	return paragraphs >= 0xA000 ? 0x0280 : paragraphs >> 0x06;
}


