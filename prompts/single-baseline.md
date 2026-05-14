# Single-Agent Baseline Prompt

Use this before the team run if you want to show the difference. **This prompt now demands the same artifact type as the team prompt — both ship HTML.** Previous versions of this prompt asked the single agent to ship a doc, which made the visual-quality comparison meaningless (the team had an artifact; the baseline didn't). For an honest head-to-head, both sides produce the same thing.

```text
Review the canceled-flight recovery experience in:

demo-inputs/northstar-canceled-flight-brief.md

Clean-room rule:
- Do not open, search, summarize, or reuse anything in `demo-output/` except to create the files listed below.
- Do not inspect prior demo branches, PR #2, or any past Northstar outputs before writing this baseline.
- If `demo-output/` already contains generated outputs, stop and ask the facilitator to start from a fresh clone or clean branch.

Create a meeting-ready recommendation for improving the experience. Cover UX research, information architecture, interaction design, UX writing, accessibility, visual/UI design, and behavioral science.

Ship two things:

1. A working HTML prototype at:
   demo-output/single-agent-baseline/index.html
   - Mobile-first, self-contained (inline CSS + JS).
   - Render the redesigned flow as actual screens (phone-frame style), not as a description of screens.
   - Respect prefers-color-scheme (light + dark) and prefers-reduced-motion.
   - Hit WCAG 2.1 AA where possible (cite criteria when you make a notable call).

2. A meeting-ready recommendation doc at:
   demo-output/single-agent-baseline.md
   Include:
   - Executive recommendation
   - Redesigned flow in 4–5 screens (target, not a hard cap)
   - Main issues found in the current flow
   - Recommended copy (verbatim, not described)
   - Accessibility and trust risks with proposed mitigations
   - Experiment plan (hypothesis + primary metric + guardrail + exit rule for each)

3. Run metadata at:
   demo-output/run-metadata.md
   Include:
   - Run metadata: branch, commit SHA, start/end time, model, and whether clean-room checks passed.

Blind-eval hygiene:
- Do not put "single-agent", "baseline", "team", "agent-team", branch names, commit SHAs, or run metadata in the recommendation doc or HTML title/body.
- Keep all origin-identifying information in `demo-output/run-metadata.md` only.

Quality bar:
- The output should be distinguishable as the work of a designer who cares about craft. Generic, safe, "meeting-template" output is a failure mode, not a default. If your output could have been produced by a Bootstrap starter, you have not earned your presence.
- Hold the line on distinctiveness over completeness.

Label assumptions ([observed from brief], [inferred], [assumption], [recommendation]).
Do not invent metrics, user quotes, airline policies, legal obligations, static wait times, credit expiration windows, eligibility promises, hotel names, voucher amounts, phone numbers, or other operational facts not present in the brief. Use dynamic copy ("current wait shown here") or mark placeholders outside user-visible copy.
If the brief names a constraint such as family / multi-passenger travel, low bandwidth, screen reader use, or refund-seeker paths, either solve it in the artifact or name it as a scoped gap in the recommendation.
Before committing, run a blind-hygiene scan on the HTML and recommendation for origin-identifying terms, branch names, commit SHAs, and ungrounded operational promises.
Before committing, run a responsive render smoke check on `demo-output/single-agent-baseline/index.html` at a narrow mobile viewport around 390px wide and at a desktop viewport. If browser rendering is available, use top-level page screenshots plus a DOM overflow check (`scrollWidth <= clientWidth`, with named overflowing elements if any). If the page uses global horizontal clipping such as `overflow-x: hidden`, also rerun the overflow check with that masking disabled so layout bugs are not hidden. Do not seal while text, nav, cards, phone frames, buttons, or fixed-format elements clip horizontally, overlap incoherently, or require sideways scrolling. Record the check method and result in `demo-output/run-metadata.md`.
```

## Why this changed

The earlier version of this prompt asked the single agent to produce only a markdown document. When facilitators ran the demo head-to-head against the team output (which by V2 of the kit had grown to include an HTML artifact), the baseline doc couldn't lose on visual quality — *because it never had to ship visual*. The scorecard claimed a fair comparison but the artifact types differed.

This version makes the artifacts apples-to-apples. The single agent must now ship the same thing the team ships. If the single agent's HTML is more visually coherent than the team's, that's a real finding about authorship and composition — and the scorecard in [`../rubrics/scorecard.md`](../rubrics/scorecard.md) is now honest about it.
