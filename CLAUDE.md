# CLAUDE.md

This file briefs Claude Code on how to work in this repo. Read it before making changes.

## What this repo is

A demo kit and improvement loop for Claude Code's agent-teams feature. The deliverables are:

- the agent definitions in `claude-agents/`
- the prompts in `prompts/`
- the runbooks in `runbooks/`
- the rubrics in `rubrics/`
- the templates in `templates/`
- the sealed evaluations in `evaluations/`

See [`START_HERE.md`](START_HERE.md) for the current recommended workflow. The README is an index of what ships; START_HERE is the source of truth for what to run.

## Working contract

**Never merge `experiment/*` branches into `main`.** Those branches are sealed evidence from individual runs. They contain `demo-output/` artifacts on purpose, and merging them pollutes `main` with run-specific HTML. Use `git log` and PR comparisons to inspect them; do not merge.

**Never edit committed evaluations under `evaluations/`.** Each one is a frozen record of one judgment. If a later run contradicts an earlier one, write a new evaluation; do not rewrite history.

**Treat agent definitions in `claude-agents/` as canonical.** The `.claude/agents/` directory (if present) is a local install copy. If you change `claude-agents/`, run `bin/install-agents.sh` to re-sync your local install. Use `bin/verify-agents.sh` to detect drift.

**Keep `demo-output/` clean on `main`.** The pre-flight check in `bin/precheck.sh` (and the runbooks) treats any file other than `.gitkeep` under `demo-output/` as contamination of the next clean-room run.

**The deck (`deck/`) lags the kit.** It is a self-contained HTML file and not all framing is current. If you change kit-level framing (which patterns the kit recommends, how scoring works, the "team wins on / single wins on" honest comparison), check whether the deck needs an update too.

## Run-time pre-flight

For any work that will spawn agents or run a demo:

- Run `bin/precheck.sh` before starting. It catches version mismatches, missing `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`, orphaned tmux sessions, agent drift, and dirty `demo-output/`.
- Run a *clean-room* experiment per [`runbooks/clean-room.md`](runbooks/clean-room.md) when comparing systems. Do not run baseline and team in the same checkout — the second run will see the first's output.

## Conventions

- Markdown links between files use repo-relative paths. From a subdirectory, use `../` to climb. Do not use absolute paths.
- Numbered file prefixes (`01-`, `02-`, …) were removed in the May 2026 reorganization. If a doc or commit references an old `NN-*.md` filename, update it to the current name (e.g., `02-master-agent-team-prompt.md` → `prompts/team-relay.md`). See `CHANGELOG.md` for the full rename table.
- Prompts are pasted directly into Claude Code by users. Keep the executable prompt body inside a fenced code block so it copies cleanly.

## When in doubt

Ask. The kit is opinionated about *how to evaluate agent teams honestly*; if a change risks softening that frame ("team always wins" pitches, hiding the visual-craft loss, dropping the clean-room rule), flag it before committing.
