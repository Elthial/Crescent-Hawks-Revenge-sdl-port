# Reko pseudocode and generated-name reference

This is the working lookup for translating Reko output into readable C while
reverse engineering the 16-bit DOS version of *The Crescent Hawk's Revenge*.
It is based on Reko 0.12.4 source and its developer documentation.

Reko output is a representation of recovered behaviour, not guaranteed
compilable C. Expressions such as `SLICE`, `SEQ`, `Mem0[...]`, `CONVERT`, and
`PHI` expose Reko's intermediate representation when its later transformations
cannot express the result cleanly. Preserve the machine-level meaning first;
make it idiomatic C only after checking widths, signedness, segment ownership,
and callers.

## Primary sources

- [Reko 0.12.4 `Slice` expression](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/Expressions/Slice.cs)
- [Reko 0.12.4 `MkSequence` expression](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/Expressions/MkSequence.cs)
- [Reko 0.12.4 memory-access expression](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/Expressions/MemoryAccess.cs)
- [Reko 0.12.4 segmented-pointer expression](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/Expressions/SegmentedPointer.cs)
- [Reko 0.12.4 primitive-type names](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/Types/PrimitiveType.cs)
- [Reko 0.12.4 generated-name policy](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/NamingPolicy.cs)
- [Reko 0.12.4 type-prefix policy](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/TypeNamingPolicy.cs)
- [Reko SSA register-aliasing notes](https://github.com/uxmal/reko/blob/version-0.12.4/doc/dev/ssa-aliasing.md)
- [Reko projection-propagation notes](https://github.com/uxmal/reko/blob/version-0.12.4/doc/dev/projection.md)
- [Maintainer explanation of residual pseudocode](https://github.com/uxmal/reko/discussions/1286)

## Essential rule: types and offsets are part of the operation

Do not simplify a Reko expression by its name alone. In particular:

```c
SLICE(value, byte, 0)  // bits 0..7
SLICE(value, byte, 8)  // bits 8..15
```

Both produce a byte, but they produce different bytes. The third argument is a
**bit offset**, not a byte count or result width.

For a 16-bit value:

```c
byte lowByte  = (byte) value;
byte highByte = (byte) (value >> 8);
```

Therefore:

```c
SLICE(pitDivisor, byte, 8)
```

becomes:

```c
(byte) (pitDivisor >> 8)
```

It does not become merely `(byte) pitDivisor`; that would select the low byte.

## Expression lookup

### `SLICE(expression, type, bitOffset)`

Extract a bit range of the size specified by `type`, beginning at
`bitOffset`. Reko describes this as an improper subsequence of bits and uses it
heavily to model aliased registers.

| Reko | Meaning | C-style form |
|---|---|---|
| `SLICE(ax, byte, 0)` | `AL`, bits 0-7 | `(uint8_t) ax` |
| `SLICE(ax, byte, 8)` | `AH`, bits 8-15 | `(uint8_t) (ax >> 8)` |
| `SLICE(dx_ax, word16, 0)` | low word, `AX` | `(uint16_t) dx_ax` |
| `SLICE(dx_ax, word16, 16)` | high word, `DX` | `(uint16_t) (dx_ax >> 16)` |
| `SLICE(ptr, selector, 16)` | segment half of a 16:16 far pointer | `FP_SEG(ptr)` or a named segment value |
| `SLICE(ptr, word16, 0)` | offset half of a 16:16 far pointer | `FP_OFF(ptr)` or `(uint16_t) ptr` |

Safe rewrite formula, assuming unsigned storage:

```c
(target_type) ((expression >> bitOffset) & mask_for_target_type)
```

The explicit mask is normally unnecessary when the final cast has the desired
width. Check signedness before right-shifting a signed value.

### `SEQ(high, low)` and `SEQ(partN, ..., part0)`

Fuse several expressions into a wider value. Reko's source specifies
most-significant part first. This is about significance, not host byte order.

```c
SEQ(ah, al)       // ((uint16_t) ah << 8) | al
SEQ(dx, ax)       // ((uint32_t) dx << 16) | ax
SEQ(segment, off) // 16:16 segmented pointer, segment:offset
```

For an ordinary integer:

```c
uint16_t value = ((uint16_t) highByte << 8) | lowByte;
```

For DOS segmented addresses, do not automatically convert `segment:offset` to
an integer concatenation in semantic code. A real-mode physical address is
`segment * 16 + offset`, while a stored far pointer preserves the two halves.
Use a far-pointer type, or retain a named segment and offset separately.

Common inverse relationship:

```c
wide = SEQ(high, low);
low  = SLICE(wide, lowType, 0);
high = SLICE(wide, highType, lowTypeBitWidth);
```

### `MemN[address:type]`

Access memory at `address` as `type`.

```c
Mem0[ds:0x6232:word16]
```

means “read a 16-bit word from `DS:6232`.” If DS is proven to be `Seg3A6A`, a
readable project form is:

```c
seg3A6A->KnownField_6232
```

The number after `Mem` is not an address, size, or segment. It is the identity
or SSA version of the abstract memory state. A write creates a newer memory
state, so one routine may contain `Mem0`, `Mem4`, `Mem17`, and so on. Once the
access has been translated to a real field or pointer dereference, the `MemN`
number normally disappears.

| Form | Meaning |
|---|---|
| `Mem0[address:byte]` | 8-bit memory access |
| `Mem7[address:word16]` | 16-bit memory access in memory state 7 |
| `Mem3[address:word32]` | 32-bit memory access |
| `MemN[seg:off:type]` | segmented memory access |
| `MemN[base + index:type]` | pointer/array/structure access not yet recovered |

Nested `Mem` expressions must be handled from the inside out. If the inner read
produces a pointer or offset, name it before translating the outer access.

### `segment:offset`

Reko's `SegmentedPointer` stores a base pointer/selector and an offset. In this
project:

```c
Mem0[seg3A6A:0x6232:word16]
```

is a word in the game data segment, while:

```c
Mem0[es:di:byte]
```

is a byte through the runtime far pointer `ES:DI`. A literal segment name must
only replace `ds` or `es` after the assembly proves the register's value.

### `CONVERT(expression, sourceType, destinationType)`

An explicit Reko conversion. The maintainer states that the high-level output
stage is intended to turn this into a C cast, but residual `CONVERT` can remain
when translation is incomplete.

```c
CONVERT(value, word16, int32)
```

usually becomes:

```c
(int32_t) (int16_t) value
```

The source type matters because it decides whether extension is signed or
unsigned. Do not reduce every conversion to `(destinationType) value` without
checking the source domain.

### `PTRADD(pointer, offset)`

Pointer arithmetic that Reko has distinguished from integer addition.

```c
PTRADD(buffer, 4)
```

usually becomes `buffer + 4` if `buffer` is a byte pointer, or a field/array
reference after the pointed-to type is known. Confirm whether the offset is in
bytes or scaled elements before simplifying.

### `PHI(a, b, ...)`

An SSA merge: the value is whichever input reaches this control-flow join. It
does not represent a runtime function call.

Typical translation:

```c
if (condition)
    result = a;
else
    result = b;
```

If Reko emits `PHI` in final-looking C, reconstruct the surrounding branches or
loop rather than defining a `PHI` helper.

### `out variable` and `nameOut`

Reko uses `out` to expose a register or storage value produced by a call in
addition to its principal return value.

```c
result = SomeCall(arg, out dxOut);
```

Possible C translations include a pointer output parameter, a small result
structure, or—when the extra value is dead—removing it. For DOS calls, `AX` and
`DX` may form one `DX:AX` result rather than two independent outputs.

### `OVERFLOW<T>(expression)` and condition-code expressions

These represent processor flags that have not yet been folded into a normal
comparison.

| Form | Meaning |
|---|---|
| `C` | carry/borrow flag |
| `Z` | zero flag |
| `S` | sign flag |
| `O` | signed overflow flag |
| `SZCO` | bundled sign, zero, carry, and overflow state |
| `Test(CC, flags)` | evaluate condition code `CC` from a flag group |
| `OVERFLOW<T>(expr)` | whether the typed arithmetic overflowed |

Prefer reconstructing the source comparison or bounds check. Carry commonly
indicates an unsigned comparison; overflow and sign together commonly indicate
a signed comparison. Never replace a carry test with signed `<` without
checking the preceding instruction.

### Unsigned and signed operators

Reko may retain operators that ordinary C expresses through operand types:

| Reko | Meaning | C-style approach |
|---|---|---|
| `a /u b` | unsigned division | cast operands to unsigned, then `/` |
| `a %u b` | unsigned remainder | cast operands to unsigned, then `%` |
| signed division/remainder | signed operation | use signed-width operands |
| logical right shift | zero-fill shift | shift an unsigned value |
| arithmetic right shift | sign-preserving shift | shift a signed value with care |

An apparent suffix such as `*16` or `/16` in damaged output can also be a
formatter/type-analysis artefact. Verify it against assembly before treating
`16` as a literal operand.

### Intrinsics

| Reko form | Interpretation |
|---|---|
| `__in<byte>(port)` | x86 `IN`; read an I/O port |
| `__out<byte>(port, value)` | x86 `OUT`; write an I/O port |
| `__cli()` / `__sti()` | clear/set interrupt enable flag |
| `__syscall(...)` | software interrupt or platform system service not yet lifted |
| `__rol`, `__ror`, shifts | exact machine rotation/shift semantics |
| `__aull...`, runtime helper | compiler support routine; identify before inlining |

For DOS `INT 21h`, identify `AH` first. The interrupt number alone does not
identify the DOS service; the service selector is normally in `AH`.

## Generated identifiers

### Register-derived names

`ax`, `bx`, `cx`, `dx`, `si`, `di`, `bp`, `sp`, `ds`, `es`, `ss`, and `cs`
record the machine storage from which a value was recovered. They are not
original C variable names.

| Register | Common 16-bit role; not a guarantee |
|---|---|
| `AX` | accumulator, return value, syscall selector/result |
| `AL` / `AH` | low/high byte of AX |
| `BX` | base/index, table offset, file handle in DOS APIs |
| `CX` | count, loop length, shift count |
| `DX` | high arithmetic word, port number, syscall data |
| `SI` | source index or general local |
| `DI` | destination index or general local |
| `BP` | hardware stack-frame base in conventional compiler output |
| `SP` | hardware stack pointer |
| `DS` | default data segment |
| `ES` | extra segment, commonly far-pointer destination/source |
| `SS` | stack segment |
| `CS` | code segment |

Names such as `ax_20`, `ax_44`, and `ax_108` are SSA versions/definitions of
register-derived values. The suffix distinguishes versions; it is not a
semantic field, address, or array index. If data flow proves they are the same
source variable, they can be merged and renamed. If their live ranges or
meanings differ, keep them separate despite the shared `ax` ancestry.

`dx_ax` normally means a wide value assembled as `DX:AX`; `es_bx` commonly
means a far pointer assembled as `ES:BX`.

### `fp`, `sp`, and stack expressions

`fp` is Reko's abstract frame pointer. It need not literally be x86 `BP`,
although it often represents the stable base Reko recovered for a procedure's
stack frame. `sp` is the evolving stack pointer.

```c
Mem0[fp - 6:word16] // local word at frame offset -6
Mem0[fp + 4:word16] // stack argument at frame offset +4
```

After stack-variable recovery these become `wLoc06` and `wArg04`. Do not leave
`fp` or `sp` as a normal C function argument: they model execution state, not
source-level parameters.

### `wLoc`, `bLoc`, `dwLoc`, and arguments

Reko generates stack names from a type prefix, `Loc` or `Arg`, and the absolute
hexadecimal frame offset. Its own developer notes give the transformation
`mem[fp - 30] -> wLoc30` and `mem[fp + 30] -> wArg30`.

| Example | Meaning |
|---|---|
| `bLoc0A` | byte-sized local at frame offset `-0Ah` |
| `wLoc06` | 16-bit local at frame offset `-06h` |
| `dwLoc10` | 32-bit local at frame offset `-10h` |
| `ptrLoc08` | pointer-like local at frame offset `-08h` |
| `wArg04` | 16-bit stack argument at `+04h` |
| `dwArg06` | 32-bit stack argument beginning at `+06h` |

The offset is a location clue, not a suitable final name. Rename from observed
use, for example `wArg04 -> fileHandle`, while retaining the address suffix on
proposed function names as this project does.

### Type/name prefixes

Reko's default short naming policy uses:

| Prefix | Meaning |
|---|---|
| `b` | 8-bit value |
| `w` | 16-bit word |
| `dw` | 32-bit double word |
| `qw` | 64-bit quad word |
| `ow` | 128-bit value |
| `hw` | 256-bit value |
| `ptr` | pointer or segmented pointer |
| `pseg` | segment selector |
| `a` | array |
| `str` | string |
| `f` | boolean in the naming policy |
| `r` | real/floating point |
| `t` | unresolved/complex generated type |
| `u` | generated union alternative/type prefix in some contexts |

Structure fields use the same idea plus their hexadecimal offset:
`b0004`, `w0012`, `ptr001A`, `a0020`, or the generic `t001E`. These names say
where and approximately how wide a field is, not what it means.

### Primitive inferred types

Clear types include:

| Reko type | Meaning |
|---|---|
| `byte` / `word16` / `word32` | width known, signedness/role unresolved |
| `int8`, `int16`, `int32` | signed integer |
| `uint8`, `uint16`, `uint32` | unsigned integer |
| `char`, `wchar_t` | character domain |
| `ptr16`, `ptr32` | near/flat pointer of that width |
| `segptr32` | 16:16 segmented pointer |
| `selector` | segment selector |
| `real32`, `real64` | floating-point value |

Compound strings such as `cui16`, `cu8`, `ci8`, `bu8`, and `cup16` are not C
keywords. They are Reko domain unions: the analysis knows the width, but more
than one semantic domain still fits.

| Example | What Reko currently knows |
|---|---|
| `ui8` | 8 bits; could be unsigned or signed integer |
| `ui16` | 16 bits; could be unsigned or signed integer |
| `cu8` | 8 bits; could be character or unsigned integer |
| `ci8` | 8 bits; could be character or signed integer |
| `cui16` | 16 bits; character, unsigned integer, or signed integer |
| `bu8` | 8 bits; Boolean or unsigned integer |
| `cup16` | 16 bits; character, unsigned integer, or pointer-like |

By contrast, `uint8` and `uint16` are specifically unsigned, while `int8` and
`int16` are specifically signed.

Domain letters used by Reko include:

| Letter | Candidate domain |
|---|---|
| `b` | Boolean |
| `c` | character |
| `u` | unsigned integer |
| `i` | signed integer |
| `s` | segmented pointer or selector context |
| `p` | pointer |
| `o` | offset |
| `r` | real |

Thus `cui16` means “16-bit value still compatible with character, unsigned
integer, or signed integer.” It does **not** mean `const unsigned int`. Choose a
normal C type only after use establishes the domain.

### `Eq_N`

`Eq_4823`, `Eq_168`, and similar names are generated equivalence-class types
from Reko's type inference. Values are grouped because constraints say they
must share a compatible type. An `Eq_N` may later be rendered as an opaque
struct, union, pointer, integer-like value, or a combination of alternatives.

Rules for cleanup:

1. Do not treat the number as an address or size.
2. Inspect the generated `typedef union Eq_N` or `typedef struct Eq_N`.
3. Follow all uses and call signatures.
4. Replace it with a semantic type only when those uses agree.
5. If it mixes incompatible roles, the function signature or a prior data type
   is probably wrong; fix metadata rather than preserving a meaningless union.

Members such as `.u0`, `.u1`, and `.u2` are alternatives in a generated union.
Select the one matching the proven interpretation, then remove the union access
when introducing the real type.

### `tNNNN`, `bNNNN`, `wNNNN`, `ptrNNNN`, `aNNNN`

These are generated structure fields at hexadecimal byte offset `NNNN`:

- `b` suggests 8 bits;
- `w` suggests 16 bits;
- `dw` suggests 32 bits;
- `ptr` suggests a pointer;
- `a` suggests an array;
- `t` means the type remains complex or unresolved.

The offset is reliable only relative to the structure/segment Reko inferred.
The semantic type is provisional. Preserve the suffix when renaming fields in
this project, for example `SpeakerEffectStreamCursor_0016`.

### `fnSEG_OFFSET`, labels, and suffixes

`fn30B2_00DF` means an unnamed procedure at `30B2:00DF`. `l30B2_0276` is a
generated control-flow label. The numeric suffix on a local such as `ax_44` is
an SSA/disambiguation suffix, whereas the suffix on a project name such as
`DecodePCSpeakerEffectTick_00DF` deliberately preserves the entry offset.

Do not confuse those two conventions.

## Common 16-bit DOS rewrites

### High and low bytes

```c
byte al = (byte) ax;
byte ah = (byte) (ax >> 8);
ax = ((word16) ah << 8) | al;
```

If only one half changes:

```c
ax = (ax & 0xFF00) | newLow;
ax = (ax & 0x00FF) | ((word16) newHigh << 8);
```

### `DX:AX` values

```c
uint32_t value = ((uint32_t) dx << 16) | ax;
dx = (uint16_t) (value >> 16);
ax = (uint16_t) value;
```

This may be a 32-bit integer, a file offset, or a compiler arithmetic result.
It is not automatically a pointer.

### Far pointers

```c
segptr32 pointer = SEQ(segment, offset);
segment = SLICE(pointer, selector, 16);
offset  = SLICE(pointer, word16, 0);
```

Prefer a descriptive `byte __far *`, `char __far *`, or record pointer once the
pointee is known. Do not convert a far pointer to `segment * 16 + offset` unless
the code is explicitly computing a physical address.

### Implicit segment registers

`DS`, `ES`, `SS`, and `CS` are processor state, not ordinary C arguments. A
routine can nevertheless change them. Before replacing `ds` with `seg3A6A` or
another named segment:

1. inspect the entry assembly and every assignment to DS;
2. check whether it is a near routine inheriting its caller's DS;
3. check whether callbacks temporarily restore another DS;
4. add a dcproject register assumption only where the value is valid;
5. retain explicit far pointers when segment ownership varies.

`REVENGE_30B2` is the useful counterexample: its IRQ handler explicitly loads
`DS=426B`. `Seg3A6A` is saved in `426B:0002` only for callbacks into the main
game layer.

## Cleanup checklist

For each routine:

1. Read the assembly at the entry and every call/return edge.
2. Establish near/far calling convention and the real stack arguments.
3. Establish DS/ES ownership before replacing segmented memory expressions.
4. Expand `SLICE` and `SEQ` with exact bit widths and offsets.
5. Convert `MemN` accesses into named fields, arrays, or pointer dereferences.
6. Merge SSA variables only when definitions, uses, and live ranges agree.
7. Replace `Eq_N` and compound inferred types only with evidence.
8. Reconstruct flag tests as signed or unsigned comparisons from the preceding
   machine instruction.
9. Name arguments and locals by role, not by their source register.
10. Backtrack procedure and field names through all callers and update the
    dcproject so the next Reko run benefits.
11. Preserve a proposed-name comment when behaviour is plausible but not yet
    fully traced.
12. Compare the rewritten C with the assembly again after cleanup.

## Quick examples from Revenge

```c
// Reko
PC_Speaker_Write_PIT_Divisor_029F(
    (byte) pitDivisor,
    SLICE(pitDivisor, byte, 8));

// C-style
PC_Speaker_Write_PIT_Divisor_029F(
    (byte) pitDivisor,
    (byte) (pitDivisor >> 8));
```

```c
// Reko
Mem98[seg3A6A:0x6232:word16]

// First readable form
seg3A6A->Unknown_6232

// Final form after tracing
seg3A6A->ActiveTextWindowTopTile_6232
```

```c
// Reko
SEQ(seg3A6A, 0x22DC)

// Pointer meaning known
"allocation/resident-program error"

// Retain provenance beside the rewrite
// TEXT DS:22DC: allocation/resident-program error
```

The final semantic rewrite is preferable to mechanically preserving Reko's IR,
but only when the string, field, pointer, or operation has been verified.
