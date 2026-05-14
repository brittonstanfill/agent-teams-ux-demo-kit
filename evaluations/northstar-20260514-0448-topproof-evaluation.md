# Top-Level Render-Proof Evaluation

## Run Metadata

| Field | Value |
|---|---|
| Run ID | northstar-20260514-0448-topproof |
| System commit | 73e8feb |
| Baseline branch / commit | experiment/northstar-20260514-0448-topproof-baseline / 48251b9 |
| Team branch / commit | experiment/northstar-20260514-0448-topproof-team / 6f019cc |
| Scenario | Northstar Air canceled-flight recovery |
| Evaluator(s) | Codex supervisor |
| Scoring date | 2026-05-14 |
| Clean-room checks passed | yes |

## Hypothesis

The stricter top-level render-proof method should remove the ambiguity from the prior render-gate loop: both systems must prove the shipped top-level page fits at mobile and desktop widths, and the four-role team should preserve its decision-quality advantage while using that proof method.

Disproof would be a team artifact that still clips or relies on iframe-only evidence, a weaker artifact than the prior four-role run, or enough added proof overhead that the compact slate no longer clears Coordination Yield.

## Layer 0 Gates

| Gate | Baseline | Team | Notes |
|---|---|---|---|
| Clean-room integrity | pass | pass | Both began from `73e8feb`, empty `demo-output/`, and sealed/pushed separate commits before scoring. |
| Same artifact type | pass | pass | Both shipped HTML plus a meeting-ready recommendation. |
| Completeness | pass | pass | Team also shipped role reports, process appendix, and metadata. |
| Constraint integrity | mixed | pass | Baseline contains several operational promises not supplied by the brief or only weakly labeled: no rebooking fee, "all still free," reversibility window, live wait texting, and some no-extra-cost framing. Team used `{system-supplied}` placeholders and scoped cash refund rather than inventing policy. |
| Accessibility floor | mixed | pass | Baseline's phone mockups use `role="img"` around interactive-looking controls, which weakens screen-reader structure. Team fixed 5 A11y blockers in the artifact, including broken list roles on buttons and small tap targets. |
| Responsive render floor | pass | pass | Evaluator top-level DOM checks passed at 360, 390, and 1280. Baseline's only flagged offender was the intentional off-canvas skip link; team had zero offenders. Screenshots looked coherent. |
| Trust floor | mixed | pass | Baseline is clearer than the current flow but overpromises some policy-like facts. Team is more conservative and safer on support eligibility, confirmation, and hidden-help falsifiers. |

Promotion blocked? `no` for the candidate system. The comparison remains valid, but baseline gate weaknesses are real scoring penalties rather than extra credit for the team.

## Blind Outcome Scores

Artifact A was the team and Artifact B was the baseline. The pass was partial-blind because the artifact styles and document lengths made origin inferable, but Layer 1 was scored before using role reports or process appendices.

| Layer 1 Dimension | Artifact A | Artifact B | Evidence Notes |
|---|---:|---:|---|
| User-job fit | 3.7 | 3.3 | A solves understand/choose/support/confirm with less policy invention. B is strong on refund visibility but relies on policy assumptions the brief did not give. |
| Flow coherence | 3.6 | 3.2 | A is a product-like five-screen flow. B is more of an editorial walkthrough with phone mockups inside explanatory sections. |
| Content quality | 3.4 | 3.1 | A is safer and more precise but sometimes placeholder-heavy. B is warmer and sharper, but several lines overclaim. |
| Recommendation clarity | 3.8 | 2.9 | A is 740 words and meeting-ready. B is useful but 3,029 words and too broad for the requested meeting memo. |
| Accessibility and inclusion | 3.7 | 2.2 | A executes fixes in HTML. B describes A11y well, but its mockup structure undercuts that claim. |
| Trust and behavioral ethics | 3.9 | 2.0 | A avoids hidden support and invented entitlement confirmation. B improves trust framing but adds unsupported promises about fees, reversibility, and wait handling. |
| Visual and interaction craft | 3.4 | 3.5 | B is more visually distinctive and editorial. A is quieter but more product-realistic, responsive, and safer to hand to implementation. |
| Experiment plan | 3.8 | 3.4 | A's primary falsifier catches call reduction by hidden-help salience. B has several good experiments, but the plan is longer and less focused. |

Blind winner: `A`

Why: A is less expressive, but it is the better product decision artifact: safer, more implementable, and cleaner against the trust/accessibility floors.

## Process And Decision Scores

| Layer 2 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Evidence hygiene | 2.4 | 3.8 | Baseline labeled many claims but still shipped unsupported operational promises. Team's hygiene scan and placeholders were more disciplined. |
| Specialist depth | 2.1 | 3.9 | Team A11y and Behavioral audits were role-specific and found artifact-changing blockers. Baseline covered disciplines broadly but less deeply. |
| Handoffs that changed output | 0.0 | 4.0 | IA shaped the flow; A11y and Behavioral blockers changed HTML; Behavioral red-team changed the falsifier. |
| Debate quality | 0.0 | 3.7 | Team preserved a real S4 button-copy disagreement with rollback conditions. Baseline had tradeoffs, but no debate. |
| Tradeoff reasoning | 3.0 | 3.8 | Both named tradeoffs. Team tied rejected alternatives to viewport, trust, and implementation risk more concretely. |
| Falsification | 3.1 | 3.9 | Team's 24-hour follow-up-call falsifier is sharper and more adversarial to the call-deflection goal. |
| Red-team value | 2.5 | 3.8 | Team lead red-team found under-modeled refund seekers, auto-recovery alternative, and hidden-help failure signals. |

## Efficiency And Rework

| Layer 3 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Time to useful draft | 3.8 | 1.2 | Baseline sealed in about 7.6 minutes; team took about 40-44 minutes. |
| Token/cost discipline | 3.5 | 1.8 | Team cost was high, though it bought real blockers and fixes rather than only more prose. |
| Human rework | 2.1 | 3.5 | Baseline would need policy scrub and A11y restructuring. Team is closer to handoff-ready. |
| Coordination overhead | 4.0 | 2.6 | Four roles were all useful, but the run remained more than 5x baseline wall time. |
| Simplicity | 3.7 | 2.7 | Baseline is simpler; team process is justified only when trust/accessibility risk matters. |

Layer 1 weighted score:

- Single agent: 33.2
- Agent team: 41.2

Layer 2 weighted score:

- Single agent: 16.4
- Agent team: 33.6

Layer 3 weighted score:

- Single agent: 17.1
- Agent team: 11.8

Total weighted score:

- Single agent: 66.7
- Agent team: 86.6

Overhead penalty: 6

Coordination Yield: 13.9

## Metacognition Notes

Expected before scoring: top-level proof would remove the render ambiguity, but might mostly validate the prior system rather than produce a new improvement.

What surprised us: the team's no-mask overflow retest was not busywork. It surfaced a real flex-shrink bug during the run, then produced stronger evidence than the baseline's proof.

Where the baseline beat the team: speed, visual distinctiveness, and a more memorable editorial tone.

Where the team produced value a single agent probably would not: A11y blockers on button/list semantics and tap targets, the S5 invented-confirmation catch, the dynamic-commit-button debate, and the primary falsifier for call reduction by hidden-help salience.

What might we be overvaluing: process completeness. The team still costs far more time, and the product artifact is quieter than the baseline's editorial prototype.

What would change our mind: a repeated single-agent run with the same proof and a stricter constraint lint that catches the no-fee/reversibility overclaims, or a four-role run that continues to take 5x baseline after the proof method is standardized.

## Decision

Promote the top-level proof method and add one narrow refinement: if the artifact uses global horizontal overflow hiding, the proof should include a no-mask retest with that hiding disabled. This run showed that the no-mask retest can find a real layout bug without adding another specialist.

Do not change the four-role slate. It is still the best current quality system, but the efficiency problem remains.

## Next Loop

One variable to change: require no-mask overflow retest when `overflow-x: hidden` or equivalent global clipping could hide layout bugs.

One variable to hold constant: four-role slate and sequencing: IA -> Visual -> A11y/Behavioral -> Visual revision -> lead red-team.

Expected improvement: same decision quality with stronger render evidence and less evaluator ambiguity.

Failure signal: the no-mask retest adds time but never catches issues across the next two runs, or the team still takes more than 5x baseline without producing higher-risk catches.
