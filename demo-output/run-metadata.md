# Run Metadata

## Origin

- **Branch:** `experiment/northstar-20260514-0448-topproof-team`
- **Parent commit (system commit the run was authored against):** `73e8feb`
- **Run date:** 2026-05-14
- **Wall-clock start:** 04:51 MDT (lead session begin, after clean-room preconditions verified)
- **Wall-clock end:** 05:35 MDT (sealing time)
- **Approximate wall time:** ~44 minutes
- **Model:** Claude Opus 4.7 (1M context) — lead and all four teammates

## Slate

Four-role compact agent team, used exactly as the prompt specified:

1. **Information Architect** — user-job spine, five-screen sequence, copy constraints, scoped gaps, handoff punch-list.
2. **Visual / UI Designer** — authored `demo-output/prototype/index.html` and ran one surgical revision pass after audits.
3. **Accessibility Specialist** — audit with blocking authority. Returned 5 BLOCKERS, 8 SHOULD-FIX, 6 NICE-TO-HAVE.
4. **Behavioral Scientist** — audit with blocking authority. Returned 2 BLOCKERS, 5 SHOULD-FIX, 3 NICE-TO-HAVE.

**Lead** ran the red-team checklist personally (no Devil's Advocate teammate spawned), performed the blind-hygiene scan, performed the top-level render proof, and synthesized.

**Extra specialists spawned:** none. No Creative Director, Content Designer, Interaction Designer, or Devil's Advocate was spawned. If any had been spawned, the prompt rule was that the run be recorded as an escalation and scored against the lean slate. That clause did not trigger.

**Teammate nudges:**
- Visual Designer received a single consolidated revision-pass brief from the lead listing which audit items to ship (blockers + named SHOULD-FIX), which to defer with reason, and which Behavioral B2 option (a vs b) the lead biased toward. This was a directed brief, not a mid-task correction. No teammate was redirected after starting their task. The IA, A11y Specialist, and Behavioral Scientist each ran their tasks without nudges.

## Clean-room checks

Verified before any teammate was spawned:

- `git rev-parse --short HEAD` = `73e8feb`. ✓ (required: `73e8feb` or later)
- `find demo-output -type f ! -name .gitkeep -print` = empty. ✓
- `.claude/agents` contained the 9 project-scoped agent definitions. ✓
- No prior baseline outputs, branches, PRs, screenshots, evaluation reports, or past Northstar artifacts were opened or referenced by lead or any teammate during authoring or audit.
- All teammates were briefed with the clean-room rule explicitly. The Visual Designer was permitted to read only the IA's role report as upstream context for authoring. The A11y Specialist and Behavioral Scientist were permitted to read the brief, the IA report, the Visual Designer's role report, and the prototype HTML, and nothing else in `demo-output/`.

## Top-level responsive render proof (this run's gate)

This run was specifically testing the stricter responsive-proof method added at commit `73e8feb`. Method and result are recorded in full below so the gate is auditable.

### Method

1. **Local server.** Served `demo-output/prototype/index.html` over `http://127.0.0.1:8765/` using `python3 -m http.server`, so the page loaded as a normal top-level document (not via `file://` and not inside an iframe).
2. **Headless browser.** Used Playwright Core 1.54.2 driving Chromium 1224 (Google Chrome for Testing 149.0.7827.3), launched in headless mode. Each viewport was a fresh browser context; the page was loaded with `waitUntil: 'networkidle'` and given a short settle.
3. **DOM overflow probe (top-level).** Evaluated on `document.documentElement` directly (the page root, not an iframe): captured `clientWidth`, `scrollWidth`, the boolean `scrollWidth > clientWidth`, and an array of up to 10 named offending elements (any element whose `getBoundingClientRect().right > clientWidth + 0.5` or `left < -0.5`).
4. **Full-page screenshot (top-level).** `page.screenshot({ fullPage: true })` at each viewport. Screenshots are not part of the committed deliverables (kept in `/tmp/proto-renders/`) but were inspected during sealing to confirm no visible clipping, no overlap, no fixed-format mockup exceeding viewport.
5. **No-mask retest.** At 390px and 1280px, re-ran the probe after injecting `html, body { overflow-x: visible !important; }` to override the prototype's `overflow-x: hidden` defense-in-depth, to confirm the clean overflow result was the layout's true state and not a mask. This is the additional check the stricter method asks for.
6. **Iframe probes were not used as primary evidence.** None of the gate findings rely on iframe-rendered DOM measurement. The Visual Designer's earlier in-task CDP probing was also top-level. Iframes are deliberately absent from the proof.

### Result

**At top-level, with the prototype's `overflow-x: hidden` shipped as-is:**

| Viewport | clientWidth | scrollWidth | overflow | offenders |
|---|---|---|---|---|
| 360 × 780 | 360 | 360 | false | [] |
| 390 × 844 | 390 | 390 | false | [] |
| 1280 × 900 | 1280 | 1280 | false | [] |
| 1920 × 1080 | 1920 | 1920 | false | [] |

**At top-level, with `overflow-x: hidden` overridden to `visible` (no-mask retest):**

| Viewport | clientWidth | scrollWidth | overflow | offenders |
|---|---|---|---|---|
| 390 × 844 | 390 | 390 | false | [] |
| 1280 × 900 | 1280 | 1280 | false | [] |

**Visual confirmation.** Full-page screenshot at 390 × 844 inspected: all five screens stack into a single column. No element clips the viewport. No card, button, nav, phone frame, or fixed-format mockup forces horizontal scroll or overlaps incoherently. Full-page screenshot at 1280 × 900 inspected: content rail centered with side padding, all screens stack vertically, no horizontal overflow.

**Verdict.** Top-level render proof **passes** at every tested viewport. The `overflow-x: hidden` declaration in the shipped file is defense-in-depth, not a mask covering a layout bug.

**Visual Designer's in-task verification (recorded for cross-reference, not the primary evidence).** During the surgical revision pass, the Visual Designer ran their own top-level CDP probe at 360, 390, 414, 640, 768, 1024, 1280, 1440, 1920 and confirmed the same result, including discovering and fixing a real flex-shrink bug in the new S5 `.support-item-status` layout that the no-mask retest had surfaced. The lead's independent re-run after sealing matches.

## Deliverables sealed

- `demo-output/role-reports/information-architect.md`
- `demo-output/role-reports/visual-designer.md`
- `demo-output/role-reports/accessibility-specialist.md`
- `demo-output/role-reports/behavioral-scientist.md`
- `demo-output/prototype/index.html`
- `demo-output/final-recommendation.md` (740 words; under 750-word cap)
- `demo-output/process-appendix.md`
- `demo-output/run-metadata.md` (this file)

## Blind-eval hygiene scan

Grep of `demo-output/prototype/index.html` and `demo-output/final-recommendation.md` for: `agent[- ]team`, `team run`, `four[- ]role`, `compact`, `teammate`, `run-metadata`, `branch`, `commit`, `SHA`, `opus`, `sonnet`, `claude`, `anthropic`, `model` — no contaminating hits in user-visible copy. The `<title>` is the product-realistic `Northstar Air — Trip Recovery`. The only matches for "agent" in the HTML are the legitimate user-facing "Get help from an agent" affordance. The only matches for "commit" are the user-facing verb on review-and-commit copy. No invented operational facts in user-visible copy: no dollar amounts, no static wait times, no hotel partner names, no phone numbers, no compensation guarantees. Every dynamic field is `{system-supplied}`.
