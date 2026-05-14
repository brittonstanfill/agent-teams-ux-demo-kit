# Run Metadata

## Branch and commit

- Branch: `experiment/northstar-20260514-0250-lean-team`
- Starting commit SHA: `3107fec` (verified via `git rev-parse --short HEAD` before authoring began)
- Final commit SHA: recorded by the commit message `Add clean-room lean agent-team run` on this branch.

## Timing

- Start: 2026-05-14 02:52 MDT (after precondition verification)
- End: 2026-05-14 03:15 MDT (before commit)
- Wall time: ~23 minutes from first agent spawn to final synthesis.

## Model

- claude-opus-4-7 (1M context). The lead and each spawned teammate used the same model family. No model overrides were specified.

## Teammates

Six teammates, lean slate:

1. Creative Director
2. Information Architect
3. Visual / UI Designer (single author of the HTML prototype across both passes)
4. Accessibility Specialist (blocking authority, used once)
5. Behavioral Scientist (blocking authority, used once)
6. Devil's Advocate

No optional specialist (Content Designer or Interaction Designer) was spawned. The lean slate held without escalation.

## Clean-room checks

Before any authoring began:

- `git rev-parse --short HEAD` returned `3107fec`. Verified.
- `find demo-output -type f ! -name .gitkeep -print` returned nothing. Verified.
- `.claude/agents/` contained 9 project-scoped agent definitions (accessibility-specialist, behavioral-scientist, content-designer, creative-director, devils-advocate, information-architect, interaction-designer, ux-researcher, visual-designer). Verified.
- The lead did not open prior demo branches, single-agent baseline output, PR #2, evaluation reports, screenshots, or any past Northstar artifacts. Each spawned teammate was given an explicit clean-room rule and a fixed required-reading list.
- The brief at `demo-inputs/northstar-canceled-flight-brief.md` was the only input source. No external operational facts, airline policies, or compensation amounts were introduced.

## Optional specialist usage

None. The brief's edge cases (family/multi-passenger, low bandwidth, screen reader, refund-seeker) were absorbed by the Information Architect's structural pass and the Visual Designer's prototype; the Accessibility Specialist held the screen-reader and contrast floor; the Behavioral Scientist held the trust floor and copy hygiene. No specific blocker emerged that the lean slate could not resolve.

## Nudges

No teammate was nudged, restarted, or asked to repeat a pass. The Visual Designer ran two passes by design (initial author + one surgical revision after the audit blockers landed); both were on-spec.

## Blind-eval hygiene

The HTML prototype and the meeting-ready recommendation were scanned for the strings "agent-team", "team run", "lean team", branch names, commit SHAs, model name, and teammate count. None appear in those two artifacts. Origin details live only in this file.

The artifacts were also scanned for ungrounded operational claims (static wait times, credit expiration windows, eligibility guarantees, hotel names, voucher amounts, phone numbers, compensation rules). Every operational value is rendered as a clearly-marked system-provided placeholder (e.g., `[hotel name]`, `[meal credit]`, `[support line]`, `[PNR]`, `[voucher id]`, `[pickup location]`, `[interval]`). Flight numbers and scheduled times are scenario-grade fictional consistent with the brief's NS482 setup; they do not represent a real airline or schedule.

## Files committed for this run

- `demo-output/role-reports/creative-director.md`
- `demo-output/role-reports/information-architect.md`
- `demo-output/role-reports/visual-designer.md`
- `demo-output/role-reports/accessibility-specialist.md`
- `demo-output/role-reports/behavioral-scientist.md`
- `demo-output/role-reports/devils-advocate.md`
- `demo-output/prototype/index.html`
- `demo-output/final-recommendation.md`
- `demo-output/process-appendix.md`
- `demo-output/run-metadata.md`

`.claude/agents/` is intentionally not committed as part of this run output, per the clean-room runbook.
