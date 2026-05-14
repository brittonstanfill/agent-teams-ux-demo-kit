# Evaluation Report Template

## Run Metadata

| Field | Value |
|---|---|
| Run ID |  |
| System commit |  |
| Baseline branch / commit |  |
| Team branch / commit |  |
| Scenario |  |
| Evaluator(s) |  |
| Scoring date |  |
| Clean-room checks passed |  |

## Hypothesis

What system change was being tested?

What result would have disproved the hypothesis?

## Layer 0 Gates

| Gate | Baseline | Team | Notes |
|---|---|---|---|
| Clean-room integrity |  |  |  |
| Same artifact type |  |  |  |
| Completeness |  |  |  |
| Constraint integrity |  |  |  |
| Accessibility floor |  |  |  |
| Responsive render floor |  |  |  |
| Trust floor |  |  |  |

Promotion blocked? `yes/no`

Responsive render evidence:

- Top-level mobile / desktop overflow result:
- No-mask result, if applicable:
- Fixed-format container inspection result:
- Screenshot or artifact reference:

## Blind Outcome Scores

Score this section before revealing which artifact is single-agent vs. team.

| Layer 1 Dimension | Artifact A | Artifact B | Evidence Notes |
|---|---:|---:|---|
| User-job fit |  |  |  |
| Flow coherence |  |  |  |
| Content quality |  |  |  |
| Recommendation clarity |  |  |  |
| Visual presentation craft |  |  |  |
| Interaction/product craft |  |  |  |
| Accessibility/trust/render robustness |  |  |  |
| Experiment plan |  |  |  |

Blind winner: `A/B/tie`

Why?

## Process And Decision Scores

Reveal process artifacts before scoring this section.

Candidate / champion-challenger evidence, if used:

- Candidate artifacts reviewed:
- Meaningful differences between candidates:
- Selected base candidate:
- Strongest borrowed element:
- Preserved dissent:

| Layer 2 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Evidence hygiene |  |  |  |
| Specialist depth |  |  |  |
| Candidate generation and selection |  |  |  |
| Handoffs that changed output |  |  |  |
| Debate quality |  |  |  |
| Tradeoff reasoning |  |  |  |
| Falsification |  |  |  |
| Red-team value |  |  |  |

## Efficiency And Rework

| Layer 3 Dimension | Single Agent | Agent Team | Evidence Notes |
|---|---:|---:|---|
| Time to useful draft |  |  |  |
| Token/cost discipline |  |  |  |
| Human rework |  |  |  |
| Coordination overhead |  |  |  |
| Simplicity |  |  |  |

Layer 1 weighted score:

Layer 2 weighted score:

Layer 3 weighted score:

Total weighted score:

Overhead penalty:

Coordination Yield:

## Metacognition Notes

What did we expect before scoring?

What surprised us?

Where did the baseline beat the team?

Did the team lose or flatten visual presentation while improving process?

Did candidate comparison improve the final artifact, or average it down?

Where did the team produce value a single agent probably would not?

What might we be overvaluing?

What would change our mind?

## Decision

Choose one:

- Promote the system change
- Hold the change and run one more eval
- Revert the change
- Split the change and retest one part

Reason:

## Next Loop

One variable to change:

One variable to hold constant:

Expected improvement:

Failure signal:
