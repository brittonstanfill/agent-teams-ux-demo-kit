# Start Here

This repo is both a demo kit and a record of an improvement loop for Claude Code agent teams. If you are opening it for the first time, use this page to avoid the common traps. This page is the **single source of truth for the current recommended workflow** — the README points here rather than restate it, so a workflow change lands in one place.

## What This Repo Is

The kit helps you compare a single-agent UX output with a small team of specialist agents on the same product problem. The current demo problem is [`demo-inputs/northstar-canceled-flight-brief.md`](demo-inputs/northstar-canceled-flight-brief.md), a fictional airline cancellation recovery flow.

The goal is not "agent teams always win." The goal is to learn when a team produces a better product artifact or a better decision, and whether the extra coordination cost is justified.

## Current Recommended Path

For a serious run, use these files in order:

1. [`bin/precheck.sh`](bin/precheck.sh) — verifies Claude Code version, agent-teams flag, tmux state, agent drift, and demo-output cleanliness. Stop and fix anything it flags before you run a team.
2. [`runbooks/clean-room.md`](runbooks/clean-room.md) — how to run without contaminating the comparison.
3. [`prompts/single-baseline.md`](prompts/single-baseline.md) — baseline prompt; run in a separate clean checkout.
4. [`prompts/team-compact.md`](prompts/team-compact.md) — current best compact team prompt; it creates two competing full artifacts early, runs a champion-challenger selection, then seals the final.
5. [`rubrics/evaluation-system.md`](rubrics/evaluation-system.md) — scoring gates, split visual/interaction/robustness rubric, coordination yield, and metacognition checks.

Use [`prompts/team-relay.md`](prompts/team-relay.md), [`prompts/team-parallel-author.md`](prompts/team-parallel-author.md), or [`prompts/team-lean.md`](prompts/team-lean.md) only when you are intentionally testing those older or alternative team patterns.

## Current Best Evaluated Output

The most recent sealed team output is on:

```text
experiment/northstar-20260514-0835-visualcraft-team
```

Review these files on that branch:

```text
demo-output/prototype/index.html
demo-output/final-recommendation.md
demo-output/process-appendix.md
demo-output/run-metadata.md
```

The evaluation for that run is on `main`:

```text
evaluations/northstar-20260514-0835-visualcraft-evaluation.md
```

For the full trajectory of evaluations and what each loop changed, see [`evaluations/INDEX.md`](evaluations/INDEX.md).

## Branches: What To Merge

`main` contains the promoted system improvements: prompts, evaluation rules, templates, and written evaluations.

Branches named like these are sealed evidence branches:

```text
experiment/northstar-20260514-0835-visualcraft-team
experiment/northstar-20260514-0750-boundedrender-team
experiment/northstar-20260514-0538-claimlint-baseline
```

Do not merge those output branches into `main` unless you intentionally want `demo-output/` run artifacts in the main history. They exist so reviewers can inspect what was actually produced in a sealed run. The full list with what each branch tested is in [`evaluations/INDEX.md`](evaluations/INDEX.md).

## First Local Setup

Install the bundled agents globally for personal use, then verify:

```bash
bin/install-agents.sh
bin/verify-agents.sh
```

Then restart Claude Code and verify the agents with `/agents`.

If a previous live demo failed because agents could not write files or coordinate, run `bin/verify-agents.sh` first — drift between the kit source and your installed agents is the most common cause. `bin/install-agents.sh` re-syncs them.

For a clean experiment, do not run directly in this checkout. Follow [`runbooks/clean-room.md`](runbooks/clean-room.md) and create fresh baseline/team worktrees or clones.

## How To Judge A Run

Read the output first, then the process:

1. Open the prototype HTML and final recommendation.
2. Check Layer 0 gates in [`rubrics/evaluation-system.md`](rubrics/evaluation-system.md): clean-room, completeness, constraint integrity, accessibility, render, and trust.
3. Score visual presentation craft separately from interaction/product craft and accessibility/trust/render robustness. A team that is safer but visibly worse is a hold/retest result, not a clean win.
4. Only then read role reports, candidate artifacts, process appendix, and run metadata.
5. Calculate Coordination Yield before promoting prompt changes.

Promote a change only when the team output is better enough to justify the added process, or when the team catches a severe risk the baseline missed.
