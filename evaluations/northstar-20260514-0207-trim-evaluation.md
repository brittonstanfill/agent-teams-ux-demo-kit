# Evaluation Report: Synthesis Trim Clean-Room Run

## Run Metadata

| Field | Value |
|---|---|
| Run ID | northstar-20260514-0207-trim |
| System commit | `434a050` |
| Baseline branch / commit | `experiment/northstar-20260514-0207-trim-baseline` / `cae36ea` |
| Team branch / commit | `experiment/northstar-20260514-0207-trim-team` / `e7d74d4` |
| Scenario | Northstar canceled-flight recovery |
| Evaluator(s) | Codex, rubric-based review |
| Scoring date | 2026-05-14 |
| Clean-room checks passed | Yes |

## Hypothesis

The synthesis-trim changes should preserve the team system's decision-quality advantage while fixing prior blind-evaluation hygiene and first-read memo bloat.

Disproof condition: the team does not beat the sealed single-agent baseline after overhead, leaks process/origin into the blind artifact, or ships a worse recommendation/prototype despite more process.

## Layer 0 Gates

| Gate | Baseline | Team | Notes |
|---|---|---|---|
| Clean-room integrity | Pass | Pass | Both started from `434a050`, empty `demo-output`, and sealed before scoring. |
| Same artifact type | Pass | Pass | Both shipped HTML artifact plus recommendation doc. |
| Completeness | Pass | Pass | Required files exist and are substantive. |
| Constraint integrity | Warn | Pass with minor watch | Baseline includes visible "Use within 24 months," an ungrounded policy claim. Team avoids policy duration/amounts, but visible static "about 6 min wait" should be dynamic in a production artifact. |
| Accessibility floor | Warn | Pass | Baseline documents accessibility but wraps phone screens in `role="img"` and misses chip state in the artifact. Team uses real buttons, labeled dialogs, `aria-pressed`, focus-return notes, contrast fixes, and conditional motion. |
| Trust floor | Pass | Pass | Both surface support and keep human help visible. Team has a held-seat default risk but instruments it and preserves the peer-card dissent. |

Promotion blocked? `no` for the candidate system. Comparison-only warnings are diagnostic and were penalized in scoring.

## Blind Outcome Scores

Layer 1 was scored from blind `A` and `B` folders containing only HTML and the meeting-ready recommendation. `A` was later revealed as single-agent; `B` was later revealed as team.

| Layer 1 Dimension | Artifact A | Artifact B | Evidence Notes |
|---|---:|---:|---|
| User-job fit | 3.2 | 3.6 | A covers the full job but keeps a three-choice fork early. B answers "am I getting home?" first, then support, then summary. |
| Flow coherence | 3.3 | 3.5 | A's five-screen flow is clear. B is tighter at four screens plus a state variant, with better held-seat preservation. |
| Content quality | 3.3 | 3.6 | A is clear but long and includes an ungrounded credit-validity line. B is crisper and more state-aware. |
| Recommendation clarity | 3.2 | 3.7 | A is thorough at 2,272 words. B is more meeting-ready at 953 words with a single through-line. |
| Accessibility and inclusion | 2.2 | 3.4 | A's artifact-level semantics lag the claims. B resolves identified blockers in the HTML. |
| Trust and behavioral ethics | 3.1 | 3.5 | A is transparent and autonomy-forward. B uses stronger choice architecture but names and instruments its coercion risk. |
| Visual and interaction craft | 3.2 | 3.5 | A is polished but more presentation-like. B has stronger state model, dialog behavior, and component rationale. |
| Experiment plan | 3.3 | 3.5 | Both include hypotheses, metrics, guardrails, and exits. B's plan better targets its own design risks. |

Blind winner: `B`

Why: B is more concise, more artifact-executed, and safer on accessibility/trust at the screen level. A remains strong and in some places more autonomy-forward, but B better fits the late-night recovery job.

## Process And Decision Scores

| Layer 2 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Evidence hygiene | 3.0 | 3.3 | Both label assumptions. Team exposes more load-bearing assumptions; baseline has the ungrounded 24-month credit detail. |
| Specialist depth | 1.2 | 3.7 | Team reports show real role vocabulary: WCAG blockers, behavioral mechanisms, content tradeoffs, IA/state models. |
| Handoffs that changed output | 0.0 | 3.8 | Appendix documents 11 artifact-changing handoffs. |
| Debate quality | 1.2 | 3.7 | Team preserves held-seat vs peer-card, S3 overclaim, dialog valence, and multi-pax dissent. |
| Tradeoff reasoning | 2.8 | 3.6 | Team rejects concrete alternatives and explains why, especially fare suppression, defaulting, and H1 conditionality. |
| Falsification | 3.0 | 3.8 | Team names what would overturn the held-seat pattern and what metrics would kill launch. |
| Red-team value | 2.2 | 3.7 | DA surfaces silent acceptance, multi-pax, refund-seeker, eligibility, SMS failure, and bias risks. |

## Efficiency And Rework

| Layer 3 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Time to useful draft | 3.8 | 2.6 | Baseline finished in ~7m32s. Team took ~29m, still usable but >3x slower. |
| Token/cost discipline | 3.5 | 2.2 | Team produced much more process material; much of it mattered, but cost is real. |
| Human rework | 2.8 | 3.2 | Team needs productionization and multi-pax follow-up, but less semantic/accessibility rebuild than baseline. |
| Coordination overhead | 4.0 | 2.0 | Team ran eight specialists plus DA; appropriate for learning, heavy for routine use. |
| Simplicity | 4.0 | 2.3 | Baseline is simple. Team system is valuable but ceremonious. |

Layer 1 weighted score:
- Single-agent: 34.9
- Agent team: 39.8

Layer 2 weighted score:
- Single-agent: 16.8
- Agent team: 32.0

Layer 3 weighted score:
- Single-agent: 18.1
- Agent team: 12.3

Total weighted score:
- Single-agent: 69.7
- Agent team: 84.1

Overhead penalty: 6

Coordination Yield: `84.1 - 69.7 - 6 = +8.4`

## Metacognition Notes

What did we expect before scoring?

The team should win Layer 2 and lose efficiency. The real question was whether the trimmed synthesis made Layer 1 strong enough to justify the overhead.

What surprised us?

The team's biggest win was not more prose; it was a concrete artifact revision after A11y/BS audits. The four accessibility blockers were fixed in the HTML, and the behavioral critique changed both Screen 1 and Screen 3.

Where did the baseline beat the team?

Speed, simplicity, and autonomy framing. The baseline's peer choices make refund/human paths more visible earlier than the team's held-seat-first design.

Where did the team produce value a single agent probably would not?

The handoff chain from Accessibility + Behavioral Scientist to Visual Designer produced a better artifact: real button flight cards, chip states, conditional entitlement H1, neutral dialog valence, and preserved dissent on silent acceptance.

What might we be overvaluing?

Visible process. The process appendix is convincing, but future loops must keep asking whether each role changed the artifact or merely created evidence that feels rigorous.

What would change our mind?

A second scenario where the team again takes >3x time but fails to improve artifact-level accessibility/trust would argue this was overfit to Northstar. A leaner role slate achieving the same score would argue the current team is too large.

## Decision

Choose one: Promote the system change.

Reason: The candidate clears the promotion rule with Coordination Yield +8.4 and catches/fixes severe artifact-level accessibility risks the baseline did not execute. The improvements most likely responsible are: hard separation of memo/process/metadata, Visual authoring before audits, A11y/BS before DA, and explicit final synthesis constraints.

Promotion is not a blank check to add more process. The next loop should reduce overhead while preserving the A11y/behavioral blocking pass.

## Next Loop

One variable to change:

Test a leaner role slate or conditional specialist gate: Creative Director, IA/UX combined spine, Visual author, A11y, Behavioral Scientist, Devil's Advocate. Keep Content and Interaction as optional targeted passes only when the lead detects copy/state risk.

One variable to hold constant:

Keep the clean-room protocol, blind Layer 1 scoring, separated memo/process/metadata, and A11y/BS blocking authority before final synthesis.

Expected improvement:

Preserve most of the +14.3 total-score advantage while cutting wall time and token/process overhead by at least 30%.

Failure signal:

If the leaner slate loses the artifact-level accessibility fixes, weakens content/state quality, or fails to preserve dissent, restore the full slate for high-risk UX work.
