/* Restart-confirmation procedure from original segment 0D73. */

#include "REVENGE.h"

#include "revenge/original_data.h"

/* 0D73:242E-2447 */
word16 ConfirmRestartGame(void)
{
	DialogFramingEnabled = TRUE;
	return ShowConfirmationDialog(RestartConfirmationText) == 0x0000;
}
