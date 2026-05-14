# Evaluations Index

Every sealed evaluation in this directory, in chronological order, with the branch it scored and the outcome.

Score values reflect the rubric in [`../rubrics/evaluation-system.md`](../rubrics/evaluation-system.md). Coordination Yield is Team weighted score − Baseline weighted score − Overhead penalty.

Outcome legend:

- **Promoted** — change merged into `main` as a kit-level improvement
- **Held** — result interesting but did not clear promotion bar; usually retest with a tightened variable
- **Reverted** — change removed because it made the team worse
- **Mixed** — partial win; one part of the change promoted, another reverted or held

| Run | Branch (team) | What was being tested | Outcome | Notes |
| :--- | :--- | :--- | :--- | :--- |
| `northstar-20260514-0207-trim` | `experiment/northstar-20260514-0207-trim-team` | First trim of the full role slate | See evaluation file | [eval](northstar-20260514-0207-trim-evaluation.md) |
| `northstar-20260514-0250-lean` | `experiment/northstar-20260514-0250-lean-team` | Six-role lean slate; tests whether dropping Content + Interaction holds quality | See evaluation file | [eval](northstar-20260514-0250-lean-evaluation.md) |
| `northstar-20260514-0325-fourrole` | `experiment/northstar-20260514-0325-fourrole-team` | First four-role compact team | See evaluation file | [eval](northstar-20260514-0325-fourrole-evaluation.md) |
| `northstar-20260514-0401-rendergate` | `experiment/northstar-20260514-0401-rendergate-team` | Adds responsive render floor to the gates | See evaluation file | [eval](northstar-20260514-0401-rendergate-evaluation.md) |
| `northstar-20260514-0448-topproof` | `experiment/northstar-20260514-0448-topproof-team` | Top-level scrollWidth pass-only render proof | See evaluation file | [eval](northstar-20260514-0448-topproof-evaluation.md) |
| `northstar-20260514-0538-claimlint` | `experiment/northstar-20260514-0538-claimlint-team` | Constraint-integrity lint for invented operational claims | See evaluation file | [eval](northstar-20260514-0613-claimlint-evaluation.md) |
| `northstar-20260514-0656-internalrender` | `experiment/northstar-20260514-0656-internalrender-team` | Fixed-format container clipping check | See evaluation file | [eval](northstar-20260514-0656-internalrender-evaluation.md) |
| `northstar-20260514-0750-boundedrender` | `experiment/northstar-20260514-0750-boundedrender-team` | Bounded render-proof loop; lead-owned exhaustive proof after revisions | See evaluation file | [eval](northstar-20260514-0750-boundedrender-evaluation.md) |
| `northstar-20260514-0835-visualcraft` | `experiment/northstar-20260514-0835-visualcraft-team` | Protected visual presentation pass after audits | **Current best evaluated output** | [eval](northstar-20260514-0835-visualcraft-evaluation.md) |

## How to add a new evaluation

1. Run the experiment per [`../runbooks/clean-room.md`](../runbooks/clean-room.md).
2. Seal both outputs on their respective `experiment/*-baseline` and `experiment/*-team` branches.
3. Write the evaluation report on `main` using [`../templates/evaluation-report-template.md`](../templates/evaluation-report-template.md). Name it `northstar-YYYYMMDD-HHMM-<slug>-evaluation.md`.
4. Add a row to this index. Keep the row short — the evaluation file carries the detail.
5. If the change cleared the promotion bar in [`../rubrics/evaluation-system.md`](../rubrics/evaluation-system.md), update the prompt/rubric on `main`, and record the change in `CHANGELOG.md`.

## Trajectory at a glance

The improvement loop on 2026-05-14 moved from the full 7-role team toward a tighter team with stronger gates:

- Trimmed the role slate (full → lean → four-role compact) without losing artifact quality.
- Hardened the responsive render floor (top-level proof → fixed-format-container proof → bounded post-revision proof).
- Added constraint-integrity to catch invented operational claims (wait times, voucher amounts).
- Protected a final visual presentation pass so accessibility/trust gains do not mask a weaker first impression.

The current default prompt — [`../prompts/team-compact.md`](../prompts/team-compact.md) — is the cumulative result of these promotions.
