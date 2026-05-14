# Run metadata

## Identity

- **Branch:** `experiment/northstar-20260514-0401-rendergate-baseline`
- **Commit SHA at run start:** `3dd0280`
- **Model:** claude-opus-4-7 (1M context)
- **Run mode:** single-agent baseline (the same model authored research, IA, interaction, content, accessibility, visual, and behavioral-science thinking in one pass — no multi-agent coordination).

## Times

- **Start (UTC):** 2026-05-14T10:03:28Z
- **End (UTC):** 2026-05-14T10:12:30Z
- **Wall time:** ~9 minutes 02 seconds (includes a one-time Playwright Chromium download of ~265 MiB for the render check).

## Clean-room checks

- `git rev-parse --short HEAD` returned `3dd0280` before any writes — confirmed at or after the required baseline commit. **PASS**
- `find demo-output -type f ! -name .gitkeep -print` returned no rows before any writes. **PASS**
- No prior `demo-output/`, prior demo branches (e.g. `demo/northstar-final-recommendation`, `demo/single-agent-baseline`), PR #2, prior Northstar artifacts, prior render-gate artifacts, screenshots, evaluation reports, or team outputs were opened during authoring. **PASS**

## Render / viewport check

- Rendered the prototype with Chromium headless (chrome-headless-shell from Playwright's bundled build) at two viewports against a local `python3 -m http.server` instance:
  - **390×844** narrow mobile — the four phone frames stack vertically, no horizontal clipping, no text escaping cards or buttons, status spine and entitlement rows render coherently.
  - **1280×any** desktop — the four phone frames sit in a 4-column row; SMS comparison renders as 2-column; trust/accessibility panel renders as 2-column. No overlap, no overflow.
- A taller-viewport pass at both widths (5000px tall mobile, 4000px tall desktop) confirmed all four screens, both panels, and the foot render in full without truncation or clipping.
- Console: no errors thrown during the render.

## Blind-eval hygiene

- Scanned the meeting-ready recommendation and the prototype HTML for origin-identifying terms (single-agent, baseline, team, agent-team, branch fragments, commit SHA, render-gate). Remaining matches in the prototype are CSS keywords (`align-items: baseline`, `box-shadow`) and are not user-visible. Fixed one origin leak in the recommendation memo (an explicit reference to the prototype file path) before sealing.
- Scanned for ungrounded operational claims (static wait times, voucher amounts, hotel names, phone numbers, credit expiration windows, eligibility guarantees, fare difference promises, layover lengths, late-checkout times, calendar windows). Found and rewrote three soft inventions to dynamic placeholders before sealing:
  - "Counter opens ~3 hours before departure" → "Window shown here · earliest counter open time appears live"
  - "Connection in ORD · 1h 5m layover" → "One connection · layover length shown here"
  - "Earliest hotel checkout is 11 a.m." → "Hotel late-checkout shown here if available"
  - "Browse the full schedule for the next 14 days" → "Browse the full schedule"
- The `$84 fare difference` token in the recommendation is a direct citation of the existing flow's copy from the brief, not an invented claim.

## Process notes

- Authored the prototype, then the memo, then the metadata — in that order — so that the artifact and the spec stayed in sync.
- Did not score, did not open any comparison output, did not open any prior prototype.
- No external editor or formatter was run on the artifacts.
