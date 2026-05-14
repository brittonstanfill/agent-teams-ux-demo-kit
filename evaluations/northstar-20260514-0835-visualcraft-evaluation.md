# Evaluation: Visual-Craft Gate Rerun

## Run Metadata

| Field | Value |
|---|---|
| Run ID | `northstar-20260514-0835-visualcraft` |
| System commit | `af82a69` |
| Baseline branch / commit | `experiment/northstar-20260514-0538-claimlint-baseline` / `34bacdf` |
| Team branch / commit | `experiment/northstar-20260514-0835-visualcraft-team` / `d2617be` |
| Scenario | Northstar canceled-flight recovery |
| Evaluator(s) | Codex evaluator |
| Scoring date | 2026-05-14 |
| Clean-room checks passed | yes |

## Hypothesis

The four-role loop plus a visual-craft gate can preserve trust, accessibility, and render-gate gains while producing a less generic, more product-real artifact. The changed variable was presentation discipline: no decorative phone-bezel storyboard, supplied facts used as real values, placeholders kept visually subordinate, and polish forbidden from hiding uncertainty or support/refund paths.

Disproof signal: the artifact becomes prettier by weakening trust/accessibility floors, or the craft gate adds enough overhead to erase coordination yield.

## Layer 0 Gates

| Gate | Baseline | Team | Notes |
|---|---|---|---|
| Clean-room integrity | pass | pass | Team started from `af82a69`; prior evaluations, branches, outputs, screenshots, and baseline artifacts were not read before sealing. Remote branch landed at `d2617be`. |
| Same artifact type | pass | pass | Both shipped HTML artifact plus meeting-ready recommendation. |
| Completeness | pass | pass | Team shipped four role reports, prototype, final recommendation, process appendix, and run metadata. |
| Constraint integrity | pass | pass | No invented hotel names, voucher amounts, phone numbers, wait times, arrival times, credit windows, compensation rules, or eligibility promises. Supplied facts are rendered as facts; unknowns remain dynamic values. |
| Accessibility floor | pass | pass | A11y found six blockers; revision fixed heading hierarchy, SMS region label, focus contrast, 320px reflow, decorative back arrows, and label-in-name on flight CTAs. |
| Responsive render floor | pass | pass | Independent evaluator probe found no top-level overflow or fixed-container offenders at 320, 390, 390 no-mask, or 1280. |
| Trust floor | pass | pass | Support remains persistent, hotel/meal is visible, standby is caveated, and refund-seekers are routed to a human rather than hidden behind credit. |

Promotion blocked? `no`

Responsive render evidence:

- Top-level mobile / desktop overflow result: evaluator loaded sealed HTML via `file://`; current team had `scrollWidth == clientWidth` at 320, 390, and 1280.
- No-mask result, if applicable: evaluator forced visible overflow except sr-only utilities; current team remained `390 / 390` with zero viewport or container offenders.
- Fixed-format container inspection result: current team had zero container findings. Prior bounded-render team still produced five hidden-input chip findings; those were false positives, but the current artifact avoids even that probe noise.
- Screenshot or artifact reference: evaluator screenshots and JSON at `/tmp/northstar-visualcraft-eval/`.

## Blind Outcome Scores

Artifact A = baseline. Artifact B = visual-craft team.

| Layer 1 Dimension | Artifact A | Artifact B | Evidence Notes |
|---|---:|---:|---|
| User-job fit | 3.6 | 3.8 | Team handles cause, path choice, hotel/meal, standby caveat, and confirmation. Refund is a routed human handoff rather than self-serve, which is honest but less complete. |
| Flow coherence | 3.4 | 3.9 | Five screens read as a product sequence rather than a storyboard; the choice point is especially clear. |
| Content quality | 3.5 | 3.8 | Copy is shorter and more concrete than the prior team run; supplied facts are visible without token clutter. |
| Recommendation clarity | 3.2 | 3.7 | Memo is concise and decision-ready, though the experiment plan is less detailed than the process appendix. |
| Accessibility and inclusion | 3.0 | 3.9 | 320px reflow, heading semantics, focus contrast, and label-in-name fixes are artifact-level, not just notes. |
| Trust and behavioral ethics | 3.4 | 3.9 | Strong no-default choice screen, persistent help, no "Recommended" badge, explicit refund handoff, and refund-seeker call-rate falsifier. |
| Visual and interaction craft | 3.6 | 3.9 | Stronger than prior team: no phone chrome, fewer dominant placeholders, more believable airline-tool surface, clean render at 320. |
| Experiment plan | 3.5 | 3.8 | Good primary and guardrail logic; refund-seeker call-rate is the right falsifier. |

Blind winner: `B`

Why? Artifact B is the first team output that meaningfully improves visual/interaction craft without giving up trust, accessibility, or render discipline.

## Process And Decision Scores

| Layer 2 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Evidence hygiene | 3.7 | 3.9 | Team uses brief-supplied facts and keeps unknowns dynamic; refund is framed as a design handoff, not a policy promise. |
| Specialist depth | 1.5 | 3.8 | A11y produced measurable blockers; Behavioral gave a dark-pattern audit with specific falsifiers. |
| Handoffs that changed output | 0.5 | 3.8 | IA shaped placeholder/fact discipline; A11y and Behavioral changed the HTML; Behavioral changed the memo guardrail. |
| Debate quality | 1.2 | 3.6 | Standby-branch debate preserved dissent and converted residual risk into a scoped gap. |
| Tradeoff reasoning | 3.3 | 3.8 | Phone-bezel rejection, refund handoff, standby split, and hotel/meal peer choice are defensible tradeoffs. |
| Falsification | 3.2 | 3.9 | Refund-seeker call-rate drop while completions rise is a sharp wrong-goal detector. |
| Red-team value | 2.5 | 3.8 | Red team surfaced self-service anchoring, low-bandwidth completion burden, and refund suppression risk. |

## Efficiency And Rework

| Layer 3 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Time to useful draft | 3.5 | 3.6 | Baseline was ~20 minutes; team sealed in ~19m35s. |
| Token/cost discipline | 3.5 | 2.6 | Wall time was excellent, but role/revision token use remained high. |
| Human rework | 3.2 | 3.7 | Six A11y blockers and one Behavioral polish item were resolved in one revision pass. |
| Coordination overhead | 4.0 | 3.5 | Four roles, no escalation, one debate, no substantive nudges. |
| Simplicity | 3.8 | 3.4 | The craft gate improved output without adding a new specialist, but the strict proof workflow remains involved. |

Layer 1 weighted score:

- Single agent: 38.3
- Agent team: 43.2

Layer 2 weighted score:

- Single agent: 19.9
- Agent team: 33.3

Layer 3 weighted score:

- Single agent: 18.0
- Agent team: 16.8

Total weighted score:

- Single agent: 76.1
- Agent team: 93.3

Overhead penalty: 0

Coordination Yield: `93.3 - 76.1 - 0 = +17.2`

Sensitivity check: if a stricter token-cost penalty of 3 were applied despite baseline-level wall time, Coordination Yield would still be `+14.2`.

## Comparison To Previous Team Run

Previous bounded-render team score: 90.9, Coordination Yield +14.8. Current visual-craft team score: 93.3, Coordination Yield +17.2. The gain is concentrated where expected: visual/interaction craft rose from 3.5 to 3.9 and render probe noise dropped to zero. Trust and accessibility did not regress.

The causal story is plausible: the craft gate changed authoring choices before the prototype was built, not as late styling polish. It removed phone-bezel chrome, reduced placeholder dominance, used supplied facts directly, and preserved a real product surface for evaluation.

## Metacognition Notes

What did we expect before scoring?

We expected better visual craft but worried the team might use polish to blur hard policy uncertainty.

What surprised us?

The craft gate also made render evaluation easier. Removing decorative phone frames and dominant token pills reduced false-positive probe noise.

Where did the baseline beat the team?

Baseline still has a stronger editorial voice and a broader written recommendation. The team memo is more decision-ready but less expansive.

Where did the team produce value a single agent probably would not?

A11y caught measurable 320px and label-in-name failures; Behavioral converted refund suppression into the central falsifier; Visual translated the craft gate into a cleaner artifact without extra specialists.

What might we be overvaluing?

The Northstar task is now highly familiar to the loop. This run proves the craft gate helps on this scenario, not that the system generalizes.

What would change our mind?

A fresh non-airline scenario where the craft gate adds ceremony or where the team gets prettier but less honest.

## Decision

Choose one:

- Promote the system change

Reason:

The visual-craft gate improved the exact residual weakness from the previous evaluation and cleared the promotion threshold with no wall-time penalty. Promote it into the four-role prompt, but treat the conclusion as scoped: the next loop needs a different scenario to test generalization.

## Next Loop

One variable to change:

Use a new, non-Northstar scenario so the team cannot reuse learned structure from repeated canceled-flight runs.

One variable to hold constant:

Four roles, clean-room hygiene, bounded pre-audit sanity check, lead-owned final render proof, and the new visual-craft gate.

Expected improvement:

Show whether the system produces better outcomes because of the reusable team protocol, not because it has overfit the Northstar task.

Failure signal:

The team either loses to the baseline on a fresh scenario, or wins only by producing more process rather than a better artifact.
