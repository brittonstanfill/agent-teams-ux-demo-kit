# Single-Agent Baseline Prompt

Use this before the team run if you want to show the difference. **This prompt now demands the same artifact type as the team prompt — both ship HTML.** Previous versions of this prompt asked the single agent to ship a doc, which made the visual-quality comparison meaningless (the team had an artifact; the baseline didn't). For an honest head-to-head, both sides produce the same thing.

```text
Review the canceled-flight recovery experience in:

Agent Teams UX Demo Kit/demo-inputs/northstar-canceled-flight-brief.md

Create a meeting-ready recommendation for improving the experience. Cover UX research, information architecture, interaction design, UX writing, accessibility, visual/UI design, and behavioral science.

Ship two things:

1. A working HTML prototype at:
   Agent Teams UX Demo Kit/demo-output/single-agent-baseline/index.html
   - Mobile-first, self-contained (inline CSS + JS).
   - Render the redesigned flow as actual screens (phone-frame style), not as a description of screens.
   - Respect prefers-color-scheme (light + dark) and prefers-reduced-motion.
   - Hit WCAG 2.1 AA where possible (cite criteria when you make a notable call).

2. A doc at:
   Agent Teams UX Demo Kit/demo-output/single-agent-baseline.md
   Include:
   - Executive recommendation
   - Redesigned flow in 4–5 screens (target, not a hard cap)
   - Main issues found in the current flow
   - Recommended copy (verbatim, not described)
   - Accessibility and trust risks with proposed mitigations
   - Experiment plan (hypothesis + primary metric + guardrail + exit rule for each)

Quality bar:
- The output should be distinguishable as the work of a designer who cares about craft. Generic, safe, "meeting-template" output is a failure mode, not a default. If your output could have been produced by a Bootstrap starter, you have not earned your presence.
- Hold the line on distinctiveness over completeness.

Label assumptions ([observed from brief], [inferred], [assumption], [recommendation]).
Do not invent metrics, user quotes, airline policies, or legal obligations.
```

## Why this changed

The earlier version of this prompt asked the single agent to produce only a markdown document. When facilitators ran the demo head-to-head against the team output (which by V2 of the kit had grown to include an HTML artifact), the baseline doc couldn't lose on visual quality — *because it never had to ship visual*. The scorecard claimed a fair comparison but the artifact types differed.

This version makes the artifacts apples-to-apples. The single agent must now ship the same thing the team ships. If the single agent's HTML is more visually coherent than the team's, that's a real finding about authorship and composition — and the scorecard in `05-scorecard.md` is now honest about it.
