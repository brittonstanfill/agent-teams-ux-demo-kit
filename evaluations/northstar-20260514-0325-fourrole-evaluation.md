# Four-Role Compact Slate Evaluation

## Run Metadata

| Field | Value |
|---|---|
| Run ID | northstar-20260514-0325-fourrole |
| System commit | 90395d0 |
| Baseline branch / commit | experiment/northstar-20260514-0325-fourrole-baseline / c2a413f |
| Team branch / commit | experiment/northstar-20260514-0325-fourrole-team / 58dbee9 |
| Scenario | Northstar Air canceled-flight recovery |
| Evaluator(s) | Codex supervisor |
| Scoring date | 2026-05-14 |
| Clean-room checks passed | yes |

## Hypothesis

The four-role compact team can preserve most of the decision-quality and accessibility gains from the six-role lean team while reducing coordination overhead.

Disproof would be a team output that loses artifact quality to the single-agent baseline, misses the same trust/accessibility risks, or requires enough extra time and cleanup that the added roles cannot be justified.

## Layer 0 Gates

| Gate | Baseline | Team | Notes |
|---|---|---|---|
| Clean-room integrity | pass | pass | Both runs verified `90395d0`, empty `demo-output/`, and no prior outputs before writing. |
| Same artifact type | pass | pass | Both shipped an HTML artifact plus meeting-ready recommendation. |
| Completeness | pass | pass | Team also shipped role reports, process appendix, and metadata. |
| Constraint integrity | pass with notes | pass with notes | Both avoided concrete invented amounts, hotels, phone numbers, wait times, and expiration windows. Baseline used soft claims such as "Most people start here"; team used `$0` fare rows but framed them as recovery-state design logic. |
| Accessibility floor | mixed | pass with caveat | Baseline placed interactive mockups inside `role="img"` containers and both outputs clipped at a 390px viewport. Team had stronger ARIA/focus mechanics but still needs a responsive render gate. |
| Responsive render floor | fail | fail | Desktop render was usable. Mobile screenshots showed horizontal clipping in both artifacts. This became a system improvement. |
| Trust floor | pass | pass | Neither hides support. Team was materially stronger on refund visibility, no default path, and pending-agent honesty. |

Promotion blocked? `no`, but future runs should treat responsive render as a pre-seal gate.

## Blind Outcome Scores

Artifact A was the baseline and Artifact B was the team. The pass was only partially blind because file size and structure made the mapping inferable before scoring.

| Layer 1 Dimension | Artifact A | Artifact B | Evidence Notes |
|---|---:|---:|---|
| User-job fit | 3.0 | 3.5 | A solves rebook/support/offline confidence, but pushes rebook and leaves refund as a gap. B preserves understand -> choose -> support -> confidence and treats refund/credit as a first-class user job. |
| Flow coherence | 3.0 | 3.4 | A is easy to follow as a presentation artifact. B is closer to a real app flow with party size, support rows, and confirmation states, though "Continue with my choice" is active before a path is selected. |
| Content quality | 3.0 | 3.2 | A is warmer and more explanatory but uses ungrounded "Most people" language. B is terse and less expressive, but more honest about unresolved items. |
| Recommendation clarity | 2.5 | 3.6 | A is useful but 2,176 words. B hits the 750-word cap with a clearer through-line and stronger launch caveat. |
| Accessibility and inclusion | 2.0 | 3.2 | A names WCAG concerns but has screen-reader-breaking mockup structure and mobile clipping. B implements fieldsets, radiogroup behavior, roving tabindex, spinbutton semantics, focus, target-size, and contrast fixes, but still clips on mobile. |
| Trust and behavioral ethics | 2.4 | 3.7 | A surfaces support but keeps a rebook default, buries cash refund, and uses social-proof wording. B removes default choice, separates standby as non-equivalent, makes refund peer to credit, and routes pending items to an agent action. |
| Visual and interaction craft | 2.7 | 2.8 | A is more visually distinctive but reads like an annotated case study, not the product. B is calmer and product-shaped but less polished and also fails the mobile render check. |
| Experiment plan | 3.0 | 3.8 | A has four sensible experiments. B has one integrated plan with falsifiers for hidden defaults, deflected support, pending-agent failure, and refund-to-credit inertia. |

Blind winner: `B`

Why: B is less showy, but it makes safer product decisions and ships more of the actual risk control into the artifact.

## Process And Decision Scores

| Layer 2 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Evidence hygiene | 3.0 | 3.2 | Baseline labels assumptions well. Team labels less in the memo but has stronger process evidence in role reports and appendix. |
| Specialist depth | 1.8 | 3.8 | Team A11y named ARIA contradictions, contrast ratios, landmarks, keyboard patterns; Behavioral named false reassurance, ambiguous endowment, phantom decline, resolution gaps, and falsifiers. |
| Handoffs that changed output | 0.0 | 4.0 | IA, A11y, Behavioral, and Visual all produced visible HTML or recommendation changes. |
| Debate quality | 0.0 | 3.5 | One real disagreement over unpressed sort chips vs hidden card-order default; dissent preserved. |
| Tradeoff reasoning | 2.5 | 3.6 | Team named concrete rejected alternatives: call-first design, red status, pure peer standby, top-level refund, badge-as-label, and sort behavior. |
| Falsification | 2.5 | 3.8 | Team gave specific watch-for metrics for hidden support deflection, pending-agent parking, standby confusion, and refund-to-credit inertia. |
| Red-team value | 2.0 | 3.6 | Lead red-team found the backend entitlement dependency and converted it into a launch gate and experiment guardrail. |

## Efficiency And Rework

| Layer 3 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Time to useful draft | 4.0 | 2.0 | Baseline sealed in about 6 minutes; team synthesis took about 27 minutes before commit/push. |
| Token/cost discipline | 3.8 | 2.5 | Team cost was high but bought visible risk reduction. |
| Human rework | 2.3 | 2.7 | Both need mobile responsive fixes. Team needs less ethics/accessibility reconstruction; baseline needs larger refund/default/accessibility work. |
| Coordination overhead | 4.0 | 2.7 | Four roles were all useful, but the run still exceeded the hypothesis' 2.5x time target. |
| Simplicity | 3.3 | 3.0 | Baseline is simpler. Team process is compact enough to follow and avoided extra specialists. |

Layer 1 weighted score:

- Single agent: 30.4
- Agent team: 38.3

Layer 2 weighted score:

- Single agent: 14.8
- Agent team: 31.9

Layer 3 weighted score:

- Single agent: 17.4
- Agent team: 12.9

Total weighted score:

- Single agent: 62.6
- Agent team: 83.0

Overhead penalty: 6

Coordination Yield: 14.4

## Metacognition Notes

Expected before scoring: four roles would keep the lean slate's decision quality but maybe lose visual distinctiveness.

Surprise: the four-role team did not cut wall time enough. It beat the baseline on decision safety, but not on the efficiency hypothesis.

Where the baseline beat the team: warmer editorial presentation, faster draft, and a more visually distinctive demo page.

Where the team produced value a single agent probably would not: it found and fixed contradictory ARIA models, identified false reassurance and phantom decline risks, preserved a real dissent about hidden sort defaults, and translated red-team concerns into falsifiers.

What might be overvalued: process evidence. The role reports are strong, but the shipped artifact still clipped on mobile. The evaluator should not reward a clean appendix for a broken viewport.

What would change our mind: a repeated run where a single agent independently catches refund/default/ARIA/behavioral issues with comparable specificity, or a four-role run that still requires a human rebuild after viewport and content QA.

## Decision

Promote the four-role compact prompt as the best current candidate for the next loop, with one required improvement: add a responsive render smoke check before sealing. The run clears the Coordination Yield threshold, and the team caught severe trust/accessibility risks the baseline missed.

Do not claim the efficiency hypothesis is proven. The next loop should target elapsed time and viewport reliability, not more specialist coverage.

## Next Loop

One variable to change: require a pre-seal mobile/desktop render check and record the result in run metadata.

One variable to hold constant: keep the four-role slate and lead-run red-team checklist.

Expected improvement: fewer visually broken artifacts without adding a fifth specialist.

Failure signal: the team still exceeds 3x baseline time or ships horizontal clipping after the render gate.
