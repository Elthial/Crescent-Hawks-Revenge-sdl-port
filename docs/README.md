# Documentation guide

The documentation is divided by authority so that an old milestone does not
look like a current instruction.

## Current and authoritative

- [`../README.md`](../README.md) — build, run, package and project status.
- [`PRESERVATION_PLAN.md`](PRESERVATION_PLAN.md) — behavioral-preservation
  rules and verification definitions.
- [`RECONSTRUCTED_C_PLAN.md`](RECONSTRUCTED_C_PLAN.md) — current readable-C
  source model and its constraints.
- [`SOURCE_LAYOUT.md`](SOURCE_LAYOUT.md) — directory ownership and where new
  evidence or code belongs.
- [`METHOD_TABLE.csv`](METHOD_TABLE.csv) — procedure-by-procedure assembly
  verification ledger.
- [`SOURCE_CONVERSION_TABLE.csv`](SOURCE_CONVERSION_TABLE.csv) —
  procedure-by-procedure reconstructed-C ledger.
- [`SUPPORTED_VERSIONS.md`](SUPPORTED_VERSIONS.md) — supported DOS executable
  profiles and SHA-256 identifiers.
- [`ORIGINAL_BUGS.md`](ORIGINAL_BUGS.md) — policy for original quirks and host
  compatibility changes.
- [`../CONTRIBUTING.md`](../CONTRIBUTING.md) — preservation contribution and
  validation requirements.

## Acceptance and audit records

- [`CAMPAIGN_SMOKE_TEST.md`](CAMPAIGN_SMOKE_TEST.md) — automated smoke path,
  manual acceptance coverage and remaining validation limits.
- [`HELPER_AUDIT.md`](HELPER_AUDIT.md) — completed audit of non-original helper
  procedures and their dispositions.
- [`RECONSTRUCTION_HISTORY.md`](RECONSTRUCTION_HISTORY.md) — concise historical
  milestones. It is not a source of current build instructions.

## Evidence

[`../evidence/README.md`](../evidence/README.md) explains the self-contained
annotation, metadata and assembly layout. Evidence records may preserve old
names and intermediate hypotheses; the two CSV ledgers connect them to the
current reconstructed source.
