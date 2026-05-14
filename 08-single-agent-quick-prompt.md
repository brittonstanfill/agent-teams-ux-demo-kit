# Single-Agent Quick Prompt

For the 80% of moments where you just need **one** specialist, not a full team debate. Paste this in Claude Code, fill the three bracketed fields, send.

## The template (3 lines)

```text
Use the [agent-name] subagent from ~/.claude/agents/ to review [target].
Context: [one sentence — what the artifact is, who the user is, what decision this informs].
Return your native artifact format. Be specific and cut anything that doesn't earn its place.
```

That's it. The agent already knows its own discipline, methods, output format, and what to defer on — you don't have to brief it.

---

## When to use this vs. the 4-round team debate

| Use the single-agent prompt | Use `07-team-debate-master-prompt.md` |
| :--- | :--- |
| One lens is enough | Multiple disciplines need to weigh in |
| Reversible / low-stakes decision | Hard-to-reverse, high-stakes choice |
| You already know which discipline to ask | You're not sure who should weigh in |
| You want an answer in minutes | You want a decision worth defending |
| Quick critique pass | A real product decision |

---

## Worked examples — one per agent

### Review copy
```text
Use the content-designer subagent from ~/.claude/agents/ to review the empty-state copy in src/components/InboxEmpty.tsx.
Context: This is the first-run empty state for a B2B inbox; users see this before they've connected any data sources.
Return your native artifact format. Be specific and cut anything that doesn't earn its place.
```

### Audit accessibility
```text
Use the accessibility-specialist subagent from ~/.claude/agents/ to audit the form in src/pages/Checkout.tsx.
Context: Checkout for a consumer e-commerce app; ships next sprint; we have a documented WCAG 2.1 AA commitment.
Return your native artifact format. Be specific and cut anything that doesn't earn its place.
```

### Map a flow
```text
Use the interaction-designer subagent from ~/.claude/agents/ to enumerate states for the password-reset flow in src/auth/PasswordReset.tsx.
Context: Currently only handles the happy path; we keep getting support tickets about "I clicked the link and nothing happened."
Return your native artifact format. Be specific and cut anything that doesn't earn its place.
```

### Stress-test a decision
```text
Use the devils-advocate subagent from ~/.claude/agents/ to stress-test the redesign proposal in docs/onboarding-v3.md.
Context: We've spent 3 weeks converging on this; before I greenlight engineering, I want the strongest case against.
Return your native artifact format. Be specific and cut anything that doesn't earn its place.
```

### Frame a research question
```text
Use the ux-researcher subagent from ~/.claude/agents/ to propose the lightest research that would tell us whether users actually want feature X.
Context: PM thinks usage will jump 20%; I don't trust the assumption; we have 2 weeks before we'd start building.
Return your native artifact format. Be specific and cut anything that doesn't earn its place.
```

### Apply behavior-change framing
```text
Use the behavioral-scientist subagent from ~/.claude/agents/ to analyze why our 7-day retention is 18%.
Context: B2C wellness app; users sign up motivated, drop off by day 4; we've tried push notifications and email — neither moved the metric.
Return your native artifact format. Be specific and cut anything that doesn't earn its place.
```

### Propose information architecture
```text
Use the information-architect subagent from ~/.claude/agents/ to propose a nav structure for the new Settings area in docs/settings-inventory.md.
Context: We're consolidating 6 scattered settings pages into one section; users currently can't find half of them in search.
Return your native artifact format. Be specific and cut anything that doesn't earn its place.
```

### Review visual craft
```text
Use the visual-designer subagent from ~/.claude/agents/ to review the dashboard mockups in design/dashboard-v2/.
Context: B2B analytics product; we want to feel closer to Linear/Stripe in restraint, currently lands closer to Salesforce.
Return your native artifact format. Be specific and cut anything that doesn't earn its place.
```

---

## Tips for getting good output

- **Be specific in the context line.** "Improve this page" gets you generic advice. "First-run empty state for a B2B inbox before users connect data sources" gets you specific advice.
- **Name the artifact path.** The agent can read files directly — pointing at a specific file or directory is faster than pasting code.
- **Don't ask the agent to defer.** Each agent already knows its lane. If you want it to push back on something outside its scope, say so explicitly: "include any boundary issues you'd hand to another specialist."
- **If you want a quick critique loop**, invoke 2–3 agents in parallel in the same prompt (e.g., "use the interaction-designer and content-designer subagents" — Claude will run both). For 4 or more, switch to the team-debate prompt.
