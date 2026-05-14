# Facilitator Runbook

## The Point To Make

Agent teams are not "more agents equals better." They are useful when the work needs multiple specialists to inspect the same problem, exchange findings, resolve conflicts, and produce a synthesis.

For this demo, the system is:

1. **Lens:** each teammate examines the problem from one role.
2. **Relay:** each teammate sends required handoffs to other teammates.
3. **Fuse:** the lead synthesizes conflicts into one product direction.
4. **Score:** the group compares output quality against a single-agent baseline.

## Setup

Before the meeting:

- Confirm Claude Code version supports agent teams.
- Enable agent teams if needed with `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`.
- Put the optional files in `claude-agents/` into `.claude/agents/` if you want the team to use named subagent definitions.
- Keep `demo-inputs/northstar-canceled-flight-brief.md` open.
- Create an empty `demo-output/` folder before the run.

## 25 Minute Live Demo

**0:00-2:00 - Frame the demo**

Say: "We are not testing whether seven agents can produce more text. We are testing whether coordination creates a better design decision."

Show the flawed Northstar flow. Explain that it is a fictional but realistic canceled-flight recovery problem.

**2:00-5:00 - Baseline**

Run the single-agent baseline prompt or show a pre-generated baseline if time is tight.

What to point out:
- One voice.
- Often broad coverage, but shallow tradeoff resolution.
- No visible cross-examination.

**5:00-8:00 - Launch the team**

Run the master agent-team prompt.

What to show:
- The team lead.
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
- Behavioral Scientist challenges dark patterns.
- Content Designer rewrites the flow after IA and behavior findings.

**15:00-22:00 - Synthesis**

Ask the lead:

```text
Create the final recommendation. Include the decisions, rejected alternatives, unresolved risks, and what changed because teammates messaged each other.
```

**22:00-25:00 - Score**

Use `05-scorecard.md`.

The best ending is not "the team wins." The best ending is: "Here is where the team earned its cost, and here is where it did not."

## If Time Is Short

Skip the baseline run live. Show the team workflow and score it against the baseline prompt criteria verbally.

Use only 4 roles live:

- UX Researcher
- Information Architect
- Accessibility Specialist
- Content Designer / UX Writer

Then explain that Visual/UI, Interaction Design, and Behavioral Science are the full version.

## Things To Avoid

- Do not let all agents write the same final file.
- Do not ask for generic best practices.
- Do not let the lead synthesize before role handoffs happen.
- Do not claim agent teams are better without the scorecard.
- Do not use a huge team for a simple task.
