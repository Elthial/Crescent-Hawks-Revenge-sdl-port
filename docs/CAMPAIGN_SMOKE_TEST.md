# Campaign acceptance record

This document separates the repeatable automated smoke path from broader manual
play testing. Neither is a claim that the complete campaign is verified.

## Automated smoke path

Established on 2026-09-29, the smoke path runs the SDL executable against a
private original-game installation. `REVENGE_SMOKE_INPUT` supplies delayed raw
keyboard values at the SDL input boundary; it does not bypass menus or call
game procedures directly.

| Check | Result |
| --- | --- |
| Title resources render before input | Pass |
| Main-menu keyboard navigation | Pass |
| New Game dispatches campaign stage 0 | Pass |
| Original save container can be loaded | Pass |
| Loaded campaign stage dispatches | Pass |
| Tactical resources, units and first frame initialize | Pass |
| Tactical interaction loop is entered | Pass |
| Confirmed title/options shutdown returns zero | Pass |

The original raw keys used by this harness include Enter `002B`, Escape
`006E`, Right `0066`, Down `0062` and Up `0060`. The harness is optional and is
inactive unless `REVENGE_SMOKE_INPUT` is set.

## Manual acceptance

Manual play testing has completed campaign missions 1 through 6. This covers
substantially more than the scripted tactical-entry smoke test, including
campaign transitions, lance assignment, tactical movement and targeting,
combat, mission completion, debriefing and continued save/campaign state.

The last behavior-changing acceptance baseline is commit `59f8cdab`. Later
commits through the documentation cleanup are preservation accounting,
repository organization and annotation readability work.

## Remaining validation

- Complete the remaining campaign and alternate branches.
- Exercise more save/load points across campaign stages.
- Compare presentation timing and audio effects with an original DOS run.
- Retest uncommon adapters and configuration combinations where practical.
- Record any discovered defect with the campaign stage, save state, input mode
  and trace output needed to reproduce it.

Original saves and assets used for acceptance remain private and are not part
of the repository.
