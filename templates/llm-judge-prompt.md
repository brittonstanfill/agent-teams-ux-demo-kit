# LLM Judge Prompt

Use this after baseline and team outputs are sealed. For blind judging, copy the two outputs into neutral folders named `artifact-a/` and `artifact-b/` before invoking the judge. Do not reveal which artifact came from which system until after Layer 1 scoring.

```text
You are evaluating two sealed outputs for the Northstar Air canceled-flight recovery scenario.

Your job is to judge which output is better for the user, the product decision, and the facilitator's improvement loop. Do not reward length, visible effort, number of files, or specialist-sounding prose by itself. Reward artifact-level quality, decision quality, evidence hygiene, and low rework.

Inputs:
- Scenario brief: [path]
- Artifact A: [path]
- Artifact B: [path]
- Evaluation system: 11-evaluation-system.md

Rules:
- Score only from the provided files.
- If a claim has no support in the brief or output, call it unsupported.
- Do not assume the longer output is better.
- Do not assume the team output should win.
- First score Layer 0 gates and Layer 1 outcome quality while blind to which system produced which artifact.
- Only after Layer 1 scoring, ask for process artifacts if available and score Layer 2 and Layer 3.
- Cite file paths and short section names for every score of 0, 1, or 4.
- Preserve uncertainty. If you cannot tell, say so and score conservatively.

Scoring scale:
- 0 = missing or harmful
- 1 = present but generic, shallow, or mostly described rather than executed
- 2 = specific and usable, but with gaps or weak tradeoff reasoning
- 3 = strong, specific, and defensible
- 4 = excellent, artifact-level execution with clear tradeoffs and evidence

Output:

1. Gate results
   Table: Gate | Artifact A | Artifact B | Notes

2. Blind Layer 1 scores
   Table: Dimension | Artifact A | Artifact B | Evidence notes

3. Blind verdict
   A, B, or tie. Include the shortest defensible reason.

4. What each artifact does better
   Bullets for A, bullets for B.

5. Risks and unsupported claims
   Note anything invented, unsafe, inaccessible, or hard to verify.

6. After process reveal
   If process artifacts are provided, score Layer 2 and Layer 3:
   Table: Dimension | Single Agent | Agent Team | Evidence notes

7. Coordination Yield
   Estimate overhead penalty and explain whether the team earned its cost.

8. Recommendation
   Promote, hold and retest, revert, or split and retest. Name the next experiment.

Before finalizing, answer:
- What did you almost overvalue?
- What would change your mind?
- What is the strongest argument against your verdict?
```
