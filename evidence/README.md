# Preservation evidence

This directory contains the evidence needed to audit the reconstructed C
procedures without relying on the former monorepo checkout.

- `annotations/` contains the reviewed C annotations and annotation indexes.
- `metadata/` contains the Reko project and procedure metadata used to recover
  entry points and signatures.
- `assembly/` contains the per-segment assembly listings used as the final
  authority for procedure behavior.
- `research/` preserves format notes, runtime investigations and reconstruction
  records. Historical hypotheses may be superseded by assembly or observed
  original behavior.

The original `REVENGE.EXE`, installed game data, saves, extracted artwork and
audio are deliberately absent. Evidence derived from the proprietary program
is excluded from the project-authored MIT license; see `../LICENSE` and
`../NOTICE.md` before redistribution.

[`../docs/METHOD_TABLE.csv`](../docs/METHOD_TABLE.csv) is the authoritative
index connecting this evidence to the corresponding implementation in
`src/Original`.