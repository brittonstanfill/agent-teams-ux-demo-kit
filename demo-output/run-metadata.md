# Run metadata

## Run identity

- **Branch:** `experiment/northstar-20260514-0538-claimlint-baseline`
- **Commit at start:** `402f472` (`402f4721785a96cdede4fbfb2a38d981a4327ce4`)
- **Start time (UTC):** 2026-05-14T11:41:56Z
- **End time (UTC):** 2026-05-14T12:01:37Z
- **Wall time:** ~20 minutes
- **Model:** Claude Opus 4.7 (1M context) — `claude-opus-4-7[1m]`
- **System variant under test:** clean-room single-agent baseline with stricter claim-provenance lint

## Clean-room checks

- `git rev-parse --short HEAD` → `402f472` ✅ (matches the runbook precondition `402f472` or later)
- `find demo-output -type f ! -name .gitkeep -print` → no output before authoring ✅
- No prior team outputs, prior branches, PR #2, screenshots, evaluation reports, or past Northstar/render-gate/topproof/claimlint artifacts were opened during this run ✅
- No score was assigned during this run ✅

## Claim-provenance lint

**Method.** Before sealing, every user-visible string in the prototype was audited line-by-line for operational assertions in these categories: fees, refunds, credits, expiration, eligibility, reversibility, wait times, texting / callback behavior, hotel / meal support, baggage, gates, compensation, and support availability. The pass criterion: each assertion must be (a) directly supplied by the brief, (b) clearly dynamic as a `{system-supplied}` placeholder, or (c) reframed in the recommendation doc as a `[recommendation]` / `[assumption]` rather than a promise in product UI.

A keyword grep was used to surface candidate lines:

```bash
grep -niE "(refund|credit|expire|expiration|fee|hotel|meal|voucher|wait|callback|baggage|bag|gate|compensat|comply|eligib|free|guarantee|hours|minutes|days|policy|insurance|standby|seat)" demo-output/single-agent-baseline/index.html
```

Each candidate line was then classified as product UI (inside `.phone__screen`), design caption (outside the phone, designer notes about the screen), or design-notes section (bottom of page, prefixed with a visible `recommendation` label).

**Findings and remediations.**

| Initial draft claim | Status | Remediation |
|---|---|---|
| Path: "Request a refund instead — Refund to your original payment method. Available because Northstar canceled this flight." | ❌ Fails: invents refund eligibility tied to airline-caused cancellation; brief does not establish refund as a path. | Replaced with the third brief-supplied path: "Try standby on another flight — No guaranteed seat." Refund is named only in the recommendation doc as a `[scoped gap]`. |
| Orient subhead: "You don't need to do anything else tonight unless you want to." | ❌ Fails: implies a timing flexibility not asserted in the brief. | Rewritten as "Here's what you can do from here." |
| Orient path 1: "Confirmed seat on the next available Northstar flight to New York." | ❌ Fails: "confirmed seat" reads as a guarantee. | Rewritten as "See the Northstar flights to New York available to you. You pick the seat and confirm." |
| Orient path 2: "The fare becomes a credit for later — terms shown on the next screen." | ❌ Fails: implies a 1:1 fare-to-credit conversion. | Rewritten as "Don't fly now. The amount and terms of the credit are shown before you confirm." |
| Tonight card: "Tonight, on us — Because the cancellation happened on Northstar's side, hotel and meal support may be available." | ❌ Fails: "on us" promises coverage; "on Northstar's side" implies an eligibility rule. | Rewritten as "Tonight — Hotel and meal support may be offered for tonight. Tap below to see what's available to you and the terms." |
| Flight cards: arrival times (`3:45 PM`, `8:25 PM`, `2:10 AM`) and layover cities (`ORD`, `ATL`). | ❌ Fails: invents arrival times and layover airports not in the brief. | Replaced with `{arrival-time}` placeholders; departures kept (brief supplies 7:10 AM / 2:40 PM / 6:30 PM); layover wording reduced to "1 stop" without specific city. |
| Meal card: "Meal on us while you wait." | ❌ Fails: "on us" promises a meal benefit. | Rewritten as "Meal while you wait" with conditional body copy. |
| Hotel card: "hotels Northstar can book for you tonight and what's covered." | ⚠️ Borderline: "what's covered" implies a coverage promise. | Softened to "the hotel options Northstar can offer you for tonight and what's included" — both terms now defer to dynamic content shown before acceptance. |
| Confirmation flight: "NS612 · DEN → ORD → LGA · Departs 7:10 AM · arrives 3:45 PM · seat {seat}" | ❌ Fails: invents flight number, layover airport, and arrival time. | Rewritten to use `{flight-number}`, `{layover}`, `{arrival-time}`, `{seat}` placeholders. Departure 7:10 AM kept (matches brief's listed option). |
| Confirmation hotel: "Shuttle pickup details and check-in window shown in the app." | ⚠️ Borderline: implies a shuttle exists. | Softened to "Pickup and check-in details shown here once confirmed by Northstar." |
| Confirmation bags: "If your bag was already checked, we'll move it to the new flight and show its current location here." | ❌ Fails: promises bag transfer behavior not in brief. | Rewritten as "Status shown here as Northstar updates it / If anything needs your attention, you'll see it on this screen." |
| Confirmation footer: "Offline copy saved · also sent to your email and Apple/Google Wallet" | ❌ Fails: promises email + wallet pass delivery channels not in brief. | Rewritten as "Recap kept in the app · text or email a copy below" with a single secondary button "Text or email me a recap." |

**Result.** ✅ Lint passes. After remediation, no operational assertion in product UI is unsourced. Every flagged term either (a) traces to the brief (cancellation event, crew availability, hotel voucher and meal credit existing as options, three flights with departure times and stop counts, standby being one of three tabs), (b) is rendered as a `{system-supplied}` placeholder visible to the reader, or (c) is moved into the recommendation doc with an explicit `[recommendation]` or `[scoped gap]` label. The recommendation doc itself uses `[observed from brief]` / `[inferred from brief]` / `[assumption]` / `[recommendation]` provenance tags throughout, with a visible legend in the prototype masthead.

## Responsive render proof

**Method.** Headless Chromium for Testing driven by Playwright (Node 23.11). The prototype's top-level page (`single-agent-baseline/index.html`) was loaded as a `file://` URL — not via iframe — at three viewports. At each viewport, the page was loaded once with normal CSS, and once with an additional injected style tag forcing `html, body { overflow: visible !important; overflow-x: visible !important }` to defeat any global horizontal clipping. After each load, a DOM overflow probe collected `documentElement.scrollWidth`, `documentElement.clientWidth`, and per-element bounding rects whose `right` value exceeded the viewport, and a full-page screenshot was taken.

Note on global clipping: the prototype's CSS does **not** set `overflow-x: hidden` on `html` or `body`. The only `overflow: hidden` rule is on `.phone__screen` (intentional clipping of phone content inside its bezel). The no-mask retest was run anyway per the runbook requirement.

**Viewports probed.**

| Viewport | Variant | scrollWidth / clientWidth | Overflow offenders |
|---|---|---|---|
| 390 × 844 (mobile) | normal | 390 / 390 | none |
| 390 × 844 (mobile) | no-mask | 390 / 390 | none |
| 360 × 780 (narrow) | normal | 360 / 360 | none |
| 360 × 780 (narrow) | no-mask | 360 / 360 | none |
| 1280 × 900 (desktop) | normal | 1280 / 1280 | none |
| 1280 × 900 (desktop) | no-mask | 1280 / 1280 | none |

**Result.** ✅ Top-level render proof passes at all probed viewports, including the no-mask retest. No element overflows the viewport at any size; no text, navigation, card, phone frame, or button clips horizontally; no horizontal scroll is induced. Full-page screenshots at each viewport were visually inspected to confirm phone frames stack cleanly at mobile (single column), wrap to two columns at tablet (≥720 px), and to three columns at desktop (≥1080 px).

## Blind-eval hygiene scan

```bash
grep -niE "single-agent|baseline|agent-team|team-run|commit|sha|branch" \
  demo-output/single-agent-baseline/index.html demo-output/single-agent-baseline.md
```

After the scan, one origin-identifying file-path reference (`single-agent-baseline/index.html`) was removed from the recommendation doc's closing provenance note and replaced with neutral wording ("the companion HTML prototype"). Remaining matches are unrelated tokens: CSS property `align-items: baseline`, occurrences of the verb "commit" in the phrase "before you commit" (i.e., before you confirm), and product copy referring to support-contact paths. No branch name, commit SHA, run metadata, or origin label appears in the recommendation doc or the HTML title / body.

## Deliverables

- `demo-output/single-agent-baseline/index.html` — five-screen mobile-first HTML prototype.
- `demo-output/single-agent-baseline.md` — meeting-ready recommendation doc (~2,750 words).
- `demo-output/run-metadata.md` — this file.

## Notes on what this run did not do

- Did not open or compare against prior `demo-output/` artifacts, prior demo branches, PR #2, prior render-gate / topproof / claimlint artifacts, or any past Northstar evaluation reports.
- Did not score the output against the comparison system; scoring is reserved for the post-seal blind evaluation step in `11-evaluation-system.md`.
- Did not commit `.claude/agents/` or any agent definitions; this is a single-agent run.
