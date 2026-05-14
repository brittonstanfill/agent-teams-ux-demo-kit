# Start Here

This repo is both a demo kit and a record of an improvement loop for Claude Code agent teams. If you are opening it for the first time, use this page to avoid the common traps.

## What This Repo Is

The kit helps you compare a single-agent UX output with a small team of specialist agents on the same product problem. The current demo problem is `demo-inputs/northstar-canceled-flight-brief.md`, a fictional airline cancellation recovery flow.

The goal is not "agent teams always win." The goal is to learn when a team produces a better product artifact or a better decision, and whether the extra coordination cost is justified.

## Current Recommended Path

For a serious run, use these files in order:

1. `10-clean-room-experiment-runbook.md` - how to run without contaminating the comparison.
2. `03-single-agent-baseline-prompt.md` - baseline prompt; run in a separate clean checkout.
3. `13-four-role-agent-team-prompt.md` - current best compact team prompt.
4. `11-evaluation-system.md` - scoring gates, weighted rubric, coordination yield, and metacognition checks.

Use `02-master-agent-team-prompt.md`, `09-parallel-author-prompt.md`, or `12-lean-agent-team-prompt.md` only when you are intentionally testing those older or alternative team patterns.

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

## Branches: What To Merge

`main` contains the promoted system improvements: prompts, evaluation rules, templates, and written evaluations.

Branches named like these are sealed evidence branches:

```text
experiment/northstar-20260514-0835-visualcraft-team
experiment/northstar-20260514-0750-boundedrender-team
experiment/northstar-20260514-0538-claimlint-baseline
```

Do not merge those output branches into `main` unless you intentionally want `demo-output/` run artifacts in the main history. They exist so reviewers can inspect what was actually produced in a sealed run.

## First Local Setup

Install the bundled agents globally for personal use:

```bash
mkdir -p ~/.claude/agents
cp claude-agents/*.md ~/.claude/agents/
grep '^tools:' ~/.claude/agents/*.md
```

Then restart Claude Code and verify the agents with `/agents`.

If a previous live demo failed because agents could not write files or coordinate, re-copy the agents before presenting. The current definitions give every role `Write`, `Edit`, `Bash`, task-list tools, and `SendMessage`.

For a clean experiment, do not run directly in this checkout. Follow `10-clean-room-experiment-runbook.md` and create fresh baseline/team worktrees or clones.

## How To Judge A Run

Read the output first, then the process:

1. Open the prototype HTML and final recommendation.
2. Check Layer 0 gates in `11-evaluation-system.md`: clean-room, completeness, constraint integrity, accessibility, render, and trust.
3. Only then read role reports, process appendix, and run metadata.
4. Calculate Coordination Yield before promoting prompt changes.

Promote a change only when the team output is better enough to justify the added process, or when the team catches a severe risk the baseline missed.
