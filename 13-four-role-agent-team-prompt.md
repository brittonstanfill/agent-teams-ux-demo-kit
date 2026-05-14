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
A four-role team can preserve most of the decision-quality and accessibility gains from the six-role lean team while reducing wall time below 2.5x the single-agent baseline, but only if it creates competing full artifacts early enough that visual quality is not flattened by committee synthesis.

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
- Visual / UI Designer owns `demo-output/prototype/candidate-a.html`, `demo-output/prototype/candidate-b.html`, and `demo-output/prototype/index.html`.
- Label every major claim as observed from brief, inferred, assumption, or recommendation.
- Do not invent research data, metrics, laws, airline policies, user quotes, wait times, credit expiration windows, eligibility promises, hotel names, voucher amounts, phone numbers, or operational facts not present in the brief.
- If the brief names an edge case or constraint, either solve it in the artifact or name it as a scoped gap in the final recommendation. Do not silently drop family / multi-passenger travel, low bandwidth, screen reader use, refund-seeker paths, or support visibility.
- Blind-eval hygiene: do not put "agent-team", "team run", branch names, commit SHAs, teammate count, or run metadata in the HTML title/body or meeting-ready recommendation. Put origin details only in `demo-output/run-metadata.md`.
- Visual presentation gate: the HTML artifact should feel like a real, high-trust product flow, not a generic storyboard or a wall of placeholder pills. Mobile-first does not require decorative phone bezels; choose the presentation that best exposes the product decisions for evaluation. Use supplied facts as real values and reserve dynamic placeholders for values the brief does not supply. Style placeholders as unobtrusive dynamic values, not dominant visual decoration. Polish must never come from hiding refund/support choices, shrinking text, masking overflow, or smoothing away uncertainty.
- Competing artifact gate: before critique, produce two complete, reviewable HTML candidates that solve the same brief with meaningfully different structure, presentation, and choice architecture. They may share brief facts and constraints, but they must not be superficial theme swaps. Preserve both candidate files so reviewers can see what the team compared.

Sequence:
1. Information Architect sets the user-job spine, revised flow, copy constraints, and scoped gaps.
2. Visual / UI Designer authors two competing full-artifact candidates: `demo-output/prototype/candidate-a.html` and `demo-output/prototype/candidate-b.html`.
3. The lead runs a short champion-challenger review. IA, Accessibility, and Behavioral each name the stronger candidate for their lens, the strongest idea to steal from the other candidate, and the biggest risk if the team ships their preferred candidate.
4. The lead chooses a direction and records the rationale. If the lead chooses neither candidate as-is, name which candidate is the base and which specific elements are borrowed. Do not merge by averaging; commit to one dominant composition and explain the tradeoff.
5. Accessibility Specialist and Behavioral Scientist audit the selected direction in parallel.
6. Visual / UI Designer produces `demo-output/prototype/index.html` as the final artifact, applying audit fixes and one protected visual presentation pass. The pass may improve hierarchy, spacing, type, rhythm, color, and presentation clarity, but it may not remove refund/support paths, uncertainty labels, accessibility fixes, or scoped gaps for polish.
7. Lead runs the red-team checklist below. Do not spawn Devil's Advocate.
8. Lead synthesizes.

Required handoffs:
- Information Architect -> Visual Designer: screen sequence, primary decision per screen, content hierarchy, copy constraints, and scoped gaps.
- Visual Designer -> lead and teammates: candidate A/B summary, which design problem each candidate is trying to win, and what should be judged visually versus product-wise.
- Teammates -> lead: champion-challenger votes, strongest borrowed element, and highest-risk tradeoff before final selection.
- Accessibility Specialist -> Visual Designer: blockers that must change the HTML.
- Behavioral Scientist -> Visual Designer and lead: trust risks that must change copy, hierarchy, or instrumentation.
- Visual Designer -> lead: selected base candidate, borrowed elements, list of audit fixes applied, any fixes deliberately rejected, visual presentation changes made in the protected pass, and a quick viewport-fit note for the final HTML. The Visual Designer should do enough local sanity checking to catch obvious clipping before handoff, but the exhaustive top-level, fixed-container, long-token, and no-mask render proof is lead-owned after audits and revision. Do not spend a long pre-audit proof loop unless a candidate is visibly broken.

Red-team checklist the lead must run personally:
- What is the strongest opposing design that does not use this flow?
- Which early framing choice is the team anchoring on?
- What hidden assumption would make the recommendation fail?
- What user segment is under-modeled?
- What metric would prove the flow reduced calls by hiding help?
- What would a frustrated user quote in a complaint if this shipped?

Record the checklist answers in `demo-output/process-appendix.md`. Convert at least one answer into a falsifier or scoped gap in the final recommendation.

Debate rule:
Run exactly one short debate, chosen from the biggest unresolved conflict after candidate review or audits. It must include at least two positions and a preserved dissent. Strong default topics are: which candidate should anchor the final, whether visual drama is reducing clarity, whether support/refund visibility is over- or under-weighted, or whether mobile-first presentation is hiding desktop realities. If no conflict emerges, debate the highest-risk default or channel choice. The compact experiment fails if the lead invents process that does not change the artifact or final recommendation.

Metacognitive checkpoint before final synthesis:
- Did the team pick the strongest artifact, or the least controversial one?
- Did the final preserve the winning candidate's visual spine?
- Did any accessibility or trust fix make the artifact visually weaker, and if so did the protected visual pass recover presentation quality without undoing the fix?
- Would the first single-agent visual design still beat this final artifact on presentation alone? If yes, hold the system change and run another iteration instead of declaring a win.

Before synthesis, the lead should show:
1. The top finding from each teammate.
2. Candidate A/B comparison, selected base candidate, borrowed elements, and preserved candidate-level dissent.
3. The one debate, resolution, and preserved dissent.
4. Which teammate message changed the HTML or final recommendation.
5. Which red-team checklist answer changed the final recommendation.

Final deliverables:
Write `demo-output/final-recommendation.md` as a concise meeting-ready memo, hard cap 750 words, with these sections only:

1. Executive recommendation
2. Redesigned flow
3. Accessibility and trust guardrails
4. Experiment plan

Before sealing, run `wc -w demo-output/final-recommendation.md`. If it is over 750 words, trim until it is under the cap.

Write `demo-output/process-appendix.md` with these sections:

1. What each role contributed
2. Candidate artifacts and selection rationale
3. Handoffs that changed the artifact
4. One debate and preserved dissent
5. Lead red-team checklist
6. Key tradeoffs and rejected alternatives
7. Compact-slate overhead notes

Write `demo-output/run-metadata.md` with branch, commit SHA, start/end time, model, teammate list, clean-room checks, whether any extra specialist was spawned, and whether any teammate was nudged.

Also produce the candidate artifacts at `demo-output/prototype/candidate-a.html` and `demo-output/prototype/candidate-b.html`, plus the final HTML artifact at `demo-output/prototype/index.html`. A recommendation without artifacts, artifacts without a recommendation, or missing appendix/metadata is incomplete.

Before committing, run a blind-hygiene scan on the HTML and final recommendation for origin-identifying terms, branch names, commit SHAs, and ungrounded operational promises. Commit only `demo-output/role-reports`, `demo-output/prototype`, `demo-output/final-recommendation.md`, `demo-output/process-appendix.md`, and `demo-output/run-metadata.md`.

Also before committing, run a responsive render smoke check on `demo-output/prototype/index.html` at a narrow mobile viewport around 390px wide and at a desktop viewport. If browser rendering is available, use top-level page screenshots plus a DOM overflow check (`scrollWidth <= clientWidth`, with named overflowing elements if any). Iframe probes can be used as secondary diagnostics, but do not rely on iframe-only evidence to pass the gate. If the page uses global horizontal clipping such as `overflow-x: hidden`, also rerun the overflow check with that masking disabled so layout bugs are not hidden.

Top-level `scrollWidth` passing is not enough. Inspect any fixed-format mockups or constrained surfaces in the rendered screenshot: phone frames, cards, tables, summary rows, buttons, and token pills must contain their text and controls. Long `{placeholder_tokens}` count as visible content in this prototype. Do not seal while text, nav, cards, phone frames, buttons, token pills, or fixed-format elements clip horizontally, overlap incoherently, escape their container, or require sideways scrolling. If named internal offenders remain, either fix them or record a narrow selector-level reason they are false positives plus screenshot evidence that no readable text/control/decision-critical content is clipped. Record the check method and result in `demo-output/run-metadata.md`.
```
