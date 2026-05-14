# Evaluation: Bounded Visual-Designer Render Rerun

## Run Metadata

| Field | Value |
|---|---|
| Run ID | `northstar-20260514-0750-boundedrender` |
| System commit | `87b1974` |
| Baseline branch / commit | `experiment/northstar-20260514-0538-claimlint-baseline` / `34bacdf` |
| Team branch / commit | `experiment/northstar-20260514-0750-boundedrender-team` / `d3ddff2` |
| Scenario | Northstar canceled-flight recovery |
| Evaluator(s) | Codex evaluator |
| Scoring date | 2026-05-14 |
| Clean-room checks passed | yes |

## Hypothesis

Bound Visual Designer pre-audit render work to a quick sanity check, then keep the exhaustive top-level, no-mask, and fixed-container render proof lead-owned after audit revisions. This should preserve the stricter render-gate quality win while reducing wall time and coordination overhead.

Disproof signal: the team reintroduces visible clipping, or still takes more than 1.5x the single-agent baseline despite moving exhaustive proof later.

## Layer 0 Gates

| Gate | Baseline | Team | Notes |
|---|---|---|---|
| Clean-room integrity | pass | pass | Team started at `87b1974` with empty `demo-output`; sealed at `d3ddff2`. Metadata records no prior outputs, evaluations, screenshots, or baseline read before sealing. |
| Same artifact type | pass | pass | Both shipped HTML artifact plus meeting-ready recommendation. |
| Completeness | pass | pass | Team shipped role reports, HTML prototype, final recommendation, process appendix, and run metadata. |
| Constraint integrity | pass | pass | No static dollars, hotels, phone numbers, credit windows, wait times, or eligibility guarantees. Dynamic placeholders are visible and framed as system-provided. |
| Accessibility floor | pass | pass | Team corrected multiple-main / multi-H1 structure, button/list roles, focus contrast, chip targets, and storyboard navigation. |
| Responsive render floor | pass | pass | Independent render probe found no top-level overflow at 390px or 1280px. No-mask rerun also passed. Fixed-container findings were hidden checkbox inputs only. |
| Trust floor | pass | pass | Refund is a peer path, support is visible on every screen, and call reduction is explicitly guarded by refund/support falsifiers. |

Promotion blocked? `no`

Responsive render evidence:

- Top-level mobile / desktop overflow result: evaluator loaded sealed HTML through `file://`; baseline and team both had `html.scrollWidth == html.clientWidth` at 390px and 1280px.
- No-mask result, if applicable: evaluator disabled `html/body` and phone-frame horizontal clipping; team remained `390 / 390` with no viewport overflow.
- Fixed-format container inspection result: team had five chip findings caused by visually hidden checkbox inputs (`leftDelta=-13/rightDelta=13`), not rendered text/control clipping. Screenshot inspection confirmed chips, tokens, support docks, cards, and phone frames fit.
- Screenshot or artifact reference: evaluator screenshots and JSON were generated at `/tmp/northstar-boundedrender-eval/`.

## Blind Outcome Scores

Artifact A = baseline. Artifact B = bounded-render team.

| Layer 1 Dimension | Artifact A | Artifact B | Evidence Notes |
|---|---:|---:|---|
| User-job fit | 3.6 | 3.9 | Team solves refund as a first-class path and gives support its own screen; baseline scopes refund out. |
| Flow coherence | 3.4 | 3.7 | Team's five-screen sequence is direct and app-like, though Screen 4 carries some repeated conditional copy. |
| Content quality | 3.5 | 3.5 | Baseline is more editorially polished; team is shorter, safer, and more action-oriented but token-heavy. |
| Recommendation clarity | 3.2 | 3.9 | Team memo is under 750 words and decision-ready with a clear rollback trigger. |
| Accessibility and inclusion | 3.0 | 3.8 | A11y blockers changed the artifact structure, focus treatment, target sizes, and nav. |
| Trust and behavioral ethics | 3.4 | 3.9 | Team removes the path-agnostic CTA, prechecked filters, and coercive support opt-out. |
| Visual and interaction craft | 3.6 | 3.5 | Team is render-clean and more operable, but baseline remains visually more distinctive and less dominated by token pills. |
| Experiment plan | 3.5 | 3.9 | Team metrics are sharper falsifiers for call suppression, refund friction, and entitlement suppression. |

Blind winner: `B`

Why? Artifact B is less visually polished, but it is the more trustworthy product decision artifact. It fixes refund-path asymmetry and support visibility while passing the render floor.

## Process And Decision Scores

| Layer 2 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Evidence hygiene | 3.7 | 3.8 | Both are disciplined; team keeps placeholders visible and names the backend eligibility assumption. |
| Specialist depth | 1.5 | 3.7 | A11y and Behavioral reports produced concrete blockers, not generic role prose. |
| Handoffs that changed output | 0.5 | 3.9 | IA, A11y, Behavioral, and lead render proof all changed HTML or final recommendation. |
| Debate quality | 1.2 | 3.5 | One real debate on the Rebook descriptor/default was resolved with preserved dissent. |
| Tradeoff reasoning | 3.3 | 3.8 | Team rejects call-first, 3-screen compression, fare badges, and evaluative recommendation labels. |
| Falsification | 3.2 | 3.9 | Refund-tapper completion and eligible-user opt-out ratios are strong wrong-goal detectors. |
| Red-team value | 2.5 | 3.8 | Red team exposed backend eligibility timing, group-split, call-first alternative, and hidden-funnel complaint language. |

## Efficiency And Rework

| Layer 3 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Time to useful draft | 3.5 | 3.0 | Baseline was ~20 minutes; team metadata says 24 minutes and terminal reported 27m46s, within 1.5x. |
| Token/cost discipline | 3.5 | 2.5 | Bounded pre-audit proof improved wall time, but total multi-agent token use remains high. |
| Human rework | 3.2 | 3.6 | Team required one lead CSS render fix, then sealed clean without rebuild. |
| Coordination overhead | 4.0 | 3.3 | Four roles, no nudges, no extra specialists, one debate; strict final proof still costs attention. |
| Simplicity | 3.8 | 3.2 | The slate stayed compact and process did not sprawl, but the proof workflow is still nontrivial. |

Layer 1 weighted score:

- Single agent: 38.3
- Agent team: 42.3

Layer 2 weighted score:

- Single agent: 19.9
- Agent team: 33.0

Layer 3 weighted score:

- Single agent: 18.0
- Agent team: 15.6

Total weighted score:

- Single agent: 76.1
- Agent team: 90.9

Overhead penalty: 0

Coordination Yield: `90.9 - 76.1 - 0 = +14.8`

Sensitivity check: if a stricter token-cost penalty of 3 were applied despite wall time being under 1.5x, Coordination Yield would still be `+11.8`, above the promotion threshold.

## Comparison To Previous Team Run

Previous internal-render team score: team 85.3, Coordination Yield +3.2, with a 6-point overhead penalty. Current bounded-render team score: team 90.9, Coordination Yield +14.8. The quality gain is modest; the real improvement is that the final render proof caught the same class of issue after audits without pushing wall time over 1.5x baseline.

The learned mechanism is credible: exhaustive proof before audits was wasteful because audit-driven HTML changes invalidated early proof work. Bounded author sanity check plus lead-owned final proof keeps the quality gate while reducing proof-loop displacement.

## Metacognition Notes

What did we expect before scoring?

We expected less wall time but were not sure whether the bounded Visual Designer pass would miss internal clipping.

What surprised us?

The final lead proof still caught a real support-dock/token issue. That argues against weakening the render gate; it argues for moving it to the right point in the loop.

Where did the baseline beat the team?

Baseline has stronger editorial and visual personality. The team artifact is safer but more utilitarian, with many visible token pills.

Where did the team produce value a single agent probably would not?

Behavioral caught the path-agnostic refund funnel; A11y forced structural HTML corrections; final proof caught internal support-dock clipping after revision.

What might we be overvaluing?

The apparent precision of DOM render probes. Hidden checkbox inputs and skip links can look like "failures" in raw counts. Screenshot inspection and categorized findings are necessary.

What would change our mind?

A second scenario where the bounded loop still burns high tokens or where a stronger single agent catches the same trust/accessibility issues with similar quality.

## Decision

Choose one:

- Promote the system change

Reason:

The bounded Visual Designer pre-audit render rule clears the promotion bar and survives the harsher overhead sensitivity check. Keep the strict final render gate, but treat exhaustive pre-audit proof as an anti-pattern unless the author sees visible breakage.

## Next Loop

One variable to change:

Run a different scenario that is less visually phone-frame-heavy, to test whether the four-role slate generalizes beyond Northstar.

One variable to hold constant:

Four roles, clean-room hygiene, role-specific blocking authority, bounded pre-audit sanity check, and lead-owned final render proof.

Expected improvement:

Confirm the system is not overfit to this one travel-recovery task and measure whether trust/accessibility gains persist.

Failure signal:

The team wins only on Northstar-like flows, or token cost stays high without producing role-specific artifact changes.
