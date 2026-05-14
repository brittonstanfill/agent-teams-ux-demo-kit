# Master Agent-Team Prompt

Copy/paste this into Claude Code from the project folder that contains this kit.

```text
Create an agent team named "Northstar UX Recovery Team" to redesign the canceled-flight recovery experience described in:

Agent Teams UX Demo Kit/demo-inputs/northstar-canceled-flight-brief.md

Use these seven teammates. If matching subagent definitions are available, use them. Otherwise create teammates with these roles and instructions:

1. UX Researcher
2. Information Architect
3. Interaction Designer
4. Content Designer / UX Writer
5. Accessibility Specialist
6. Visual / UI Designer
7. Behavioral Scientist

Goal:
Create a meeting-ready recommendation for a better canceled-flight recovery flow. The output should show how the team improved the product decision through role-specific analysis and teammate communication.

Working rules:
- Each teammate owns one file in `Agent Teams UX Demo Kit/demo-output/role-reports/`.
- No teammate should edit another teammate's role report.
- The lead owns the final synthesis file: `Agent Teams UX Demo Kit/demo-output/final-recommendation.md`.
- Label every major claim as one of: observed from brief, inferred, assumption, or recommendation.
- Do not invent research data, metrics, laws, airline policies, or user quotes.
- Make the teammate messages visible in the final recommendation.

Required role outputs:
- UX Researcher: user needs, emotional state, research questions, assumptions to validate.
- Information Architect: revised flow structure, content hierarchy, decision points, navigation labels.
- Interaction Designer: step-by-step interaction model, states, error recovery, handoff moments.
- Content Designer / UX Writer: screen-level copy, notification copy, plain-language guidance, tone rules.
- Accessibility Specialist: blockers, WCAG-style concerns, assistive tech implications, inclusive design fixes.
- Visual / UI Designer: layout direction, hierarchy, component suggestions, visual system notes.
- Behavioral Scientist: trust risks, choice architecture, ethical nudges, experiment ideas.

Required peer handoffs:
- UX Researcher must message Information Architect and Content Designer with top user needs.
- Information Architect must message Interaction Designer and Content Designer with the proposed flow model.
- Interaction Designer must message Accessibility Specialist and Visual/UI Designer with proposed states.
- Accessibility Specialist must message Interaction Designer, Visual/UI Designer, and Content Designer with blockers.
- Behavioral Scientist must message Content Designer and Interaction Designer with ethical choice-architecture risks.
- Visual/UI Designer must message Accessibility Specialist before finalizing the UI direction.
- Content Designer must message Information Architect and Accessibility Specialist before finalizing copy.

Synthesis requirements:
Before writing the final recommendation, the lead should show:
1. Top 3 findings from each teammate.
2. The most important disagreement or tension.
3. Which teammate message changed another teammate's recommendation.

Final deliverable:
Write `Agent Teams UX Demo Kit/demo-output/final-recommendation.md` with these sections:

1. Executive recommendation
2. Redesigned flow in 5 screens or fewer
3. What each role contributed
4. Cross-agent handoffs that changed the answer
5. Key tradeoffs and rejected alternatives
6. Accessibility and trust guardrails
7. Experiment plan
8. Scorecard-ready comparison against a single-agent baseline

Keep the final synthesis crisp and meeting-ready.
```
