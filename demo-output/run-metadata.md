# Run metadata

## Run identifiers

- Branch: `experiment/northstar-20260514-0613-claimlint-team-cleanrerun`
- Starting commit SHA: `402f4721785a96cdede4fbfb2a38d981a4327ce4` (`402f472`)
- Run start (UTC): `2026-05-14T12:15:39Z`
- Run end (UTC): `2026-05-14T12:44:04Z`
- Wall time: ~28 minutes 25 seconds
- Model: Claude Opus 4.7 (1M context); teammates spawned as Claude Code project-scoped agents
- Run owner: lead (this conversation)

## Slate and process

- Slate: **four-role compact agent team** (`13-four-role-agent-team-prompt.md`).
- Teammates: Information Architect, Visual / UI Designer, Accessibility Specialist, Behavioral Scientist.
- Extra specialist spawned during the run: **none**. No Creative Director, Content Designer, Interaction Designer, or Devil's Advocate.
- Lead-personal work this run: claim-provenance lint, red-team checklist, render proof (top-level + no-mask retest), one defensive CSS edit on `.flight-card .row` / `.flight-card .top` to clear narrow-viewport intrinsic-width overflow at 390 px.
- Teammate nudges: none.

## Clean-room checks

- `git rev-parse --short HEAD` at start: `402f472`. Matches the prerequisite floor.
- `find demo-output -type f ! -name .gitkeep -print` at start: returned no files. demo-output was clean.
- `.claude/agents/` at start: 9 project-scoped agent definitions present.
- Prior outputs inspected before sealing: none. No prior branches, no PR #2, no past Northstar artifacts, no past evaluation reports, no past render-gate or top-proof or claim-lint outputs, no screenshots from prior runs, no invalid claim-lint attempts.
- Origin-identifying terms in the HTML body or `<title>`: scanned, none present. Page title is "Canceled-flight recovery — concept prototype." No commit SHAs, branch names, "agent team," or run metadata in product UI or the meeting-ready recommendation.

## Claim-provenance lint

Method: lead-personal scan of every user-visible string inside the five phone canvases of `demo-output/prototype/index.html` against operational-assertion categories named in the run prompt: fees/refunds/credits/expiration, eligibility, reversibility, wait times, texting/callback behavior, hotel/meal support, baggage, gates, compensation, support availability. Cross-checked against the Behavioral Scientist's claim-provenance audit (which produced 5 BLOCKERs prior to the v2 revision pass).

Findings on the v1 prototype (pre-revision): 5 claim-provenance blockers — re-notification promise (Screen 4), re-notification + reversibility promise (Screen 5), social-proof claim "Most travelers choose this" (Screen 2), reversibility promise "you can change your mind on the next screen" (Screen 2), process promise "We'll show you refund vs. credit on the next screen" (Screen 2). All resolved in v2.

Findings on the v3 prototype (final): every operational value in the user-visible product UI is either (a) a `{snake_case_token}` placeholder (44+ token slots, fully dynamic), (b) a user-action affordance label ("Text me this link," "Call Northstar support," "Add to wallet"), or (c) a definitional consequence of the option ("Confirmed seat on a later flight" / "No guaranteed seat" — what rebook and standby mean by definition). No invented amounts, names, phone numbers, wait times, callback windows, refund timelines, credit expirations, support hours, baggage rules, or gate info. Re-notification statements on Screens 4 and 5 are tokenized for both channels and entry points.

Result: **PASS**. Recorded as a hard floor for promotion.

## Render proof

Method: started a local HTTP server on port 7321 (verified free with `lsof -nP -iTCP:7321 -sTCP:LISTEN` before starting). Confirmed served bytes matched current `demo-output/prototype/index.html` by comparing `shasum -a 256` of the file against `curl http://127.0.0.1:7321/index.html | shasum -a 256`. Used `file://` was tried first but the local Playwright binding rejected it with `URL.canParse is not a function`; HTTP fallback used.

Top-level page renders captured with headless Chrome at 390×4400 (mobile) and 1280×4400 (desktop). Top-level DOM overflow checks run via Playwright `evaluate`.

### Initial v2 prototype (sha256 `275f34f9…` then `854136ef…`)

- 390 viewport: `html.scrollWidth = 417` vs `html.clientWidth = 375`. **FAIL**. 11 offenders, including `.page`, `.mockups`, and several `.summary-block .row-item`. Lead returned a render-gate fix request to Visual Designer.

### v3 prototype after VD fix (sha256 `854136ef…`)

- 390 viewport: top-level overflow narrowed; `.mockups` still 401 vs 351 client. Lead applied a one-line `minmax(0, 1fr)` change to `.mockups` `grid-template-columns` to allow shrinking.

### Final prototype (sha256 `d0c12c500071b492ebdfafd6e711a5e2855e0d9636ee98388d716b14128becad`)

- 390 viewport (with default scoped chrome masking on `.phone`, `.summary-block`, `.tonight-wrap`): `html.scrollWidth = body.scrollWidth = 375`; `html.clientWidth = body.clientWidth = 375`. **PASS**. 23 remaining offenders — all inside the phone frame, attributable to intrinsic-min-content widths of token-pill flex descendants in `.covered .items` and `.flight-card`.
- 390 viewport no-mask retest (`.phone`, `.summary-block`, `.tonight-wrap` set to `overflow: visible`): `html.scrollWidth = body.scrollWidth = 375`. Top-level still passes. **PASS**. 28 offenders, same intrinsic-content quirks; none push past page-level bounds.
- 1280 viewport: `html.scrollWidth = html.clientWidth = 1265`. **PASS**. 30 internal offenders, same pattern.
- Mobile and desktop screenshots inspected: no visible text/buttons/cards/CTAs escape any phone frame; tokens render visibly; CTAs operable; the warm "What's covered tonight" panel is salient on Screen 1; Screen 2 reads "Rebook is primary" without inversion-style coercion.

The remaining internal offenders represent token pills (`white-space: nowrap`) whose nominal content width exceeds the flex slot they occupy. They are clipped by scoped `overflow: hidden` on `.phone` for card-chrome corner rounding. Lead applied a defensive `flex-wrap: wrap` on `.flight-card .top` and `.flight-card .row` to clear the most user-noticeable cases on Screen 3.

Server cleanup: HTTP server on port 7321 stopped (`kill` returned SIGTERM, exit 143 as expected). No render-proof artifacts (screenshots, scratch files) are committed to the repository; they live only in a temporary directory.

## Final artifact

- Final prototype: `demo-output/prototype/index.html`
- Final prototype sha256: `d0c12c500071b492ebdfafd6e711a5e2855e0d9636ee98388d716b14128becad`
- Final prototype lines: 1179
- Final recommendation word count: 722 (under the 750 cap)

## Sequence summary

1. Information Architect (sequential, first).
2. Visual / UI Designer v1 prototype (sequential, after IA).
3. Accessibility Specialist + Behavioral Scientist audits (in parallel, both with blocking authority).
4. Visual / UI Designer v2 revision pass (single surgical pass against both audits).
5. Lead claim-provenance lint + red-team checklist (personal, no extra specialist).
6. Lead render-proof: failed; Visual / UI Designer v3 render-gate fix pass; lead follow-up CSS edit on flight-card flex-wrap.
7. Lead synthesis (final-recommendation, process-appendix, run-metadata).
8. Commit + push.
