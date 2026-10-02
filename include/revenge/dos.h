#ifndef REVENGE_DOS_H
#define REVENGE_DOS_H

#include "revenge/types.h"

enum
{
    DOS_FILE_ATTRIBUTES_GET = 0x00,
    DOS_FILE_ATTRIBUTES_SET = 0x01,
    DOS_DRIVE_A = 0x00,
    DOS_DRIVE_B = 0x01,
    DOS_SEEK_FROM_START = 0x00,
    DOS_SEEK_FROM_CURRENT = 0x01,
    DOS_SEEK_FROM_END = 0x02,
    DOS_ERROR_INVALID_HANDLE = 0x06,
    DOS_ERROR_FILE_EXISTS = 0x50,
    DOS_DEVICE_CHARACTER = 0x0080,
    DOS_DEVICE_RAW_MODE = 0x0020
};

typedef void (*DOS_InterruptHandler)(void);

typedef struct DOS_Date
{
    uint16 year;
    byte month;
    byte day;
} DOS_Date;

typedef struct DOS_Time
{
    byte hour;
    byte minute;
    byte second;
    byte hundredth;
} DOS_Time;

uint16 DOS_PrintCharacter(char character);
void DOS_PrintString(const char *text);
void DOS_SelectDefaultDrive(byte zeroBasedDrive);

int16 DOS_CreateFile(uint16 attributes, const char *filePath);
int16 DOS_OpenFile(const char *filePath, uint16 openFlags);
int16 DOS_CloseFile(int16 fileHandle);
int16 DOS_ReadFile(uint16 fileHandle, void *destinationBuffer, uint16 byteCount);
int16 DOS_WriteFile(uint16 fileHandle, const void *sourceBuffer, uint16 byteCount);
long DOS_SeekFile(uint16 fileHandle, long fileOffset, byte origin);
int16 DOS_DeleteFile(const char *filePath);
int16 DOS_GetSetFileAttributes(const char *filePath, byte operation, uint16 attributes);
int16 DOS_DeviceIOControl(uint16 fileHandle, uint16 operation, void *data, uint16 count);
int16 TranslateDOSError(int16 dosErrorCode);

word16 DOS_ResizeMemoryBlock(word16 memorySegment, word16 paragraphCount);
void DOS_GetSystemDate(DOS_Date *date);
void DOS_GetSystemTime(DOS_Time *time);
void DOS_SetInterruptVector(byte interruptNumber, DOS_InterruptHandler handler);

#endif
