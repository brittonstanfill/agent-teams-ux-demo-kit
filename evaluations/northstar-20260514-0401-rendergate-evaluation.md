# Render-Gate Four-Role Evaluation

## Run Metadata

| Field | Value |
|---|---|
| Run ID | northstar-20260514-0401-rendergate |
| System commit | 3dd0280 |
| Baseline branch / commit | experiment/northstar-20260514-0401-rendergate-baseline / 448e201 |
| Team branch / commit | experiment/northstar-20260514-0401-rendergate-team / f7ebd23 |
| Scenario | Northstar Air canceled-flight recovery |
| Evaluator(s) | Codex supervisor |
| Scoring date | 2026-05-14 |
| Clean-room checks passed | yes |

## Hypothesis

The render-gate prompt should preserve the four-role team's decision-quality advantage while preventing mobile viewport failures before sealing.

Disproof would be either a weaker artifact than the prior four-role run, a missed responsive-render issue, or enough extra elapsed time that the compact slate no longer justifies itself.

## Layer 0 Gates

| Gate | Baseline | Team | Notes |
|---|---|---|---|
| Clean-room integrity | pass | pass | Both began from `3dd0280`, empty `demo-output/`, and no prior-output reads. |
| Same artifact type | pass | pass | Both shipped HTML plus recommendation. |
| Completeness | pass | pass | Team also shipped role reports, appendix, and metadata. |
| Constraint integrity | pass | pass | Both scrubbed ungrounded operational specifics before sealing. Team removed an invented phone number and undefined wait-threshold language. |
| Accessibility floor | mixed | pass | Team cleared 10 A11y blockers in a revision pass. Baseline has weaker structure and relies more on described mitigations. |
| Responsive render floor | mixed | mixed | Both runs recorded render PASS. Evaluator top-level 390px screenshots still looked clipped under standalone headless Chrome, while team iframe probes reported zero offenders. This is enough to call the new gate useful but under-specified. |
| Trust floor | pass | pass | Team is stronger on refund as peer option, non-guaranteed standby, itemized consent, and hidden-help falsifiers. |

Promotion blocked? `no`, but the render gate needs a top-level-page proof requirement before the next loop.

## Blind Outcome Scores

Artifact A was the team and Artifact B was the baseline. The pass was partial-blind because length and structure made origin inferable.

| Layer 1 Dimension | Artifact A | Artifact B | Evidence Notes |
|---|---:|---:|---|
| User-job fit | 3.6 | 3.2 | A covers rebook/refund/credit/standby/support/confirmation in a product-shaped flow. B covers the job but is more walkthrough-like. |
| Flow coherence | 3.5 | 3.1 | A has a clearer recovery-state progression and confirmation gate. B has a strong narrative but more artifact/tutorial framing. |
| Content quality | 3.3 | 3.2 | A is concise and careful; B is warmer and more detailed but wordier. |
| Recommendation clarity | 3.6 | 3.0 | A is 743 words and meeting-ready. B is useful but 2,687 words. |
| Accessibility and inclusion | 3.4 | 2.6 | A incorporates A11y fixes into HTML. B has render pass and mitigations, but less specialist-grade structure. |
| Trust and behavioral ethics | 3.8 | 3.1 | A directly addresses refund suppression, hidden help, standby misread, and consent. B names trust risks but executes fewer of them in the artifact. |
| Visual and interaction craft | 3.0 | 3.1 | B is more editorially distinctive. A is more product-like. Both need stronger top-level viewport proof. |
| Experiment plan | 3.7 | 3.3 | A's falsifiers are sharper around hidden help, refund rate, standby confusion, and post-completion calls. |

Blind winner: `A`

Why: A is less expressive but more decision-safe and closer to a shippable product artifact.

## Process And Decision Scores

| Layer 2 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Evidence hygiene | 3.0 | 3.5 | Both scrubbed claims. Team recorded specific hygiene catches and clean-room telemetry. |
| Specialist depth | 2.0 | 3.9 | A11y and Behavioral reports were highly specific: WCAG criteria, ARIA misuse, target size, false scarcity, pre-checked consent, hidden-help metrics. |
| Handoffs that changed output | 0.0 | 4.0 | IA, A11y, Behavioral, and lead red-team all changed artifact or memo. |
| Debate quality | 0.0 | 3.6 | Real disagreement on view defaults vs coercive filters, with dissent preserved. |
| Tradeoff reasoning | 2.5 | 3.6 | Team named rejected alternatives and scoped what six roles would have improved. |
| Falsification | 2.5 | 3.8 | Team turned hidden-help and standby-misread risks into measurable falsifiers. |
| Red-team value | 2.0 | 3.5 | Lead red-team added auto-rebook alternative and post-completion-call falsifier. |

## Efficiency And Rework

| Layer 3 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Time to useful draft | 3.2 | 1.5 | Baseline sealed in ~9m including browser install; team took ~32m. |
| Token/cost discipline | 3.5 | 2.0 | Team cost bought real risk coverage, but the run is still >3x baseline. |
| Human rework | 2.6 | 3.0 | Team needs less ethics/accessibility rework; both need clearer render-gate evidence. |
| Coordination overhead | 3.6 | 2.0 | Four roles all contributed, but overhead remains material. |
| Simplicity | 3.4 | 2.6 | Baseline is simpler; team process is justified only when risk coverage matters. |

Layer 1 weighted score:

- Single agent: 34.9
- Agent team: 39.2

Layer 2 weighted score:

- Single agent: 15.0
- Agent team: 31.9

Layer 3 weighted score:

- Single agent: 16.3
- Agent team: 11.1

Total weighted score:

- Single agent: 66.2
- Agent team: 82.2

Overhead penalty: 6

Coordination Yield: 10.0

## Metacognition Notes

Expected before scoring: the render gate would improve artifact reliability and might cost time.

What surprised us: the team treated an apparent 390px clipping issue seriously, then resolved it with iframe probes. The evaluator still found direct top-level screenshots ambiguous enough that the gate needs clearer proof criteria.

Where the baseline beat the team: speed, visual distinctiveness, and broader explanatory narrative.

Where the team produced value a single agent probably would not: specific A11y blockers, behavioral dark-pattern detection, consent relocation, hidden-help falsifiers, and disciplined hygiene scrubs.

What might be overvalued: the team's process rigor. It is useful, but cannot substitute for artifact-level viewport proof.

What would change our mind: a repeated single-agent run that catches the same A11y/Behavioral failures, or a four-role run that continues to take >3x baseline after the render check is standardized.

## Decision

Promote the render-gate concept and keep the four-role slate as the strongest current system, but tighten the gate before the next run: require top-level page screenshots and a top-level DOM overflow check. Do not rely on iframe-only probes.

The system clears the Coordination Yield threshold, but the efficiency hypothesis remains weak. The next loop should reduce elapsed time and make render evidence unambiguous.

## Next Loop

One variable to change: render-gate proof method. Require top-level screenshot + top-level overflow scan, with the command/method recorded in metadata.

One variable to hold constant: four-role slate with IA -> Visual -> A11y/Behavioral -> Visual revision -> lead red-team.

Expected improvement: less ambiguity in responsive QA without adding a fifth specialist.

Failure signal: team still takes >3x baseline or the evaluator can reproduce clipping/overflow after a recorded pass.
