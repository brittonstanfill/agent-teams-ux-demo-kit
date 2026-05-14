# Master Agent-Team Prompt

Copy/paste this into Claude Code from the project folder that contains this kit.

> **Two patterns ship in this kit.** Use this *relay-with-debate* prompt when the team needs to converge on one synthesized recommendation. For visual / compositional work where authorship matters, use [`team-parallel-author.md`](team-parallel-author.md) instead — that pattern produces 2–3 distinct authored versions and a chosen winner. Mixing them is fine: do a parallel-author pass for the surface, then a relay-with-debate pass for the audit.

> _Run [`../bin/precheck.sh`](../bin/precheck.sh) before pasting. Shared preflight and clean-room rules live in [`_preflight.md`](_preflight.md); the clean-room block restated below should match it. If you change either here, keep them in sync._

```text
Create an agent team named "Northstar UX Recovery Team" to redesign the canceled-flight recovery experience described in:

demo-inputs/northstar-canceled-flight-brief.md

Clean-room rule:
- Do not open, search, summarize, or reuse anything in `demo-output/` except to create the deliverables for this run.
- Do not inspect prior demo branches, PR #2, single-agent output branches, or any past Northstar outputs before the team deliverables are sealed.
- If `demo-output/` already contains generated outputs, stop and ask the facilitator to start from a fresh clone or clean branch.
- The lead may read the baseline only after both the team deliverables and baseline deliverables are complete, when scoring begins.

Use these eight teammates. If matching subagent definitions are available, use them. Otherwise create teammates with these roles and instructions:

1. Creative Director (team-lead's partner — sets aesthetic anchor and quality bar; pushes back on safe / generic / committee-flattened choices)
2. UX Researcher
3. Information Architect
4. Interaction Designer
5. Content Designer / UX Writer
6. Accessibility Specialist
7. Visual / UI Designer
8. Behavioral Scientist

Goal:
Create a meeting-ready recommendation for a better canceled-flight recovery flow, including an authored HTML artifact (not a doc describing a design — the design itself). The output should show how the team improved the product decision through role-specific analysis, teammate communication, and at least two visible debates that materially changed a decision.

Quality bar (read this twice):
- The output should be distinguishable as the work of seven specialists who care about craft. Generic, safe, "meeting-template" output is a failure mode, not a default. If your output could have been produced by a Bootstrap starter or by a single agent reading the brief, the team has not earned its cost.
- Hold the line on distinctiveness over completeness. Better to ship four screens that are unmistakable than five screens that are forgettable.
- "Could you defend this in a portfolio review?" is the bar for visual and interaction work. "Would the user thank you in six months?" is the bar for behavioral work. "Would a screen-reader user complete this without resorting to a phone call?" is the bar for accessibility work.

Working rules:
- Each teammate owns one file in `demo-output/role-reports/`.
- No teammate edits another teammate's role report.
- The lead owns the meeting-ready recommendation file: `demo-output/final-recommendation.md`.
- The lead owns the process appendix file: `demo-output/process-appendix.md`.
- The lead owns the run metadata file: `demo-output/run-metadata.md`.
- The team also produces a working HTML artifact at `demo-output/prototype/index.html`. Visual-designer authors this; other teammates refine in their domain.
- Label every major claim as one of: observed from brief, inferred, assumption, or recommendation.
- Do not invent research data, metrics, laws, airline policies, or user quotes. WCAG criteria and named behavioral principles are standard reference, not invention.
- Do not invent static operational details unless the brief provides them. This includes wait times, credit expiration windows, eligibility promises, hotel names, voucher amounts, phone numbers, legal rights, or airline policy. Use dynamic copy ("current wait shown here") or explicitly mark a placeholder in process-only notes; do not put ungrounded operational facts into user-visible copy.
- If the brief names an edge case or constraint, either solve it in the artifact or name it as a scoped gap in the final recommendation. Do not silently drop constraints such as family / multi-passenger travel, low bandwidth, screen reader use, or refund-seeker paths.
- Make teammate messages visible in the process appendix, not in the meeting-ready recommendation.
- Blind-eval hygiene: do not put "agent-team", "team run", branch names, commit SHAs, teammate count, or run metadata in the HTML title/body or in the meeting-ready recommendation. Put origin-identifying details only in `demo-output/run-metadata.md`.

Required role outputs:
- Creative Director: aesthetic anchor and quality bar briefed BEFORE the team starts authoring. Names the reference language (e.g., "Linear restraint" / "Stripe clarity"), the three moves worth stealing, and the failure mode to avoid. Holds the line against committee flattening.
- UX Researcher: user needs, emotional state, research questions, assumptions to validate.
- Information Architect: revised flow structure, content hierarchy, decision points, navigation labels.
- Visual / UI Designer: an AUTHORED HTML artifact for the redesigned flow, NOT a description of a design. Plus: aesthetic direction, design tokens, component spec for the key reusable pieces.
- Interaction Designer: step-by-step interaction model, states per screen, error recovery, handoff moments.
- Content Designer / UX Writer: screen-level copy, notification copy, plain-language guidance, tone rules.
- Accessibility Specialist: blockers, WCAG-style concerns by criterion, assistive tech implications, inclusive design fixes.
- Behavioral Scientist: trust risks, choice architecture, ethical nudges, experiment ideas.

Sequence (this matters — visual goes early, not late):
1. Creative Director briefs the anchor and quality bar (≤5 minutes of context).
2. UX Researcher and Information Architect set the spine (user needs + flow).
3. Visual/UI Designer AUTHORS the prototype from a clean canvas, with the aesthetic anchor in hand. Not a tuning pass — an authoring pass.
4. Interaction Designer adds states and behavior to the authored surface.
5. Content Designer writes copy on the structure.
6. Behavioral Scientist audits choice architecture.
7. Accessibility Specialist audits WCAG and AT.
8. Devils-advocate (optional but recommended) stress-tests the consensus before synthesis.
9. Team-lead synthesizes.

Required peer handoffs (these create the visible debates):
- Creative Director must brief every teammate on the anchor before they begin.
- UX Researcher must message Information Architect and Content Designer with top user needs.
- Information Architect must message Interaction Designer and Content Designer with the proposed flow model.
- Visual / UI Designer must message Creative Director with the authored direction for sign-off, and Accessibility Specialist before finalizing.
- Interaction Designer must message Accessibility Specialist and Visual / UI Designer with proposed states.
- Accessibility Specialist must message Interaction Designer, Visual / UI Designer, and Content Designer with blockers.
- Behavioral Scientist must message Content Designer and Interaction Designer with ethical choice-architecture risks.
- Content Designer must message Information Architect and Accessibility Specialist before finalizing copy.

Required debates (do not skip this section):
Mid-flow, the team will identify AT LEAST 2 specific decisions where ≥2 specialists disagree. For each, hold a formal debate round:
- Each affected specialist takes a position (≤120 words) independently — no peer-reading until all positions are in.
- The lead surfaces convergence and splits.
- A counter-argument round runs on the splits.
- Resolution is recorded with the winning argument and the dissenting position (the dissent is part of the artifact — don't bury it).

Safe consensus reached without disagreement is a smell. If no debate emerges naturally, the lead manufactures one on a borderline call (e.g., where to place the retreat affordance, whether to default a recommendation).

Synthesis requirements:
Before writing the final recommendation, the lead should show:
1. Top 3 findings from each teammate.
2. The debates that ran, the resolutions, and the dissenting positions preserved.
3. Which teammate message changed another teammate's recommendation.

Final deliverables:
Write `demo-output/final-recommendation.md` as a concise meeting-ready memo, hard cap 900 words, with these sections only:

1. Executive recommendation
2. Redesigned flow (target 4–5 screens, but if a 6-screen flow is genuinely better, ship 6; explain why)
3. Accessibility and trust guardrails
4. Experiment plan

Before sealing, run `wc -w demo-output/final-recommendation.md`. If it is over 900 words, trim until it is under the cap. The process appendix can carry evidence, debates, and dissent; the first-read memo should stay presentable.

Write `demo-output/process-appendix.md` with these sections:

1. What each role contributed
2. Cross-agent handoffs that changed the answer
3. Debates that ran and their resolutions, including dissenting positions
4. Key tradeoffs and rejected alternatives
5. Scorecard-ready comparison setup against a single-agent baseline, without reading the baseline
6. Devil's Advocate stress-test summary

Write `demo-output/run-metadata.md` with branch, commit SHA, start/end time, model, teammate list, clean-room checks, and whether any teammate was replaced or nudged.

Also produce the HTML artifact at `demo-output/prototype/index.html`. All deliverables ship; a recommendation without an artifact, an artifact without a recommendation, or a missing process appendix is incomplete.

Before committing, run a blind-hygiene scan on the HTML and final recommendation for origin-identifying terms, branch names, commit SHAs, and ungrounded operational promises. Keep the final recommendation crisp and meeting-ready. Distinctiveness over completeness; named principles over generic best practices. Preserve dissent in the appendix, not in the first-read memo.
```

## What's different from the V2 version of this prompt

If you're updating from an earlier copy of this kit:

- Adds the **Creative Director** role and an aesthetic-anchor briefing step before authoring begins.
- Reorders the sequence: **Visual goes early**, not late. Visual-designer authors a clean prototype; other specialists refine *around* their authored surface. The previous "Visual / UI Designer: layout direction" framing produced tuning, not authoring.
- Adds an explicit **quality bar** — "distinctive over safe" — to head off committee flattening.
- Bakes **debates into the process**, not just into the report. The team must produce ≥2 documented disagreements with dissent preserved.
- Loosens the structural constraint — **4–5 screens is a target, not a cap** — and replaces it with a quality demand.
- Demands an **authored HTML artifact**, not just a doc describing one. The baseline prompt in [`single-baseline.md`](single-baseline.md) now demands the same, so the comparison is honest.
