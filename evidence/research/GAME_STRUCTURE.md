# Game and scenario structure

The campaign is mostly linear combat connected by briefings, with decisions
and battle outcomes altering later forces or selecting one branch. This is the
key architectural requirement for any scenario extractor: it must represent
objectives, conditional carry-over, and unit persistence rather than treating
each map as a standalone skirmish.

## Campaign phases

1. **Lyons, 3029** — DropShip crash, recovery of the surviving Hawks, bridge
   defense, Kell Hound base defense, gauntlet/road-run branch, and destruction
   of the Kurita Mobile HQ.
2. **Dieron / Operation Liberty** — choose force composition and mountain or
   forest approach, optionally capture Crusaders, break into the prison,
   extract the prisoners, and escape Chiun's pursuit.
3. **Interlude, 3030–3049** — narrated time jump through the War of 3039 and
   the lead-up to the Clan invasion.
4. **Arc-Royal training, 3051** — six simulations in any order: attack town,
   defend town, enemy advance, advance fast, hold ground, and seize position.
   Artillery, air strikes, and satellite maps appear here.
5. **Kaesong** — combat-drop versus full-company arrival, followed by the
   choice to help the town. Helping provides full repairs; refusing carries
   existing damage forward.
6. **Luthien, 3052** — convoy defense, survival and relief, river-valley
   defense, northern-plains counterattack, and pursuit of the Clan Galaxy
   Commander.
7. **Pacifica training ground** — post-victory custom battles rather than
   further story progression.

This outline combines the [Sarna game
overview](https://www.sarna.net/wiki/BattleTech:_The_Crescent_Hawks%27_Revenge)
with the supplied Electronic Gamer walkthrough. It is a structural summary,
not a reproduction of the walkthrough.

## Scenario data leads

- The installation contains 30 `SCENE*.DAT` files, each no larger than 2,005
  bytes.
- The supplied winning saves describe named checkpoints from scenario 2
  through scenario 26 plus the training ground.
- Scenario files contain verified MAP and ICONSET selectors, 72 bounded message
  strings, and a bytecode block interpreted by `ExecuteSceneInstructions_2A4E`.
- All 48 dispatch entries `CFh..FEh` have verified operand widths. The decoded
  operations cover unit placement, movement routes, attacks, damage/repair,
  ammunition, equipment, campaign time, narration events, global state, and
  conditional flow.
- The maps and scene count are not one-to-one: 30 scenes share 11 maps.
- `SCENE1.DAT` has an end-to-end trace connecting its resources, roster recipe,
  all 166 reachable instruction bytes, state changes, branches, and event
  messages.

## Remaining scenario investigation

1. Use controlled play to identify D4h selectors 04h/05h, the four D5h award
   slots, and confirm the proposed FCh tactical-order labels.
2. Correlate save campaign fields with one isolated scenario transition.
3. Identify generic narration speaker banks only where executable or live
   evidence supports a character identity.
4. Use DOSBox-X or Spice86 captures only for semantics that static producer and
   consumer tracing cannot settle; DAh withdrawal and F8h attack state no
   longer require capture.

## Walkthrough source status

- The supplied Electronic Gamer text covers the campaign and is sufficient for
  the phase summary above.
- The indexed FortuneCity [walkthrough](https://lethe97.fortunecity.ws/chrsolve.htm)
  and [mech reference](https://lethe97.fortunecity.ws/chrmechs.htm) currently
  fail direct retrieval; retain the URLs for provenance.
- The [Abandonware DOS
  walkthrough](https://www.abandonwaredos.com/docawd.php?sf=battletechcrescentrevengewalkthrough.txt&st=walkthrough&sg=BattleTech%3A+The+Crescent+Hawks%27+Revenge&idg=1770)
  also failed direct retrieval during this research pass. Do not infer missing
  details from an unavailable copy.
