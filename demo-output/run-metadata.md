# Run metadata

This file is excluded from blind Layer-1 scoring; it lives outside the recommendation doc and the HTML artifact so origin information does not leak into outcome judgement.

## Run identity

- **Run kind**: clean-room single-agent baseline for the four-role compact experiment
- **Branch**: `experiment/northstar-20260514-0325-fourrole-baseline`
- **Starting commit SHA (HEAD before write)**: `90395d0`
- **Model**: `claude-opus-4-7` (Claude Opus 4.7, 1M context)
- **Working directory**: `~/agent-team-experiments/northstar-20260514-0325-fourrole-baseline`
- **Date (local)**: 2026-05-14

## Timing

- **Start (UTC)**: 2026-05-14T09:30:32Z
- **End (UTC, files sealed)**: 2026-05-14T09:36:34Z
- **Wall time**: ≈ 6 minutes for authoring + hygiene scan (single uninterrupted run)

## Clean-room checks

- `git rev-parse --short HEAD` at start: **90395d0** — at or after the required system commit. **PASS**
- `find demo-output -type f ! -name .gitkeep -print` at start: **empty output**. **PASS**
- No prior `demo-output/` outputs, demo branches, PR #2, screenshots, or past Northstar artifacts opened during the run. **PASS**
- Brief read: `demo-inputs/northstar-canceled-flight-brief.md` only.
- Process files read (per task instructions): `03-single-agent-baseline-prompt.md`, `10-clean-room-experiment-runbook.md`, `11-evaluation-system.md`.
- Blind-eval hygiene scan run on `demo-output/single-agent-baseline.md` and `demo-output/single-agent-baseline/index.html` before sealing: no origin-identifying terms (no occurrence of the words "single-agent", "baseline", "team", "agent-team", branch names, commit SHAs, model names, or process-role names in those two files). **PASS**

## Deliverables

- `demo-output/single-agent-baseline/index.html` — mobile-first HTML prototype, self-contained (inline CSS + JS), 4 phone-framed screens after the SMS, respects `prefers-color-scheme` (light + dark) and `prefers-reduced-motion`, WCAG 2.1 AA criteria cited inline.
- `demo-output/single-agent-baseline.md` — meeting-ready recommendation: executive recommendation, current-flow issues, redesigned flow (4 screens after the SMS), verbatim copy beyond the screens, accessibility/trust risks + mitigations, four-experiment plan with primary metric / guardrail / exit rule for each, labeled assumptions.
- `demo-output/run-metadata.md` — this file.

## Ungrounded-detail discipline

Operational facts that the brief did not supply are either:

- **Bracketed placeholders** (`[arrival time]`, `[new flight number]`, `[gate]`, `[check-in time]`, `[time before flight]`) — system-supplied at render.
- **Dynamic phrasing** ("Wait time shown when you tap.", "The amount is on your confirmation.", "We'll text the hotel and shuttle details after you confirm.") — defers to live data without inventing a number.

No invented voucher amounts, hotel names, phone numbers, call wait times, credit expiration windows, eligibility guarantees, compensation rules, or airline policy claims appear in the user-facing prototype or recommendation doc.

## Blockers / risks for downstream evaluation

- A real screen-reader walkthrough (VoiceOver / TalkBack) of the prototype was not performed in this run — flagged as a scoped gap in the recommendation doc.
- Family / multi-passenger seat selection is acknowledged via a filter chip on Screen 2 but not designed in detail — flagged as a scoped gap.
- Refund-seeker (cash refund vs. travel credit) path is not in the four-screen happy path — flagged as a scoped gap.
- Experiment thresholds in the plan are deliberately left as "an agreed threshold" / "an expected band" rather than inventing numbers; analytics partners would need to set these before launch.

## Counts (for downstream comparison only — not for scoring)

- Recommendation doc words: 2,176
- HTML file size: 5,222 words including inline CSS/JS (≈ 51 KB on disk)
- Screens authored: 5 (1 SMS + 4 in-app)
- Distinct screens in redesign: 4 (within brief's 5-screen ceiling)

## Final commit SHA

Will be added by the commit message; this file is committed alongside the deliverables in a single commit titled `Add clean-room four-role single-agent baseline`.
