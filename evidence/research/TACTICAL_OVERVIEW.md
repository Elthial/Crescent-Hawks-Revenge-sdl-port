# Tactical overview map

The tactical overview is a dedicated full-map display layered over the normal
tactical interface. Segment `24C5` owns its redraw and exit paths. The names in
this note are verified from the original 16-bit assembly unless marked
otherwise.

## Rendering model

`DS:83E6` is a far pointer to a byte-per-cell overview color map. Its row
stride is `(MapWidth_00A6 + 7) & FFF8h`, so each row is rounded up to an
eight-byte boundary. `DrawTacticalOverviewMap_037F` clears the active video
buffer and plots every aligned map byte at screen X
`TacticalOverviewScreenOriginX_A7F1 + mapX` and screen Y `mapY`.

The tactical camera covers `13h` by `0Ch` map cells. On the overview it is
drawn as a `26h` by `18h` pixel outline because each map cell in the frame is
doubled in both axes. `DrawTacticalOverviewViewportFrame_02F1` first invokes
`1A1F:182E` to constrain the camera origin, copies the current X/Y values to
the previous-frame cache, and draws four color-`0Fh` lines.

## Unit markers

`RefreshTacticalOverview_012E` maintains two 24-byte arrays:

| Address | Name | Meaning |
|---|---|---|
| `DS:8374` | `TacticalOverviewMarkerX_8374` | Last drawn marker X; `FFh` means absent. |
| `DS:83C0` | `TacticalOverviewMarkerY_83C0` | Last drawn marker Y. |

Each refresh restores the map color beneath the previous markers and viewport
border before drawing their new positions. Deployed records in
`PersistentUnitRoster_8B81` take their coordinates from
`ScenarioUnitMapX_8562` and `ScenarioUnitMapY_857B`. Slots `00h`-`0Bh` use
color `DDh`; slots `0Ch`-`17h` use `66h`, or `AAh` for scenario suffixes
`46h`-`53h`.

## Mode transition

`TacticalOverviewActive_8104` selects the overview update path. Its earlier
`SuppressCampaignClock` label described only a side effect: the ordinary
clock renderer is skipped while overview mode is active.

`ExitTacticalOverview_0401` clears the flag and framebuffer, resets the first
nine `SceneRuntimeSlotSentinel_B574` bytes to `FFh`, invokes
`RedrawTacticalStatusPanel_16BA` to rebuild text window `06h`, its side
indicator, and the campaign clock, then restores the mouse cursor.

## Procedure map

| Address | Name | Confidence |
|---|---|---|
| `0800:0B07` | `PlotPixel_0B07(x, y, color)` | V |
| `24C5:012E` | `RefreshTacticalOverview_012E()` | V |
| `24C5:02F1` | `DrawTacticalOverviewViewportFrame_02F1()` | V |
| `24C5:037F` | `DrawTacticalOverviewMap_037F()` | V |
| `24C5:0401` | `ExitTacticalOverview_0401()` | V |

The overview submode at `DS:8335` is intentionally left unnamed. Its callers
show that it selects full-map versus incremental refresh behavior, but the
player-facing meaning still needs tracing through the tactical input state
machine.
