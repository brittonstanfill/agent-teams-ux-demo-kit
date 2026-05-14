# Evaluation System

Use this when the goal is to improve the agent-team system, not just run the demo. The evaluation should answer one question:

> Did this system produce a better outcome than the simpler alternative, and do we understand why?

Better does not mean longer, more specialist-sounding, or more visibly coordinated. Better means a human would make a better product decision or ship a better artifact with less risky rework.

Grounding sources: Anthropic's Claude Code [agent-team docs](https://code.claude.com/docs/en/agent-teams), [worktree docs](https://code.claude.com/docs/en/worktrees), ["How we built our multi-agent research system"](https://www.anthropic.com/engineering/multi-agent-research-system), and ["Building effective agents"](https://www.anthropic.com/engineering/building-effective-agents).

## What Success Means

A successful output does five things:

1. Helps the target user complete the job under realistic constraints.
2. Ships the same artifact type as the comparison output, so the comparison is fair.
3. Makes better decisions visible: what changed, why it changed, and what was rejected.
4. Handles hard floors: accessibility, trust, factual honesty, and no invented policy or data.
5. Justifies its cost: wall time, token use, coordination overhead, and human cleanup.

For this kit, an agent team succeeds only when it beats the single-agent baseline on decision quality or risk coverage without giving away too much artifact quality. If the team finds more issues but ships a worse design, that is a mixed result, not a win.

## Evaluation Layers

### Layer 0: Gates

Any gate failure blocks promotion, even if the score is high.

| Gate | Pass Standard |
|---|---|
| Clean-room integrity | No prior outputs, branches, PRs, screenshots, or summaries inspected before outputs were sealed. |
| Same artifact type | Single-agent and team outputs both ship the requested HTML artifact plus recommendation doc. |
| Completeness | Required files exist and are not stubs. |
| Constraint integrity | No invented metrics, user quotes, laws, airline policies, or compensation guarantees. |
| Accessibility floor | No obvious keyboard trap, unreadable contrast, missing focus path, or screen-reader-breaking structure. |
| Trust floor | The flow does not hide refund/support/entitlement information to reduce calls. |

### Layer 1: Outcome Quality

Weight: 45 percent.

| Dimension | What A 4 Looks Like |
|---|---|
| User-job fit | The flow solves the stressed traveler's actual jobs in order: understand, choose, get support, leave with confidence. |
| Flow coherence | Screen sequence, state model, and recovery paths are clear without relying on explanation text. |
| Content quality | Copy is plain, actionable, emotionally appropriate, and concrete at screen level. |
| Recommendation clarity | The memo has one coherent through-line, separates decisions from rationale, and is easy to present. |
| Accessibility and inclusion | WCAG-style concerns are handled in the artifact, not only described in the doc. |
| Trust and behavioral ethics | Choice architecture helps without coercing; dark-pattern risks are named by mechanism and removed. |
| Visual and interaction craft | The artifact has intentional hierarchy, state visibility, responsive behavior, and is not template-generic. |
| Experiment plan | Hypotheses are falsifiable and include primary metric, guardrail, and exit rule. |

### Layer 2: Decision Quality

Weight: 35 percent.

| Dimension | What A 4 Looks Like |
|---|---|
| Evidence hygiene | Claims are labeled as observed, inferred, assumption, or recommendation. Load-bearing assumptions are easy to find. |
| Specialist depth | Role-specific claims use the vocabulary and methods of the discipline, not generic UX advice. |
| Handoffs that changed output | The report identifies specific teammate messages that changed a decision or artifact. |
| Debate quality | At least two real disagreements are resolved with the winning argument and dissent preserved. |
| Tradeoff reasoning | Rejected alternatives are concrete and the reason for rejecting them is defensible. |
| Falsification | The output says what evidence would change the recommendation. |
| Red-team value | Failure modes are plausible, specific, and tied to watch-for signals. |

### Layer 3: Efficiency And Rework

Weight: 20 percent.

| Dimension | What A 4 Looks Like |
|---|---|
| Time to useful draft | The output is shareable within the intended meeting or decision window. |
| Token/cost discipline | Added cost buys visible decision quality, not just extra prose. |
| Human rework | A facilitator can use the artifact after light editing, not a rebuild. |
| Coordination overhead | The team size and handoff count match the task's complexity. |
| Simplicity | The system avoids ceremony that does not improve the output. |

## Scoring Scale

Use 0-4 for each dimension:

- 0 = missing or harmful
- 1 = present but generic, shallow, or mostly described rather than executed
- 2 = specific and usable, but with gaps or weak tradeoff reasoning
- 3 = strong, specific, and defensible
- 4 = excellent, artifact-level execution with clear tradeoffs and evidence

Do not reward length. If two outputs make the same point, the shorter clearer one should score higher.

Weighted score calculation:

```text
Layer score = (average dimension score / 4) * layer weight
Total score = Layer 1 score + Layer 2 score + Layer 3 score
```

Layer 0 gates do not add points. They only block promotion.

## Coordination Yield

After scoring both outputs, calculate:

```text
Coordination Yield = Team weighted score - Single-agent weighted score - Overhead penalty
```

Suggested overhead penalty:

- 0 points: team completed within 1.5x baseline time and needed similar or less human rework
- 3 points: team took 1.5-3x baseline time or needed modest extra synthesis
- 6 points: team took more than 3x baseline time or required substantial cleanup
- 10 points: team output was hard to use without a human rebuild

Promote a system change only when:

- All Layer 0 gates pass.
- Coordination Yield is at least +8 points, or the team catches a severe risk the baseline missed.
- The team does not drop more than 1 point on visual craft or recommendation clarity unless the task explicitly deprioritized those.
- The evaluator can name what changed in the system and why that change likely caused the improvement.

## Blind Evaluation Workflow

1. Seal both outputs in separate commits before scoring.
2. Copy or link artifacts into blind labels `A` and `B`; hide which one is single-agent vs. team.
3. Have at least one judge score outcome quality while blind to process.
4. Reveal process artifacts only after Layer 1 scoring, then score Layer 2 and Layer 3.
5. Reveal which system produced which output.
6. Write an evaluation report using `templates/evaluation-report-template.md`.
7. Decide: promote, hold, revert, or run another experiment.

For an LLM judge, use `templates/llm-judge-prompt.md`. For human facilitators, use the same rubric and require evidence notes for every score of 0, 1, or 4.

## Metacognition Checks

Run these before, during, and after each loop. The point is to avoid grounding too heavily in the current system, the team's preferred story, or the last visible output.

### Before The Run

- What is the one hypothesis this run is testing?
- What result would convince us the change did not help?
- Are we choosing a task where a team has a real chance to lose?
- Are we measuring output quality, process quality, or both?
- What are we at risk of rewarding accidentally?

### During The Run

- Is the lead waiting for teammates or synthesizing too early?
- Are teammates producing role-specific artifacts, or generic advice in different voices?
- Has any handoff actually changed the artifact?
- Is dissent being preserved, or softened into false consensus?
- Are we adding process because it helps, or because it feels rigorous?

### After The Run

- What surprised us?
- What did the baseline do better?
- What did the team do better that a single agent probably would not have done?
- Which improvement was real, and which was just more text?
- What would change our mind about this conclusion?
- What single variable should change in the next loop?

## Common Evaluation Traps

- **Verbosity bias:** longer reports feel more rigorous. Penalize repetition.
- **Team halo:** visible coordination feels valuable even when it did not change a decision.
- **Artifact blindness:** a strong memo can hide a weak prototype.
- **Process blindness:** a good prototype can hide unsafe assumptions or missing edge cases.
- **Aesthetic overcorrection:** after a generic team artifact, the next run may chase distinctiveness and lose clarity.
- **Single-scenario overfitting:** one Northstar result is useful signal, not proof. Promote cautiously.

## What To Improve Next

Treat every evaluation as a diagnosis. If the team loses:

- Lost on visual craft: try `09-parallel-author-prompt.md`, fewer authors, stronger Creative Director brief.
- Lost on decision quality: strengthen debate requirements, role reports, and lead synthesis gates.
- Lost on accessibility/trust: move those specialists earlier and give them blocking authority.
- Lost on time/cost: reduce team size, shorten cross-exam, or use a single specialist.
- Lost on coherence: make one owner responsible for the final artifact voice or composition.

The evaluation system is part of the product. Keep improving it when it fails to explain the output you are seeing.
