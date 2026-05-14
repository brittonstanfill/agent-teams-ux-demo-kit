# Run Metadata

## Branch and commit

- **Branch**: `experiment/northstar-20260514-0656-internalrender-team`
- **Preflight HEAD**: `320b640` ("Record claim-lint evaluation and tighten render gate")
- **Sealing commit SHA**: (to be filled by the sealing commit)

## Timing

- **Preflight (clean-room check) UTC**: 2026-05-14T12:55Z (approx — first command after task start)
- **Seal UTC**: 2026-05-14T13:44Z (approx — when deliverables completed)
- **Wall-clock duration (lead session)**: ~50 minutes

## Model

- **Lead and all four teammates**: claude-opus-4-7 (1M context)

## Team composition

Four teammates, per prompt — no extras:

1. Information Architect — `01-information-architect.md`
2. Visual / UI Designer — `02-visual-ui-designer.md`
3. Accessibility Specialist — `03-accessibility-specialist.md`
4. Behavioral Scientist — `04-behavioral-scientist.md`

Lead personally owned: claim-provenance lint, red-team checklist, render proof, final memo, process appendix, and the late `.time-block` CSS fix from render-gate inspection.

## Extra specialists spawned

**None.** Creative Director, Content Designer, Interaction Designer, Devil's Advocate, and UX Researcher were not invoked.

## Nudges

**None.** No teammate was re-prompted to redo or adjust their work; the Visual Designer's single surgical revision pass after audits is the prompt-defined revision, not a nudge.

## Clean-room checks (preflight)

- `git rev-parse --short HEAD` → `320b640` ✓
- `find demo-output -type f ! -name .gitkeep -print` → empty ✓
- `.claude/agents/` count → 9 files ✓
- No reads from `evaluations/`, prior demo branches, PRs, screenshots, previous Northstar outputs, previous claim-lint attempts, or baseline outputs before deliverables were sealed.

## Render check method and result

- **Mode**: HTTP. `file://` was unsupported by the available browser MCP build (Node `URL.canParse` error). Fallback to a fresh local HTTP server.
- **Port**: 8421. Verified free via `lsof` before binding (`8421` was the first free candidate; not 7321, 8765, or 9876).
- **Server**: `python3 -m http.server 8421 --bind 127.0.0.1` from `demo-output/prototype/`.
- **Served-bytes vs file**: 51272 bytes served, 51272 bytes on disk; MD5 match (`07bc8ee1…` before fix, `2a48e546…` after the late `.time-block` CSS fix). Re-verified after the fix landed.
- **Browser**: Google Chrome 148 headless via puppeteer-core (installed in `/tmp/northstar-render` only; not committed).

### Checks run

1. **Top-level overflow @ 390×3000**: `html.scrollWidth = 390 = clientWidth`; `body.scrollWidth = 390 = clientWidth`. No top-level horizontal overflow.
2. **Top-level overflow @ 1200×3000**: same — `scrollWidth = clientWidth = 1200`.
3. **Per-element overflow walk (`scrollWidth > clientWidth`)**:
   - **Pre-fix @ 390**: 20 internal offenders — `.time-block`, `.when`, `.where`, `.times` overflowing inner box widths by 3–6px (token text wider than allocated flex basis). Container-escape check was clean (children stayed within `.flight` and `.mock` rects), but the stricter gate flags `scrollWidth > clientWidth` regardless.
   - **Fix applied**: `min-width: 0` added to `.flight .time-block .when` and `.where`; the `.tok` pills inside those elements set to `display: inline-block; max-width: 100%; word-break: break-all; overflow-wrap: anywhere`.
   - **Post-fix @ 390**: 0 non-`.sr-only` offenders. `.sr-only` matches (e.g. `Reason: earliest arrival`) are the standard visually-hidden screen-reader utility (width:1px + overflow:hidden) and are by-design accessibility content, not layout faults.
   - **Post-fix @ 1200**: 0 non-`.sr-only` offenders.
4. **Container-escape inspection** (children's rects vs parent rect for: `.mock`, `.phone`, `.choice`, `.flight`, `.summary-row`, `.status-line`, `.btn`, `.btn-primary`, `.btn-ghost`, `.tok`, `.filter`, `.toggle`, `.help`, `.banner`, `.status-pill`, `.primary-with-helper`): **0 escapees** at 390 and 1200.
5. **Long-token stress @ 390** (substitutions of all 15 known placeholder tokens with longer strings like `NS482-RETURN-LEG-A-EXTRA-LONG`, `SOMEWHERE-FAR-AWAY-INTERNATIONAL`, `STILL-WORKING-LATE-NIGHT-CHECK-LONG`): 0 non-`.sr-only` offenders, 0 escapees.
6. **Mask-off rerun @ 390 + long tokens**: `html, body, * { overflow: visible !important; overflow-x: visible !important; }` injected; rerun returned 0 non-`.sr-only` offenders, 0 escapees. No layout was being hidden by `overflow: hidden`.
7. **`overflow: hidden` scan**: scan for elements with computed `overflow-x: hidden` or `overflow: hidden` and `clientWidth > 50` returned **0 elements** in the prototype. (The `.sr-only` utility has `clientWidth = 1` and is correctly excluded.)
8. **Screen presence**: 5 `<article>` mocks with proper `aria-label="Screen N of 5: …"` attributes — verified.
9. **Token-pill count**: 56 `.tok` elements rendered.

### Render-gate result

**PASS** at both 390 and 1200 viewports, with and without long-token stress, with and without overflow masking.

## Claim-provenance lint result

- No dollar amounts, voucher values, hotel/chain names, phone numbers, wait times, expiration windows, or eligibility promises in the HTML or in the final memo.
- The phrase "Not guaranteed" appears on the standby card per the IA copy rule and is honest — it is a non-promise, not an entitlement claim.
- HTML `<title>`: `Canceled-flight recovery — mobile prototype` (no origin terms, no branch/SHA, no teammate count).
- Final memo and HTML body: no occurrences of "agent team," "team run," teammate count, branch name, or commit SHA.

## Notes

- Playwright MCP build in this environment failed on both `file://` and `http://` URLs with a `URL.canParse is not a function` error (Node compatibility on the MCP side). Fell back to direct Chrome headless via puppeteer-core; identical evidence quality.
- A scratch file `demo-output/prototype/probed.html` was used during render proof to inject the inspection script; it was removed before commit. Only `demo-output/prototype/index.html` is sealed.
