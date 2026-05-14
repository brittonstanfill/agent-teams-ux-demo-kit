# Agent Teams UX Demo Kit

A meeting-ready kit for showing — and actually using — Claude Code's agent-teams feature with a team of specialist UX agents.

The kit ships:

- **9 Claude Code subagents** representing distinct UX disciplines plus a Creative Director (researcher, IA, interaction, content, visual, accessibility, behavioral scientist, devil's advocate, creative director). Each is an opinionated, named specialist with an artifact spec and stances for debating teammates.
- **Two team patterns:** *relay-with-debate* (for synthesis-shaped artifacts) and *parallel-author* (for composition-shaped artifacts). Both ship in the kit; the right one depends on what you're making.
- **A demo scenario** (Northstar Air canceled flight recovery) so you can run the team live in a meeting and compare its output against a single-agent baseline that *ships the same artifact type* — so the comparison is honest.

## Demo concept

**Lens Relay (or Parallel Author):** give a team one flawed product experience, assign each teammate a UX lens, force them to exchange findings or to author independently, then compare the team output against a single-agent baseline.

The demo problem is a canceled-flight recovery flow for a fictional airline, Northstar Air. Familiar enough for everyone to understand, complex enough that research, IA, interaction, content, accessibility, visual design, and behavioral science all matter.

## Honest framing

The earlier version of this kit pitched "team output > single output." That is true on some dimensions and false on others. v3+ of the kit is upfront about both:

- **Agent teams win on:** specialist-cited audits (WCAG by criterion, behavioral mechanisms by name), risk surface, visible tradeoff reasoning, dark-pattern detection, decision durability under stakeholder review.
- **Single agents win on:** visual composition, narrative coherence, distinctive aesthetic, time-to-useful-draft.

A good demo names both. The scorecard in `05-scorecard.md` is built around the "team wins on / single wins on" comparison so the audience leaves with a *how to choose between the patterns*, not a victory lap.

## Why this works for agent teams (when it works)

- The roles work in parallel without editing the same file.
- The roles need to talk to each other, not just report to the lead.
- The final answer requires tradeoffs: speed, clarity, accessibility, business pressure, emotional state, trust.
- The team output can be measured against a single-agent baseline shipping the same artifact type.
- The Creative Director holds the cross-discipline vision so the team's output doesn't flatten into committee-safe consensus.

---

## What's in the box

### Prompts and runbooks

| File | What it is |
| :--- | :--- |
| `01-facilitator-runbook.md` | Live demo script and timing — names where the team wins and where it loses |
| `02-master-agent-team-prompt.md` | Relay-with-debate prompt for the Northstar scenario. Bakes in required debate rounds; ships HTML + doc. |
| `03-single-agent-baseline-prompt.md` | Baseline prompt — now ships HTML, not just a doc, so the comparison is honest |
| `04-role-cards.md` | Human-readable role briefs (author + audit framing) |
| `05-scorecard.md` | Measurement rubric — includes the "team wins on / single wins on" honest comparison |
| `06-meeting-one-pager.md` | Concise shareable explanation for the meeting |
| `07-team-debate-master-prompt.md` | **General-purpose 4-round team debate prompt** — use this for real product decisions beyond the demo |
| `08-single-agent-quick-prompt.md` | **3-line single-agent prompt** — for the 80% of moments where you just need one specialist, not a team |
| `09-parallel-author-prompt.md` | **Parallel-author team prompt** — use when authorship matters more than peer-challenge (visual composition, distinctive aesthetic). Produces 2–3 distinct authored drafts; team picks a winner. |
| `10-clean-room-experiment-runbook.md` | **Evaluation protocol** — fresh clone/branch, no prior output contamination, sealed baseline/team outputs, scorecard, and promotion rules |
| `agent-teams-meetup-deck.html` | Self-contained HTML talk deck (17 slides, ~20 min). Open in any browser; arrow keys to navigate; `N` for speaker notes; `F` for fullscreen |

### The 9 agents (in `claude-agents/`)

| Agent | Discipline / training | Role in a team debate |
| :--- | :--- | :--- |
| `creative-director.md` | Cross-discipline design leadership | **Holds the aesthetic anchor against committee flattening. New in v3+.** "Is this the version you'd put in your portfolio? No? Then it's not the version we ship." |
| `ux-researcher.md` | Cognitive psychology / HCI | "What do users actually do? Where's the evidence?" |
| `information-architect.md` | Library / information science | "Where should this live? What do we call it?" |
| `interaction-designer.md` | HCI | "What are all the states? What happens when it fails?" |
| `content-designer.md` | Linguistics / journalism / UX writing | "Cut the copy. The verb is wrong. The tone is off." |
| `accessibility-specialist.md` | CPACC / WAS / disability studies | "Walk this with a keyboard. Walk it with VoiceOver." |
| `visual-designer.md` | Graphic / communication design | "I author the surface. I do not retreat to 'redline someone else's draft' mode when the work needs authorship." |
| `behavioral-scientist.md` | Cognitive psychology / behavioral economics | "Will they actually do this? And keep doing it? Ethically?" |
| `devils-advocate.md` | Red teaming / structured analytic techniques | Steel-mans the consensus, runs the pre-mortem, names the biases |

**Important kit note (v3+):** earlier versions of this kit shipped the role agents with read-only tool permissions (`Read, Glob, Grep`), which meant they couldn't actually write the files they were asked to author. v3+ grants `Write, Edit, Bash, TaskCreate, TaskUpdate, TaskGet, TaskList, SendMessage` so team coordination and authoring actually work. The role-card framing also shifted from "Looks for" (review-only) to "Authors + audits" (authoring-first), and the visual-designer's identity changed from a reviewer with permission to write to an author whose audit is a sub-skill. If you copied the agents into `~/.claude/agents/` from an older version of this kit, re-copy them.

### Supporting

- `demo-inputs/northstar-canceled-flight-brief.md` — the artifact the agents review
- `templates/` — optional role-report and final-recommendation templates
- `demo-output/` — sample outputs from past runs

#### A worked example

[PR #2 — Demo run output: Northstar canceled-flight recovery](https://github.com/brittonstanfill/agent-teams-ux-demo-kit/pull/2) is a **review-only, do-not-merge** PR that captures one full team run. It includes the final recommendation, all seven role reports, 38 peer-message files documenting the cross-agent handoffs, and a single-agent comparison baseline. Open it to see what a real run produces before you commit to running one yourself.

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
2. Run [`03-single-agent-baseline-prompt.md`](03-single-agent-baseline-prompt.md) first if you want a direct comparison. For a serious evaluation, follow [`10-clean-room-experiment-runbook.md`](10-clean-room-experiment-runbook.md) so the baseline and team run do not see past outputs.
3. Run [`02-master-agent-team-prompt.md`](02-master-agent-team-prompt.md) and point it at the brief.
4. Show the team messages, role-owned files, conflict resolution, and final recommendation.
5. Score both outputs with [`05-scorecard.md`](05-scorecard.md).

For a deeper, debate-style run (recommended once the demo proves the concept), use [`07-team-debate-master-prompt.md`](07-team-debate-master-prompt.md) instead of `02-`. The 4-round structure forces the team into independent positions → cross-examination → steelman/revise → lead synthesis, with devil's advocate running an inline pre-mortem.

---

## Use the team for real product decisions

The kit isn't just for demos. For real decisions:

**Quick path — single specialist.** When you just need one lens (e.g., "review this copy" or "audit this for accessibility"), invoke a single agent by name. Use [`08-single-agent-quick-prompt.md`](08-single-agent-quick-prompt.md) for a copy-paste 3-line template plus 8 worked examples.

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
- [Run parallel sessions with worktrees](https://code.claude.com/docs/en/worktrees)
- [How we built our multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system)
- [Building effective agents](https://www.anthropic.com/engineering/building-effective-agents)

---

## License

MIT — see [LICENSE](LICENSE).
