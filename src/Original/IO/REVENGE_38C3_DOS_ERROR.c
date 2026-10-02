// Reconstructed original DOS-error translator (segment 38C3).

#include "REVENGE.h"
#include "revenge/original_data.h"

// 38C3:0004: Register int16 TranslateDOSError(Stack int16 dosErrorCode)
int16 TranslateDOSError(int16 dosErrorCode)
{
	int16 errnoValue;

	if (dosErrorCode < 0x00)
	{
		errnoValue = -dosErrorCode;
		if ((uint16) errnoValue <= 0x0023)
		{
			RuntimeDOSError = -0x01;
			RuntimeErrno = errnoValue;
			return -0x01;
		}
	}

	if ((uint16) dosErrorCode > 0x0058)
		dosErrorCode = 0x0057; // DOS error 87: invalid parameter

	RuntimeDOSError = dosErrorCode;
	errnoValue = DOSErrorToErrnoTable[(uint16) dosErrorCode];
	RuntimeErrno = errnoValue;
	return -0x01;
}
