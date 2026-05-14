# Four-Role Agent-Team Prompt

Use this prompt when the lean slate is still too expensive. It tests whether the minimum useful team can preserve artifact-level improvements while cutting coordination overhead.

```text
Create a compact agent team named "Northstar Four-Role UX Recovery Team" to redesign the canceled-flight recovery experience described in:

demo-inputs/northstar-canceled-flight-brief.md

Clean-room rule:
- Do not open, search, summarize, or reuse anything in `demo-output/` except to create the deliverables for this run.
- Do not inspect prior demo branches, PR #2, single-agent output branches, evaluation reports, screenshots, or any past Northstar outputs before the team deliverables are sealed.
- If `demo-output/` already contains generated outputs, stop and ask the facilitator to start from a fresh clone or clean branch.
- The lead may read the baseline only after both compact-team deliverables and baseline deliverables are complete, when scoring begins.

Hypothesis for this run:
A four-role team can preserve most of the decision-quality and accessibility gains from the six-role lean team while reducing wall time below 2.5x the single-agent baseline.

Use exactly these four teammates:

1. Information Architect - owns user-job spine, flow structure, hierarchy, copy constraints, scoped gaps, and lightweight UX research labels.
2. Visual / UI Designer - authors the working HTML prototype from a clean canvas and performs one surgical revision pass.
3. Accessibility Specialist - has blocking authority over keyboard, screen-reader, contrast, focus, target-size, landmarks, headings, forms, and motion.
4. Behavioral Scientist - has blocking authority over trust, coercion, dark-pattern risk, choice architecture, and falsification.

Do not spawn Creative Director, Content Designer, Interaction Designer, or Devil's Advocate. The lead must run the red-team checklist in this prompt personally after A11y and Behavioral audits. If the lead spawns any extra specialist, record why in `demo-output/run-metadata.md`; the run should be considered an escalation and scored against the lean slate, not as a clean four-role result.

Goal:
Create a meeting-ready recommendation and authored HTML artifact. The output should show whether the smallest practical team can still beat the single-agent baseline on the outcome that matters: a better artifact and a more defensible product decision.

Working rules:
- Each teammate owns one file in `demo-output/role-reports/`.
- No teammate edits another teammate's role report.
- The lead owns `demo-output/final-recommendation.md`, `demo-output/process-appendix.md`, and `demo-output/run-metadata.md`.
- Visual / UI Designer owns `demo-output/prototype/index.html`.
- Label every major claim as observed from brief, inferred, assumption, or recommendation.
- Do not invent research data, metrics, laws, airline policies, user quotes, wait times, credit expiration windows, eligibility promises, hotel names, voucher amounts, phone numbers, or operational facts not present in the brief.
- If the brief names an edge case or constraint, either solve it in the artifact or name it as a scoped gap in the final recommendation. Do not silently drop family / multi-passenger travel, low bandwidth, screen reader use, refund-seeker paths, or support visibility.
- Blind-eval hygiene: do not put "agent-team", "team run", branch names, commit SHAs, teammate count, or run metadata in the HTML title/body or meeting-ready recommendation. Put origin details only in `demo-output/run-metadata.md`.

Sequence:
1. Information Architect sets the user-job spine, revised flow, copy constraints, and scoped gaps.
2. Visual / UI Designer authors the prototype.
3. Accessibility Specialist and Behavioral Scientist audit the prototype in parallel.
4. Visual / UI Designer makes one surgical revision pass if either audit finds blockers.
5. Lead runs the red-team checklist below. Do not spawn Devil's Advocate.
6. Lead synthesizes.

Required handoffs:
- Information Architect -> Visual Designer: screen sequence, primary decision per screen, content hierarchy, copy constraints, and scoped gaps.
- Accessibility Specialist -> Visual Designer: blockers that must change the HTML.
- Behavioral Scientist -> Visual Designer and lead: trust risks that must change copy, hierarchy, or instrumentation.
- Visual Designer -> lead: list of audit fixes applied, any fixes deliberately rejected, and a viewport-fit note for the final HTML.

Red-team checklist the lead must run personally:
- What is the strongest opposing design that does not use this flow?
- Which early framing choice is the team anchoring on?
- What hidden assumption would make the recommendation fail?
- What user segment is under-modeled?
- What metric would prove the flow reduced calls by hiding help?
- What would a frustrated user quote in a complaint if this shipped?

Record the checklist answers in `demo-output/process-appendix.md`. Convert at least one answer into a falsifier or scoped gap in the final recommendation.

Debate rule:
Run exactly one short debate, chosen from the biggest unresolved conflict after audits. It must include at least two positions and a preserved dissent. If no conflict emerges, debate the highest-risk default or channel choice. The compact experiment fails if the lead invents process that does not change the artifact or final recommendation.

Before synthesis, the lead should show:
1. The top finding from each teammate.
2. The one debate, resolution, and preserved dissent.
3. Which teammate message changed the HTML or final recommendation.
4. Which red-team checklist answer changed the final recommendation.

Final deliverables:
Write `demo-output/final-recommendation.md` as a concise meeting-ready memo, hard cap 750 words, with these sections only:

1. Executive recommendation
2. Redesigned flow
3. Accessibility and trust guardrails
4. Experiment plan

Before sealing, run `wc -w demo-output/final-recommendation.md`. If it is over 750 words, trim until it is under the cap.

Write `demo-output/process-appendix.md` with these sections:

1. What each role contributed
2. Handoffs that changed the artifact
3. One debate and preserved dissent
4. Lead red-team checklist
5. Key tradeoffs and rejected alternatives
6. Compact-slate overhead notes

Write `demo-output/run-metadata.md` with branch, commit SHA, start/end time, model, teammate list, clean-room checks, whether any extra specialist was spawned, and whether any teammate was nudged.

Also produce the HTML artifact at `demo-output/prototype/index.html`. A recommendation without an artifact, an artifact without a recommendation, or missing appendix/metadata is incomplete.

Before committing, run a blind-hygiene scan on the HTML and final recommendation for origin-identifying terms, branch names, commit SHAs, and ungrounded operational promises. Commit only `demo-output/role-reports`, `demo-output/prototype`, `demo-output/final-recommendation.md`, `demo-output/process-appendix.md`, and `demo-output/run-metadata.md`.

Also before committing, run a responsive render smoke check on `demo-output/prototype/index.html` at a narrow mobile viewport around 390px wide and at a desktop viewport. If browser rendering is available, use top-level page screenshots plus a DOM overflow check (`scrollWidth <= clientWidth`, with named overflowing elements if any). Iframe probes can be used as secondary diagnostics, but do not rely on iframe-only evidence to pass the gate. If the page uses global horizontal clipping such as `overflow-x: hidden`, also rerun the overflow check with that masking disabled so layout bugs are not hidden. Do not seal while text, nav, cards, phone frames, buttons, or fixed-format elements clip horizontally, overlap incoherently, or require sideways scrolling. Record the check method and result in `demo-output/run-metadata.md`.
```
