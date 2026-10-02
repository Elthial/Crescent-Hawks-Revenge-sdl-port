#include "fake_backend.h"
#include "revenge/dos.h"

#include <assert.h>
#include <string.h>

static void TestInterruptHandler(void)
{
}

static void TestConsoleAndDrive(void)
{
    FakeBackend_Reset();

    assert(DOS_PrintCharacter('R') == 0x0652);
    DOS_PrintString("CH");
    DOS_SelectDefaultDrive(DOS_DRIVE_B);

    assert(fakeBackend.consoleCharacterCount == 0x0003);
    assert(fakeBackend.consoleCharacters[0x00] == 'R');
    assert(fakeBackend.consoleCharacters[0x01] == 'C');
    assert(fakeBackend.consoleCharacters[0x02] == 'H');
    assert(fakeBackend.drive == DOS_DRIVE_B);
}

static void TestFiles(void)
{
    char buffer[0x10];
    const char *path;

    path = "REVENGE.SAV";
    FakeBackend_Reset();

    assert(DOS_CreateFile(0x0020, path) == 0x0005);
    assert(fakeBackend.path == path);
    assert(fakeBackend.firstWord == 0x0020);

    assert(DOS_OpenFile(path, 0x8004) == 0x0006);
    assert(fakeBackend.firstWord == 0x8004);

    assert(DOS_ReadFile(0x0006, buffer, sizeof(buffer)) == sizeof(buffer));
    assert(fakeBackend.fileHandle == 0x0006);
    assert(fakeBackend.buffer == buffer);

    assert(DOS_WriteFile(0x0006, buffer, 0x0007) == 0x0007);
    assert(fakeBackend.firstWord == 0x0007);

    assert(DOS_SeekFile(0x0006, -0x20L, 0x02) == 0x12345678L);
    assert(fakeBackend.fileOffset == -0x20L);
    assert(fakeBackend.firstByte == 0x02);

    assert(DOS_DeviceIOControl(0x0006, 0x0001, buffer, 0x0002) == 0x0080);
    assert(fakeBackend.firstWord == 0x0001);
    assert(fakeBackend.secondWord == 0x0002);

    assert(DOS_GetSetFileAttributes(path, DOS_FILE_ATTRIBUTES_SET, 0x0001) == 0x0021);
    assert(fakeBackend.firstByte == DOS_FILE_ATTRIBUTES_SET);
    assert(fakeBackend.firstWord == 0x0001);

    assert(DOS_DeleteFile(path) == 0x0000);
    assert(DOS_CloseFile(0x0006) == 0x0000);
    assert(fakeBackend.fileHandle == 0x0006);
}

static void TestSystemServices(void)
{
    DOS_Date date;
    DOS_Time timeValue;

    FakeBackend_Reset();

    assert(DOS_ResizeMemoryBlock(0x3A6A, 0x0200) == 0xFFFF);
    assert(fakeBackend.firstWord == 0x3A6A);
    assert(fakeBackend.secondWord == 0x0200);

    memset(&date, 0, sizeof(date));
    memset(&timeValue, 0, sizeof(timeValue));
    DOS_GetSystemDate(&date);
    DOS_GetSystemTime(&timeValue);
    assert(date.year == 0x07EA && date.month == 0x09 && date.day == 0x1A);
    assert(timeValue.hour == 0x0C && timeValue.minute == 0x22);
    assert(timeValue.second == 0x38 && timeValue.hundredth == 0x4E);

    DOS_SetInterruptVector(0x24, TestInterruptHandler);
    assert(fakeBackend.firstByte == 0x24);
    assert(fakeBackend.interruptHandler == TestInterruptHandler);
}

int main(void)
{
    TestConsoleAndDrive();
    TestFiles();
    TestSystemServices();
    return 0;
}
