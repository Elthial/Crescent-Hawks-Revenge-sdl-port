#include "revenge/dos.h"
#include "revenge/original_data.h"

#include <assert.h>

int main(void)
{
	static const char missingPath[] = "revenge-file-does-not-exist.tmp";
	int16 result;

	RuntimeErrno = 0x0000;
	RuntimeDOSError = 0x0000;
	result = DOS_OpenFile(missingPath, 0x8000);
	assert(result == -0x01);
	assert(RuntimeDOSError == -0x01);
	assert(RuntimeErrno > 0x0000);

	RuntimeErrno = 0x0000;
	result = DOS_CloseFile(0x0014);
	assert(result == -0x01);
	assert(RuntimeDOSError == -0x01);
	assert(RuntimeErrno == 0x0009);

	return 0x00;
}
