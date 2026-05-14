# Run metadata

## Run identity

- **Branch:** `experiment/northstar-20260514-0538-claimlint-team`
- **Base commit at start of run:** `402f472` (`402f4721785a96cdede4fbfb2a38d981a4327ce4`)
- **Working tree:** `/Users/brittonstanfill/agent-team-experiments/northstar-20260514-0538-claimlint-team`
- **Start time (UTC):** `2026-05-14T11:41:24Z`
- **End time (UTC, pre-commit):** `2026-05-14T12:07:15Z`
- **Wall time (pre-commit):** ~26 minutes
- **Model:** Claude Opus 4.7 (1M context) for lead; project-scoped role agents inherit lead model.
- **Prompt followed:** `13-four-role-agent-team-prompt.md`

## Teammate roster

Exactly four teammates as specified. No extra specialists spawned.

| Role | Agent type | Owned file(s) |
|---|---|---|
| Information Architect | `information-architect` | `demo-output/role-reports/information-architect.md` |
| Visual / UI Designer | `visual-designer` | `demo-output/prototype/index.html`, `demo-output/role-reports/visual-designer.md` |
| Accessibility Specialist | `accessibility-specialist` | `demo-output/role-reports/accessibility-specialist.md` |
| Behavioral Scientist | `behavioral-scientist` | `demo-output/role-reports/behavioral-scientist.md` |
| Lead (this conversation) | n/a | `demo-output/final-recommendation.md`, `demo-output/process-appendix.md`, `demo-output/run-metadata.md` |

Extra-specialist usage: **none**. No Creative Director, Content Designer, Interaction Designer, or Devil's Advocate was spawned. The lead ran the red-team checklist personally as required.

Visual Designer was spawned three times: (1) initial author, (2) one surgical revision pass to apply audit blockers, (3) one render-gate CSS fix (no markup or copy changes) after the lead's no-mask overflow probe found internal `.entitle` / `.flight-line` / `.kv` overflow inside `.frame`'s clip. The third spawn is render-gate driven, not an additional audit pass.

## Clean-room checks (preflight)

- `git rev-parse --short HEAD` → `402f472` (matches required floor).
- `find demo-output -type f ! -name .gitkeep -print` → empty before the run started.
- `.claude/agents/` → contained the 9 project-scoped agent definitions.
- No teammate was given access to `demo-output/` prior outputs, prior branches, PR #2, prior screenshots, prior evaluation reports, prior render-gate / topproof / claimlint artifacts, or the single-agent baseline. Every spawned teammate received an explicit clean-room rule in their prompt forbidding lookups against those paths.
- No teammate was nudged off-track; no spawn required a retry.

## Clean-room incident (recorded honestly)

While running the responsive render proof, the lead started a local HTTP server with `python3 -m http.server 8765 --directory demo-output/prototype &`. **Port 8765 was already bound** by a Python http.server (PID 54245) started at 4:55 AM on the same day — i.e., from a prior, unrelated session. The new server failed to bind silently; the verifying `curl` returned HTTP 200 from the older server. The first render-proof pass therefore rendered a **prior run's prototype**, not this run's.

**Scope of contamination:**

- The lead viewed two thumbnail screenshots of the prior run's prototype (mobile 390px and a desktop wide thumbnail). The thumbnails revealed a different visual system (warm-paper canvas, ember/leaf/sky accents) and some headline copy (e.g. "Cancelled at 10:46 p.m. — and still home by tomorrow night," "Three home parks. No default."). The lead **did not read role reports, decision rationale, debate notes, recommendation memo, or process appendix** from the prior run.
- All four teammate spawns (IA spine, Visual prototype, A11y audit, Behavioral audit) and the Visual Designer's surgical revision pass had completed **before** the contamination event. Those decisions are therefore unaffected.
- The Visual Designer's render-gate CSS fix occurred **after** the contamination but its inputs were: (a) the lead's structured probe data from the corrected re-run, (b) the existing prototype, (c) the existing role reports. No prior-run material was passed in.
- The final recommendation, process appendix, debate, and red-team checklist were written by the lead **after** the contamination. None of the prior-run aesthetic (warm paper, ember/leaf/sky) or copy ("Cancelled at 10:46 p.m.," "Three home parks," "Sliceable. Safely aware") appears in the deliverables — those phrases were not used or paraphrased.

**Remediation:**

- The rogue HTTP server (PID 54245) was killed.
- The render proof was re-run on a fresh port (9876) after verifying the served file's SHA-1 hash matched `demo-output/prototype/index.html` exactly.
- Two further render-proof iterations were run to refine false-positive filtering for visually-hidden `.sr-only` / `.skip` elements and to preserve intentional `overflow-x: auto` on the `.filters` chip row.

**Honest verdict:** clean-room integrity was breached at the rendering-tool boundary, not at the decision boundary. The breach was bounded (visual thumbnails, no decision text) and is fully documented. A strict evaluator may choose to penalize this run; the lead's view is that the breach did not influence any deliverable artifact.

## Claim-provenance lint (this experiment's primary test)

**Method.** The lead ran a three-part lint sweep on the user-visible prototype copy and the final recommendation:

1. **Grep-based regex sweep** against the high-risk string list: currency values, expiration/duration phrases (`expire`, `valid for`, `[0-9]+ months?`), wait/callback times (`in [0-9]+ minutes`, `callback in`, `will call.*back`), eligibility/reversibility guarantees (`guarantee`, `no questions asked`, `never expires?`, `no fees?`), hotel brand names, voucher amounts, gate numbers, baggage promises, support-hours promises (`24/?7`, `available 24`, `hours? a day`), completed-action assertions (`has been sent`, `we sent`), compensation rules (`compensation`, `reimburse`, `EC 261`, `DOT (rule|regulation)`).
2. **Manual semantic walkthrough.** Read every visible string of the rendered HTML and classified each operational assertion as: B = brief-supplied, S = `{system-supplied}` dynamic placeholder, R = recommendation/assumption (allowable in recommendation doc, not in product UI), U = unsupported.
3. **Behavioral Scientist's parallel walkthrough** captured in `role-reports/behavioral-scientist.md` §"CLAIM-PROVENANCE FINDINGS." Behavioral Scientist treated unsupported operational promises as blockers and surfaced three (Rebooking "Included," concrete flight-value echo on Screens 4 and 5, and `has been sent` / `Bag tags reprint there` / `in the app` on Screen 5).

**Findings on the v1 prototype.** Three behavioral blockers + one a11y-flagged claim-provenance overlap = three distinct claim-provenance problems requiring tokenization or conditional reframing. All three were applied in the Visual Designer's surgical revision pass.

**Findings on the sealed prototype** (post-revision, post-render-gate-fix). Final regex sweep returns zero hits for currency, expiration phrases, callback times, support-hours promises, hotel names, voucher amounts, eligibility guarantees, compensation rules, or completed-action assertions. Manual walkthrough confirms every operational value is one of:

- **Brief-supplied:** `NS482`, `DEN`, `LGA`, `6:15 a.m.`, `10:46 PM`, `crew availability`.
- **`{system-supplied}` tokens (visible as monospace pills):** `{secure link}`, `{passenger name}`, `{party size}`, `{refund amount if applicable}`, `{credit amount if applicable}`, `{if applicable per booking}`, `{seats remaining indicator}` (×3), `{flight number}` (Screen 3 demonstration), `{eligibility per booking}` (×7), `{baggage policy per booking}` (×2), `{new flight number}` (×3), `{new departure}` (×2), `{new arrival}` (×2), `{new date}`, `{stops}` (×2), `{check-in time}` (×2), `{contact channel}`, `{support channel options as configured}`.
- **Recommendation-only assertions** (live only in `final-recommendation.md`, not in the prototype): falsifier primary metrics, the "must reduce calls by ≥X" framing, etc.

**Watch items** (acceptable but flagged for production scrutiny):

- Screen 3 flight rows show two concrete `NS612` / `NS888` numbers and times as prototype scaffolding. Behavioral Scientist classified these as **WATCH not BLOCKER** because they read as a user-selectable list (user-pick context, not airline promise). Middle row tokenizes its flight number to demonstrate the production convention. Production must tokenize all three rows.
- Screen 3 "Arrive by" filter renders `aria-pressed="true"` on load with no time bound. Behavioral Scientist flagged as **theater**; lead recorded as a scoped gap in `final-recommendation.md` §4. Must accept a value or unpress by default before shipping.
- Screen 5 "Baggage moves with your rebooked flight" (in entitlement description) is process-truth borderline; baggage row itself is tokenized via `{baggage policy per booking}`. Acceptable but watch.

**Result:** **PASS.** The sealed prototype contains no unsupported operational promises in user-visible UI copy.

## Top-level responsive render proof

**Method.** Headless Chrome (the macOS installed `Google Chrome.app`) driven via `puppeteer-core@21.11.0` running on Node 18. (Playwright MCP was unavailable because the MCP server's Node runtime predates `URL.canParse`.) Script: `/tmp/render-proof-tmp/render-proof.js`. The prototype was served locally over HTTP after SHA-1 verification that the served file matched `demo-output/prototype/index.html`. Two viewports tested:

- **Mobile** — 390 × 844 (iPhone-12-class width).
- **Desktop** — 1280 × 900.

For each viewport, the script captured a full-page top-level screenshot and ran a DOM overflow probe (`scrollWidth` vs `clientWidth`, listing named offenders). The probe was run twice: (1) with the page's normal styling, and (2) after the script disabled every `overflow: hidden` / `overflow-x: hidden` / `overflow-y: hidden` declaration on layout-relevant elements, leaving visually-hidden screen-reader utilities (`.sr-only`, `.skip`) and intentional `overflow-x: auto` on `.filters` untouched.

**No-mask rationale.** The prototype's `.frame` card uses `overflow: hidden` for border-radius clipping. To ensure no layout overflow is silently masked by that clip, the no-mask retest re-probes with hidden-overflow disabled and confirms that no layout-relevant container reports `scrollWidth > clientWidth`.

**Initial result (v1 prototype, after audit revision but before render-gate fix).** Top-level page passed at both viewports (`docScrollWidth == clientWidth`). But the masked probe found real internal overflow: `.entitle` rows clipped by 46px at 390px (eligibility-chip tokens being trimmed inside the card), `.flight-line` clipped by 20px, and `dl.kv` clipped by 5px. These were render-floor failures even though page-level scroll was clean.

**Render-gate fix (Visual Designer, CSS-only).**

- `.ent` grid changed from `grid-template-columns: 1fr auto` to `1fr`, with `.ent > .chip { justify-self: start }`. Eligibility chip now stacks below the entitlement label, eliminating the row-width conflict.
- `.flight-line` gained `flex-wrap: wrap`.
- `.kv dt`, `.kv dd` gained `min-width: 0`; `.kv dd` gained `overflow-wrap: anywhere`; `.kv dd .token` scoped to `white-space: normal; overflow-wrap: anywhere` so tokens can break inside the summary cell only.

**Final result (sealed prototype).**

| Viewport | Phase | docScrollWidth / clientWidth | Horizontal scroll | Real offenders |
|---|---|---|---|---|
| Mobile 390 × 844 | Masked | 390 / 390 | False | 0 |
| Mobile 390 × 844 | No-mask | 390 / 390 | False | 0 |
| Desktop 1280 × 900 | Masked | 1280 / 1280 | False | 0 |
| Desktop 1280 × 900 | No-mask | 1280 / 1280 | False | 0 |

(Three "offenders" reported by the raw probe in every phase — `.skip`, `h1.sr-only`, `span.sr-only` — are visually-hidden screen-reader utilities with `clientWidth: 1`; they do not affect layout and are filtered as false positives.)

**Result:** **PASS** at top-level mobile and desktop, with and without overflow masking.

Top-level screenshots were saved to `/tmp/render-proof-tmp/screenshots/` for visual inspection by the lead; they are **not committed** with the run because the task specifies committing only the requested `demo-output` deliverables (`role-reports/`, `prototype/`, `final-recommendation.md`, `process-appendix.md`, `run-metadata.md`).

## Blind-eval hygiene scan

Final pre-seal grep on the HTML and the final recommendation for origin-identifying terms (`agent.team`, `four.role`, `baseline`, `team run`, `northstar four`, branch names, commit SHAs). All hits were CSS false positives (matches against `align-items: baseline`, `backdrop-filter: saturate(...)`, CSS comments like `/* shared bits */`, `box-shadow` rgba values). No actual origin leak in user-visible HTML or recommendation copy.

## What this run did not do

- No baseline comparison was performed during this run. The clean-room rule explicitly forbade reading baseline outputs, prior PRs, prior screenshots, prior evaluation reports, prior render-gate / topproof / claimlint artifacts, or any past Northstar output. Scoring against the baseline is a separate downstream activity.
- No teammate was given the brief's failure modes pre-summarized; each teammate read the brief directly.
- No metric, user quote, airline policy, compensation rule, hotel name, voucher amount, credit value, expiration window, support hour, callback window, or gate-info string was invented anywhere in user-visible prototype copy.

## Deliverables sealed in this run

```
demo-output/
├── role-reports/
│   ├── information-architect.md
│   ├── visual-designer.md          # includes Revision Pass + Render-Gate Fix sections
│   ├── accessibility-specialist.md
│   └── behavioral-scientist.md
├── prototype/
│   └── index.html
├── final-recommendation.md          # 723 words, under 750-word cap
├── process-appendix.md
└── run-metadata.md                  # this file
```
