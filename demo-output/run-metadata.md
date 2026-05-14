# Run metadata

## Identity

- **Branch:** `experiment/northstar-20260514-0448-topproof-baseline`
- **Commit SHA at run start:** `73e8febcfb405064a782e59585fc65ac9b342dba` (short: `73e8feb`)
- **Run type:** Single-agent baseline (clean-room)
- **Model:** Claude Opus 4.7 (1M context) — `claude-opus-4-7[1m]`
- **Prompt used:** `03-single-agent-baseline-prompt.md`

## Timing

- **Start:** `2026-05-14T10:51:42Z`
- **End:** `2026-05-14T10:59:18Z`
- **Wall time:** ~7 minutes 36 seconds

## Clean-room checks

- `git rev-parse --short HEAD` printed `73e8feb` before any output was written. **Pass.**
- `find demo-output -type f ! -name .gitkeep -print` printed nothing before any output was written. **Pass.**
- No prior `demo-output/` content read, no prior demo branches inspected, no prior PR opened, no prior screenshots or evaluation reports opened, no past Northstar / render-gate / topproof artifacts opened. **Pass.**
- No team outputs, role reports, or process appendices read. **Pass.**
- No scoring performed in this run. **Pass.**

## Top-level render proof

This run is specifically testing the stricter render-proof method added at `73e8feb`: render the **top-level page** (not an iframe) at ~390 px mobile and a desktop width, and check the **top-level DOM** for `scrollWidth <= clientWidth` with named offenders if any.

### Method

1. Served `demo-output/single-agent-baseline/index.html` from a local static HTTP server (`python3 -m http.server 8765`).
2. Launched headless Google Chrome 148 with `--remote-debugging-port=9222` and loaded the page directly (top-level — not embedded in any iframe).
3. Used the Chrome DevTools Protocol over a WebSocket from a Node 18 script to:
   - call `Emulation.setDeviceMetricsOverride` with the target width/height (`mobile: true` at narrow widths),
   - reload the page so layout ran at the emulated width,
   - call `Runtime.evaluate` on the top-level document to read `document.documentElement.scrollWidth`, `document.documentElement.clientWidth`, `body.scrollWidth`, `body.clientWidth`, and to walk every element collecting any whose `getBoundingClientRect()` extended past `viewW + 0.5` or before `-0.5`.
4. Captured top-level **page** screenshots (headless Chrome `--screenshot`, **not** an inner-iframe probe) at:
   - 390 × 2700 (mobile, light scheme)
   - 1280 × 2700 (desktop; rendered with the OS-default dark-mode preference in headless Chrome)
   - 390 × 2700 with `--force-dark-mode` (mobile, dark scheme stress)
5. Inspected the screenshots visually for horizontal clipping, incoherent overlap, or text/nav/cards/buttons/fact-bar/filter chips/flight cards/review card/checklist/toolbar escaping their containers.

### Result

| Viewport | `docScrollWidth` | `docClientWidth` | `overflowFits` | Offenders flagged |
|---|---|---|---|---|
| 360 × 800 (stress) | 360 | 360 | **true** | `a.skip` at `left=-9999, right=-9806` |
| 390 × 844 (mobile) | 390 | 390 | **true** | `a.skip` at `left=-9999, right=-9806` |
| 1280 × 900 (desktop) | 1280 | 1280 | **true** | `a.skip` at `left=-9999, right=-9806` |

The single flagged "offender" at all three widths is the WCAG skip link (`<a class="skip" href="#screens">Skip to recovery flow</a>`), positioned at `left: -9999px` until focused — the standard accessible skip-to-content pattern. It is intentionally off-canvas and does not cause horizontal scroll. No real content overflows.

Visual inspection of the screenshots: no text clips outside cards, the phone frames sit comfortably inside the viewport at 390 px, all buttons fit on a single line, filter chips wrap rather than overflow, the fact-bar's "Was → Now" grid stays inside its cell, the checklist's `value` text stays inside its cell, and the masthead `h1` wraps cleanly rather than escaping.

**Top-level render proof: PASS** at 360 px, 390 px, and 1280 px on the top-level page, by both DOM measurement and screenshot inspection. The method exercises the shipped page directly; no iframe-only probe was relied upon.

## Constraint-integrity self-check

- No invented metrics, percentages, or rates.
- No invented user quotes.
- No invented airline policy, legal obligation, or compensation rule.
- No static wait times — wait language is "wait shown live" / "current wait time shows here".
- No credit expiration windows.
- No eligibility promises beyond "may be available" / "shown live based on your booking".
- No hotel names — placeholder is "partner shown live".
- No voucher amounts.
- No phone numbers.
- "Reversible for the next hour, or until check-in opens" is labeled in the recommendation doc as a [recommendation] requiring ops sign-off, not as existing policy.
- "Most travelers in this situation" line on Screen 2 is labeled in the recommendation doc as conditional on telemetry backing — removed at implementation if it cannot be backed.

## Blind-eval hygiene self-check

The recommendation doc and the HTML title/body contain no occurrences of: "single-agent", "baseline", "team", "agent-team", branch name, commit SHA, or run metadata. (All origin-identifying information lives only in this file.)
