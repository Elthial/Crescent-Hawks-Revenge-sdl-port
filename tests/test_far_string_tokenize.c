#include "REVENGE.h"
#include "revenge/far_memory.h"
#include "revenge/original_data.h"

#include <assert.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
	char text[] = "  ALPHA,BETA  GAMMA";
	char *token;

	HostFarPointer_Reset();
	HostFarPointer_Register(text, sizeof(text));
	token = FarStringTokenize(text, " ,");
	assert(token == text + 0x02);
	assert(strcmp(token, "ALPHA") == 0x00);
	token = FarStringTokenize(NULL, " ,");
	assert(strcmp(token, "BETA") == 0x00);
	token = FarStringTokenize(NULL, " ,");
	assert(strcmp(token, "GAMMA") == 0x00);
	assert(FarStringTokenize(NULL, " ,") == NULL);

	return EXIT_SUCCESS;
}
