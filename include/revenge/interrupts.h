#ifndef REVENGE_INTERRUPTS_H
#define REVENGE_INTERRUPTS_H

#include "revenge/types.h"

enum
{
	INTERRUPT_SYSTEM_TIMER_IRQ = 0x08,
	INTERRUPT_DOS_CRITICAL_ERROR = 0x24
};

#pragma pack(push, 1)
typedef struct InterruptRegisterBlock
{
	word16 ax;
	word16 bx;
	word16 cx;
	word16 dx;
	word16 si;
	word16 di;
	word16 carry;
	word16 flags;
} InterruptRegisterBlock;

typedef struct InterruptSegmentState
{
	word16 es;
	word16 cs;
	word16 ss;
	word16 ds;
} InterruptSegmentState;
#pragma pack(pop)

/* Original 0800 segment wrappers around the x86 STI and CLI instructions. */
void EnableHardwareInterrupts(void);
void DisableHardwareInterrupts(void);

/* Lowest-level host boundary used by the original wrappers. */
void RevengeHost_EnableInterruptDelivery(void);
void RevengeHost_DisableInterruptDelivery(void);

#endif
