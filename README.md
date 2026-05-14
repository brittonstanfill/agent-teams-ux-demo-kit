# Agent Teams UX Demo Kit

A meeting-ready kit for showing — and actually using — Claude Code's agent-teams feature with a team of specialist UX agents.

**New here? Start with [`START_HERE.md`](START_HERE.md).** It is the single source of truth for the *current recommended workflow*, where to review the latest sealed output, and why several experiment branches are intentionally left unmerged.

This README is a tour of *what ships in the kit* and *how to install it*. For *what to run first*, follow `START_HERE.md`.

The kit ships:

- **9 Claude Code subagents** representing distinct UX disciplines plus a Creative Director (researcher, IA, interaction, content, visual, accessibility, behavioral scientist, devil's advocate, creative director). Each is an opinionated, named specialist with an artifact spec and stances for debating teammates.
- **Three team patterns:** *relay-with-debate* (for synthesis-shaped artifacts), *parallel-author* (for composition-shaped artifacts), and the current compact champion-challenger path that creates two early full artifacts before synthesis. The right one depends on what you're making.
- **A demo scenario** (Northstar Air canceled flight recovery) so you can run the team live in a meeting and compare its output against a single-agent baseline that *ships the same artifact type* — so the comparison is honest.
- **Scripts** in `bin/` for installing the agents, verifying they haven't drifted, and pre-flighting a run.

## Demo concept

**Lens Relay (or Parallel Author):** give a team one flawed product experience, assign each teammate a UX lens, force them to exchange findings or to author independently, then compare the team output against a single-agent baseline.

The demo problem is a canceled-flight recovery flow for a fictional airline, Northstar Air. Familiar enough for everyone to understand, complex enough that research, IA, interaction, content, accessibility, visual design, and behavioral science all matter.

## Honest framing

The earlier version of this kit pitched "team output > single output." That is true on some dimensions and false on others. v3+ of the kit is upfront about both:

- **Agent teams win on:** specialist-cited audits (WCAG by criterion, behavioral mechanisms by name), risk surface, visible tradeoff reasoning, dark-pattern detection, decision durability under stakeholder review.
- **Single agents win on:** visual composition, narrative coherence, distinctive aesthetic, time-to-useful-draft.

A good demo names both. The scorecard in [`rubrics/scorecard.md`](rubrics/scorecard.md) is built around the "team wins on / single wins on" comparison so the audience leaves with a *how to choose between the patterns*, not a victory lap.

## Why this works for agent teams (when it works)

- The roles work in parallel without editing the same file.
- The roles need to talk to each other, not just report to the lead.
- The final answer requires tradeoffs: speed, clarity, accessibility, business pressure, emotional state, trust.
- The team output can be measured against a single-agent baseline shipping the same artifact type.
- A single surface owner, Creative Director, or champion-challenger selection step holds the cross-discipline vision so the team's output does not flatten into committee-safe consensus.

---

## Repo layout

```
README.md              You are here — what's in the kit, how to install
START_HERE.md          Current recommended workflow; canonical run order
CHANGELOG.md           Kit-level changes over time
CLAUDE.md              Contract for Claude Code when working in this repo

bin/                   Scripts: install-agents, verify-agents, precheck
claude-agents/         Source-of-truth agent definitions (9 files)
prompts/               Team-team and single-agent prompts
runbooks/              Live-demo and clean-room run protocols
rubrics/               Scorecard (live-demo) and evaluation system (improvement loop)
reference/             Role cards and meeting one-pager
templates/             Templates the prompts and eval system reference
deck/                  Slide deck for an in-person talk

demo-inputs/           The Northstar canceled-flight brief
demo-output/           Workspace for generated outputs (clean per run)
evaluations/           Sealed evaluation reports (INDEX.md is the trajectory)
```

## What's in the box

### Prompts (`prompts/`)

| File | What it is |
| :--- | :--- |
| [`prompts/team-compact.md`](prompts/team-compact.md) | **Compact team prompt** (current default) — IA, Visual, A11y, Behavioral, with two early competing artifacts and a lead-run red-team checklist |
| [`prompts/team-lean.md`](prompts/team-lean.md) | **Lean team prompt** — tests whether fewer specialists can preserve artifact quality with lower overhead |
| [`prompts/team-relay.md`](prompts/team-relay.md) | **Relay-with-debate prompt** for the Northstar scenario. Bakes in required debate rounds; ships HTML + doc. |
| [`prompts/team-parallel-author.md`](prompts/team-parallel-author.md) | **Parallel-author team prompt** — use when authorship matters more than peer-challenge (visual composition, distinctive aesthetic). Produces 2–3 distinct authored drafts; team picks a winner. |
| [`prompts/team-debate.md`](prompts/team-debate.md) | **General-purpose 4-round team debate prompt** — use this for real product decisions beyond the demo |
| [`prompts/single-baseline.md`](prompts/single-baseline.md) | Baseline prompt — ships HTML, not just a doc, so the comparison is honest |
| [`prompts/single-quick.md`](prompts/single-quick.md) | **3-line single-agent prompt** — for the 80% of moments where you just need one specialist, not a team |
| [`prompts/_preflight.md`](prompts/_preflight.md) | Shared preflight checks referenced by every team prompt |

### Runbooks (`runbooks/`)

| File | What it is |
| :--- | :--- |
| [`runbooks/facilitator.md`](runbooks/facilitator.md) | Live demo script and timing — names where the team wins and where it loses |
| [`runbooks/clean-room.md`](runbooks/clean-room.md) | Evaluation protocol — fresh clone/branch, no prior output contamination, sealed baseline/team outputs, scorecard, and promotion rules |

### Rubrics (`rubrics/`)

| File | What it is |
| :--- | :--- |
| [`rubrics/scorecard.md`](rubrics/scorecard.md) | Quick live-demo scorecard — includes the "team wins on / single wins on" honest comparison |
| [`rubrics/evaluation-system.md`](rubrics/evaluation-system.md) | Improvement-loop evaluator — gates, split visual/interaction/robustness scoring, candidate-selection scoring, coordination yield, and metacognition checks |

### Reference (`reference/`)

| File | What it is |
| :--- | :--- |
| [`reference/role-cards.md`](reference/role-cards.md) | Human-readable role briefs (author + audit framing) |
| [`reference/meeting-one-pager.md`](reference/meeting-one-pager.md) | Concise shareable explanation for the meeting |

### Scripts (`bin/`)

| File | What it is |
| :--- | :--- |
| [`bin/install-agents.sh`](bin/install-agents.sh) | Sync `claude-agents/*.md` into `~/.claude/agents/` (or `.claude/agents/` with `--project`). Supports `--dry-run`. |
| [`bin/verify-agents.sh`](bin/verify-agents.sh) | Diff the installed agents against the kit source. Exits non-zero on drift. |
| [`bin/precheck.sh`](bin/precheck.sh) | Pre-flight: version, experimental flag, tmux, agent drift, demo-output cleanliness. `--clean` removes leftover output. |

### Other

| File | What it is |
| :--- | :--- |
| [`deck/agent-teams-meetup-deck.html`](deck/agent-teams-meetup-deck.html) | Self-contained HTML talk deck (17 slides, ~20 min). Open in any browser; arrow keys to navigate; `N` for speaker notes; `F` for fullscreen |

### The 9 agents (in `claude-agents/`)

| Agent | Discipline / training | Role in a team debate |
| :--- | :--- | :--- |
| `creative-director.md` | Cross-discipline design leadership | **Holds the aesthetic anchor against committee flattening.** "Is this the version you'd put in your portfolio? No? Then it's not the version we ship." |
| `ux-researcher.md` | Cognitive psychology / HCI | "What do users actually do? Where's the evidence?" |
| `information-architect.md` | Library / information science | "Where should this live? What do we call it?" |
| `interaction-designer.md` | HCI | "What are all the states? What happens when it fails?" |
| `content-designer.md` | Linguistics / journalism / UX writing | "Cut the copy. The verb is wrong. The tone is off." |
| `accessibility-specialist.md` | CPACC / WAS / disability studies | "Walk this with a keyboard. Walk it with VoiceOver." |
| `visual-designer.md` | Graphic / communication design | "I author the surface. I do not retreat to 'redline someone else's draft' mode when the work needs authorship." |
| `behavioral-scientist.md` | Cognitive psychology / behavioral economics | "Will they actually do this? And keep doing it? Ethically?" |
| `devils-advocate.md` | Red teaming / structured analytic techniques | Steel-mans the consensus, runs the pre-mortem, names the biases |

The current agents use a live-demo-safe tool allowlist: `Read, Glob, Grep, Write, Edit, Bash, WebSearch, WebFetch, TaskCreate, TaskUpdate, TaskGet, TaskList, SendMessage`. That lets teammates write role reports, edit artifacts, run checks, coordinate tasks, and message each other. If you previously copied an older version of this kit into `~/.claude/agents/`, run `bin/verify-agents.sh` to confirm nothing has drifted, then `bin/install-agents.sh` if it has.

### Supporting

- [`demo-inputs/northstar-canceled-flight-brief.md`](demo-inputs/northstar-canceled-flight-brief.md) — the artifact the agents review
- [`templates/`](templates/) — role-report, final-recommendation, evaluation-report, llm-judge, metacognition, and process-appendix templates referenced by the prompts and rubrics
- [`demo-output/`](demo-output/) — empty workspace for generated outputs on `main`; sealed run outputs live on experiment branches
- [`evaluations/INDEX.md`](evaluations/INDEX.md) — the trajectory of the improvement loop: every run → branch → top-line score → outcome

#### A worked example

[PR #2 — Demo run output: Northstar canceled-flight recovery](https://github.com/brittonstanfill/agent-teams-ux-demo-kit/pull/2) is a **review-only, do-not-merge** PR that captures one full team run. It includes the final recommendation, all seven role reports, 38 peer-message files documenting the cross-agent handoffs, and a single-agent comparison baseline. Open it to see what a real run produces before you commit to running one yourself.

---

## Install the agents

Use the install script. It overwrites kit-owned filenames in the target directory but doesn't touch unrelated files.

### Option A — Global (recommended for personal use)

Available in every project on your machine.

```bash
bin/install-agents.sh             # installs to ~/.claude/agents/
bin/install-agents.sh --dry-run   # see what would change
bin/verify-agents.sh              # confirm no drift afterwards
```

Then in Claude Code, run `/agents` to verify they loaded, or restart your session.

### Option B — Project-scoped

Available only inside this project (and checkable into version control with the project).

```bash
bin/install-agents.sh --project   # installs to ./.claude/agents/
bin/verify-agents.sh --project    # verify
```

Restart your Claude Code session in this project.

> The previous install instructions used a manual `cp claude-agents/*.md ~/.claude/agents/`. That still works but offers no drift detection — when the kit updated an agent's tool allowlist, your local copy silently fell behind. The scripts above replace that pattern.

---

## Run the demo (live meeting flow)

`START_HERE.md` names *which prompt to use today*. The runbooks describe *how to run them*.

1. Open [`demo-inputs/northstar-canceled-flight-brief.md`](demo-inputs/northstar-canceled-flight-brief.md).
2. For a serious evaluation, follow [`runbooks/clean-room.md`](runbooks/clean-room.md): fresh checkouts, no contamination, sealed outputs.
3. For the live-meeting timing script, follow [`runbooks/facilitator.md`](runbooks/facilitator.md).
4. Score both outputs with [`rubrics/scorecard.md`](rubrics/scorecard.md). For improvement-loop decisions, use [`rubrics/evaluation-system.md`](rubrics/evaluation-system.md) plus [`templates/evaluation-report-template.md`](templates/evaluation-report-template.md).

The compact team in [`prompts/team-compact.md`](prompts/team-compact.md) is the current default. Other team prompts in `prompts/` exist for intentional comparison — `START_HERE.md` will tell you when to reach for them.

---

## Use the team for real product decisions

The kit isn't just for demos. For real decisions:

**Quick path — single specialist.** When you just need one lens (e.g., "review this copy" or "audit this for accessibility"), invoke a single agent by name. Use [`prompts/single-quick.md`](prompts/single-quick.md) for a copy-paste 3-line template plus 8 worked examples.

**Phased path — sequence specialists.** For larger work, invoke 2–3 agents per phase:
- **Discovery:** `ux-researcher` + `behavioral-scientist`
- **Structure:** `information-architect` + `interaction-designer`
- **Surface:** `content-designer` + `visual-designer`
- **Pre-ship:** `accessibility-specialist` + `ux-researcher`

**Full debate — when stakes warrant it.** Use [`prompts/team-debate.md`](prompts/team-debate.md). Spawns 3–4 specialists + devil's advocate in tmux split-pane mode, runs the 4-round structure, and ends with a synthesis memo plus a decision table.

---

## Pre-flight

Agent teams have specific requirements. The easiest way to confirm everything is in place:

```bash
bin/precheck.sh
```

That verifies: Claude Code version, `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`, tmux state, agent drift, and demo-output cleanliness. Use `bin/precheck.sh --clean` to also remove leftover output from a prior run (with confirmation).

Manually, the requirements are:

- Claude Code v2.1.32 or later (`claude --version`)
- `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` set (env or `settings.json`)
- `teammateMode` set to `"tmux"` in `~/.claude/settings.json`, OR launch with `claude --teammate-mode tmux`, OR already inside a tmux session
- No orphaned tmux sessions (`tmux ls` clean; `tmux kill-server` if needed)

The team-debate prompt itself starts with a pre-flight check that gates on the above.

---

## Notes on the agent files

The agent files in `claude-agents/` use the YAML-frontmatter format documented in Claude Code's [sub-agents docs](https://code.claude.com/docs/en/sub-agents). Each has:

- A `description` field that controls when Claude delegates to it (these are written for explicit invocation, not aggressive auto-firing)
- A `tools` allowlist (every role has the tools it needs to author, audit, and message peers)
- A `model: inherit` (uses whatever model your main session is on)
- A `color` for visual distinguishing in the UI
- A body covering identity, methods, output format, boundaries, artifacts, and how the agent should disagree with other teammates

Agents are designed to **defer to each other** where their disciplines overlap, so when you invoke two together they collaborate rather than duplicate.

---

## Sources and grounding

This kit follows the current Claude Code docs. Agent teams are experimental, use separate Claude Code sessions, include a shared task list, support direct teammate messaging, and cost more than single-session work. The docs recommend teams for parallel exploration, peer challenge, or cross-layer coordination. Subagents are better for focused side tasks that report back to the main session.

- [Agent teams](https://code.claude.com/docs/en/agent-teams)
- [Sub-agents](https://code.claude.com/docs/en/sub-agents)
- [Agents (overview)](https://code.claude.com/docs/en/agents)
- [Run parallel sessions with worktrees](https://code.claude.com/docs/en/worktrees)
- [How we built our multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system)
- [Building effective agents](https://www.anthropic.com/engineering/building-effective-agents)

---

## License

MIT — see [LICENSE](LICENSE).
