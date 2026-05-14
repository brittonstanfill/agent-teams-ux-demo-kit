# Run Metadata

## Run identity

- **Branch:** `experiment/northstar-20260514-0750-boundedrender-team`
- **Parent commit (preflight `git rev-parse --short HEAD`):** `87b1974`
- **Parent commit (full):** `87b1974f9ef5810bae71632ec2038d009234b440`
- **Start (UTC):** 2026-05-14T13:51:29Z
- **End (UTC):** 2026-05-14T14:15:30Z
- **Model:** claude-opus-4-7 (Opus 4.7, 1M-context variant)
- **Lead role:** human-operator-coordinated synthesis; lead-owned strict render proof, red-team, debate resolution, final memo.

## Teammates spawned (exactly four, per prompt)

1. Information Architect — `information-architect` subagent
2. Visual / UI Designer — `visual-designer` subagent (called twice: initial author, single surgical revision pass)
3. Accessibility Specialist — `accessibility-specialist` subagent
4. Behavioral Scientist — `behavioral-scientist` subagent

No extra specialists were spawned. No Creative Director, Content Designer, Interaction Designer, Devil's Advocate, or UX Researcher. No teammate was nudged.

## Clean-room checks

- Preflight `git rev-parse --short HEAD`: `87b1974`.
- Preflight `find demo-output -type f ! -name .gitkeep -print`: empty (clean).
- Preflight `.claude/agents` count: 9 files (none touched during run).
- Per-role clean-room rule embedded in every teammate's prompt: no reading of `evaluations/`, `claude-agents/`, prior demo branches, prior PRs, prior screenshots, baseline outputs, or any past Northstar output. Each teammate was bounded to: the brief, the IA report (downstream roles), the prototype HTML (auditors and lead), and their own writes.
- Lead did not read `evaluations/`, prior Northstar branches, baseline output, or past claim-lint/internal-render attempts before sealing.
- Blind-hygiene scan on `demo-output/prototype/index.html` and `demo-output/final-recommendation.md`: no occurrence of "agent-team", "team run", branch name, commit SHA, teammate count, "Claude", or run metadata. Token pills use generic placeholders only.

## Render-proof method (lead-owned, post-audit)

Tool: Playwright (Chromium-headless-shell 147.0.7727.15), Python 3.13 in an isolated `/tmp/.render-probe-venv`. Loaded via `file://` URL (preferred per prompt) — no HTTP server required, so no port reservation, no `lsof`, no served-bytes check needed.

**Checks performed:**

1. **Top-level overflow at mobile (390×900) and desktop (1280×900).** `document.documentElement.scrollWidth` vs `clientWidth`, plus `document.body` equivalents.
2. **No-mask rerun at 390px.** Injected a stylesheet that set `html, body { overflow: visible !important }` and `.phone { overflow: visible !important }` to defeat both global and per-container clipping masks; re-measured.
3. **Internal fixed-container inspection.** 23 selector classes (`.phone`, `.phone-inner`, `.app-header`, `.status-banner`, `.paths`, `.path`, `.flights`, `.flight-card`, `.filters`, `.chip`, `.sort-row`, `.btn-primary`, `.btn-secondary`, `.btn-ghost`, `.support-dock`, `.dock-link`, `.token`, `.confirm-hero`, `.save-row`, `.support-card`, `.stub-line`, `.callout`, `.path-title`, `.flight-times-row`). For each match: scrollWidth > clientWidth check, plus descendant bounding-box-escape against the parent's padding box.
4. **Visual screenshot evidence.** Full-page PNG at 390 and 1280, full-page PNG at 390 no-mask, and per-screen zoom crops (`.phone` 1–5, `.app-header`, `.filters`, `.paths`, `.flights`, `.support-dock`, `.confirm-hero`).

**Results (final pass after the lead's CSS regression-fix on `.support-dock` and `.token`):**

- Top-level overflow: **zero** at 390 mobile (masked), 390 no-mask, and 1280 desktop. `scrollWidth == clientWidth` in all three modes.
- Fixed-container scrollWidth overflow: **zero** across all 23 inspected selectors in all three modes.
- Descendant escape findings: 10 total, identical across all three modes. Categorized after visual inspection of zoom crops:
  - 5 × `app-header → <a class="call-support">`: escape = 8px = parent's right padding. Child sits flush to the inner padding edge, not past the border box. `zoom-header.png` confirms "Call support" link fully visible with full 44px tap target.
  - 5 × `filter-chip → <input type="checkbox">`: escape = 14px = the visually-hidden checkbox's native bounding box. The element has `clip: rect(0 0 0 0); width: 1px; height: 1px`, so no rendered content escapes. `zoom-filters.png` confirms all five chip labels ("Nonstop only", "Arrive by 4 p.m.", "Morning", "Afternoon", "Seats for {passenger_count}") fully visible.
- No-mask check identical to masked: confirms `.phone { overflow: hidden }` is not masking any real clipping.
- Per-screen visual inspection (zoom crops): all phone frames, cards, buttons, status rows, support docks, and token pills contain visible text and controls. No clipping, no overlap, no sideways scroll.

**Render fix applied by the lead** (after audit revision, before sealing):

- `.support-dock` got `flex-wrap: wrap; gap: var(--s-2) var(--s-3)` and `min-width: 0` on its first child.
- `.support-dock a` got `gap: 6px; flex-wrap: wrap; max-width: 100%`.
- `.token` switched from `word-break: break-word` (which broke `{support_number}` mid-word into `{support_numbe / r}`) to `overflow-wrap: anywhere` with `max-width: 100%`.

Render proof re-ran clean after the fix. Scratch render scripts and the venv live under `/tmp` and are not in the repo.

## What was bounded vs lead-owned this run (changed variable for the rerun)

- **Visual Designer's pre-audit render check:** bounded — one 390px viewport top-level overflow probe, deleted before commit. Per the prompt, the exhaustive top-level + fixed-container + long-token + no-mask proof is **lead-owned after audits**. The Visual Designer did not enumerate fixed containers before handoff.
- **Lead post-audit render gate:** strict — top-level + no-mask + 23-selector fixed-container internal inspection + per-screen visual zoom crops. Sealed only after all three modes returned zero scrollWidth overflow and all 10 escape findings were confirmed false-positive with screenshot evidence.

## Files committed

- `demo-output/role-reports/information-architect.md`
- `demo-output/role-reports/visual-designer.md`
- `demo-output/role-reports/accessibility-specialist.md`
- `demo-output/role-reports/behavioral-scientist.md`
- `demo-output/prototype/index.html`
- `demo-output/final-recommendation.md`
- `demo-output/process-appendix.md`
- `demo-output/run-metadata.md`
