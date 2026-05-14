# Run Metadata

## Origin

- **Team name:** Northstar Four-Role UX Recovery Team — Visual Craft Gate
- **Branch:** experiment/northstar-20260514-0835-visualcraft-team
- **Parent commit SHA (worktree HEAD at start):** af82a69c1011acbd5272b10780c7b5aea1d1e660
- **Worktree:** /Users/brittonstanfill/agent-team-experiments/northstar-20260514-0835-visualcraft-team
- **Start time (UTC):** 2026-05-14T14:29:53Z
- **End time (UTC):** 2026-05-14T14:49:28Z
- **Model:** claude-opus-4-7 (1M context) on Claude Code
- **Protocol:** 13-four-role-agent-team-prompt.md plus the visual-craft gate amendment described in the run brief.

## Teammates

1. Information Architect
2. Visual / UI Designer
3. Accessibility Specialist
4. Behavioral Scientist

No additional specialist was spawned. Creative Director, Content Designer, Interaction Designer, UX Researcher, and Devil's Advocate were explicitly not invoked. The lead ran the red-team checklist personally.

## Nudges

No teammate was nudged on substance. One teammate was prompted once to finish writing its assigned role-report file after it returned a results message without writing the report. No content direction was given in that prompt; only the file-output instruction was repeated.

## Clean-room checks

- `evaluations/` not opened, searched, summarized, or referenced by any teammate or by the lead before seal.
- Prior demo branches, PRs, prior baseline outputs, prior team outputs, prior screenshots, and prior agent transcripts were not opened.
- `demo-output/` was empty except `.gitkeep` at worktree HEAD af82a69 before this run.
- Stale `/tmp` artifacts from a previous (unrelated) render attempt were observed in a `ls` listing while picking a fresh scratch directory; the files were not read. Render outputs for this run were written to a fresh `/tmp/northstar-visualcraft-render-*` directory created during this run, and the puppeteer probe scratch was written to a separate `/tmp/northstar-vc-probe-*` directory. No scratch files were placed inside the worktree and no scratch files are committed.
- Only the files listed under "Committed paths" below are committed.

## Render proof

- **Method:** Real browser, Google Chrome (`/Applications/Google Chrome.app/Contents/MacOS/Google Chrome`) in headless=new mode, driven by puppeteer-core 22 installed in a `/tmp` scratch directory outside the repository.
- **Serving:** `python3 -m http.server 7891 --bind 127.0.0.1` from `demo-output/prototype/`. Port 7891 is not 8421, 7321, 8765, 9876, or 5500. Port-free check via `lsof -i :7891` before start. Served bytes verified equal to file bytes (both 38113) before probes ran. The HTTP path was used because the local Playwright MCP tool failed on `file://` URLs (`URL.canParse is not a function`); the same HTML was rendered via the local file system, served unchanged.
- **Top-level overflow check (mask preserved):**
  - 320 px: scrollWidth 320 = clientWidth 320 — no overflow.
  - 390 px: scrollWidth 390 = clientWidth 390 — no overflow.
  - 1280 px: scrollWidth 1280 = clientWidth 1280 — no overflow.
- **Top-level overflow check (mask off, sr-only preserved):** A probe that forced `overflow: visible !important` on every element except the standard `.visually-hidden` sr-only utility found:
  - 390 px: no overflow, zero internal offenders.
  - 320 px + long-token substitution: no overflow, zero internal offenders.
- **Long-token stress:** Tokens such as `{confirmation_code}`, `{baggage_status}`, `{hotel_status}`, `{meal_status}`, and `{new_arrival_time}` were replaced at runtime with long stand-ins (e.g. `CONF-7H3K9MQX-LONGCASE`, `Bag checked through to LGA, transferred at ORD, tag NS9482-X`, full-sentence statuses). Page reflowed and wrapped; nothing clipped.
- **Fixed-container check:** Mobile-width screen cards (`.screen`, max-width 420 px) remained visible-overflow (`overflow: visible`) and did not clip their content. Path cards, flight cards, summary rows, buttons, and the SMS bubble all reflowed without horizontal scroll at 320 px / 390 px and rendered correctly at 1280 px.
- **`overflow:hidden` audit:** The only `overflow: hidden` declaration in the artifact is the standard `.visually-hidden` sr-only utility used to clip a single 1 px screen-reader-only heading. It is not used to mask any visible layout.
- **Decorative phone bezels:** None. The prototype renders mobile-width cards as a vertical stack so the full five-screen flow is readable at a glance.

Screenshots saved to `/tmp/northstar-visualcraft-render-14047/` (`mobile-320-fullpage.png`, `mobile-390-fullpage.png`, `mobile-390-longtokens.png`, `desktop-1280.png`) for human inspection. They are not committed.

## Blind-eval hygiene scan

- HTML: scanned for "agent-team", branch name "experiment/northstar-20260514-0835-visualcraft-team", commit SHA "af82a69", model name "claude" / "opus", teammate count, run dates. No hits.
- Final recommendation and process appendix: scanned for the same terms. No hits.
- Operational facts: scanned for invented hotel names, voucher amounts, support phone numbers, arrival times, credit-expiration windows, wait times, compensation rules, legal obligations, eligibility promises. None present. Dynamic values appear as named tokens.

## Committed paths

Only the following are committed:

- `demo-output/role-reports/01-information-architect.md`
- `demo-output/role-reports/02-visual-designer.md`
- `demo-output/role-reports/03-accessibility-specialist.md`
- `demo-output/role-reports/04-behavioral-scientist.md`
- `demo-output/prototype/index.html`
- `demo-output/final-recommendation.md`
- `demo-output/process-appendix.md`
- `demo-output/run-metadata.md`
