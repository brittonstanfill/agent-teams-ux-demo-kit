# Agent Teams UX Demo Kit

A meeting-ready kit for showing — and actually using — Claude Code's agent-teams feature with a team of specialist UX agents.

The kit ships:

- **8 Claude Code subagents** representing distinct UX disciplines (researcher, IA, interaction, content, visual, accessibility, behavioral scientist, devil's advocate). Each is an opinionated, named specialist with an artifact spec and stances for debating teammates.
- **A structured team-debate prompt** (4-round, with a lightweight variant) for using those agents as a coordinated team on a real product decision.
- **A demo scenario** (Northstar Air canceled flight recovery) so you can run the team live in a meeting and compare its output against a single-agent baseline.

## Demo concept

**Lens Relay:** give a team one flawed product experience, assign each teammate a UX lens, force them to exchange findings, then compare the team output against a single-agent baseline.

The demo problem is a canceled-flight recovery flow for a fictional airline, Northstar Air. Familiar enough for everyone to understand, complex enough that research, IA, interaction, content, accessibility, visual design, and behavioral science all matter.

## Why this works for agent teams

- The roles work in parallel without editing the same file
- The roles need to talk to each other, not just report to the lead
- The final answer requires tradeoffs: speed, clarity, accessibility, business pressure, emotional state, trust
- The team output can be measured against a single-agent baseline

---

## What's in the box

### Prompts and runbooks

| File | What it is |
| :--- | :--- |
| `01-facilitator-runbook.md` | Live demo script and timing |
| `02-master-agent-team-prompt.md` | Original demo prompt for the Northstar scenario |
| `03-single-agent-baseline-prompt.md` | Baseline prompt for direct comparison |
| `04-role-cards.md` | Human-readable role briefs |
| `05-scorecard.md` | Measurement rubric for team vs non-team output |
| `06-meeting-one-pager.md` | Concise shareable explanation for the meeting |
| `07-team-debate-master-prompt.md` | **General-purpose 4-round team debate prompt** — use this for real product decisions beyond the demo |

### The 8 agents (in `claude-agents/`)

| Agent | Discipline / training | Role in a team debate |
| :--- | :--- | :--- |
| `ux-researcher.md` | Cognitive psychology / HCI | "What do users actually do? Where's the evidence?" |
| `information-architect.md` | Library / information science | "Where should this live? What do we call it?" |
| `interaction-designer.md` | HCI | "What are all the states? What happens when it fails?" |
| `content-designer.md` | Linguistics / journalism / UX writing | "Cut the copy. The verb is wrong. The tone is off." |
| `accessibility-specialist.md` | CPACC / WAS / disability studies | "Walk this with a keyboard. Walk it with VoiceOver." |
| `visual-designer.md` | Graphic / communication design | "The hierarchy is muddy. The grid is broken. It feels cheap." |
| `behavioral-scientist.md` | Cognitive psychology / behavioral economics | "Will they actually do this? And keep doing it? Ethically?" |
| `devils-advocate.md` | Red teaming / structured analytic techniques | Steel-mans the consensus, runs the pre-mortem, names the biases |

### Supporting

- `demo-inputs/northstar-canceled-flight-brief.md` — the artifact the agents review
- `templates/` — optional role-report and final-recommendation templates
- `demo-output/` — sample outputs from past runs

---

## Install the agents

You have two options. Pick one.

### Option A — Global (recommended for personal use)

Available in every project on your machine.

```bash
mkdir -p ~/.claude/agents
cp claude-agents/*.md ~/.claude/agents/
```

Then in Claude Code, run `/agents` to verify they loaded, or restart your session.

### Option B — Project-scoped

Available only inside this project (and checkable into version control with the project).

```bash
mkdir -p .claude/agents
cp claude-agents/*.md .claude/agents/
```

Restart your Claude Code session in this project.

---

## Run the demo (live meeting flow)

1. Open [`demo-inputs/northstar-canceled-flight-brief.md`](demo-inputs/northstar-canceled-flight-brief.md).
2. Run [`03-single-agent-baseline-prompt.md`](03-single-agent-baseline-prompt.md) first if you want a direct comparison.
3. Run [`02-master-agent-team-prompt.md`](02-master-agent-team-prompt.md) and point it at the brief.
4. Show the team messages, role-owned files, conflict resolution, and final recommendation.
5. Score both outputs with [`05-scorecard.md`](05-scorecard.md).

For a deeper, debate-style run (recommended once the demo proves the concept), use [`07-team-debate-master-prompt.md`](07-team-debate-master-prompt.md) instead of `02-`. The 4-round structure forces the team into independent positions → cross-examination → steelman/revise → lead synthesis, with devil's advocate running an inline pre-mortem.

---

## Use the team for real product decisions

The kit isn't just for demos. For real decisions:

**Quick path — single specialist.** When you just need one lens (e.g., "review this copy" or "audit this for accessibility"), invoke a single agent by name. No team needed.

**Phased path — sequence specialists.** For larger work, invoke 2–3 agents per phase:
- **Discovery:** `ux-researcher` + `behavioral-scientist`
- **Structure:** `information-architect` + `interaction-designer`
- **Surface:** `content-designer` + `visual-designer`
- **Pre-ship:** `accessibility-specialist` + `ux-researcher`

**Full debate — when stakes warrant it.** Use [`07-team-debate-master-prompt.md`](07-team-debate-master-prompt.md). Spawns 3–4 specialists + devil's advocate in tmux split-pane mode, runs the 4-round structure, and ends with a synthesis memo plus a decision table.

---

## Pre-flight for the team debate

Agent teams have specific requirements. Before running `07-`:

- Claude Code v2.1.32 or later (`claude --version`)
- `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` set (env or `settings.json`)
- `teammateMode` set to `"tmux"` in `~/.claude/settings.json`, OR launch with `claude --teammate-mode tmux`, OR already inside a tmux session
- No orphaned tmux sessions (`tmux ls` clean; `tmux kill-server` if needed)

The prompt itself starts with a pre-flight check that gates on the above.

---

## Notes on the agent files

The agent files in `claude-agents/` use the YAML-frontmatter format documented in Claude Code's [sub-agents docs](https://code.claude.com/docs/en/sub-agents). Each has:

- A `description` field that controls when Claude delegates to it (these are written for explicit invocation, not aggressive auto-firing)
- A `tools` allowlist (most are read-only review agents)
- A `model: inherit` (uses whatever model your main session is on)
- A `color` for visual distinguishing in the UI
- A body covering identity, methods, output format, boundaries, artifacts, and how the agent should disagree with other teammates

Agents are designed to **defer to each other** where their disciplines overlap, so when you invoke two together they collaborate rather than duplicate.

> **Note on file cleanup:** The kit originally shipped with two skeleton agent files (`content-designer-ux-writer.md`, `visual-ui-designer.md`). They've been superseded by the richer `content-designer.md` and `visual-designer.md` and can be safely removed:
>
> ```bash
> rm claude-agents/content-designer-ux-writer.md claude-agents/visual-ui-designer.md
> ```

---

## Sources and grounding

This kit follows the current Claude Code docs. Agent teams are experimental, use separate Claude Code sessions, include a shared task list, support direct teammate messaging, and cost more than single-session work. The docs recommend teams for parallel exploration, peer challenge, or cross-layer coordination. Subagents are better for focused side tasks that report back to the main session.

- [Agent teams](https://code.claude.com/docs/en/agent-teams)
- [Sub-agents](https://code.claude.com/docs/en/sub-agents)
- [Agents (overview)](https://code.claude.com/docs/en/agents)

---

## License

MIT — see [LICENSE](LICENSE).
