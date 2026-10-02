// REVENGE_39DC_ENVIRONMENT.c
// Reconstructed DOS environment lookup with an SDL host boundary (segment 39DC).

#include "REVENGE.h"
#include "revenge/platform_backend.h"

// 39DC:0009
char *GetEnvironmentVariable(const char *name)
{
	if (name == 0x00 || *name == '\0')
		return 0x00;

	return (char *) SDLBackend_GetEnvironmentVariable(name);
}
