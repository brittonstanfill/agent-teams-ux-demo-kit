# Scorecard: Single Agent vs Agent Team

Use this to keep the demo honest. The agent team should not "win" unless the output improves enough to justify coordination cost.

For the improvement loop, use `11-evaluation-system.md`. This file is the quick live-demo scorecard.

**Honest framing for the demo:** the kit's earlier pitch — "team output > single output" — is true on some dimensions and false on others. A live demo that hides this is less useful than one that surfaces it. The "What team wins on / What single agent wins on" section at the bottom is now the most important part of the scorecard.

Score each item 0 to 3.

- 0 = missing
- 1 = generic
- 2 = specific and usable
- 3 = specific, usable, and shows tradeoff awareness

| Criterion | Single Agent | Agent Team | Notes |
|---|---:|---:|---|
| Finds high-severity user problems |  |  |  |
| Separates observations from assumptions |  |  |  |
| Produces a coherent flow |  |  |  |
| **Authored a visually distinctive artifact** |  |  | New row. Score on craft, not on count. |
| **Interaction/product craft** |  |  | Score states, affordances, controls, recovery paths, and responsive behavior separately from visual presentation. |
| **Accessibility/trust/render robustness** |  |  | Score executed accessibility, visible refund/support paths, honest uncertainty, and no clipping or masking as one hard-floor bucket. |
| Improves labels and content |  |  |  |
| Catches accessibility blockers (WCAG-cited) |  |  |  |
| Identifies ethical / behavioral risks (mechanism-named) |  |  |  |
| Creates competing full artifacts early |  |  | Candidates should differ in structure/presentation/choice architecture, not just styling. |
| Resolves role conflicts / surfaces debates |  |  |  |
| Gives concrete screen-level recommendations |  |  |  |
| Defines a useful experiment plan |  |  |  |
| Requires low human rework |  |  |  |
| **Output is distinguishable from a Bootstrap template** |  |  | New row. The "could a single junior designer have produced this in an afternoon?" check. |
| **Clean-room protocol followed** |  |  | No prior outputs, branches, PRs, or screenshots inspected before both sides were sealed. |

## Additional Measures

Record these if you can:

| Measure | Single Agent | Agent Team |
|---|---:|---:|
| Time to useful draft |  |  |
| Token usage |  |  |
| Number of unique severe issues found |  |  |
| Number of contradictions caught |  |  |
| Number of role handoffs that changed output |  |  |
| Number of visible debates with preserved dissent |  |  |
| Number of full candidate artifacts compared before final |  |  |
| Human edits needed before sharing |  |  |
| Clean-room checks passed |  |  |

## What Counts As A Real Agent-Team Win

The team earns its cost when it does at least two of these:

- Produces visual presentation that at least ties the single-agent baseline while improving the product decision.
- Finds issues the single agent missed (specifically: cites WCAG criteria by number, names behavioral mechanisms, identifies dark patterns by type).
- Uses competing full artifacts to create a stronger final, not just more artifacts to review.
- Produces a better flow because roles challenged each other (handoffs visibly changed decisions; dissent preserved).
- Catches accessibility or trust risks before synthesis.
- Makes disagreements visible and resolves them — with the dissenting position preserved, not erased.
- Creates a better experiment plan than the baseline (hypothesis + primary metric + guardrail + exit rule per experiment).

If the team only produces more text, it did not win. If the team produces consensus output with no preserved dissent, "consensus" is a smell.

---

## What team wins on / What single agent wins on

This section is the honest part of the scorecard. It is also the most useful frame for the demo.

### What an agent team genuinely wins on

These compound when you have multiple specialists; they're hard for a single agent to match.

- **Specialist depth in cite-and-defend domains.** WCAG criterion-level audits, named behavioral mechanisms (default effect, ambiguity aversion, loss aversion, reactance), IA tradeoff vocabulary (information scent, controlled vocabulary), interaction state matrices. A single agent does these *plausibly*; specialists do them *citationally*.
- **Risk surface.** Three or four specialists looking at the same artifact will find roughly 1.5–2× the dark patterns, accessibility blockers, and edge-case state holes that a single agent finds. The marginal specialist returns more risk-catching than redundant breadth.
- **Visible tradeoff reasoning.** A team that debates leaves a paper trail of *what was considered and rejected*. A single agent who debates with themselves writes a tidier doc, but the dissent is harder to see and harder to trust.
- **Dark-pattern detection.** Behavioral-scientist with a real choice-architecture vocabulary catches things a single agent misses (e.g., naming the "Travel credit default" *as* a dark pattern by mechanism, not just "fix the default").
- **Decision durability.** Output a team converged on, with dissent preserved, holds up better in front of skeptical stakeholders than output that has no audit trail.

### What a single agent genuinely wins on

These don't compound — they belong to one author. A team can refine them but rarely *improve* them past a single coherent vision.

- **Visual composition.** Type, color, spacing, hierarchy, focal flow, rhythm. One author holds the whole; teams flatten it through serial refinement.
- **Narrative coherence.** The voice of a synthesis doc, the through-line of a recommendation. Many specialists each writing one section will not produce one voice.
- **Distinctive aesthetic.** Anything that depends on *taste* and *commitment to a reference*. Teams converge on safe; single authors can be distinctive (or distinctively wrong, but that's part of the deal).
- **Time-to-useful-draft.** A single agent can ship a credible first cut in minutes. A team needs setup, briefing, relay or parallel phase, synthesis. Coordination overhead is real.

### How to use this in the demo

1. Run the single-agent baseline (`03-`) — note it now ships HTML, not just a doc.
2. Run the compact team (`13-`) for the current recommended path. Use `02-` or `09-` only when intentionally comparing older patterns.
3. Score both honestly with the rubric above.
4. End the demo with the "team wins on / single wins on" comparison. Show the audience *where the team earned its cost* and *where the single agent held its own*.

The best ending is not "the team wins." The best ending is: **"Here's what coordination buys you, and here's what it costs. Choose the pattern that fits the artifact."**

That's a more useful insight to take home than a victory lap.
