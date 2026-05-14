# Run metadata

| Field | Value |
|-------|-------|
| Variant | single-agent baseline (clean-room) |
| Branch | `experiment/northstar-20260514-0207-trim-baseline` |
| Commit SHA at start | `434a050c9062cf37fc36419ce1aaa6c838c4c241` (`434a050`) |
| Start time (UTC) | 2026-05-14T08:08:26Z |
| End time (UTC) | 2026-05-14T08:15:58Z |
| Wall-clock duration | ~7m 32s |
| Model | Claude Opus 4.7 (1M context) |
| Prompt followed | `03-single-agent-baseline-prompt.md` |
| Brief | `demo-inputs/northstar-canceled-flight-brief.md` |

## Clean-room checks

| Check | Result |
|-------|--------|
| `git rev-parse --short HEAD` is `434a050` or later at start | PASS (`434a050`) |
| `find demo-output -type f ! -name .gitkeep -print` is empty at start | PASS (no files) |
| No inspection of prior branches, PRs, screenshots, or past outputs | PASS |
| No reuse of anything in `demo-output/` other than creating the listed files | PASS |
| Blind-eval hygiene: no banned tokens ("single-agent", "baseline", "team", "agent-team", branch names, commit SHAs, run metadata) in the recommendation doc or HTML title/body | PASS — scrubbed and re-verified by grep |
| No invented metrics, user quotes, airline policies, or legal obligations | PASS — eligibility and policy phrased as system-determined; placeholder agent number labelled `[assumption]` |
| Assumptions labelled with `[observed from brief]` / `[inferred]` / `[assumption]` / `[recommendation]` | PASS |

## Artifacts produced

- `demo-output/single-agent-baseline/index.html` — five-screen phone-frame prototype, self-contained CSS, light + dark + reduced-motion modes, WCAG 2.1 AA target.
- `demo-output/single-agent-baseline.md` — meeting-ready recommendation doc.
- `demo-output/run-metadata.md` — this file.

## Notes

- The CSS property value `align-items: baseline` appears in the stylesheet as a typographic-alignment keyword; this is a CSS layout primitive, not content visible to the reader, and is unrelated to the experiment label.
- No external network resources are loaded by the prototype (no fonts, scripts, or images fetched). Type stack is system-resident only.
