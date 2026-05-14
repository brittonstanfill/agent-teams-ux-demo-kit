# Parallel-Author Team Prompt

Use this when **authorship matters** — visual composition, narrative coherence, distinctive aesthetic. Sequential relay (covered in `02-master-agent-team-prompt.md`) tends to produce committee-flattened output: each specialist tunes the prior pass in their domain, no one owns the whole, the median wins. This prompt produces 2–3 *distinct authored versions* and asks the team to pick a winner.

## When to use this vs. `02-`

| Use parallel-author (this prompt) | Use relay-with-debate (`02-`) |
| :--- | :--- |
| Visual composition is load-bearing | Audit + risk surface is load-bearing |
| You want a distinctive aesthetic | You want defensible analysis |
| The artifact is a built thing (HTML, mockup, doc with voice) | The artifact is a synthesis or recommendation |
| Single-author coherence matters more than peer-challenge | Peer-challenge matters more than authorial vision |
| One screen made well > five screens made by committee | One audit done by seven > five screens made alone |

You can also chain the two: parallel-author to ship the surface, then relay-with-debate to audit it.

## The prompt

```text
Create an agent team named "[Team Name]" to design [artifact name] for [problem described in brief].

Brief: [path to brief]

Use these teammates:
1. Creative Director — sets aesthetic anchor + quality bar; picks the winning author at the end.
2. Two or three "authors" — specialists you trust to compose a whole artifact. For most product work, pick from: visual-designer, content-designer, interaction-designer. Match the author to the artifact: if visual matters most, visual authors. If voice matters most, content authors.
3. The remaining specialists — they refine the winning version after selection, not before. They do not author drafts in parallel.

Phase 1 — Author in parallel (each author works solo, no peer reading):

Each named author independently produces a full draft of the artifact, from a clean canvas, holding the whole composition in mind. Each ships to:
   demo-output/parallel-drafts/[author-name]/index.html (or relevant extension)

The Creative Director briefs them upfront with:
- The aesthetic anchor (a specific reference: "Linear restraint" / "Stripe clarity" / "Things deliberateness").
- The three moves worth stealing from that reference.
- The failure mode to avoid ("generic", "could be a Bootstrap template", "looks like every fintech app").
- The quality bar: distinctive over safe.

Authors do not read each other's work during Phase 1. Convergence kills distinction.

Phase 2 — Critique round (all specialists, including non-authors):

After all parallel drafts are submitted, the full team reviews them. Each specialist writes a ≤200-word critique of each draft from their lens. Specialists name what's strong, what's weak, and which draft best serves the artifact's job.

Phase 3 — Selection:

Creative Director picks the winner. Explicitly names: which draft, why, and what dissenting positions remain. Dissent is preserved, not erased — it informs Phase 4.

Phase 4 — Refinement (now the relay applies):

Specialists each take one targeted refinement pass on the winning draft, in their domain. This is tuning, not authoring — the composition is locked. Refinement is paced and short.

Phase 5 — Final audit:

Accessibility-specialist + behavioral-scientist + devils-advocate do the final pass. They are explicitly authorized to flag — but not to redesign. Their job is to catch problems before ship.

Outputs:
- demo-output/parallel-drafts/ — all original authored versions (preserve all of them; the comparison is part of the artifact)
- demo-output/final/[winning-author]/index.html — the chosen draft, refined
- demo-output/final-recommendation.md — the lead's synthesis, including:
    * The Creative Director's brief
    * What each draft did differently
    * Why the winner won
    * Dissenting positions from the critique round
    * The refinement passes
    * The final audit findings

Quality bar:
- Each draft should be distinguishable from the others. If two drafts look the same, the authors weren't independent enough — that's a failure mode.
- The winning draft should be unmistakably the work of a designer who cares. Generic, safe, "meeting-template" output is a failure mode, not a default.
- Dissenting positions are preserved in the synthesis. "We unanimously agreed" is a smell.

Working rules:
- No author reads another author's work until Phase 2.
- The Creative Director does not author. They direct.
- Specialists in refinement mode (Phase 4) can revise within their domain but cannot rewrite composition. If they want to rewrite composition, they raise it as a debate; Creative Director decides.
- Label every claim ([observed from brief], [inferred], [assumption], [recommendation]).
- Do not invent metrics, policies, laws, or quotes.
```

## What this pattern gets you

- **Authorial coherence.** Each draft has one head holding the whole composition. Visual hierarchy, narrative flow, tonal consistency don't get smoothed away by consensus.
- **Real comparison.** Three drafts, side by side, make taste-level disagreements concrete. "I prefer A because…" is more useful than "I think we should adjust the spacing on the consensus version."
- **Preserved dissent.** The losing drafts and the critique-round disagreements stay in the artifact. A future facilitator can show *what was rejected and why*, not just *what was kept*.
- **Refinement without erasure.** Phase 4 specialists know they're tuning, not authoring. That changes the kind of changes they make.

## When this pattern hurts

- The work is genuinely a synthesis (research findings, requirements doc, recommendation memo) and a single composed voice would be less useful than seven specialist voices weighing in. Use `02-` instead.
- You can't afford 2–3 parallel authoring passes (token cost). Use `02-` and accept the median-pull risk.
- The artifact has no compositional dimension — it's a checklist, a spec, a list. Use `02-` or `08-single-agent-quick-prompt.md`.

## Notes for facilitators

- For demo purposes, this pattern produces more visible artifacts than the relay. Three drafts in `parallel-drafts/` give viewers something to *see* and *prefer between* — a stronger meeting moment than one synthesized output.
- The Creative Director's brief is the single most important moment. A vague anchor produces vague drafts. Spend time on the brief.
- Don't run this pattern with more than three authors. Four authors in parallel is coordination overhead with diminishing returns on distinction.
