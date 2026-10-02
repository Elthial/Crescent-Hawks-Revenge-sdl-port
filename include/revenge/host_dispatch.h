#ifndef REVENGE_HOST_DISPATCH_H
#define REVENGE_HOST_DISPATCH_H

#include "revenge/types.h"

/*
 * Select the native callback table paired with an original DOS descriptor.
 * This bridge contains no game policy; callers supply the identity mapping.
 */
const void *HostDispatch_Select(
	const void *identity,
	const void *const *identities,
	const void *const *dispatches,
	word16 count,
	const void *fallback);

#endif
