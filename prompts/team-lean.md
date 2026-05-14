# Lean Agent-Team Prompt

Use this prompt when the full relay-with-debate run wins on quality but costs too much time or coordination. It tests whether a smaller team can preserve the artifact-level gains from [`team-relay.md`](team-relay.md).

> _Run [`../bin/precheck.sh`](../bin/precheck.sh) before pasting. Shared preflight and clean-room rules live in [`_preflight.md`](_preflight.md); the clean-room block restated below should match it. If you change either here, keep them in sync._

```text
Create a lean agent team named "Northstar Lean UX Recovery Team" to redesign the canceled-flight recovery experience described in:

demo-inputs/northstar-canceled-flight-brief.md

Clean-room rule:
- Do not open, search, summarize, or reuse anything in `demo-output/` except to create the deliverables for this run.
- Do not inspect prior demo branches, PR #2, single-agent output branches, evaluation reports, screenshots, or any past Northstar outputs before the team deliverables are sealed.
- If `demo-output/` already contains generated outputs, stop and ask the facilitator to start from a fresh clone or clean branch.
- The lead may read the baseline only after both the lean-team deliverables and baseline deliverables are complete, when scoring begins.

Hypothesis for this run:
A lean team can keep the full team's artifact-level accessibility and behavioral-risk gains while reducing wall time and process volume.

Use this smaller role slate. If matching subagent definitions are available, use them; otherwise create teammates with these instructions:

1. Creative Director — sets aesthetic anchor and one quality bar before authoring.
2. Information Architect — owns user-job spine, flow structure, hierarchy, and navigation labels. Also covers the lightweight UX research pass by labeling observed facts, inferred needs, and load-bearing assumptions.
3. Visual / UI Designer — authors the working HTML prototype from a clean canvas.
4. Accessibility Specialist — has blocking authority over keyboard, screen-reader, contrast, focus, target-size, and motion issues.
5. Behavioral Scientist — has blocking authority over trust, coercion, dark-pattern risk, and falsification.
6. Devil's Advocate — runs after A11y and Behavioral Scientist; stress-tests the chosen direction and names the falsifier.

Do not spawn Content Designer or Interaction Designer by default. The lead may spawn exactly one of them only if a specific blocker appears that the lean slate cannot resolve. If that happens, record why in `demo-output/run-metadata.md`; the run should be penalized for coordination overhead during evaluation.

Goal:
Create a meeting-ready recommendation and authored HTML artifact. The output should show whether fewer specialists can still produce a better product decision than the single-agent baseline.

Working rules:
- Each teammate owns one file in `demo-output/role-reports/`.
- No teammate edits another teammate's role report.
- The lead owns `demo-output/final-recommendation.md`, `demo-output/process-appendix.md`, and `demo-output/run-metadata.md`.
- Visual / UI Designer owns `demo-output/prototype/index.html`; other teammates provide blocking fixes, not parallel rewrites.
- Label every major claim as observed from brief, inferred, assumption, or recommendation.
- Do not invent research data, metrics, laws, airline policies, user quotes, wait times, credit expiration windows, eligibility promises, hotel names, voucher amounts, phone numbers, or operational facts not present in the brief.
- If the brief names an edge case or constraint, either solve it in the artifact or name it as a scoped gap in the final recommendation. Do not silently drop family / multi-passenger travel, low bandwidth, screen reader use, or refund-seeker paths.
- Blind-eval hygiene: do not put "agent-team", "team run", branch names, commit SHAs, teammate count, or run metadata in the HTML title/body or meeting-ready recommendation. Put origin details only in `demo-output/run-metadata.md`.

Sequence:
1. Creative Director briefs the anchor and quality bar.
2. Information Architect sets the user-job spine and revised flow.
3. Visual / UI Designer authors the prototype.
4. Accessibility Specialist audits the prototype and names blockers.
5. Behavioral Scientist audits the prototype and names trust/coercion blockers.
6. Visual / UI Designer makes one surgical revision pass if A11y or Behavioral Scientist found blockers.
7. Devil's Advocate stress-tests the revised direction.
8. Lead synthesizes.

Required handoffs:
- Creative Director -> Information Architect and Visual Designer: aesthetic anchor and failure mode to avoid.
- Information Architect -> Visual Designer: screen sequence, primary decision per screen, and scoped gaps.
- Accessibility Specialist -> Visual Designer: blockers that must change the HTML.
- Behavioral Scientist -> Visual Designer and lead: trust risks that must change copy, hierarchy, or instrumentation.
- Devil's Advocate -> lead: strongest opposing design, hidden assumptions, and what would falsify the recommendation.

Debate rule:
Run exactly two decision debates. One must be about the core choice architecture. The second should come from A11y, trust, content, or flow risk. For each debate, record the winning argument and dissent in the appendix. Keep the debate short; the lean-team experiment fails if process volume crowds out artifact quality.

Before synthesis, the lead should show:
1. The top finding from each teammate.
2. The two debates, their resolution, and preserved dissent.
3. Which teammate message changed the HTML or final recommendation.

Final deliverables:
Write `demo-output/final-recommendation.md` as a concise meeting-ready memo, hard cap 850 words, with these sections only:

1. Executive recommendation
2. Redesigned flow
3. Accessibility and trust guardrails
4. Experiment plan

Before sealing, run `wc -w demo-output/final-recommendation.md`. If it is over 850 words, trim until it is under the cap.

Write `demo-output/process-appendix.md` with these sections:

1. What each role contributed
2. Handoffs that changed the artifact
3. Two debates and preserved dissent
4. Key tradeoffs and rejected alternatives
5. Lean-slate overhead notes
6. Devil's Advocate stress-test summary

Write `demo-output/run-metadata.md` with branch, commit SHA, start/end time, model, teammate list, clean-room checks, whether any optional teammate was spawned, and whether any teammate was nudged.

Also produce the HTML artifact at `demo-output/prototype/index.html`. A recommendation without an artifact, an artifact without a recommendation, or missing appendix/metadata is incomplete.

Before committing, run a blind-hygiene scan on the HTML and final recommendation for origin-identifying terms, branch names, commit SHAs, and ungrounded operational promises. Commit only `demo-output/role-reports`, `demo-output/prototype`, `demo-output/final-recommendation.md`, `demo-output/process-appendix.md`, and `demo-output/run-metadata.md`.
```
