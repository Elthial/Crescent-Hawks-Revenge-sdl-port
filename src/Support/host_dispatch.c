#include "revenge/host_dispatch.h"

const void *HostDispatch_Select(
	const void *identity,
	const void *const *identities,
	const void *const *dispatches,
	word16 count,
	const void *fallback)
{
	word16 index;

	for (index = 0x0000; index < count; ++index)
	{
		if (identity == identities[index])
			return dispatches[index];
	}
	return fallback;
}
