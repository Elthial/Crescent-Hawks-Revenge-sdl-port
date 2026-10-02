# Reviewed annotations

This directory contains the maintained C-like annotation view of
`REVENGE.EXE`. It is evidence for the reconstructed source, not compilable
modern C and not an alternative implementation.

## Relationship to other evidence

- `../assembly/` contains the per-segment assembly listings.
- `../metadata/` contains the Reko project and procedure metadata.
- `../../docs/METHOD_TABLE.csv` maps each executable procedure to its
  annotation and reconstructed C procedure.
- `ANNOTATION_INDEX.md` records broader data-flow and subsystem findings.

The source files intentionally retain Reko equivalence types, segmented
notation and imperfect expressions where rewriting them would erase useful
evidence. The large generated `REVENGE.h` is part of that type graph.

## Annotation conventions

- `ANNOTATION:` states a conclusion supported by executable bytes, an API
  contract, a data-file layout or repeated observed behavior.
- `CANDIDATE:` states a useful hypothesis that still needs confirmation.
- `V:` and `P:` in the index distinguish verified and proposed conclusions.
- Assembly settles any disagreement between annotations and reconstructed C.

Confirmed procedure names do not carry address suffixes; their addresses remain
in procedure headers, metadata and the method table. For generated data fields,
an evidence-backed semantic name may retain the original generated token as a
suffix, for example `SuppressPostStageMenu_b24E4`. This preserves direct
provenance while improving use-site readability. Already meaningful names do
not receive such a suffix retroactively, and unknown fields remain address
named.

Text recovered from fixed DS addresses may be written as a C string literal
with a `TEXT DS:xxxx` provenance comment. Fixed addresses are written as
`DS:xxxx`; genuinely dynamic far pointers remain pointer values rather than
being forced into a fixed segment model.

## Maintenance

When a reconstructed name, type or purpose is established:

1. confirm it against the assembly and current reconstructed procedure;
2. update the annotation use sites and generated type-graph field consistently;
3. retain address provenance in the identifier, declaration or nearby comment;
4. update `ANNOTATION_INDEX.md` when the finding affects a subsystem; and
5. run `tools/Test-PreservationLedgers.ps1` from the repository root.

Do not normalize uncertain decompiler output merely to make it look like valid
C. A readable uncertainty is better evidence than a clean but invented answer.
