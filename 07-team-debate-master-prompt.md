# Master Prompt: UX Team Debate (4-round, structured)

A general-purpose prompt for running a structured multi-specialist UX debate using Claude Code's agent-teams feature. Use this when the team needs to converge on a design decision and you want real friction in the process — not just a single agent's answer.

This prompt is intentionally heavier than `02-master-agent-team-prompt.md` (the Northstar demo prompt). Use this one for real product decisions where the cost of being wrong justifies the cost of running the team.

---

## When to use this prompt

- A redesign or feature direction where multiple disciplines need to weigh in
- A decision where two specialists have agreed too quickly and you suspect a shared blind spot
- Any moment where "let's just ship it" is happening before the alternatives have been argued
- High-stakes or hard-to-reverse choices (architectural, brand, accessibility commitments, behavior-change interventions)

## When NOT to use this prompt

- Small, reversible decisions — use a single specialist agent instead
- Open exploration / brainstorming — adversarial energy kills early ideas
- When you have not yet packaged the decision being made into one clear sentence
- When the team has only one viable option and you're using the debate to perform consensus

---

## Pre-flight (confirm before spawning)

- `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` is set in `settings.json` or env
- `teammateMode` is `"tmux"` in `~/.claude/settings.json`, OR this session was launched with `claude --teammate-mode tmux`, OR you are already inside a tmux session
- `claude --version` is `2.1.32` or later
- `tmux ls` shows no orphaned sessions from prior runs (kill any first)

If any of the above is missing, stop and tell the user before continuing.

---

## The prompt

Copy from here. Adapt the bracketed sections to your specific decision.

```text
Use the Claude Code agent teams feature in TMUX SPLIT-PANE display mode for this work.

PRE-FLIGHT (confirm before spawning)
- CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 is set in settings.json or env
- teammateMode is "tmux" in ~/.claude/settings.json, OR this session was launched with
  `claude --teammate-mode tmux`, OR we are already inside a tmux session
- claude --version is 2.1.32 or later
- tmux ls shows no orphaned sessions from prior runs (kill any first)
If any of the above is missing, stop and tell me before continuing.

MODE
Default mode: FULL (4 rounds, 4 teammates).
Use LIGHTWEIGHT mode (2 rounds, 3 teammates, no Round 2 cross-exam) when the decision
is reversible, low-stakes, or the team has already done discovery work elsewhere.
Ask me which mode if unclear.

TEAM SHAPE
Spawn one lead (this session) plus 3-4 teammates, each in its own tmux pane, drawn from
the subagent library at ~/.claude/agents/. Pick the slate based on decision type:

  - Discovery / strategy: ux-researcher, behavioral-scientist, devils-advocate, +1
  - Structure / flow:     information-architect, interaction-designer, devils-advocate, +1
  - Surface / craft:      content-designer, visual-designer, devils-advocate, +1
  - Pre-ship validation:  accessibility-specialist, ux-researcher, devils-advocate, +1
  - Mixed / unclear:      ask me to confirm the slate

Spawn each teammate by referencing the subagent type so its system prompt loads as
additional instructions (per agent-teams docs). Use the agent's defined name as the
pane label so I can address it with Shift+Down or by clicking.

CONTEXT PACKAGE (include in every spawn prompt — non-negotiable)
- The decision being made, in one sentence
- Artifact under review (paths, links, or pasted content)
- Current state and constraints
- Success criteria — what "good" looks like
- What's out of scope for this debate
- Who the user is, in concrete terms
- What's been tried or considered before
- File ownership: who owns which artifact, who is read-only

EXECUTION MODEL
One task per teammate per round on the shared task list. Round N tasks depend on Round
N-1 tasks for the same teammate. Lead waits for ALL teammates to complete a round before
unblocking the next. Lead does not implement during teammate work — its job is steering
and synthesis.

ROUND-COMPLETION CRITERIA (anti-premature-done guard)
For each round, a teammate's task is complete only when:
- The named artifact for that round exists in full (no stubs, no "TBD")
- Every required field per the artifact spec is filled
- The teammate has marked the task done AND posted a one-line completion summary to the lead
The lead verifies before unblocking the next round. Reject incomplete work; do not advance.

ROUND 1 — Independent positions (parallel, NO cross-talk)
Each teammate writes a short position. Use the artifact format from their own
~/.claude/agents/ definition.
Required fields: recommended direction, top 3 claims, evidence, load-bearing assumptions,
risk if wrong.
The devils-advocate teammate runs DIFFERENTLY in Round 1: instead of taking a position,
it produces an "assumption inventory" — the load-bearing assumptions every other teammate
is implicitly making. No attacks yet.
No mailbox messages this round. No reading other teammates' work.
Done when each teammate's position file exists and is summarized to the lead.

ROUND 2 — Cross-examination (parallel, via mailbox, BOUNDED)
Each non-adversarial teammate sends direct messages to exactly two other teammates with
substantive challenges. Constraints:
- One paragraph per challenge (≤120 words)
- Each teammate may post one reply per challenge received (≤120 words). No third turn.
- No nested threading. No new challenges spawned from replies.
- Style preferences are out of scope; reject and re-route.
- Allowed challenge dimensions: evidence, user risk, accessibility, trust, feasibility,
  excluded users, falsifiability.
The devils-advocate teammate observes Round 2 but does not participate — it is reading
the cross-exam to inform Round 3.
Done when challenges and replies for all assigned pairs exist and are summarized to lead.

ROUND 3 — Steelman, revise, and pre-mortem (parallel)
Each non-adversarial teammate must:
1. Steelman the strongest opposing argument against their own recommendation in good faith
2. Either revise their position or defend it with a sharper case
The devils-advocate teammate now runs its FULL pre-mortem on the emerging consensus:
   steel-man / failure modes (≥5) / bias audit / excluded-user note / falsification asks /
   honest concessions. (Per its system prompt.)
Plan approval required before any teammate finalizes a revision that materially changes
direction. Reject revisions that drop accessibility commitments or that have no way to be
falsified.
Done when each teammate's revised position and devils-advocate's red-team memo exist.

ROUND 4 — Lead synthesis (lead only)
Lead waits for all Round 3 tasks to be marked complete and verified, then writes a
decision memo with these sections IN THIS ORDER:
1. WHAT CHANGED because teammates debated (specifically — if nothing changed, the team was wasted)
2. Final recommendation
3. Decisions accepted (and from whom)
4. Alternatives rejected (and why, briefly)
5. Unresolved dissent — preserved, not flattened into false consensus
6. Top 3 failure modes from devils-advocate that we are accepting, with what we'll watch
7. One falsifiable experiment to test the decision, with success criteria and a kill switch

DELIVERABLE
A single scannable table:

  Claim | Owner | Evidence | Challenge | Resolution | Decision | Watch-for signal

Plus the decision memo above.

CLEANUP
After memo and table are delivered:
1. Shut down each teammate explicitly
2. Run "Clean up the team" from the lead so shared resources release
3. Verify with `tmux ls` and kill any orphaned panes
4. Note total tokens / wall-time so we can decide whether the team paid for itself

PROMOTE TO SKILL
If this debate produced a clearly better decision than a single agent would have, package
the prompt + role slate + round criteria as a skill at ~/.claude/skills/ux-team-debate/.
A skill is the right home for repeatable patterns; running this prompt from scratch every
time is the wrong default.
```

---

## Lightweight variant

For the ~80% of decisions that don't warrant 4 rounds. ~3 teammates, ~15 minutes.

```text
LIGHTWEIGHT mode: 3 teammates, 2 rounds, ~15 minutes.
Pick 2 specialists + devils-advocate from ~/.claude/agents/ based on the decision type.

ROUND 1 (parallel, no cross-talk): Each teammate posts a position using its native
artifact format. Devils-advocate posts assumption inventory only.

ROUND 2 (lead): Synthesis memo with the same 7 sections as the FULL mode. No cross-exam.

Use this when the decision is reversible, scope is small, or you've already done
discovery elsewhere.
```

---

## Why this prompt is structured this way

Several documented failure modes for agent teams informed the structure:

- **Generic role names produce generic positions.** This prompt plugs in named, opinionated specialists from `~/.claude/agents/` — each one comes with its own artifact spec and "When debating with teammates" stances, so the debate has real friction.
- **Teammates often mark tasks done prematurely.** Round-completion criteria are observable, not vibes-based — the lead verifies before unblocking.
- **Cross-examination is the most token-expensive round.** It's bounded: max paragraph length, one reply per challenge, no nested threading.
- **Devil's advocate works best on emerging consensus, not on early ideas.** Its role shifts across rounds — assumption inventory in Round 1, full pre-mortem in Round 3 — to honor its own definition (it explicitly says "do not invoke during open exploration").
- **The lead's job is to synthesize, not to participate.** The prompt instructs the lead to wait and gates each round.
- **Coordination cost grows non-linearly.** Team is capped at 4 teammates total. Lines of communication = n×(n−1)/2; 4 teammates = 6 lines, 5 = 10, 8 = 28.
- **Repeated patterns belong in skills.** The prompt ends by asking the lead to promote the pattern to `~/.claude/skills/` if it earned its keep.

## Pairing with the Northstar demo

If you're using this in a live demo or workshop, run the prompt against the Northstar canceled-flight brief in `demo-inputs/`. That brief was designed so multiple UX lenses are genuinely needed — research, IA, interaction, content, accessibility, and behavioral science all have load-bearing concerns. Devil's advocate then stress-tests the synthesis.
