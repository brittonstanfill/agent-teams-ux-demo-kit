# Run Metadata

## Origin

- **Branch:** `experiment/northstar-20260514-0401-rendergate-team`
- **Commit SHA at run start:** `3dd0280bc2cde29014e3fa2cbd765be679814c51` (short: `3dd0280`)
- **Start time (UTC):** 2026-05-14T10:04:05Z
- **End time (UTC):** 2026-05-14T10:35:48Z
- **Wall time:** approximately 31 minutes 43 seconds
- **Model:** `claude-opus-4-7` (1M context)
- **Run type:** clean-room four-role compact agent-team — render-gate test

## Teammates

Four-role slate, exactly:

1. Information Architect — `information-architect` (project-scoped)
2. Visual / UI Designer — `visual-designer` (project-scoped)
3. Accessibility Specialist — `accessibility-specialist` (project-scoped)
4. Behavioral Scientist — `behavioral-scientist` (project-scoped)

No additional specialists were spawned. Specifically, no Creative Director, no Content Designer, no Interaction Designer, no Devil's Advocate, no UX Researcher. The lead ran the red-team checklist personally as required by the prompt.

## Clean-room checks

- `git rev-parse --short HEAD` before any spawning: **3dd0280** ✔
- `find demo-output -type f ! -name .gitkeep -print` before any spawning: **(empty)** ✔
- `.claude/agents/` count: **9 project-scoped agent definitions present** ✔ (accessibility-specialist, behavioral-scientist, content-designer, creative-director, devils-advocate, information-architect, interaction-designer, ux-researcher, visual-designer)
- No teammate or lead opened anything in `demo-output/` other than this run's own deliverables, no prior demo branches, no PR #2, no past Northstar artifacts, no baseline outputs, no past evaluation reports or screenshots. Each teammate's prompt explicitly enforced this clean-room rule.

## Responsive render smoke check (the new gate at commit `3dd0280`)

Verified before sealing. Method: headless Google Chrome 148.0.7778.97 served the prototype from a local `python3 -m http.server`. A same-origin probe page loaded the prototype in iframes at multiple widths and ran a JS scan for every element whose right edge extended past its iframe viewport.

**Results:**

| Width  | viewport | docWidth | Overflow | Offenders |
|--------|----------|----------|----------|-----------|
| 320 px | 320 px   | 305 px   | -15 px   | 0         |
| 360 px | 360 px   | 345 px   | -15 px   | 0         |
| 390 px | 390 px   | 375 px   | -15 px   | 0         |
| 1280 px | 1280 px | 1265 px  | -15 px   | 0         |
| **390 px (no inner scrollbar)** | **390 px** | **390 px** | **0 px** | **0** |

The first four rows used short iframes that triggered an inner scrollbar (-15 px reservation), so the effective content width was 15 px less than the iframe declared width. The final row used a tall iframe (height 11000 px) so no inner scrollbar appeared and the page rendered at the full 390 px viewport. Either way: zero offending elements at every viewport.

Direct full-page screenshots at 390 px and 1280 px confirmed clean rendering visually — text wraps, phone-frame chrome strips below 420 px so content reaches the edges, no nav / cards / buttons / fixed-format mockups clip horizontally or overlap incoherently.

**Render-gate verdict: PASS.**

Process note: early standalone-Chrome screenshots at `--window-size=390,800` appeared at first glance to show right-edge clipping on the page header, intro paragraph, and primary button. Investigation traced this to a Chrome-headless macOS scaling/scrollbar artifact rather than real layout overflow. The iframe-probe method (final row above) removed the ambiguity: at a true 390 px viewport, content fits at exactly 390 px with zero offenders. No second revision pass to the Visual Designer was required to pass the render gate.

## Extra-specialist usage

**None.** The run stayed strictly within the four-role slate.

## Nudges

- **One scheduled nudge** to the Visual Designer: the post-audit surgical revision pass, which is part of the four-role prompt's specified sequence (it is not an off-spec escalation).
- **No additional nudges.** The render gate was met by the first surgical revision and did not require a second VD pass.

## Sequence (telemetry)

1. IA spawned and authored `role-reports/information-architect.md` (≈ 2 min).
2. VD spawned and authored `prototype/index.html` and `role-reports/visual-designer.md` (≈ 4 min). The prototype was a clean-canvas author, not a relay.
3. A11y and Behavioral spawned in parallel and each authored their role report (≈ 4 min wall, ≈ 6.5 min summed work).
4. VD revision pass: cleared 10 A11y blockers and 4 in-HTML Behavioral blockers in a single pass (≈ 5 min).
5. Lead red-team checklist ran personally (no Devil's Advocate spawn).
6. Lead render-gate smoke check at 320 / 360 / 390 / 1280 widths (zero overflow offenders).
7. Lead synthesized `final-recommendation.md` (under the 750-word cap at 743 words), `process-appendix.md`, and this metadata file.
8. Lead ran a blind-hygiene scan on the prototype HTML and the final recommendation. Three items were scrubbed: (a) an "render-gate" string in a CSS comment, (b) an invented phone number `1-800-555-0482` (the IA explicitly left this as a slot for content-designer/policy to fill — for the blind artifact, the visible number was replaced with the placeholder text "support number from your booking" and `tel:` hrefs became `href="#"`), (c) two instances of "may be issued if your wait exceeds the threshold" on the Screen 3 meal-support item, replaced with non-promising eligibility language that defers to the confirm step. The scrubs do not change layout or the render-gate result.

## Deliverables committed

- `demo-output/role-reports/information-architect.md`
- `demo-output/role-reports/visual-designer.md`
- `demo-output/role-reports/accessibility-specialist.md`
- `demo-output/role-reports/behavioral-scientist.md`
- `demo-output/prototype/index.html`
- `demo-output/final-recommendation.md`
- `demo-output/process-appendix.md`
- `demo-output/run-metadata.md`

`.claude/agents/` is NOT committed (project-scoped agent installation is environment, not run output).
