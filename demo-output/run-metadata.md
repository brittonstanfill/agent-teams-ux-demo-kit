# Run metadata

| Field | Value |
|---|---|
| Run type | Clean-room single-agent baseline (lean-slate experiment) |
| Branch | `experiment/northstar-20260514-0250-lean-baseline` |
| Starting commit SHA | `3107fec53043f3c7da972fc7dcbc10eb5ea3a885` (short: `3107fec`) |
| Start time (UTC) | 2026-05-14T08:52:42Z |
| End time (UTC) | 2026-05-14T09:00:11Z |
| Wall time | ~7 min 29 s |
| Model | Claude Opus 4.7 (1M context) — `claude-opus-4-7[1m]` |
| Prompt followed | `03-single-agent-baseline-prompt.md` |
| Runbook | `10-clean-room-experiment-runbook.md` |
| Evaluation system | `11-evaluation-system.md` |

## Clean-room checks

| Check | Result |
|---|---|
| `git rev-parse --short HEAD` is `3107fec` or later at start | Pass — `3107fec` |
| `find demo-output -type f ! -name .gitkeep -print` empty at start | Pass — printed nothing |
| Did not open, search, or summarize anything else in `demo-output/` | Pass |
| Did not open prior demo branches | Pass |
| Did not open PR #2 | Pass |
| Did not open past screenshots, evaluation reports, or prior Northstar artifacts | Pass |
| Did not score | Pass |
| Did not open any prior prototype | Pass |
| Blind-eval hygiene: no run-identifying terms in recommendation doc or HTML title/body | Pass (post-scan; one residual is the CSS keyword `align-items: baseline` in the stylesheet, which is not rendered text) |
| No invented operational facts (compensation amounts, voucher values, hotel partners, static wait times, eligibility promises, phone numbers, credit expiration windows) in user-visible copy | Pass — illustrative values are framed as system-determined per-traveler state; "Most people pick this" is annotated as requiring real behavioral data or removal |

## Deliverables

- `demo-output/single-agent-baseline/index.html` — self-contained mobile HTML prototype (light + dark, `prefers-reduced-motion` respected, five phone-frame screens plus a lock-screen alert).
- `demo-output/single-agent-baseline.md` — meeting-ready recommendation, including executive recommendation, redesigned flow narrative, current-flow issue table, verbatim recommended copy, accessibility and trust risk table with mitigations, three sequenced experiments with hypothesis / primary metric / guardrail / exit rule, and scoped gaps named (split-rebooking, refund-seeker path, screen-reader walkthrough).
- `demo-output/run-metadata.md` — this file.

## Blockers

None.
