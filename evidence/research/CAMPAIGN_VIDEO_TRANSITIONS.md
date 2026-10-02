# Campaign and tactical video transitions

This note records the assembly-verified display path exposed by the latest
error-free Reko decompile. It deliberately describes only behavior visible in
the executable.

## Battle-boundary rebuild

`RebuildTacticalVideoResources_0387(adapterType, showScenarioCompletion)` is
called twice by `InitializeTacticalScenario_0214` when
`UseEgaTacticalFallback_83DC` requires a mode transition:

- before the tactical battle with adapter type `02h` (EGA) and result display
  disabled;
- after the battle with adapter type `03h` (VGA) and result display enabled.

The routine selects the video mode, loads the palette rooted at `DS:00AC`, and
returns early when `DS:0096` says the display path is unavailable. Otherwise it
optionally draws the scenario result, reloads graphics resource zero, rebuilds
the mouse cursor backing buffer, reloads screen resource zero, and converts the
work buffer into the EGA off-screen page at segment `A200h` when appropriate.
It finally frees and replaces the eight-tile strip stored at `DS:99B5:99B7`.

## VGA palette bank anchors

`InstallVgaPaletteBankAnchors_329E` runs only for adapter type `03h`. The loop
copies three bytes per iteration from consecutive palette entries `00h..0Fh`
to entries `00h,10h,20h,...,F0h`, then calls `LoadVideoPalette_0004` for the
complete palette. The term *bank anchor* describes this exact layout without
assuming how later drawing code interprets the sixteen banks.

## Scenario result banner

`ShowScenarioCompletionStatus_5789` hides the mouse cursor, tests bit 0 of
`CampaignFlags_24DF`, and draws one of two verified strings:

| Address | Text | Tile position | Foreground/background |
|---|---|---|---|
| `DS:2B11` | `Scenario completed successfully` | `(4, 12)` | `0Fh / 0Ch` |
| `DS:2B31` | `Scenario completed unsuccessfully` | `(3, 12)` | `06h / 0Ch` |

After restoring the cursor it writes `0Bh` to `DS:5923`.
`InitializeTacticalScenario_0214` waits until that word becomes zero. The
assembly at `0800:2440` proves that the installed BIOS `INT 1Ch` callback
decrements it once per DOS system tick (approximately 54.9254 ms). Thus the
banner remains for roughly 0.604 seconds. Tactical play normally reloads the
same `TacticalUpdateDelayTicks_5923` field from `DS:17DA`, so this is a shared
frame/update countdown rather than a banner-specific variable.

`ApplyVideoConfigOption_0669` proves the adapter distinction. The `VGA` entry
stores adapter type `03h` and sets `UseEgaTacticalFallback_83DC`; the `MCGA`
entry stores configuration value `07h`, normalizes it to renderer type `03h`,
and leaves the fallback clear. The EGA-before/VGA-after transition is therefore
the explicit VGA tactical fallback, not a generic VGA/MCGA compatibility flag.
