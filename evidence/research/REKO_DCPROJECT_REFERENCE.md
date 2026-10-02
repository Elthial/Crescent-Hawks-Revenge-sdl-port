# Reko `.dcproject` reference

This is the working reference for feeding discoveries back into Reko while
reverse engineering *The Crescent Hawk's Revenge*. It describes the v5 project
format used by `REVENGE.dcproject`, with particular attention to Reko 0.12.4,
the version kept in this repository's local tooling.

The reference was checked against both the `version-0.12.4` tag and the current
Reko source on 23 September 2026. The relevant project serialization files have
not materially changed between those revisions. This document records behavior
implemented by Reko, not just behavior visible in its GUI.

## Primary sources

- [Reko user metadata guide](https://github.com/uxmal/reko/blob/version-0.12.4/doc/guide/usermetadata.md)
- [v5 project model](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/Serialization/Project_v5.cs)
- [v4 user-data model used inside v5 projects](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/Serialization/Project_v4.cs)
- [project loader and validation behavior](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/Serialization/ProjectLoader.cs)
- [procedure serialization model](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/Serialization/Procedure_v1.cs)
- [C signature parser](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/Hll/C/UserSignatureBuilder.cs)
- [C metadata/header loader](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/Loading/CHeaderLoader.cs)
- [C metadata attributes and storage rules](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/Hll/C/NamedDataTypeExtractor.cs)
- [metadata annotations and segments](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/Hll/C/SymbolTable.cs)
- [project saver, which shows what Reko considers canonical](https://github.com/uxmal/reko/blob/version-0.12.4/src/Core/Serialization/ProjectSaver.cs)
- [indirect-control-transfer override handling](https://github.com/uxmal/reko/blob/version-0.12.4/src/Decompiler/Scanning/BlockWorkitem.cs)
- [automatic call/jump-table extent discovery](https://github.com/uxmal/reko/blob/version-0.12.4/src/Decompiler/Scanning/BackwardSlicer.cs)
- [Python scripting example](https://github.com/uxmal/reko/blob/version-0.12.4/subjects/scripting/py_func_names.py)

## What happens when Reko opens a project

Reko recognizes the file by its XML root namespace, not merely by the
`.dcproject` extension. It currently accepts v4 and v5 projects. We should use
v5:

```xml
<project xmlns="http://schemata.jklnet.org/Reko/v5">
```

The load sequence is important:

1. Reko resolves the common architecture and platform.
2. It loads top-level metadata files.
3. It loads each binary input and its `<user>` metadata.
4. It loads top-level scripts.
5. During scanning, user procedures become procedure seeds, comments are
   injected, assumed registers are applied, and signatures influence calls.
6. Later data-flow analysis applies user C signatures again to the discovered
   procedures.

This means a corrected signature is not cosmetic. It can change argument
recovery, return values, stack deltas, call expressions, and analysis of every
caller.

Invalid addresses are generally skipped. Several parse failures return `null`
with little or no user-visible warning. A valid XML document is therefore not
proof that every entry was accepted.

## Minimal v5 project

```xml
<?xml version="1.0" encoding="utf-8"?>
<project xmlns="http://schemata.jklnet.org/Reko/v5">
  <arch>x86-real-16</arch>
  <platform>ms-dos</platform>
  <input>
    <location>..\..\Chrevenge\REVENGE.EXE</location>
    <asmDir>..\..\Chrevenge\REVENGE.reko</asmDir>
    <srcDir>..\..\Chrevenge\REVENGE.reko</srcDir>
    <includeDir>..\..\Chrevenge\REVENGE.reko</includeDir>
    <resources>..\..\Chrevenge\REVENGE.reko\resources</resources>
    <user>
      <processor />
      <outputFilePolicy>Segment</outputFilePolicy>
    </user>
  </input>
</project>
```

`<location>` is the current v5 spelling. `<filename>` remains accepted only for
backward compatibility. Relative input, metadata, script, output, and procedure
output paths are resolved relative to the project file.

Do not add `<loader>` to the Revenge input merely to be explicit. Supplying a
loader name forces Reko down its raw-image loading path. The MZ executable
should continue to use automatic executable loading.

## Procedure entries

The most useful project entry is:

```xml
<procedure name="DOS_PrintString">
  <address>3327:0007</address>
  <CSignature>void DOS_PrintString(const char __far *text);</CSignature>
</procedure>
```

Supported child data includes:

| XML | Effect |
| --- | --- |
| `name="..."` | User name and scan seed. If absent, Reko generates a name. |
| `<address>` | Required entry address, parsed by `x86-real-16`; use `SEG:OFF`. |
| `<CSignature>` | C declaration used to replace Reko's inferred signature. |
| `<decompile>false</decompile>` | Treat the address like a known external procedure and do not decode its body. |
| `<assume ... />` | Force register state at procedure entry. |
| `<characteristics>` | Attach behavior such as non-returning or allocator. |
| `<OutputFile>` | Put this procedure in a specified project-relative output file. The capital letters are part of the XML name. |
| `ordinal="..."` | Library/export ordinal where applicable; not normally useful for Revenge. |

`decompile` defaults to `true`. If it is `false`, always provide a signature.
Reko warns about a no-decompile procedure with neither a serialized signature
nor a C signature.

### Naming rule

The name inside `CSignature` can replace the `name` attribute during signature
building. Keep all three representations identical:

```xml
<procedure name="GetFileLength">
  <address>39C0:0000</address>
  <CSignature>long GetFileLength(unsigned short fileHandle)</CSignature>
</procedure>
```

Do not leave an old `fnXXXX_YYYY` identifier inside a newly renamed signature.

Reko appends a semicolon internally before parsing `CSignature`. Existing
signatures containing a semicolon are accepted, but omitting it is the cleanest
form.

### Ordinary 16-bit C signatures

On the `x86-real-16`/`ms-dos` platform, C types have their 16-bit DOS meanings.
Be explicit where ambiguity matters:

```c
void DrawVerticalSpan_4EF3(
    unsigned short x,
    unsigned short yStart,
    unsigned short yEnd,
    unsigned short color)

long GetFileLength(unsigned short fileHandle)

void DeleteFileIgnoringErrors(char __far *filePath)
```

Useful declarators understood by the parser include `__cdecl`, `__pascal`,
`__stdcall`, `__fastcall`, `__near`, and `__far`. A near function has a 2-byte
return address; declaring a function itself far changes the return-address
contract. A `__far *` data pointer is a 32-bit segment:offset pointer.

Only add a calling convention when the assembly supports it. A wrong convention
or near/far qualifier can make the stack delta worse than Reko's inference.

### Register arguments and returns

Reko's C parser supports attributes for non-ABI storage:

```c
[[reko::returns(register, "ax")]]
unsigned short ReadRawKeypress_01B5(void)

void ExampleRegisterInput(
    [[reko::arg(register, "bx")]] unsigned short value)

[[reko::returns(seq, "dx", "ax")]]
unsigned long ExampleLongReturn(void)

void ExampleFarPointer(
    [[reko::arg(seq, "ds", "dx")]] char __far *path)
```

Storage forms implemented in 0.12.4 are:

- `register, "name"` for one register;
- `seq, "high", "low"` for a register sequence such as `DX:AX` or `DS:DX`;
- `fpu` for an x87 stack value;
- `flag, "name"` for a flag group;
- `out, ...` before another argument storage form for an output parameter.

For example:

```c
void ExampleOutputPair(
    [[reko::arg(out, seq, "dx", "ax")]] unsigned long result)
```

If any non-standard register storage is specified, explicitly annotate all
non-standard inputs and outputs. Use actual machine-code register flow, not the
temporary arguments emitted by an earlier Reko run.

### DS is normally state, not a C argument

An ambient `DS` is normally not a source-level C parameter. There are three
different cases:

1. If `DS` has a known value at procedure entry, use a procedure `<assume>`.
2. If `DS` changes or becomes known at one instruction, use
   `<registerValues>` at that address.
3. If a real API contract passes a far pointer in `DS:DX`, describe that one
   pointer with `[[reko::arg(seq, "ds", "dx")]]`.

For Revenge's main data segment:

```xml
<procedure name="SomeProcedure_1234">
  <address>2C7F:1234</address>
  <assume reg="ds" value="3A6A" />
</procedure>
```

The value is hexadecimal without `0x`. At procedure scope, the optional `addr`
attribute is unnecessary; the containing procedure supplies the address.

### Procedure characteristics

The direct XML form is:

```xml
<characteristics>
  <terminates>true</terminates>
</characteristics>
```

The implemented characteristics are:

- `<terminates>true</terminates>`: control never returns;
- `<is-alloca>true</is-alloca>`: models stack allocation;
- `<allocator>true</allocator>`: returns newly allocated storage;
- `<array-size>...</array-size>`: relates an array argument to its size;
- `<varargs>Namespace.Type,Assembly</varargs>`: custom varargs parser;
- `<adjustRet>N</adjustRet>`: skip extra bytes following a special call.

The C metadata equivalent includes:

```c
[[noreturn]] void FatalError(unsigned short code);

[[reko::characteristics({terminates:true})]]
void FatalError(unsigned short code);
```

Empty `<characteristics />` elements have no effect and may be omitted.

## Assumed register values

### At procedure entry

Use `<assume>` inside a procedure as shown above. These values initialize the
processor state before the procedure body is scanned.

### At a precise instruction

```xml
<registerValues>
  <assume addr="2C7F:003C" reg="ds" value="3A6A" />
  <assume addr="2C7F:0170" reg="es" value="4184" />
  <assume addr="2C7F:0200" reg="dx" value="*" />
</registerValues>
```

These are applied when the scanner reaches that exact instruction. `*` means an
explicitly unknown/invalid value rather than zero. Register names must be valid
for `x86-real-16`; unknown registers are ignored or can fail later processing.

This feature is the best way to turn stable segment state into meaningful
memory references on a new Reko run. It is preferable to pretending that every
procedure takes `DS` as a C argument.

## Source annotations

Project annotations become comments at exact instruction addresses:

```xml
<annotation addr="2C7F:003C">
  Game initialization entry; displays the copyright banner.
</annotation>
```

The compact form is also valid:

```xml
<annotation addr="2C7F:003C">Game initialization entry.</annotation>
```

Annotations are injected during scanning only when an emitted statement has
the exact same address. An annotation on an address that produces no statement
will not appear in the decompiled C. Prefer one consolidated annotation per
address.

Use annotations for evidence that does not yet justify changing a signature,
for example:

- the string referenced by an instruction;
- a proposed method role awaiting a tracing pass;
- the meaning of a branch value or hardware port;
- a table base and record interpretation;
- a known original-game quirk.

## Calls at specific instructions

A `<call>` describes one call site rather than every call to a callee:

```xml
<call>
  <address>3390:0660</address>
  <comment>Delete the old save before creating its replacement.</comment>
</call>
```

It can also contain:

```xml
<noreturn>true</noreturn>
```

or a full serialized `<signature>`. A call-site signature forces Reko to emit
an application with that contract for this instruction. This is useful for
indirect calls, dispatch stubs, and calls whose target cannot be recovered.

Prefer a procedure `CSignature` when the callee is known, because it improves
all callers. Use `<call>` only for genuinely call-site-specific information.
The serialized type XML is verbose and fragile; let the GUI generate it when a
call override needs a full signature.

## Global data

A typed global gives Reko a name and shape for data at an address. Direct XML
uses serialized Reko types:

```xml
<global>
  <Address>3A6A:B7D8</Address>
  <prim domain="UnsignedInt" size="1" />
  <Name>PCSpeakerBitstreamData</Name>
  <Comment>Bitstream played by PlayPCSpeakerBitstream_007E.</Comment>
</global>
```

Capitalization matters for `Address`, `Name`, and `Comment`. Common serialized
type nodes include:

```xml
<prim domain="UnsignedInt" size="2" />
<prim domain="SignedInt" size="2" />
<prim domain="Character" size="1" />
<type>PreviouslyDefinedType</type>
<ptr size="4"><prim domain="Character" size="1" /></ptr>
```

For non-trivial structures, arrays, enums, and function pointers, use a C
metadata file instead of hand-authoring serialized type XML. It is easier to
review and less likely to encode the wrong pointer size.

### Segmented far-pointer global workaround

Reko can infer a DOS offset:segment global as its internal `MemberPointer`
type. In Reko 0.12.4, both `GlobalDataWorkItem.VisitMemberPointer` and parts of
the global C writer are unimplemented, producing errors such as “An error
occurred while tracing the object” and “Failed to write global variable.”

Do not declare it as a pointer: a four-byte `<ptr>` describes a flat 32-bit
address, not the DOS `offset:segment` representation. Do not declare two
independent globals either, because later `LES`/`LDS` use can re-unify the
offset word as a `MemberPointer`.

Declare one four-byte value structure in the C metadata file instead:

```c
typedef struct FarAddress16 {
    unsigned short offset;
    unsigned short segment;
} FarAddress16;

[[reko::address("2A6A:84C1")]]
FarAddress16 ActiveFontResource_84C1;
```

This deliberately describes storage rather than pointer semantics. The
metadata entry supersedes the compiler-inferred object before global-data
scanning, so Reko only visits supported structure and primitive types.

Use the address reported by Reko's object/global diagnostic. That can be the
pre-relocation image address even when the instructions access the same
storage through a different runtime segment value.

## Reusable C metadata files

Reko treats `.inc` files as C header metadata. Add one at project level:

```xml
<metadata>
  <location>RevengeMetadata.inc</location>
</metadata>
```

Metadata is loaded before program inputs, so its typedefs are available when
project `CSignature` entries are parsed. A metadata file can define:

- typedefs, structs, unions, enums, and function typedefs;
- typed globals;
- named procedures and signatures;
- procedure addresses;
- non-standard register storage and characteristics;
- annotations;
- memory segments.

Example:

```c
typedef unsigned char byte;
typedef unsigned short word;

typedef struct RevengeUnitRecord {
    word unitType;
    word armour;
    word movement;
} RevengeUnitRecord;

[[reko::address("3A6A:9000")]]
RevengeUnitRecord MechTable[32];

[[reko::address("3717:007E")]]
void PlayPCSpeakerBitstream_007E(
    byte __far *sampleData,
    word byteCount);

[[reko::annotation("3717:007E",
    "Wraps PIT timing around a PC-speaker bitstream write.")]]

[[reko::segment("3A6A:0000", "game_data", 0xB900, "rw",
    "Main Revenge data segment")]]
```

For segmented addresses, `[[reko::address("SEG:OFF")]]` is supported. Segment
access strings are combinations of `r`, `w`, and `x`.

### Metadata versus project XML

Use the project XML for facts tightly coupled to this exact executable:

- procedure seeds and no-decompile decisions;
- per-instruction register assumptions;
- call-site overrides;
- jump-table recovery;
- output placement.

Use a `.inc` metadata file for reusable declarations:

- shared type definitions;
- large sets of typed globals and tables;
- API signatures;
- structured annotations.

Avoid defining the same address independently in both places. The scanner
processes user procedures and metadata procedures through different paths, and
duplicate/conflicting declarations make precedence difficult to reason about.

## Jump tables and indirect jumps

Known destination lists can repair an unresolved switch or dispatch table:

```xml
<jumpTable tableAddress="3A6A:8120">
  <dst>2C7F:1000</dst>
  <dst>2C7F:1040</dst>
  <dst>2C7F:1090</dst>
</jumpTable>

<indirectJump
    instrAdress="2C7F:0FE8"
    tableAddress="3A6A:8120"
    idxReg="bx" />
```

Important implementation details:

- `instrAdress` is intentionally misspelled with one `d` in Reko's v5 XML
  model. Use that exact spelling.
- Despite its XML name, `<indirectJump>` applies to both indirect jumps and
  indirect calls. Reko checks this override before running its automatic table
  extent analysis. This is the supported way to suppress an indeterminate
  call-table-size warning when every destination is already known.
- The jump table must exist before the indirect jump can resolve it.
- `idxReg` must name a valid architecture register.
- Destination parsing stops at the first invalid destination.

For an array of structures containing callback pointers, `tableAddress` should
identify the first callback field and the `<dst>` elements should enumerate the
callbacks explicitly. Reko's XML has no stride field for such an interleaved
table; the destination list, rather than contiguous pointer decoding, is what
the scanner trusts during the override.

This is a high-value feature for menu dispatchers, opcode interpreters, and AI
state tables.

## Block labels

```xml
<blocklabel location="2C7F:1234" name="invalidSaveSlot" />
```

Block labels replace generated labels when the scanner's block key matches the
`location` string. They improve control-flow readability without claiming a
new procedure boundary.

## User segments and raw inputs

```xml
<segment
    name="game_data"
    addr="3A6A:0000"
    offset="0"
    length="B900"
    arch="x86-real-16"
    access="rw" />
```

`offset` and `length` are hexadecimal strings. Missing access defaults to
`rwx`. These definitions are especially important for raw binaries, where the
explicit loader consumes them while constructing the image. Do not assume that
adding a user segment will rewrite the segment map already created by the MZ
loader for `REVENGE.EXE`.

## Output control

Project-level output policy accepts:

```xml
<outputFilePolicy>SingleFile</outputFilePolicy>
```

or:

```xml
<outputFilePolicy>Segment</outputFilePolicy>
```

Revenge currently uses `Segment`, producing one output grouping per image
segment. A procedure can override placement:

```xml
<procedure name="DOS_PrintString">
  <address>3327:0007</address>
  <OutputFile>text\DOS_PrintString.c</OutputFile>
</procedure>
```

The file is resolved relative to the project. This can eventually separate
sound, graphics, DOS I/O, input, and game logic, but it should be introduced
only after function boundaries are stable.

## Scanner and analysis heuristics

The implemented heuristic names relevant to project files are:

```xml
<heuristic name="shingle" />
<heuristic name="unlikely" />
<heuristic name="userMode" />
<heuristic name="aggressive-branch-removal" />
<heuristic name="calls-respect-abi" />
```

- `shingle` searches gaps for procedures missed by recursive scanning.
- `unlikely` accepts instructions the architecture normally rejects as
  improbable.
- `userMode` rejects privileged instructions.
- `aggressive-branch-removal` removes more branches during analysis.
- `calls-respect-abi` assumes calls preserve/alter state according to the ABI.

For Revenge, add heuristics one at a time and compare output. `shingle` can find
real routines but can also identify data as code. `aggressive-branch-removal`
can hide evidence that is useful during reverse engineering.

## Text and disassembly options

Available user settings include:

```xml
<textEncoding>ibm437</textEncoding>
<renderBaseInstrs>true</renderBaseInstrs>
<dasmAddress>true</dasmAddress>
<dasmBytes>true</dasmBytes>
<extractResources>false</extractResources>
```

- `textEncoding` uses a .NET encoding name. DOS US text is normally IBM code
  page 437, but confirm what the specific files use.
- `renderBaseInstrs` requests canonical/base instruction rendering.
- `dasmAddress` includes addresses in disassembly.
- `dasmBytes` includes instruction bytes.
- `extractResources` controls resource extraction.

## Debug tracing

```xml
<debug-trace-proc>DOS_PrintString</debug-trace-proc>
```

This watches a procedure by name during analysis. Much of the dump machinery is
compiled only in DEBUG builds or needs Reko's test-generation service, so it is
primarily useful when developing/debugging Reko itself, not as a dependable
feature of the published release build.

## Python project scripts

A top-level script is loaded from the project:

```xml
<script>
  <location>revenge_metadata.py</location>
</script>
```

The Python API supports event handlers for:

- `program_loaded`;
- `program_decompiling`;
- `program_scanned`;
- `program_decompiled`.

Scripts can read memory and programmatically set procedure names/signatures,
decompile flags, output files, globals, and comments. This is suitable for
repeatable bulk discoveries such as:

- walking a far-pointer table and naming every referenced object;
- reading a string table and adding comments at known consumers;
- defining fixed-size mech, vehicle, or weapon records;
- assigning names to a large dispatch table.

Prefer declarative XML or `.inc` metadata for hand-reviewed facts. Use a script
when the metadata can be derived deterministically from bytes and should be
regenerated. Keep scripts in source control; generated `.reko` output remains
disposable.

## Recommended Revenge workflow

1. Confirm a function entry in assembly.
2. Add or correct the `<procedure>` name immediately.
3. Add `CSignature` only when argument storage, widths, pointer distance, return
   storage, and near/far behavior are supported by assembly.
4. Use `<assume reg="ds" value="3A6A" />` when the procedure truly enters with
   the main data segment loaded.
5. Add exact-address annotations for strings, hardware accesses, table bases,
   and proposed behavior.
6. Type stable globals and tables, preferably in `RevengeMetadata.inc` once
   their layouts are known.
7. Describe confirmed switch/dispatch tables with `<jumpTable>` and
   `<indirectJump>`.
8. Re-run Reko into a fresh output directory and diff it against the previous
   run. Do not overwrite the hand-annotated `C` project.
9. Check Reko's diagnostics and search the output for the old generated name,
   unresolved `Mem*` expressions, unexpected `Stack` arguments, and bad stack
   deltas.
10. Commit the project metadata separately from regenerated output when
    practical, so a bad signature can be isolated and reverted.

## Validation checklist

Before accepting a project edit:

- XML parses and retains the exact v5 namespace.
- Every address is in architecture syntax (`SEG:OFF` for Revenge).
- The procedure attribute name and C declaration name agree.
- `__near`, `__far`, and calling conventions match the call/return assembly.
- Register attributes use real x86 register names and correct sequence order.
- Hex register values omit `0x`.
- `decompile=false` procedures have a complete signature.
- Annotations point to instruction addresses that produce statements.
- Indirect jumps use the schema's exact `instrAdress` spelling.
- Global pointer sizes match 16-bit near or 32-bit far pointers.
- Metadata paths are relative to the `.dcproject` location.
- A clean Reko run shows the intended improvement in callers as well as in the
  renamed procedure itself.

## Features not to confuse

- `CSignature` describes a function contract. It does not transplant our edited
  C body back into Reko.
- A project annotation is attached to an instruction address; it does not name
  a data object. Use a typed global for data.
- A procedure `<assume>` sets entry state; it does not add a C parameter.
- `<registerValues>` sets state at one instruction; it is not a global constant.
- `OutputFile` controls generated placement; it does not change procedure
  ownership or segment addressing.
- A `.inc` metadata file is parsed C with Reko attributes, not a header included
  by the generated C compiler.
