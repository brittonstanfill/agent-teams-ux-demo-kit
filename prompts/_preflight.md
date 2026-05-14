# Shared preflight (referenced by team prompts)

This file is the single source of truth for the preflight checks every team prompt depends on. The team prompts in this directory paste an equivalent block into the prompt body so the user can copy/paste a self-contained prompt; this file is what they should stay aligned with.

If you change the preflight here, update each team prompt that restates it (`team-relay.md`, `team-debate.md`, `team-parallel-author.md`, `team-lean.md`, `team-compact.md`).

## Easiest path: one script

```bash
bin/precheck.sh
```

That checks:

- Claude Code version (`>= 2.1.32`)
- `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` is set
- tmux is installed and has no orphaned sessions
- Installed agents in `~/.claude/agents/` match the kit source (`bin/verify-agents.sh`)
- `demo-output/` is empty except for `.gitkeep`

If any check fails, the script exits non-zero and tells you what to fix.

## Manual equivalent

If you cannot run the script, confirm each of these by hand:

- `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` is set in env or `~/.claude/settings.json`.
- `teammateMode` is `"tmux"` in `~/.claude/settings.json`, OR this session was launched with `claude --teammate-mode tmux`, OR you are already inside a tmux session.
- `claude --version` reports `2.1.32` or later.
- `tmux ls` shows no orphaned sessions from prior runs (kill any first).
- `bin/verify-agents.sh` passes (agents in `~/.claude/agents/` match the kit source).
- `find demo-output -type f ! -name .gitkeep -print` prints nothing.

If any of the above is missing, stop and fix it before spawning the team.

## Clean-room rule (always copy into the prompt)

Every team prompt includes this clean-room rule. Keep it identical across prompts:

```text
Clean-room rule:
- Do not open, search, summarize, or reuse anything in `demo-output/` except to create the deliverables for this run.
- Do not inspect prior demo branches, PR #2, single-agent output branches, evaluation reports, screenshots, or any past Northstar outputs before the team deliverables are sealed.
- If `demo-output/` already contains generated outputs, stop and ask the facilitator to start from a fresh clone or clean branch.
- The lead may read the baseline only after both the team deliverables and baseline deliverables are complete, when scoring begins.
```

## Why the prompts restate this instead of including by reference

Claude Code prompts are pasted directly into a session. There is no include mechanism that resolves at paste time. The team prompts therefore restate the preflight inline so the user can copy/paste a complete prompt. This file is the canonical version; the prompts should match it. The `SHARED PREFLIGHT` marker in each team prompt points back here.
