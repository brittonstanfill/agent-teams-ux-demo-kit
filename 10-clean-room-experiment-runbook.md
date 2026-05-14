# Clean-Room Experiment Runbook

Use this when you are testing whether a prompt, role slate, or agent-team process is actually better. A demo can reuse prior outputs for explanation; an evaluation cannot.

## Goal

Compare single-agent and agent-team outputs without contaminating either run with prior Northstar outputs, prior PRs, or the facilitator's memory of a preferred answer. The goal is not to prove that the team wins. The goal is to learn which system produces the better outcome for this artifact type and why.

## Research-backed principles

This protocol borrows from Anthropic's public guidance:

- Agent teams work best when teammates have distinct lenses, enough context, and clear file ownership.
- Start with 3-5 teammates for most workflows; coordination overhead rises quickly beyond that.
- Monitor and steer the team during the run; unattended teams waste effort when a teammate stalls or the lead synthesizes too early.
- Evaluate outcomes, not exact paths. Multi-agent runs can take different valid routes.
- Use small eval sets immediately. Early prompt and tool changes often have large effects that show up in a few cases.
- Preserve direct artifacts from teammates to avoid "game of telephone" loss through the coordinator.
- Use fresh context between unrelated tasks; accumulated corrections can degrade later work.

Sources: Anthropic's Claude Code [agent-team docs](https://code.claude.com/docs/en/agent-teams), [worktree docs](https://code.claude.com/docs/en/worktrees), ["How we built our multi-agent research system"](https://www.anthropic.com/engineering/multi-agent-research-system), and ["Building effective agents"](https://www.anthropic.com/engineering/building-effective-agents).

## Clean-room setup

Start from two fresh clones or worktrees: one for the baseline and one for the team. Do not reuse `skill-hack-demo-1` or any checkout that contains prior Northstar outputs. Keeping the two runs in separate checkouts prevents the team from seeing the baseline before scoring.

```bash
RUN_ID="$(date +%Y%m%d-%H%M)"
mkdir -p ~/agent-team-experiments
cd ~/agent-team-experiments
git clone https://github.com/brittonstanfill/agent-teams-ux-demo-kit.git "northstar-$RUN_ID-baseline"
git clone https://github.com/brittonstanfill/agent-teams-ux-demo-kit.git "northstar-$RUN_ID-team"
cd "northstar-$RUN_ID-baseline" && git switch -c "experiment/northstar-baseline-$RUN_ID"
cd "../northstar-$RUN_ID-team" && git switch -c "experiment/northstar-team-$RUN_ID"
```

Verify both checkouts are on the same system commit and that outputs are empty:

```bash
git rev-parse --short HEAD
find demo-output -type f ! -name .gitkeep -print
```

The `find` command should print nothing. If it prints generated files, stop and start over.

Install the project-scoped agent definitions in the team checkout so the run does not depend on whatever happens to be installed globally:

```bash
cd "../northstar-$RUN_ID-team"
mkdir -p .claude/agents
cp claude-agents/*.md .claude/agents/
```

Do not commit `.claude/agents/` as part of the experiment output unless the experiment is specifically testing project-scoped agent packaging.

## Contamination rules

- Do not open `demo-output/` except to verify it is empty or to write new outputs.
- Do not open prior branches such as `demo/northstar-final-recommendation` or `demo/single-agent-baseline`.
- Do not open PR #2, past screenshots, or previous HTML outputs.
- Do not paste excerpts from past runs into prompts.
- Do not score until both sides have sealed their outputs.

## Run order

Run the baseline first in the baseline checkout:

```text
Use 03-single-agent-baseline-prompt.md exactly. Follow its clean-room rule. Write only the requested files. When done, stop.
```

Commit the sealed baseline:

```bash
git add demo-output/single-agent-baseline demo-output/single-agent-baseline.md demo-output/run-metadata.md
git commit -m "Add clean-room single-agent baseline"
```

Start a new Claude Code session in the separate team checkout with `/clear` or a fresh terminal. Then run either:

- `02-master-agent-team-prompt.md` for relay-with-debate
- `09-parallel-author-prompt.md` when visual authorship is the main thing being tested

Commit the sealed team output:

```bash
git add demo-output/role-reports demo-output/prototype demo-output/final-recommendation.md demo-output/process-appendix.md demo-output/run-metadata.md
git commit -m "Add clean-room agent-team run"
```

Only after both commits exist may the lead compare outputs. At that point, create a scoring branch or folder that brings the two sealed artifacts side by side.

For blind Layer 1 scoring, copy only the HTML artifact and meeting-ready recommendation into neutral `artifact-a/` and `artifact-b/` folders. Do not include `run-metadata.md`, role reports, process appendices, branch names, or commit SHAs until Layer 2 and Layer 3 scoring.

## Score and decide

Use `11-evaluation-system.md` for improvement-loop decisions. Use `05-scorecard.md` only for quick live-demo scoring. Record:

- Branch and commit SHAs for baseline and team outputs
- Wall time
- Token usage when available
- Number of teammate handoffs that changed the output
- Number of visible debates with preserved dissent
- Accessibility blockers caught
- Behavioral/trust risks caught
- Visual distinctiveness score
- Human edits needed before sharing

Promotion rule:

- Promote a system change only when it improves at least two high-value criteria without materially worsening visual craft or time-to-useful-draft.
- If the team only produces more text, do not promote the change.
- If the single agent produces the better visual artifact, keep that finding. Improve the team pattern instead of burying the result.

## Iteration loop

For each loop:

1. Name the hypothesis in one sentence.
2. Change one system variable: prompt, role slate, sequence, output format, or evaluation rule.
3. Run a clean-room baseline/team comparison.
4. Score before reading past outputs.
5. Promote the change only if the scorecard and human review both show a better outcome.

Keep old experiment branches. Failed runs are useful because they show which failure mode the next prompt must prevent.
