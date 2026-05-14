# Evaluation: Internal Fixed-Container Render Gate Rerun

## Run Metadata

| Field | Value |
|---|---|
| Run ID | `northstar-20260514-0656-internalrender` |
| System commit | `320b640` |
| Baseline branch / commit | `experiment/northstar-20260514-0538-claimlint-baseline` / `34bacdf` |
| Team branch / commit | `experiment/northstar-20260514-0656-internalrender-team` / `e98ec89` |
| Scenario | Northstar canceled-flight recovery |
| Evaluator(s) | Codex evaluator |
| Scoring date | 2026-05-14 |
| Clean-room checks passed | yes |

## Hypothesis

The stricter fixed-container render gate should prevent the previous false pass where top-level `scrollWidth` was clean but content clipped inside phone/card mockups.

Disproof signal: the team still seals with visible internal clipping, or the stricter gate consumes enough time that the compact slate no longer has a defensible coordination yield.

## Layer 0 Gates

| Gate | Baseline | Team | Notes |
|---|---|---|---|
| Clean-room integrity | pass | pass | Team started at `320b640` with empty `demo-output`; no prior outputs read before sealing. |
| Same artifact type | pass | pass | Both shipped HTML prototype plus recommendation. |
| Completeness | pass | pass | Required files are present and substantive. |
| Constraint integrity | pass | pass | Team claim lint found no invented dollars, hotels, phone numbers, wait times, expirations, or eligibility promises. |
| Accessibility floor | pass | pass | Team fixed native keyboard/AT operability for flight cards, focus contrast, and 44px targets. |
| Responsive render floor | pass | pass | Independent evaluator render of sealed HTML passed normal 390px and 1200px screenshots/probes. |
| Trust floor | pass | pass | Support remains visible; team names call-suppression and entitlement-disappointment falsifiers. |

Promotion blocked? `no`

Responsive render evidence:

- Top-level mobile / desktop overflow result: evaluator loaded sealed HTML through `file://`; both artifacts had `html.scrollWidth == html.clientWidth` at 390px and 1200px in normal mode.
- No-mask result, if applicable: team metadata reports normal, long-token, and mask-off checks all clean after a late `.time-block` fix; evaluator normal screenshots confirmed no visible clipping.
- Fixed-format container inspection result: team normal mode returned no internal offenders or container escapees. Evaluator's deliberately extreme all-token replacement found a small Screen 5 status-line token escape under synthetic stress; this is recorded as residual risk, not a gate failure, because the sealed artifact and normal placeholder lengths render cleanly.
- Screenshot or artifact reference: evaluator screenshots generated at `/tmp/northstar-internalrender-eval/`.

## Blind Outcome Scores

Artifact A = baseline. Artifact B = internal-render team.

| Layer 1 Dimension | Artifact A | Artifact B | Evidence Notes |
|---|---:|---:|---|
| User-job fit | 3.6 | 3.8 | Team better covers refund/credit and standby as real paths; baseline leaves refund as a scoped gap. |
| Flow coherence | 3.4 | 3.6 | Team's five-screen app flow is clearer about path choice and support, though variants are still partly sketched. |
| Content quality | 3.5 | 3.4 | Baseline copy is more polished; team copy is shorter and safer but more utilitarian. |
| Recommendation clarity | 3.2 | 3.8 | Team memo is concise, under 750 words, and decision-ready. |
| Accessibility and inclusion | 3.0 | 3.8 | Team fixed native radio-group, focus ring, and target-size issues at artifact level. |
| Trust and behavioral ethics | 3.4 | 3.9 | Team removed silent defaults, distinguishes pending vs confirmed rows, and keeps support visible. |
| Visual and interaction craft | 3.6 | 3.4 | Team is less visually distinctive than baseline but more app-operable and render-clean. |
| Experiment plan | 3.5 | 3.7 | Team has fewer experiments but stronger falsifiers for hidden calls, entitlement disappointment, and standby surprise. |

Blind winner: `B`

Why? Artifact B is less polished, but it is a safer and more decision-useful product artifact: it resolves refund/standby paths, shows state differences, and passes the stricter render floor.

## Process And Decision Scores

| Layer 2 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Evidence hygiene | 3.7 | 3.8 | Team carried placeholder discipline through artifact and lint. |
| Specialist depth | 1.5 | 3.6 | A11y and Behavioral each produced real blockers that changed the HTML. |
| Handoffs that changed output | 0.5 | 3.8 | IA, A11y, Behavioral, and lead render-gate handoffs all changed the artifact. |
| Debate quality | 1.2 | 3.5 | Standby warning debate preserved dissent and linked it to a falsifier. |
| Tradeoff reasoning | 3.3 | 3.7 | Team names equal choices vs default, disabled button vs unresolved state, and native radio tradeoffs. |
| Falsification | 3.2 | 3.8 | "Calls hidden, not helped" is a strong product falsifier. |
| Red-team value | 2.5 | 3.6 | Red-team exposed auto-resolve alternative, sync-eligibility assumption, and elite-status gap. |

## Efficiency And Rework

| Layer 3 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Time to useful draft | 3.5 | 1.8 | Baseline ~20 min; team ~50 min. |
| Token/cost discipline | 3.5 | 1.8 | Visual authoring alone used 117k tokens and 104 tool calls before audits. |
| Human rework | 3.2 | 3.3 | Team artifact is usable after the lead-owned render fix. |
| Coordination overhead | 4.0 | 2.3 | Four-role slate stayed clean, but render proof became expensive. |
| Simplicity | 3.8 | 2.5 | No extra specialists, but proof work crowded the loop. |

Layer 1 weighted score:

- Single agent: 38.3
- Agent team: 41.3

Layer 2 weighted score:

- Single agent: 19.9
- Agent team: 32.3

Layer 3 weighted score:

- Single agent: 18.0
- Agent team: 11.7

Total weighted score:

- Single agent: 76.1
- Agent team: 85.3

Overhead penalty: 6

Coordination Yield: `85.3 - 76.1 - 6 = +3.2`

## Metacognition Notes

What did we expect before scoring?

We expected the stricter gate to prevent the prior render false positive.

What surprised us?

The gate worked, but it pulled a lot of effort into Visual Designer self-proofing before the audits. The team won on quality, not efficiency.

Where did the baseline beat the team?

Baseline had stronger editorial polish and far better time/cost discipline.

Where did the team produce value a single agent probably would not?

A11y caught a keyboard-inoperable flight-card pattern, Behavioral caught silent entitlement/default risks, and the lead-owned render gate caught internal overflow before sealing.

What might we be overvaluing?

Render-proof ceremony. It matters because it prevented a real failure, but it should run at the right time and with bounded scope.

What would change our mind?

If the same quality can be achieved with a quick Visual sanity check plus final lead proof, the compact team becomes much more attractive. If not, the render gate may need automation rather than prompt discipline.

## Decision

Choose one:

- Split the change and retest one part

Reason:

Keep/promote the stricter fixed-container render gate: it directly fixed the previous failure mode and enabled a clean sealed artifact. Do not promote the broader current loop as efficient; Coordination Yield is only +3.2 after overhead. Retest with the same gate but a bounded Visual Designer sanity check so exhaustive render proof happens once, after audit revisions.

## Next Loop

One variable to change:

Bound Visual Designer pre-audit render work: quick sanity check only; exhaustive top-level/fixed-container/long-token/no-mask proof remains lead-owned after the revision pass.

One variable to hold constant:

Four-role compact slate, lead-owned claim lint, and strict fixed-container render gate.

Expected improvement:

Preserve the artifact-quality win while reducing wall time and token cost.

Failure signal:

The next run either reintroduces clipping, or spends another 40-50 minutes despite the proof being moved later and bounded.
