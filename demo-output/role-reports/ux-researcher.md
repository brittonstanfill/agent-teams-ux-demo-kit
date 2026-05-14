# UX Researcher Role Report — Northstar Canceled-Flight Recovery

Confidence levels and labels are explicit. Source labels: **observed** (from brief), **inferred** (reasoned from context), **assumption** (load-bearing belief), **recommendation** (proposed next step).

---

## 1. User goal, in priority order

The brief's single-sentence goal ("understand, choose, get support, leave with confidence") collapses four sequential jobs into one. The real spine, in order:

1. **Understand** — "Is my flight really canceled? What does that mean for tomorrow?" (observed: SMS uses "schedule irregularity"; user has to decode it.)
2. **Decide direction** — "Am I still flying, or am I taking credit and figuring it out tomorrow?" (inferred from current 3-tab structure forcing this fork.)
3. **Secure tonight** — "Where do I sleep? Is the airline paying? Do I need to walk to a desk?" (observed: hotel/meal buried in FAQ.)
4. **Leave with confidence about tomorrow** — "What time, what gate, what bag, what if it changes again?" (observed: confirmation screen says only "Your changes have been applied.")

The current flow inverts this — it pushes "decide direction" before "understand," and treats "secure tonight" as an afterthought.

## 2. Emotional state model (three states, no invented quotes)

| State | Trigger | What it demands |
|---|---|---|
| **Disbelief** (inferred) | 10:46 p.m. SMS with vague "schedule irregularity" wording | Plain confirmation of what happened, in one sentence, without apology theater |
| **Scrambling** (inferred) | Realizing tomorrow's family event is at risk | A clear recommended path with consequences spelled out — not three equal-weight tabs |
| **Wanting closure** (inferred) | After choosing an option | A concrete summary they can fall asleep on: time, hotel, bag, what-if |

All three states are **inferred** from the scenario context. None are validated by field research yet — see Section 4.

## 3. The five silent questions, mapped to the flow

These are the questions a tired, mobile-only traveler is asking under their breath at each step (**inferred**):

1. **"Am I actually getting home?"** — at SMS and Screen 1
2. **"What are my real options, and which one is the airline pushing me toward and why?"** — at Screen 2
3. **"Where do I sleep tonight, and who is paying for it?"** — should be Screen 2, currently Screen 4
4. **"What is this going to cost me?"** — at Screen 3 (fare-difference badge appears here)
5. **"What do I need to do next, and what if this falls apart again?"** — at Screen 5

The current flow answers #2 before #1, hides #3, surfaces #4 unexpectedly, and silently drops #5.

## 4. Research assumptions that must be true (load-bearing)

Each is **assumption**-tagged and falsifiable in a single 5-user moderated mobile session.

- **A1: Travelers prefer rebooking over travel credit in a same-night cancellation.** Falsify: present three equally-weighted options; observe first tap. If >1 of 5 chooses credit first without prompting, revisit defaults.
- **A2: "Recommended" is read as a trusted suggestion, not an upsell.** Falsify: ask participants what they think "Recommended" means and who benefits. If suspicion shows up, change the label.
- **A3: Users will not discover hotel entitlement if it sits behind "Other policies."** Falsify: 5-task test, "find where you would sleep tonight." Time-to-find and abandonment rate tell us.
- **A4: A single-decision-per-screen rhythm reduces abandonment vs. a tabbed picker.** Falsify: A/B prototype comparison on think-aloud completion.
- **A5: Late-night users want fewer filters, not more.** Falsify: offer filter affordance; measure use. If <1 of 5 touches it, the team is over-building.

## 5. What the current flow gets wrong, in research terms

Diagnosis only — redesign belongs to the IA and interaction designers.

- **Goal/UI mismatch** (observed): default tab is *Travel credit* but the user arrived to rebook. The UI's default contradicts the user's likely first job.
- **Information sequencing inversion** (observed): "choose" comes before "understand." Screen 1 says what happened but offers no options; Screen 2 demands a choice with no consequences spelled out.
- **Entitlement obscurity** (observed): hotel/meal in a collapsed FAQ. Under stress, users do not explore — they take the first visible path. This is a known low-trust pattern.
- **Cognitive load mismatch with state** (inferred): three equal tabs ask a tired user to adjudicate. The emotional state is "want guidance," the UI offers "you decide."
- **Closure failure** (observed): "Your changes have been applied" is a system message, not a human one. It does not answer question #5.
- **Channel-context mismatch** (observed): SMS uses jargon ("schedule irregularity") at the moment of highest confusion.

## 6. Message-to-team (to IA and Content Designer)

> Team — before we pick screens or words, here is the user spine: **understand → decide direction → secure tonight → leave with confidence about tomorrow**. The current flow inverts this. The five silent questions, in order, are: (1) Am I getting home? (2) What are my options and which is the airline pushing? (3) Where do I sleep and who pays? (4) What will this cost me? (5) What do I do next if it falls apart again? Every screen should answer one of these, in order, without making the user adjudicate.
>
> **IA — one specific request:** do not carry over the three-tab picker. Sequence the flow so "secure tonight" surfaces before the user commits to a flight option, not after. Hotel cannot live behind an FAQ.
>
> **Content Designer — one specific request:** kill "schedule irregularity" and "your changes have been applied." Write copy that answers the silent question at that step in one declarative sentence. No apology theater. Flag any phrase the user has to decode.

---

*Confidence overall: medium-low. Diagnosis of current flow is high-confidence (observed from brief). Emotional states, silent questions, and assumptions are inferred and need a 5-user moderated test to confirm before the team treats them as ground truth.*
