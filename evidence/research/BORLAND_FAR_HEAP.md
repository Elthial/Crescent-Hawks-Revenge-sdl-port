# Borland far-heap runtime

Segments `38CD`, `398D`, and `38FE` implement the Borland far-heap used by the
game's ordinary resource allocations. This is allocator machinery rather than
game-specific state; naming it prevents its linked-list fields from leaking
back into resource and graphics analysis as false method arguments.

## Public contracts

| Address | Name | Contract | Confidence |
| --- | --- | --- | :---: |
| `38CD:0002` | `AllocateFarHeapBytes16` | Zero-extend a 16-bit byte count and allocate it. | V |
| `38CD:0203` | `AllocateFarHeapBytes` | Allocate a 32-bit byte count and return a far payload pointer, or null for zero/failure. | V |
| `398D:000C` | `FreeHeapBlock` | Compiler/runtime wrapper around the core free operation. | V |
| `398D:02E6` | `FreeFarHeapAllocation` | Ignore null; subtract the eight-byte header and free/coalesce the block. | V |

The lower program-break layer has now also been recovered directly from the
assembly:

| Address | Name | Contract | Confidence |
| --- | --- | --- | :---: |
| `38FE:0002` | `ResizeProgramBreak_0002` | Resize the program's DOS block in 1 KiB units and record the exact logical break. | V |
| `38FE:0092` | `SetProgramBreak` | Checked Borland `brk` equivalent; return `0` or `-1`. | V |
| `38FE:00D9` | `AdjustProgramBreak` | Signed Borland `sbrk` equivalent; return the old break or `FFFF:FFFF`. | V |
| `0800:53B0` | `AddSignedOffsetToFarPointer` | Add a signed 32-bit displacement and normalize the resulting far pointer. | V |

The apparent ES/DX outputs in the old decompile were incidental register state.
They are not C output arguments.

## Block header

The executable accesses a 16-byte header. The first eight bytes describe the
physical arena chain; the last eight are used while the block is free.

| Offset | Size | Meaning | Confidence |
| ---: | ---: | --- | :---: |
| `+00h` | 4 | block span/size with bit 0 used as the allocated flag | V |
| `+04h` | 4 | adjacent physical-block link used during split/coalesce | V structure, P direction label |
| `+08h` | 4 | circular free-list link | V structure, P direction label |
| `+0Ch` | 4 | opposite circular free-list link | V structure, P direction label |

Payload begins at `header + 08h`. Allocation requests are transformed with
`(byteCount + 17h) & FFFFFFF0h`, giving room for the header and preserving the
allocator's 16-byte block alignment. A large free block is split from its high
end; otherwise the arena is extended through the lower `38FE` DOS-memory layer.

## Global roots

| DS range | Name | Meaning | Confidence |
| --- | --- | --- | :---: |
| `701Ah-701Dh` | `FarHeapArenaBase_701A` | first physical block header | V |
| `701Eh-7021h` | `FarHeapTailBlock_701E` | terminal physical block header | V |
| `7022h-7025h` | `FarHeapFreeListHead_7022` | circular free-list root | V |

Maintained C now uses a typed `FarHeapBlockHeader`, and all sixteen former
`<invalid>` flag expressions have been replaced by assembly-verified pointer
comparisons. The `+08h` and `+0Ch` links are named `previousFree` and
`nextFree`: unlink and insertion assembly verifies those directions.
