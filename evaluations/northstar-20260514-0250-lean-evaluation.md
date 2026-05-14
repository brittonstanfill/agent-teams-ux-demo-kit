# Evaluation Report: Lean Slate Clean-Room Run

## Run Metadata

| Field | Value |
|---|---|
| Run ID | northstar-20260514-0250-lean |
| System commit | `3107fec` |
| Baseline branch / commit | `experiment/northstar-20260514-0250-lean-baseline` / `7f543da` |
| Team branch / commit | `experiment/northstar-20260514-0250-lean-team` / `4f79f81` |
| Scenario | Northstar canceled-flight recovery |
| Evaluator(s) | Codex, rubric-based review |
| Scoring date | 2026-05-14 |
| Clean-room checks passed | Yes |

## Hypothesis

A lean team can keep the full team's artifact-level accessibility and behavioral-risk gains while reducing wall time and process volume.

Disproof condition: the lean team loses the artifact-level accessibility fixes, weakens content/state quality, fails to preserve dissent, or does not clear the coordination-yield promotion bar.

## Layer 0 Gates

| Gate | Baseline | Team | Notes |
|---|---|---|---|
| Clean-room integrity | Pass | Pass | Both started from `3107fec`, empty `demo-output`, and sealed before scoring. |
| Same artifact type | Pass | Pass | Both shipped HTML artifact plus recommendation doc. |
| Completeness | Pass | Pass | Required files exist and are substantive. |
| Constraint integrity | Warn | Pass | Baseline includes visible "Most people pick this"; it is annotated as needing real behavioral data, but still appears in the artifact. Team uses placeholders for operational values and avoids static wait times, phone numbers, hotel names, voucher amounts, and policy durations. |
| Accessibility floor | Pass | Pass | Baseline has meaningful semantic work. Team is stronger: native radiogroups, `aria-live` support status, skip link, focus-ring fix, heading cleanup, and separated standby section. |
| Trust floor | Pass | Pass | Both surface help. Team co-equalizes refund/credit on Screen 1 and instruments the accept-default risk. |

Promotion blocked? `no`

## Blind Outcome Scores

Layer 1 was scored from blind `A` and `B` folders containing only HTML and the meeting-ready recommendation. `A` was later revealed as single-agent; `B` was later revealed as lean team.

| Layer 1 Dimension | Artifact A | Artifact B | Evidence Notes |
|---|---:|---:|---|
| User-job fit | 3.4 | 3.7 | A covers the whole journey. B better centers the first fork: travel or not. |
| Flow coherence | 3.2 | 3.7 | A is clear but broad. B's five-screen spine is tighter: SMS, fork, flights, support, receipt. |
| Content quality | 3.1 | 3.4 | A has strong copy but is verbose and carries a visible behavioral-data claim. B is concise and placeholder-safe, though less warm. |
| Recommendation clarity | 2.9 | 3.8 | A is 2,486 words; useful, but heavy. B is 847 words and meeting-ready. |
| Accessibility and inclusion | 3.0 | 3.7 | B executes native controls and AT state in the artifact, not only in prose. |
| Trust and behavioral ethics | 3.1 | 3.6 | A is transparent but uses "Most people pick this." B instruments its pro-user defaults and keeps refund/credit co-equal. |
| Visual and interaction craft | 3.3 | 3.5 | A is polished and complete. B is more restrained, stateful, and semantically deliberate. |
| Experiment plan | 3.3 | 3.5 | A is comprehensive. B targets its actual risks: accept defaults, receipt confidence, fork comprehension, call/dispute tradeoff. |

Blind winner: `B`

Why: B is substantially easier to present, has stronger artifact-level semantics, and better avoids invented operational specifics. A remains a strong single-agent output and is more exhaustive, but the evaluation should not reward length.

## Process And Decision Scores

| Layer 2 Dimension | Single Agent | Lean Team | Evidence Notes |
|---|---:|---:|---|
| Evidence hygiene | 3.0 | 3.4 | Both label assumptions. Lean team isolates operational facts as placeholders and names backend assumptions. |
| Specialist depth | 1.4 | 3.4 | Lean reports are fewer but still discipline-specific: contrast/focus blockers, trust mechanisms, IA fork logic, DA channel critique. |
| Handoffs that changed output | 0.0 | 3.5 | Appendix identifies CD -> VD, IA -> VD, A11y -> VD, Behavioral -> VD, DA -> lead changes. |
| Debate quality | 1.1 | 3.2 | Two real debates: web vs SMS-native, and accept-preselected vs neutral support defaults. |
| Tradeoff reasoning | 2.8 | 3.5 | Concrete rejected alternatives: SMS-native default, Recommended badge, fare delta, credit tab, neutral support defaults, celebratory receipt. |
| Falsification | 3.0 | 3.6 | Team includes distinct falsifiers for reversals/disputes, receipt confidence, fork comprehension, and call/dispute tradeoff. |
| Red-team value | 2.1 | 3.5 | DA introduces SMS-native alternative and anchoring-on-CD warning. |

## Efficiency And Rework

| Layer 3 Dimension | Single Agent | Lean Team | Evidence Notes |
|---|---:|---:|---|
| Time to useful draft | 3.8 | 2.9 | Baseline took ~7m29s. Lean team took ~23m, just over 3x baseline but less than the full team's ~29-31m. |
| Token/cost discipline | 3.5 | 2.9 | Six teammates and one revision pass; no optional specialists. Process volume lower than full team. |
| Human rework | 3.0 | 3.4 | Lean team leaves fewer artifact-level accessibility fixes for a human. |
| Coordination overhead | 4.0 | 2.8 | Six teammates is still real overhead, but much less ceremony than the full slate. |
| Simplicity | 4.0 | 3.0 | Lean prompt is understandable and held without escalation. |

Layer 1 weighted score:
- Single-agent: 35.2
- Lean team: 40.4

Layer 2 weighted score:
- Single-agent: 16.7
- Lean team: 30.1

Layer 3 weighted score:
- Single-agent: 18.3
- Lean team: 15.0

Total weighted score:
- Single-agent: 70.2
- Lean team: 85.5

Overhead penalty: 6

Coordination Yield: `85.5 - 70.2 - 6 = +9.3`

## Metacognition Notes

What did we expect before scoring?

The lean team should lose some specialist/process depth but keep the artifact-level gains from A11y and Behavioral blocking authority.

What surprised us?

The lean team did not need Content or Interaction to preserve quality on this scenario. IA absorbed the user-job/content spine, Visual carried the interaction surface, and A11y/Behavioral forced the important revisions.

Where did the baseline beat the team?

Speed, breadth, and copy richness. The baseline is very usable after one pass and names more scoped gaps in prose.

Where did the team produce value a single agent probably would not?

The native radiogroup conversion, focus-ring fix, heading cleanup, standby separation, and SMS-native dissent all came from specialist handoffs rather than general synthesis.

What might we be overvaluing?

Dark-mode distinctiveness and a tight memo. The "night-shift dispatcher" posture is coherent, but the DA correctly notes that nobody argued hard for a warmer or SMS-native default until late.

What would change our mind?

A second lean run on a different domain where optional Content/Interaction are needed would show this lean slate is scenario-dependent. A user test showing web-flow abandonment vs SMS-native would challenge the core channel decision.

## Decision

Choose one: Promote the lean prompt as an option, not as a replacement.

Reason: The lean team clears the promotion rule with Coordination Yield +9.3 and preserves the key mechanism from the full team: Visual authoring plus A11y/Behavioral blocking authority before DA and synthesis. It reduces process volume and role count, but wall time only drops about 20-25 percent versus the prior full-team run, so it should not replace the full prompt for all high-stakes work.

## Next Loop

One variable to change:

Test a sharper overhead cut: four-role slate of IA, Visual, A11y, Behavioral, with DA as a checklist run by the lead rather than a spawned teammate.

One variable to hold constant:

Keep clean-room protocol, blind Layer 1 scoring, separated memo/process/metadata, Visual authoring, and A11y/Behavioral blocking authority.

Expected improvement:

Maintain most of the decision-quality gain while cutting wall time under 2.5x baseline.

Failure signal:

If losing Creative Director or spawned DA weakens visual posture, dissent, or red-team quality, keep the six-role lean slate as the default "efficient team" option.
