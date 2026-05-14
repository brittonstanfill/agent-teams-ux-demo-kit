# Facilitator Runbook

## The Point To Make

Agent teams are not "more agents equals better." They are useful when the work needs multiple specialists to inspect the same problem, exchange findings, resolve conflicts, and produce a synthesis. **They are also genuinely worse at some kinds of work** — visual composition, narrative coherence, distinctive aesthetic — where one head holding the whole composition beats five specialists each tuning a slice.

A good demo names both. A demo that hides the second half loses the audience's trust the moment they notice.

For this demo, the system is:

1. **Lens:** each teammate examines the problem from one role.
2. **Relay (or parallel):** each teammate sends required handoffs to other teammates, OR a subset of teammates each authors the full artifact in parallel and the team picks a winner.
3. **Debate:** at least two specific decisions surface real disagreement; positions are taken, counter-arguments run, and dissenting voices are preserved.
4. **Fuse:** the lead (with a Creative Director if you're running the v3+ version of the kit) synthesizes into one product direction.
5. **Score:** the group compares output quality against a single-agent baseline that *ships the same artifact type*, then names what the team won on and what it didn't.

## Setup

Before the meeting:

- Confirm Claude Code version supports agent teams.
- Enable agent teams if needed with `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`.
- Put the optional files in `claude-agents/` into `.claude/agents/` if you want the team to use named subagent definitions. (Make sure tool permissions include `Write, Edit, Bash, TaskCreate, TaskUpdate, TaskGet, TaskList, SendMessage` — earlier versions of the kit shipped read-only agent definitions that couldn't actually produce files.)
- Keep `demo-inputs/northstar-canceled-flight-brief.md` open.
- Create an empty `demo-output/` folder before the run.

## 25 Minute Live Demo

**0:00-2:00 - Frame the demo**

Say: "We are not testing whether seven agents can produce more text than one. We are testing two things — first, can coordination produce a better *decision*, and second, where does coordination *hurt*. Agent teams are not categorically better; they're better at specific things and worse at others."

Show the flawed Northstar flow. Explain that it is a fictional but realistic canceled-flight recovery problem.

**2:00-5:00 - Baseline**

Run the single-agent baseline prompt or show a pre-generated baseline if time is tight. **Note the baseline now ships an HTML artifact, not just a doc** — this was a kit-level fix to make the comparison honest.

What to point out:
- One voice.
- Often broad coverage with shallow tradeoff resolution.
- No visible cross-examination.
- *And:* often a more coherent visual composition than the team will produce. Set the expectation now so it lands as a finding, not a surprise.

**5:00-8:00 - Launch the team**

Run the master agent-team prompt (`02-master-agent-team-prompt.md`) OR the parallel-author prompt (`09-parallel-author-prompt.md`) depending on what the demo is making. For a visual-heavy artifact, parallel-author produces a better story.

What to show:
- The team lead.
- The Creative Director's brief (this is new in v3+ of the kit — the briefing moment sets the aesthetic anchor before anyone authors).
- The role list.
- The shared task list.
- Role-owned output files.

**8:00-15:00 - Make the communication visible**

Ask the lead:

```text
Pause after first-pass findings. Show me what each teammate sent to at least two other teammates, and show unresolved conflicts before synthesis.
```

Good things to watch for:
- UX Researcher influences IA and Content.
- IA constrains Interaction Designer.
- Accessibility Specialist blocks or revises Visual/UI and Interaction proposals.
- Behavioral Scientist challenges dark patterns *by mechanism*, not just by name.
- Content Designer rewrites copy after IA and behavior findings.
- **Visible debate** — at least two decisions where ≥2 specialists disagree, with positions on the table and dissent preserved at resolution. If no debate happens, the team's consensus is suspect. Ask the lead to surface a borderline call and run a debate manually.

**15:00-22:00 - Synthesis**

Ask the lead:

```text
Create the final recommendation. Include the decisions, rejected alternatives, dissenting positions on resolved debates, unresolved risks, and what changed because teammates messaged each other.
```

**22:00-25:00 - Score honestly**

Use `05-scorecard.md`. Run the "team wins on / single wins on" section explicitly. The best ending is not "the team wins." The best ending is: **"Here is where the team earned its cost. Here is where the single agent held its own. Here's how you choose between the patterns for *your* next artifact."**

## If Time Is Short

Skip the baseline run live. Show the team workflow and score it against the baseline prompt criteria verbally.

Use only 4 roles live:

- UX Researcher
- Information Architect
- Accessibility Specialist
- Content Designer / UX Writer

Then explain that Visual/UI, Interaction Design, and Behavioral Science are the full version. **Skip Creative Director only if you must** — without it, the team tends to converge on safe.

## Things To Avoid

- Do not let all agents write the same final file.
- Do not ask for generic best practices.
- Do not let the lead synthesize before role handoffs happen.
- Do not let the team declare consensus without a debate.
- Do not erase dissent at resolution — preserved dissent is part of the artifact.
- Do not claim agent teams are better without the scorecard.
- Do not run the demo with the *old* (V1/V2) version of this kit — the V1 agents shipped read-only and couldn't produce files; the V2 prompt produced docs, not artifacts. If you're not sure which version you have, check that `claude-agents/visual-designer.md` describes itself as "an author first, a reviewer second" — that's the v3+ wording.
- Do not use a huge team for a simple task.

## Honest pre-demo gut check

Before you run this in front of people, ask yourself:

- *Could the team win or lose? If the answer is "only win," your demo is rigged.*
- *Have I picked an artifact where coordination actually pays?* Visual composition: probably not the right artifact for a relay run; use parallel-author instead. WCAG audit + behavioral risk surface: yes, coordination pays.
- *Is the baseline shipping the same artifact type the team will?* If not, fix the baseline prompt first.

A demo that lets the team genuinely lose on a dimension, then explain why, lands stronger than a demo that protects the team from comparison.
