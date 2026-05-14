# Changelog

A running record of kit-level changes. Sealed evaluations live in `evaluations/`; this file records what changed in the *system* (prompts, agents, runbooks, scoring) over time and why.

Dates use the project's wall-clock (UTC offset is not tracked).

## 2026-05-14 — Kit reorganization

A structural pass driven by a repo evaluation that flagged drift hazards, stale documentation, and a numbered-file naming scheme that misled new readers.

### Added

- `bin/install-agents.sh` — replaces the manual `cp claude-agents/*.md ~/.claude/agents/` with a script that supports `--dry-run` and `--project` and prints a per-file diff summary.
- `bin/verify-agents.sh` — diffs the installed agents against the kit source and exits non-zero on drift. The previous workflow had no way to detect drift; this was the demo-day failure mode the README itself worried about.
- `bin/precheck.sh` — single pre-flight that verifies Claude Code version, `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`, tmux state, agent drift, and `demo-output/` cleanliness. Optional `--clean` flag removes leftover output after confirmation.
- `CLAUDE.md` — project-level contract for Claude Code working in this repo (don't merge `experiment/*` into `main`, don't edit committed evaluations, etc.).
- `CHANGELOG.md` — this file.
- `evaluations/INDEX.md` — one-page rollup of every sealed evaluation, the branch it scored, and the outcome. Replaces the "open each file to see the trajectory" pattern.
- `prompts/_preflight.md` — single source of truth for the shared preflight block. Each team prompt references it instead of restating it.

### Reorganized

Numbered file prefixes removed; files moved into category directories. The numbers misled readers because the file order (01–13) did not match the recommended run order (clean-room → baseline → compact → eval). Old paths and their new homes:

| Old | New |
| :--- | :--- |
| `01-facilitator-runbook.md` | `runbooks/facilitator.md` |
| `02-master-agent-team-prompt.md` | `prompts/team-relay.md` |
| `03-single-agent-baseline-prompt.md` | `prompts/single-baseline.md` |
| `04-role-cards.md` | `reference/role-cards.md` |
| `05-scorecard.md` | `rubrics/scorecard.md` |
| `06-meeting-one-pager.md` | `reference/meeting-one-pager.md` |
| `07-team-debate-master-prompt.md` | `prompts/team-debate.md` |
| `08-single-agent-quick-prompt.md` | `prompts/single-quick.md` |
| `09-parallel-author-prompt.md` | `prompts/team-parallel-author.md` |
| `10-clean-room-experiment-runbook.md` | `runbooks/clean-room.md` |
| `11-evaluation-system.md` | `rubrics/evaluation-system.md` |
| `12-lean-agent-team-prompt.md` | `prompts/team-lean.md` |
| `13-four-role-agent-team-prompt.md` | `prompts/team-compact.md` |
| `agent-teams-meetup-deck.html` | `deck/agent-teams-meetup-deck.html` |

### Changed

- README is now a tour of *what ships* and *how to install*. The "current recommended workflow" was asserted in README, START_HERE, and the facilitator runbook; it now lives in START_HERE only, and the other two link there.
- Removed the stale "Note on file cleanup" block from README that told readers to delete two agent files (`content-designer-ux-writer.md`, `visual-ui-designer.md`) that had already been removed in a prior cleanup.
- Facilitator runbook now references `bin/precheck.sh` as the primary pre-flight, with the manual `find` command as a fallback.
- Clean-room runbook reorders the team-prompt options with `team-compact.md` first (the current default) instead of `team-relay.md` (the older pattern).
- Scorecard now points to `evaluation-system.md` for the improvement loop using the new repo-relative path.
- Deck (`deck/agent-teams-meetup-deck.html`) updated to v3+ in two passes:
  1. First pass aligned the UX-kit-specific slides: baseline-prompt and team-prompt slides now show the current `single-baseline.md` / `team-relay.md` content (clean-room rule, HTML artifact requirement, Creative Director role, required debates); prompt-anatomy slide reflects the 9-agent team; resources slide replaced the dead `agent-teams-meetup-plan.md` link with `START_HERE.md` and `bin/install-agents.sh`.
  2. Second pass — once the deck was named as reference material — rewrote the four remaining HealthPortal stage-demo slides (Setup, Cancellation Moment, mechanism, rubric) to use Northstar so the deck is internally consistent with the repo. Setup slide now walks the actual install workflow (`git clone` + fresh branch + `bin/install-agents.sh` + `bin/precheck.sh` + paste from `prompts/`). Cancellation Moment slide uses the Northstar entry SMS and trip-status screen as the two surfaces. Mechanism and rubric slides use Northstar-grounded examples. Title-slide speaker notes carry a "Reading this as a reference?" orientation block pointing at the canonical entry files.

### Earlier history (reconstructed)

Before this changelog existed, the kit went through several rounds the repo refers to as "v1," "v2," and "v3+":

- **v1:** Agent files shipped with read-only tool allowlists (`Read, Glob, Grep`). The team prompt asked agents to write files they couldn't actually write. Live demos failed silently.
- **v2:** Agent allowlists expanded to include `Write, Edit, Bash, TaskCreate, TaskUpdate, TaskGet, TaskList, SendMessage`. Team prompt produced a recommendation doc but not an HTML artifact. The single-agent baseline shipped only a doc, so visual-quality comparisons against the team were meaningless.
- **v3:** Baseline prompt rewritten to ship the same HTML artifact type as the team prompt. Creative Director role added. Sequence reordered so visual authors *before* audit specialists, not after. Quality bar ("distinctive over safe") added explicitly.
- **v3+:** Honest-framing pass. Scorecard and runbook stopped claiming "team output > single output" categorically. The "team wins on / single wins on" comparison became the centerpiece. Evaluation system grew from a single rubric into Layer 0 gates + Layer 1 outcome + Layer 2 decision + Layer 3 efficiency + Coordination Yield + metacognition checks. Compact champion-challenger prompt (`prompts/team-compact.md`) became the current default.

See `evaluations/INDEX.md` for the per-run trajectory.
