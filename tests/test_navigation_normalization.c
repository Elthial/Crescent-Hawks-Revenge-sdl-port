#include "REVENGE.h"
#include "revenge/input.h"
#include "revenge/original_data.h"

#include <assert.h>

int main(void)
{
	NumericKeypadNavigationEnabled = 0x0000;
	assert(NormalizeNavigationKeyCode(-0x004B) == -0x004B);
	assert(NormalizeNavigationKeyCode(0x007C) == -0x004B);
	assert(NormalizeNavigationKeyCode(0x007E) == -0x0048);
	assert(NormalizeNavigationKeyCode(0x0060) == -0x0050);
	assert(NormalizeNavigationKeyCode(0x000C) == -0x004D);
	assert(NormalizeNavigationKeyCode(0x0032) == 0x0032);

	NumericKeypadNavigationEnabled = 0x0001;
	assert(NormalizeNavigationKeyCode(0x0031) == -0x004F);
	assert(NormalizeNavigationKeyCode(0x0032) == -0x0050);
	assert(NormalizeNavigationKeyCode(0x0036) == -0x004D);
	assert(NormalizeNavigationKeyCode(0x0039) == -0x0049);
	assert(NormalizeNavigationKeyCode(0x0035) == 0x0035);
	return 0x00;
}
