/* Input-wait procedure from original segment 0D73. */

#include "REVENGE.h"

#include "revenge/input.h"

// 0D73:3C7C: word16 FlushInputAndWait(word16 timeoutRetraces)
// Called from:
//      PresentScreenAndMessage
word16 FlushInputAndWait(word16 timeoutRetraces)
{
	FlushPendingInput();
	return WaitForDismissInputOrTimeout(timeoutRetraces);
}
