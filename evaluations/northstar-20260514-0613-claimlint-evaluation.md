# Evaluation: Claim-Provenance Lint Clean Rerun

## Run Metadata

| Field | Value |
|---|---|
| Run ID | `northstar-20260514-0613-claimlint` |
| System commit | `402f472` |
| Baseline branch / commit | `experiment/northstar-20260514-0538-claimlint-baseline` / `34bacdf` |
| Team branch / commit | `experiment/northstar-20260514-0613-claimlint-team-cleanrerun` / `8977e71` |
| Scenario | Northstar canceled-flight recovery |
| Evaluator(s) | Codex evaluator |
| Scoring date | 2026-05-14 |
| Clean-room checks passed | yes |

## Hypothesis

The stricter claim-provenance lint, run by the lead without adding another specialist, should catch unsupported operational promises while preserving the four-role compact team's artifact quality and efficiency.

Disproof signal: the team catches claim issues but ships an artifact that fails a hard floor, or the added lint produces more process than usable outcome improvement.

## Layer 0 Gates

| Gate | Baseline | Team | Notes |
|---|---|---|---|
| Clean-room integrity | pass | pass | Both runs started from `402f472` with empty `demo-output`; prior invalid claim-lint team run was excluded. |
| Same artifact type | pass | pass | Both shipped HTML prototype plus recommendation. |
| Completeness | pass | pass | Required files exist and are substantive. |
| Constraint integrity | pass | pass | Both used dynamic placeholders for operational values; team lint found and cleared five pre-seal claim blockers. |
| Accessibility floor | pass | pass | Team resolved concrete ARIA/focus blockers; baseline had no obvious floor break. |
| Responsive render floor | pass | **fail** | Independent evaluator render showed team Screens 4 and 5 have token text escaping/clipping inside fixed phone-card containers despite top-level `scrollWidth` passing. |
| Trust floor | pass | pass | Both keep support/entitlement paths visible; team explicitly guards against call suppression. |

Promotion blocked? `yes`

Responsive render evidence:

- Top-level mobile / desktop overflow result: independent evaluator CDP probe loaded both sealed HTML files through `file://`; baseline and team both had `html.scrollWidth == html.clientWidth` at 390px and 1280px.
- No-mask result, if applicable: injected `html, body, .phone, .phone__screen, .summary-block, .tonight-wrap { overflow: visible !important; overflow-x: visible !important; }`; top-level widths still passed for both artifacts.
- Fixed-format container inspection result: baseline phone/card contents remained visually contained. Team Screens 4 and 5 showed long token pills escaping summary rows and warm entitlement cards inside the fixed phone mockups; the visible artifact was not meeting-ready without CSS repair.
- Screenshot or artifact reference: evaluator screenshots were generated from sealed commits at `/tmp/northstar-claimlint-eval-screens/`; the gate decision is recorded here rather than relying on the team's self-reported render proof.

## Blind Outcome Scores

Artifact A = baseline. Artifact B = team. Outcome scoring was necessarily partially unblinded by visual style, but process artifacts were not used until Layer 2.

| Layer 1 Dimension | Artifact A | Artifact B | Evidence Notes |
|---|---:|---:|---|
| User-job fit | 3.6 | 3.4 | Both solve understand/choose/support/confirm. Team puts entitlement status earlier, but leaves refund branch and eligibility states more visibly unresolved. |
| Flow coherence | 3.4 | 3.1 | Baseline reads as a coherent walkthrough. Team is app-like but token-heavy and Screen 4/5 layout issues interrupt comprehension. |
| Content quality | 3.5 | 2.8 | Baseline copy is more polished. Team is safer on promises but raw `{token}` density harms user-level readability. |
| Recommendation clarity | 3.2 | 3.5 | Team memo is concise and decision-ready; baseline is stronger in detail but too long for the same meeting use. |
| Accessibility and inclusion | 3.0 | 3.2 | Team made stronger semantic fixes; render clipping keeps this below excellent. |
| Trust and behavioral ethics | 3.4 | 3.6 | Team's behavioral audit removed fabricated social proof and added a call-suppression falsifier. |
| Visual and interaction craft | 3.6 | 1.8 | Baseline is polished and responsive. Team has visible fixed-card overflow/clipping in the sealed artifact. |
| Experiment plan | 3.5 | 3.3 | Baseline has four richer experiments; team has a tighter single plan with a good falsifier. |

Blind winner: `A`

Why? Artifact A is the better artifact to show without repair. Artifact B has stronger safety discipline but fails the visual/render floor in the sealed prototype.

## Process And Decision Scores

| Layer 2 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Evidence hygiene | 3.7 | 3.6 | Both explicitly label or tokenize claims; team lint is stronger on product UI, baseline doc is stronger on visible provenance tags. |
| Specialist depth | 1.5 | 3.4 | Team a11y/behavioral reports use real discipline-specific blockers; baseline simulates the concerns in one pass. |
| Handoffs that changed output | 0.5 | 3.7 | Team records specific IA, a11y, behavioral, and render handoffs that changed HTML. |
| Debate quality | 1.2 | 3.5 | Team preserved a real disagreement on default visual weight and coercion risk. |
| Tradeoff reasoning | 3.3 | 3.5 | Team names branch-depth, support-channel, and entitlement-state tradeoffs. |
| Falsification | 3.2 | 3.6 | Team's "call rate falls but recovery/claim rates do not rise" falsifier is especially valuable. |
| Red-team value | 2.5 | 3.5 | Team lead red-team was specific, but missed that internal render offenders should remain blocking. |

## Efficiency And Rework

| Layer 3 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Time to useful draft | 3.5 | 2.8 | Baseline ~20 min; team ~28 min. |
| Token/cost discipline | 3.5 | 2.2 | Team used meaningful specialist work but still shipped a gate failure. |
| Human rework | 3.2 | 1.6 | Team artifact needs CSS repair before it can be shown. |
| Coordination overhead | 4.0 | 3.0 | Four-role slate stayed compact; no extra specialists spawned. |
| Simplicity | 3.8 | 3.2 | Lead-owned lint avoided extra-role sprawl, but render proof interpretation became too ceremonial. |

Layer 1 weighted score:

- Single agent: 38.5
- Agent team: 34.7

Layer 2 weighted score:

- Single agent: 19.9
- Agent team: 31.4

Layer 3 weighted score:

- Single agent: 18.4
- Agent team: 12.5

Total weighted score:

- Single agent: 76.8
- Agent team: 78.6

Overhead penalty: 6

Coordination Yield: `78.6 - 76.8 - 6 = -4.2`

## Metacognition Notes

What did we expect before scoring?

The expected win condition was that claim-provenance lint would create a safer team artifact without hurting the four-role slate's compactness.

What surprised us?

The lint worked, but the run failed on a different hard floor: the lead over-accepted a top-level `scrollWidth` pass while internal fixed-format card clipping remained visible.

Where did the baseline beat the team?

Visual craft, readable prototype copy, and artifact readiness. The baseline was longer and less process-rich, but it was more presentable.

Where did the team produce value a single agent probably would not?

The behavioral scientist caught fabricated social proof, unsupported re-notification promises, and default coercion. The a11y specialist caught real ARIA and focus-target defects. Those are valuable, role-specific wins.

What might we be overvaluing?

Process evidence. The team report reads rigorous, but a screenshot made the artifact failure obvious. Render proof must not become a box-checking ritual.

What would change our mind?

A repaired team artifact, sealed from a clean rerun, that preserves the claim-provenance gains and passes an internal fixed-container clipping check.

## Decision

Choose one:

- Hold the change and run one more eval

Reason:

Do not promote the claim-provenance lint as a standalone improvement yet. It caught a real class of risk, but this run shows the current render gate is too easy to satisfy with top-level metrics while fixed-format mockups still clip. Promote a narrower system fix: make internal fixed-container clipping a hard render-gate failure, then rerun.

## Next Loop

One variable to change:

Tighten the render proof: top-level overflow passing is necessary but not sufficient; any visible text/control/token escaping or clipping inside fixed phone mockups blocks sealing unless explicitly fixed.

One variable to hold constant:

Keep the four-role compact slate and lead-owned claim-provenance lint. Do not add a content designer or devil's advocate yet.

Expected improvement:

Preserve the team's safety wins while preventing render-proof false positives.

Failure signal:

The next team again ships a prototype where long dynamic tokens or cards visibly escape their containers, or the team spends materially more time proving the render than improving the artifact.
