#include "revenge/platform_backend.h"

#include <SDL3/SDL.h>
#include <errno.h>
#include <limits.h>
#include <stdio.h>
#include <sys/stat.h>

#if defined(_WIN32)
#include <io.h>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#else
#include <unistd.h>
#endif

enum
{
    FileHandleCapacity = 0x40,
    FirstGameFileHandle = 0x05,
    DosAttributeReadOnly = 0x01,
    DosAccessReadOnly = 0x00,
    DosAccessWriteOnly = 0x01,
    DosAccessReadWrite = 0x02
};

static SDL_IOStream *files[FileHandleCapacity];
static byte fileAccess[FileHandleCapacity];
static byte defaultDrive;

static int16 HostFileError(void)
{
    int errorNumber;

    errorNumber = errno;
    if (errorNumber <= 0x00 || errorNumber > 0x23)
        errorNumber = EIO;
    return (int16)-errorNumber;
}

static SDL_IOStream *GetFile(uint16 fileHandle)
{
    if (fileHandle >= FileHandleCapacity)
        return 0;
    return files[fileHandle];
}

static int16 StoreFile(SDL_IOStream *file, byte access)
{
    uint16 fileHandle;

    if (file == 0)
        return HostFileError();

    for (fileHandle = FirstGameFileHandle;
         fileHandle < FileHandleCapacity;
         ++fileHandle)
    {
        if (files[fileHandle] == 0)
        {
            files[fileHandle] = file;
            fileAccess[fileHandle] = access;
            return (int16)fileHandle;
        }
    }

    SDL_CloseIO(file);
    return -EMFILE;
}

static int TruncateAtCurrentPosition(SDL_IOStream *file)
{
    SDL_PropertiesID properties;

    if (!SDL_FlushIO(file))
        return 0;

    properties = SDL_GetIOProperties(file);
#if defined(_WIN32)
    {
        HANDLE handle;

        handle = (HANDLE)SDL_GetPointerProperty(
            properties,
            SDL_PROP_IOSTREAM_WINDOWS_HANDLE_POINTER,
            0);
        return handle != 0 && SetEndOfFile(handle) != 0;
    }
#else
    {
        Sint64 position;
        Sint64 descriptor;

        position = SDL_TellIO(file);
        descriptor = SDL_GetNumberProperty(
            properties,
            SDL_PROP_IOSTREAM_FILE_DESCRIPTOR_NUMBER,
            -1);
        return position >= 0 && descriptor >= 0
            && ftruncate((int)descriptor, (off_t)position) == 0;
    }
#endif
}

uint16 SDLBackend_DirectConsoleIO(byte character)
{
    if (character == 0xFF)
        return 0x0600;

    (void)fwrite(&character, 0x01, 0x01, stdout);
    (void)fflush(stdout);
    return (uint16)(0x0600 | character);
}

void SDLBackend_SelectDefaultDrive(byte zeroBasedDrive)
{
    /* Both original floppy volumes are resolved below the selected asset root.
     * Keep DOS's logical drive state without changing a host working drive. */
    defaultDrive = zeroBasedDrive;
    (void)defaultDrive;
}

int16 SDLBackend_CreateFile(uint16 attributes, const char *filePath)
{
    (void)attributes;
    if (filePath == 0)
        return -EINVAL;
    return StoreFile(SDL_IOFromFile(filePath, "w+b"), DosAccessReadWrite);
}

int16 SDLBackend_OpenFile(const char *filePath, uint16 openFlags)
{
    byte access;
    const char *mode;

    if (filePath == 0)
        return -EINVAL;

    /* 392F:0008-0028 gives bit 0002h precedence over bit 0004h and maps
     * them to DOS access values 1 (write) and 2 (read/write). */
    if ((openFlags & 0x0002) != 0x0000)
        access = DosAccessWriteOnly;
    else if ((openFlags & 0x0004) != 0x0000)
        access = DosAccessReadWrite;
    else
        access = DosAccessReadOnly;
    mode = access == DosAccessReadOnly ? "rb" : "r+b";

    return StoreFile(SDL_IOFromFile(filePath, mode), access);
}

int16 SDLBackend_CloseFile(int16 fileHandle)
{
    SDL_IOStream *file;

    if (fileHandle < 0)
        return -EBADF;

    file = GetFile((uint16)fileHandle);
    if (file == 0)
        return -EBADF;

    files[(uint16)fileHandle] = 0;
    fileAccess[(uint16)fileHandle] = DosAccessReadOnly;
    return SDL_CloseIO(file) ? 0x0000 : HostFileError();
}

int16 SDLBackend_ReadFile(
    uint16 fileHandle,
    void *destinationBuffer,
    uint16 byteCount)
{
    SDL_IOStream *file;
    size_t bytesRead;

    file = GetFile(fileHandle);
    if (file == 0)
        return -EBADF;
    if (destinationBuffer == 0 && byteCount != 0x0000)
        return -EINVAL;
    if (fileAccess[fileHandle] == DosAccessWriteOnly)
        return -EACCES;

    bytesRead = SDL_ReadIO(file, destinationBuffer, byteCount);
    if (SDL_GetIOStatus(file) == SDL_IO_STATUS_ERROR)
        return HostFileError();
    return (int16)(uint16)bytesRead;
}

int16 SDLBackend_WriteFile(
    uint16 fileHandle,
    const void *sourceBuffer,
    uint16 byteCount)
{
    SDL_IOStream *file;
    size_t bytesWritten;

    file = GetFile(fileHandle);
    if (file == 0)
        return -EBADF;
    if (fileAccess[fileHandle] == DosAccessReadOnly)
        return -EACCES;
    if (sourceBuffer == 0 && byteCount != 0x0000)
        return -EINVAL;

    /* DOS INT 21h/AH=40h defines a zero-byte write as truncate/extend at the
     * current position. REVENGE uses this while opening a truncated file. */
    if (byteCount == 0x0000)
        return TruncateAtCurrentPosition(file) ? 0x0000 : HostFileError();

    bytesWritten = SDL_WriteIO(file, sourceBuffer, byteCount);
    if (SDL_GetIOStatus(file) == SDL_IO_STATUS_ERROR)
        return HostFileError();
    return (int16)(uint16)bytesWritten;
}

long SDLBackend_SeekFile(uint16 fileHandle, long fileOffset, byte origin)
{
    SDL_IOStream *file;
    SDL_IOWhence whence;
    Sint64 position;

    file = GetFile(fileHandle);
    if (file == 0)
        return -EBADF;
    if (origin > 0x02)
        return -EINVAL;

    whence = origin == 0x00 ? SDL_IO_SEEK_SET
        : origin == 0x01 ? SDL_IO_SEEK_CUR
        : SDL_IO_SEEK_END;
    position = SDL_SeekIO(file, (Sint64)fileOffset, whence);
    if (position < 0 || position > INT32_MAX)
        return HostFileError();
    return (long)position;
}

int16 SDLBackend_DeleteFile(const char *filePath)
{
    if (filePath == 0)
        return -EINVAL;
    return SDL_RemovePath(filePath) ? 0x0000 : HostFileError();
}

int16 SDLBackend_GetSetFileAttributes(
    const char *filePath,
    byte operation,
    uint16 attributes)
{
    struct stat status;

    if (filePath == 0)
        return -EINVAL;
    if (stat(filePath, &status) != 0)
        return HostFileError();

    if (operation == DOS_FILE_ATTRIBUTES_GET)
    {
#if defined(_WIN32)
        return (status.st_mode & _S_IWRITE) == 0 ? DosAttributeReadOnly : 0x0000;
#else
        return (status.st_mode & S_IWUSR) == 0 ? DosAttributeReadOnly : 0x0000;
#endif
    }

    if (operation != DOS_FILE_ATTRIBUTES_SET)
        return -EINVAL;

#if defined(_WIN32)
    if (_chmod(filePath,
        (attributes & DosAttributeReadOnly) != 0
            ? _S_IREAD
            : _S_IREAD | _S_IWRITE) != 0)
        return HostFileError();
#else
    if ((attributes & DosAttributeReadOnly) != 0)
        status.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
    else
        status.st_mode |= S_IWUSR;
    if (chmod(filePath, status.st_mode) != 0)
        return HostFileError();
#endif
    /* INT 21h/AH=43h returns through the wrapper's CX->AX exchange. */
    return (int16)attributes;
}

int16 SDLBackend_DeviceIOControl(
    uint16 fileHandle,
    uint16 operation,
    void *data,
    uint16 count)
{
    (void)data;
    (void)count;

    if (GetFile(fileHandle) == 0)
        return -EBADF;

    /* Regular host files report no DOS character-device flags. */
    if (operation == 0x0000 || operation == 0x0001)
        return 0x0000;
    return -EINVAL;
}
