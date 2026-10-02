#ifndef REVENGE_DEBUG_H
#define REVENGE_DEBUG_H

void RevengeTrace(const char *format, ...);
void RevengeInstallCrashDiagnostics(void);

/* Diagnostics injected while reconstructing a procedure are not part of the
 * original executable.  Keep them visibly distinct and absent from normal
 * preservation builds. */
#ifdef REVENGE_ENABLE_PRESERVATION_INSTRUMENTATION
#define REVENGE_PRESERVATION_TRACE(...) RevengeTrace(__VA_ARGS__)
#else
#define REVENGE_PRESERVATION_TRACE(...) ((void) 0)
#endif

#endif
